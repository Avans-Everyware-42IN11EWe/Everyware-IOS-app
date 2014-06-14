//
//  glPictureViewController.h
//  GlasAanHuis
//
//  Created by leon on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "glRegisterViewController.h"

@interface glPictureViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

//@property (strong, nonatomic) NSString *districtID;
//- (void)setDistrictID:(NSString *)districtID;
@property (weak, nonatomic) glRegisterViewController *regController;
- (void)setRegController:(glRegisterViewController *)controller;
@end

