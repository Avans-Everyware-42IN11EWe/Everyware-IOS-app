//
//  glChatManagerViewController.m
//  GlasAanHuis
//
//  Created by leon on 15/06/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glChatManagerViewController.h"
#import "SWRevealViewController.h"
#import "glBuddyChatViewController.h"
@interface glChatManagerViewController ()

@end

@implementation glChatManagerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"register center");
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(handleNotification)
     name:@"Nieuw bericht."
     object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    userID = [defaults valueForKey:@"userID"];
    [self getNewLines];
    
    _sideBarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    _sideBarButton.target = self.revealViewController;
    _sideBarButton.action = @selector(revealToggle:);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)handleNotification:(NSNotification *)pNotification
{
    NSLog(@"#1 received message = %@",(NSString*)[pNotification object]);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [myMessageArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView
                                                dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *itemAtIndex = (NSDictionary *)[myMessageArray objectAtIndex:indexPath.section];
    NSInteger *messageID = [[itemAtIndex valueForKey:@"id"]integerValue];
    if (loaded==TRUE) {
        [self checkNewMessage:messageID];
    }
    NSString *senderName = [self getName:[itemAtIndex valueForKey:@"sender_id"]];
    NSString *textlabelContent = [NSString stringWithFormat:@"Bericht van: %@ %@",senderName,[itemAtIndex valueForKey:@"message"]];
    cell.textLabel.text = textlabelContent;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *itemAtIndex = (NSDictionary *)[myMessageArray objectAtIndex:indexPath.section];
    _messageClickedID = [itemAtIndex valueForKey:@"sender_id"];
    [self performSegueWithIdentifier:@"goToMessages" sender:self];
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"goToMessages"]) {
        glBuddyChatViewController *controller = [segue destinationViewController];
        [controller setRecieverID:_messageClickedID];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(NSArray*)executeGetLines:(NSString*)MyID
{
    NSString *urlstring = [NSString stringWithFormat:@"http://glas.mycel.nl/history?resident_id=%@",MyID];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:url];
    
    NSData *data;
    NSError *error;
    NSURLResponse *response = nil;
    data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    if (data == nil) {
        return [[NSArray alloc]init];
    }
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
}

-(Boolean)checkNewMessage:(NSInteger*)currentMessageID
{
    if (currentMessageID>lastMessage) {
        NSLog(@"true");
        lastMessage = currentMessageID;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"You have a new message" object:self];
        return true;
    }
    return false;
}

-(NSString*)getName:(NSString *)userId
{
    NSString *path = [NSString stringWithFormat:@"http://glas.mycel.nl/buddy?id=%@",userId];
    NSString *urlstring = [NSString stringWithFormat:path];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"GET";
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    NSJSONSerialization *user = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] mutableCopy];
    
    if (error == nil)
    {
        
    }
    
    NSString *name = [user valueForKey:@"naam"];
    return name;
}

-(void)getNewLines
{
    dispatch_queue_t newLinesQ = dispatch_queue_create("newLinesQ", NULL);
    dispatch_async(newLinesQ, ^{
        myMessageArray = [self executeGetLines:userID];
        if (loaded==FALSE) {
            [self setLast];
        }
        loaded=TRUE;
        dispatch_async(dispatch_get_main_queue(), ^{
            [_myMessages reloadData];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                        [self methodSignatureForSelector: @selector(onTick)]];
            [invocation setTarget:self];
            [invocation setSelector:@selector(onTick	)];
            timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                 invocation:invocation repeats:NO];        });
    });
}

-(void)setLast
{
    for (NSDictionary *value in myMessageArray) {
        int messageID = [[value valueForKey:@"id"]intValue];
        if (messageID > lastMessage) {
            lastMessage = messageID;
        }
    }
}

-(void)onTick
{
    [self getNewLines];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_myMessages reloadData];
}

@end
