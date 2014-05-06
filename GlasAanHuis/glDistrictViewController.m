//
//  glDistrictViewController.m
//  GlasAanHuis
//
//  Created by leroy on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glDistrictViewController.h"
#import "glRegisterViewController.h"
@interface glDistrictViewController ()

@end

@implementation glDistrictViewController
-(void)setSelectedDistrict:(NSJSONSerialization *)selectedDistrict
{
    _selectedDistrict = selectedDistrict;
}
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"register"]) {
        //NSString * userID = [ _selectedDistrict valueForKey:@"id"];
        [segue.destinationViewController setDistrictID:@"testid"];
    }
}


- (IBAction)goToRegister:(id)sender {
    //if(_selectedDistrict != nil){
        [self performSegueWithIdentifier:@"register" sender:self];
    //}
}
@end
