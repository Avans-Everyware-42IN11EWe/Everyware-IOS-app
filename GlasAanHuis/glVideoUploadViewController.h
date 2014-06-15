//
//  glVideoUploadViewController.h
//  GlasAanHuis
//
//  Created by leon on 07/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface glVideoUploadViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (strong, nonatomic) IBOutlet UIView *videoView;
- (IBAction)save:(id)sender;
- (IBAction)leukeVideoToevoegen:(id)sender;
- (IBAction)leukeVideoOpnemen:(id)sender;

@end
