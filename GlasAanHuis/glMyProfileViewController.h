//
//  glMyProfileViewController.h
//  GlasAanHuis
//
//  Created by leon on 07/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface glMyProfileViewController : UIViewController
@property (nonatomic, strong) MPMoviePlayerController *mc;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
//@property (weak, nonatomic) IBOutlet UIImageView *MyProfilePicture;

@property (weak, nonatomic) IBOutlet UILabel *MyProfileLocation;
@property (weak, nonatomic) IBOutlet UILabel *MyProfilePhone;
@property (weak, nonatomic) IBOutlet UILabel *MyProfileEmail;
@property (weak, nonatomic) IBOutlet UILabel *MyProfileAge;
@property (weak, nonatomic) IBOutlet UILabel *MyProfileName;
@property (weak, nonatomic) IBOutlet UIImageView *MyProfilePicture;
@property (strong, nonatomic) IBOutlet UIView *videoView;

@end
