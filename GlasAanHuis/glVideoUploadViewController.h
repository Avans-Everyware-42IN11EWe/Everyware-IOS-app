//
//  glVideoUploadViewController.h
//  GlasAanHuis
//
//  Created by leon on 07/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>

@interface glVideoUploadViewController : UIViewController

@property (strong, nonatomic) IBOutlet NSURL *videoUrl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (strong, nonatomic) IBOutlet UIView *videoView;
- (IBAction)save:(id)sender;
- (IBAction)leukeVideoToevoegen:(id)sender;
- (IBAction)leukeVideoOpnemen:(id)sender;

@property (nonatomic, strong) MPMoviePlayerController *mc;
//@property (strong, nonatomic)NSString *userVideoUrl;

@end
