//
//  glBlurView.h
//  GlasAanHuis
//
//  Created by leon on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDKBlurredBackgroundDefaultLevel 0.9f
#define kDKBlurredBackgroundDefaultGlassLevel 0.2f
#define kDKBlurredBackgroundDefaultGlassColor [UIColor whiteColor]

@interface glBlurView : UIImageView
@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, assign) float initialBlurLevel;
@property (nonatomic, assign) float initialGlassLevel;
@property (nonatomic, assign) BOOL isGlassEffectOn;
@property (nonatomic, strong) UIColor *glassColor;

- (void)setBlurLevel:(float)blurLevel;

@end
