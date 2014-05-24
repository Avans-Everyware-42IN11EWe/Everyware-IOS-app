//
//  glBuddyDetailViewController.h
//  GlasAanHuis
//
//  Created by leon van Woezik on 21/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface glBuddyDetailViewController : UIViewController
@property (nonatomic, strong) MPMoviePlayerController *mc;
@property (strong, nonatomic) IBOutlet UIView *movie;

@end
