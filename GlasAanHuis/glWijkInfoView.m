//
//  glWijkInfoView.m
//  GlasAanHuis
//
//  Created by Nanne on 18-05-14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glWijkInfoView.h"

@interface glWijkInfoView ()

@end

@implementation glWijkInfoView
- (IBAction)DITISMIJNWIJK:(id)sender {
    [self.eindbaas goToRegister:sender];
}

- (IBAction)ANDEREWIJK:(id)sender {
    [self.eindbaas goToAndereWijk:sender];
}

@end
