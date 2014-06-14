//
//  glMyProfileViewController.m
//  GlasAanHuis
//
//  Created by leon on 07/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glMyProfileViewController.h"
#import "SWRevealViewController.h"
@interface glMyProfileViewController ()

@end

@implementation glMyProfileViewController

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
    _sideBarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sideBarButton.target = self.revealViewController;
    _sideBarButton.action = @selector(revealToggle:);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *senderID = [defaults valueForKey:@"userID"];
    NSJSONSerialization *user =[self getUser:senderID];

    self.MyProfileName.text = [user valueForKey:@"naam"];
    self.MyProfileAge.text = [NSString stringWithFormat:@"Leeftijd: %@",[user valueForKey:@"leeftijd"]];
    self.MyProfileLocation.text = [NSString stringWithFormat:@"Adres: %@",[user valueForKey:@"adres"]];
    self.MyProfileEmail.text = [NSString stringWithFormat:@"Email: %@",[user valueForKey:@"email"]];
    self.MyProfilePhone.text = [NSString stringWithFormat:@"Telefoon: %@",[user valueForKey:@"telefoon"]];
    
    NSURL *urlplaatje = [NSURL URLWithString:[user valueForKey:@"plaatje"]];
    NSData *dataplaatje = [NSData dataWithContentsOfURL:urlplaatje];
    self.MyProfilePicture.image = [UIImage imageWithData:dataplaatje];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
