//
//  glIntroViewController.m
//  GlasAanHuis
//
//  Created by leroy on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glIntroViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface glIntroViewController ()

@end

@implementation glIntroViewController

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
	// Do any additional setup after loading the view, typically ]from a nib.
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Comp2" ofType:@"mp4"];
    NSURL *fileURL = [NSURL fileURLWithPath:filepath];
    self.mc = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(introMovieFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.mc];
    
    // Hide the video controls from the user
    [self.mc setControlStyle:MPMovieControlStyleNone];

    [self.mc prepareToPlay];
    [self.mc.view setFrame: self.view.bounds];
    [self.view addSubview:self.mc.view];
    
    
    
    [self.mc play];
}

- (void)introMovieFinished:(NSNotification *)notification
{
    NSLog(@"Video ended!");
    [self performSegueWithIdentifier:@"gostart" sender:self];
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
