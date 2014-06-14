//
//  glProviderViewController.m
//  GlasAanHuis
//
//  Created by leon on 25/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glProviderViewController.h"

@interface glProviderViewController ()

@end

@implementation glProviderViewController

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
    providers = [self getProviders];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSJSONSerialization*)getProviders
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults valueForKey:@"userID"];
    NSString *path = [NSString stringWithFormat:@"http://glas.mycel.nl/b/providers?user_id=%@",userId];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"GET";
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    return [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] mutableCopy];
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

- (IBAction)providerChosen:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:@"3" forKey:@"userStatus"];
    [defaults synchronize];

}
@end
