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
    senderID = [defaults valueForKey:@"userID"];
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
    // Return the number of sections.
    return [roomLines count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7;
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
    cell.imageView.frame = CGRectOffset(cell.frame, 10, 10);
    NSDictionary *itemAtIndex = (NSDictionary *)[roomLines objectAtIndex:indexPath.section];
    cell.textLabel.text = [itemAtIndex objectForKey:@"message"];
    cell.imageView.image = [UIImage imageNamed:@"billgates.jpg"];
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
        roomLines = [self executeGetLines:@"nope"];
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
//TODO:id meegeven
-(NSArray*)executeGetLines:(NSString*)receiverid
{
    NSDictionary *tmp = [[NSDictionary alloc]initWithObjectsAndKeys:@"2",@"resident_id", nil];
    NSError *postError;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:NSASCIIStringEncoding error:&postError];
    
    NSURL *url = [NSURL URLWithString:@"http://glas.mycel.nl/chat?resident_id=2"];
    NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:url];
    /*
    [req setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [req setHTTPBody:postdata];
    */
    NSData *data;
    NSError *error;
    NSURLResponse *response = nil;
    data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    if (data == nil) {
        return [[NSArray alloc]init];
    }
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
}
//TODO:berichten niet naar jezelf sturen..
-(NSArray*)sendMessage
{
    NSDictionary *tmp = [[NSDictionary alloc]initWithObjectsAndKeys:senderID,@"sender_id",@"2",@"receiver_id",_txtMessageToSend.text,@"message",nil];
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
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (IBAction)sendMessage:(id)sender {
    [self sendMessage];
}
@end
