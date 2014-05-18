//
//  glViewController.m
//  GlasAanHuis
//
//  Created by Nanne on 07-04-14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glViewController.h"

@interface glViewController ()

@end

@implementation glViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    UIColor * color = [UIColor colorWithRed:255/255.0f green:225/255.0f blue:131/255.0f alpha:1.0f];
//    [self.navigationController.navigationBar setBarTintColor:color];
    //[self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"userID"]!=nil) {
        [self performSegueWithIdentifier:@"login" sender:self];
    }else{
        [self performSegueWithIdentifier:@"notlogin" sender:self];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
