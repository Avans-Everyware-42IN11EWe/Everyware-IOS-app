//
//  glDistrictViewController.h
//  GlasAanHuis
//
//  Created by leroy on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface glDistrictViewController : UIViewController

@property (strong, nonatomic) NSJSONSerialization *selectedDistrict;
- (void)setSelectedDistrict:(NSJSONSerialization *)selectedDistrict;

- (IBAction)goToRegister:(id)sender;

@end
