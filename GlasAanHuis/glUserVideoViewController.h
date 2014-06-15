//
//  glUserVideoViewController.h
//  GlasAanHuis
//
//  Created by leon on 01/06/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface glUserVideoViewController : UIViewController
@property (nonatomic, strong) MPMoviePlayerController *mc;
@property (strong, nonatomic)NSString *userVideoUrl;

@property (strong, nonatomic) IBOutlet UIView *movie;
-(void)setUrl:(NSString*)url;
@end
