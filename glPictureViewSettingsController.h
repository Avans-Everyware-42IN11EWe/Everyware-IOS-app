//
//  glPictureViewSettingsController.h
//  GlasAanHuis
//
//  Created by leroy on 14/06/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "glMyProfileSettingsChangeViewController.h"

@interface glPictureViewSettingsController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//@property (strong, nonatomic) NSString *districtID;
//- (void)setDistrictID:(NSString *)districtID;
@property (weak, nonatomic) glMyProfileSettingsChangeViewController *regController;
- (void)setRegController:(glMyProfileSettingsChangeViewController *)controller;

//@property (strong, nonatomic) IBOutlet UIImageView *plaatje;
//- (IBAction)voegToe:(id)sender;
//- (IBAction)veranderPlaatje:(id)sender;

//- (IBAction)gaVerder:(id)sender;

@end
