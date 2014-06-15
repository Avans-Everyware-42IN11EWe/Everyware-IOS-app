//
//  glGlasNavigationController.m
//  GlasAanHuis
//
//  Created by leon on 15/06/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glGlasNavigationController.h"

@interface glGlasNavigationController ()

@end

@implementation glGlasNavigationController

- (NSUInteger)supportedInterfaceOrientations {
    if ([self.topViewController isMemberOfClass:[glGlasNavigationController class]]){
        return UIInterfaceOrientationMaskPortrait;
    }else{
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
}

@end
