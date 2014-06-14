//
//  glMyProfileSettingsChangeViewController.m
//  GlasAanHuis
//
//  Created by leroy on 14/06/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glMyProfileSettingsChangeViewController.h"

@interface glMyProfileSettingsChangeViewController ()

@end

@implementation glMyProfileSettingsChangeViewController

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
    NSString *senderID = [defaults valueForKey:@"userID"];
    // Do any additional setup after loading the view.
    NSJSONSerialization *user =[self getUser:senderID];
    self.MyProfileName.text = [user valueForKey:@"naam"];
    self.MyProfileAge.text = [NSString stringWithFormat:@"Leeftijd: %@",[user valueForKey:@"leeftijd"]];
    self.MyProfileLocation.text = [NSString stringWithFormat:@"Woonplaats: %@",[user valueForKey:@"woonplaats"]];
    self.MyProfileEmail.text = [NSString stringWithFormat:@"Email: %@",[user valueForKey:@"email"]];
    self.MyProfilePhone.text = [NSString stringWithFormat:@"Telefoon: %@",[user valueForKey:@"telefoon"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSJSONSerialization*)getUser:(NSString *)userId
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
    NSLog(@"%@",user);
    return user;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
