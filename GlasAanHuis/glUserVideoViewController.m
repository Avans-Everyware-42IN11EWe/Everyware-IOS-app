//
//  glUserVideoViewController.m
//  GlasAanHuis
//
//  Created by leon on 01/06/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glUserVideoViewController.h"

@interface glUserVideoViewController ()

@end

@implementation glUserVideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setUrl:(NSString*)url
{
    _userVideoUrl = url;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSURL URLWithString:_userVideoUrl];
    
    _mc = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [_mc.view setFrame:CGRectMake(0, 0, 260, 160)];
    [_mc prepareToPlay];
    _mc.shouldAutoplay = false;
    [_movie addSubview:_mc.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

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
