//
//  glCommitmentViewController.m
//  GlasAanHuis
//
//  Created by leon on 25/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glCommitmentViewController.h"

@interface glCommitmentViewController ()

@end

@implementation glCommitmentViewController

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
    // Do any additional setup after loading the view.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)committed:(id)sender {
    if (![_txtAdres.text isEqual:@""] && ![_txtNaam.text isEqual:@""]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _userID = [defaults valueForKey:@"userID"];
        _authtoken = [defaults valueForKey:@"authToken"];
        [self postCommitment];
    }
}

-(void)postCommitment
{
    NSDictionary *tmp = [[NSDictionary alloc]initWithObjectsAndKeys:_txtAdres.text,@"adres",_txtNaam.text,@"naam",nil];
    NSError *postError;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:NSASCIIStringEncoding error:&postError];
    
    NSString *urlstring = [NSString stringWithFormat:@"http://glas.mycel.nl/commitment?id=%@&auth_token=%@",_userID,_authtoken];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:url];
    
    req.HTTPMethod=@"POST";
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setHTTPBody:postdata];
    
    NSData *data;
    NSURLResponse *response = nil;
    data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:nil];
    _txtNaam.text = nil;
    _txtAdres.text = nil;
}
@end
