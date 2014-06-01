//
//  glBuddyDetailViewController.m
//  GlasAanHuis
//
//  Created by leon van Woezik on 21/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glBuddyDetailViewController.h"

@interface glBuddyDetailViewController ()

@end

@implementation glBuddyDetailViewController

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    /*_movie = [[UIView alloc]initWithFrame:self.view.frame];
    [_movie setFrame:CGRectMake(30, 670, 260, 160)];
    [_movie setBackgroundColor:[UIColor colorWithRed:(173/255.0) green:(173/255.0) blue:(173/255.0) alpha:0.4]];
    
     */
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Comp2" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    _mc = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [_mc.view setFrame:CGRectMake(0, 0, 260, 160)];
    
    
    //[_movie play];
    [_mc prepareToPlay];
    //[movie pause];
    _mc.shouldAutoplay = false;
    [_movie addSubview:_mc.view];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
