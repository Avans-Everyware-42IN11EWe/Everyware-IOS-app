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
@property (strong, nonatomic) IBOutlet UIView *movie;
@property (strong, nonatomic)NSString *userVideoUrl;
-(void)setUrl:(NSString*)url;
@end
