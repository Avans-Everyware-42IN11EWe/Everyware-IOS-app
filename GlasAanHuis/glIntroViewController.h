//
//  glIntroViewController.h
//  GlasAanHuis
//
//  Created by leroy on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface glIntroViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *skipBTN;
@property (nonatomic, strong) MPMoviePlayerController *mc;
@property (weak, nonatomic) IBOutlet UIView *videoView;
- (IBAction)goToStart:(id)sender;

@end
