//
//  glDistrictParticipantsCell.h
//  GlasAanHuis
//
//  Created by leroy on 27/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface glDistrictParticipantsCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
-(void) setPhoto:(UIImage *)image;
-(void) setBuddy:(NSInteger *)isBuddy;

@end