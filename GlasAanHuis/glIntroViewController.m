//
//  glIntroViewController.m
//  GlasAanHuis
//
//  Created by leroy on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glIntroViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "objc/message.h"

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

//-(NSUInteger)supportedInterfaceOrientations {
//    return UIInterfaceOrientationMaskLandscape;
//}
//
//-(BOOL)shouldAutorotate {
//    return YES;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically ]from a nib.
    //objc_msgSend([UIDevice currentDevice], @selector(setOrientation:), UIInterfaceOrientationMaskLandscape);
}

- (void)viewDidAppear:(BOOL)animated
{
//    if (self.interfaceOrientation != UIInterfaceOrientationPortrait) {
//
//        [[UIDevice currentDevice] performSelector:NSSelectorFromString(@"setOrientation:") withObject:(id)UIInterfaceOrientationPortrait];
//    }

//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        objc_msgSend([UIDevice currentDevice], @selector(setOrientation:),    UIInterfaceOrientationLandscapeLeft );
//   }
    
    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"Comp2" ofType:@"mp4"];
    NSURL *fileURL = [NSURL fileURLWithPath:filepath];
    self.mc = [[MPMoviePlayerController alloc] initWithContentURL:fileURL];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(introMovieFinished:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.mc];
    
    // Hide the video controls from the user
    [self.mc setControlStyle:MPMovieControlStyleNone];
    
    for(UIView* subV in self.mc.view.subviews) {
        subV.backgroundColor = [UIColor clearColor];
    }
    self.mc.view.backgroundColor = [UIColor clearColor];

    [self.mc prepareToPlay];
    //[self.mc setRepeatMode:MPMovieRepeatModeOne];
    //[self.mc setControlStyle:MPMovieControlStyleEmbedded];
    self.mc.view.transform = CGAffineTransformMakeRotation(M_PI/2);
    
    [self.mc.view setFrame: self.videoView.bounds];
    [self.videoView addSubview:self.mc.view];
    
    self.skipBTN.transform = CGAffineTransformMakeRotation(M_PI/2);
    
    [self.mc play];
}

- (void)introMovieFinished:(NSNotification *)notification
{
    NSLog(@"Video ended!");
    [self.mc stop];
    [self performSegueWithIdentifier:@"gotostart" sender:self];
}
- (IBAction)goToStart:(id)sender {
    [self.mc stop];
    [self performSegueWithIdentifier:@"gotostart" sender:self];
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
