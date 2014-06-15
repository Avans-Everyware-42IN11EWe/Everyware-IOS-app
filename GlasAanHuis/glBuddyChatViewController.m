//
//  glBuddyChatViewController.m
//  GlasAanHuis
//
//  Created by leon on 24/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glBuddyChatViewController.h"

@interface glBuddyChatViewController ()
@end

@implementation glBuddyChatViewController
NSArray *menuItems;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _senderID = [defaults valueForKey:@"userID"];
    
    _cReceiverImage = [self getPhoto:_recieverID];
    _cSenderImage = [self getPhoto:_senderID];
    _ReceiverImage.image = _cReceiverImage;
    _ReceiverName.text = [self getName:_recieverID];
    [self getNewLines];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [roomLines count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *v = [UIView new];
    [v setBackgroundColor:[UIColor clearColor]];
    return v;
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
    
    NSDictionary *itemAtIndex = (NSDictionary *)[roomLines objectAtIndex:indexPath.section];
    
    if ([itemAtIndex objectForKey:@"receiver_id"]==_recieverID) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:_cReceiverImage];
        cell.accessoryView = imageView;
        cell.accessoryView.frame = CGRectMake(cell.frame.size.width-5, 0,44, 44);
        cell.textLabel.textAlignment = NSTextAlignmentRight;
    }else{
        cell.imageView.image = _cSenderImage;
    }
    cell.imageView.frame = CGRectOffset(cell.frame, 10, 10);

    cell.textLabel.text = [itemAtIndex objectForKey:@"message"];
    
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

-(void)getNewLines
{
    dispatch_queue_t newLinesQ = dispatch_queue_create("newLinesQ", NULL);
    dispatch_async(newLinesQ, ^{
        roomLines = [self executeGetLines:_recieverID];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_messageTable reloadData];
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                        [self methodSignatureForSelector: @selector(onTick)]];
            [invocation setTarget:self];
            [invocation setSelector:@selector(onTick	)];
            timer = [NSTimer scheduledTimerWithTimeInterval:2.0
                                                 invocation:invocation repeats:NO];        });
    });
}

-(void)onTick
{
    [self getNewLines];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [_messageTable reloadData];
}

-(NSArray*)executeGetLines:(NSString*)receiverid
{
    NSString *urlstring = [NSString stringWithFormat:@"http://glas.mycel.nl/chat?resident_id=%@&sender_id=%@",_recieverID,_senderID];
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

-(NSArray*)sendMessage
{
    NSLog(@"%@",_senderID);
    NSLog(@"%@",_recieverID);
    NSDictionary *tmp = [[NSDictionary alloc]initWithObjectsAndKeys:_senderID,@"sender_id",_recieverID,@"receiver_id",_txtMessageToSend.text,@"message",nil];
    NSError *postError;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:NSASCIIStringEncoding error:&postError];
    
    NSURL *url = [NSURL URLWithString:@"http://glas.mycel.nl/chat"];
    NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:url];
    
    req.HTTPMethod=@"POST";
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setHTTPBody:postdata];
    
    NSData *data;
    NSURLResponse *response = nil;
    data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:nil];
    if (data == nil) {
        return [[NSArray alloc]init];
    }
    _txtMessageToSend.text = nil;
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (IBAction)sendMessage:(id)sender {
    [self sendMessage];
}

-(UIImage*)getPhoto:(NSString *)userId
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
    
    NSURL *urlplaatje = [NSURL URLWithString:[user valueForKey:@"plaatje"]];
    NSData *dataplaatje = [NSData dataWithContentsOfURL:urlplaatje];
    UIImage *plaatje = [UIImage imageWithData:dataplaatje];
    return plaatje;
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

@end
