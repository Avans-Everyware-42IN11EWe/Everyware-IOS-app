//
//  glVideoPlayViewController.h
//  GlasAanHuis
//
//  Created by leon van Woezik on 21/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>

@interface glVideoPlayViewController : UIViewController
    -(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate;
@end
