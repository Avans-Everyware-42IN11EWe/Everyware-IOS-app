//
//  glWijkInfoView.m
//  GlasAanHuis
//
//  Created by Nanne on 18-05-14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glWijkInfoView.h"

@interface glWijkInfoView ()
- (IBAction)goToDistrictPage:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *placeholder;

@property (weak, nonatomic) IBOutlet UIView *wijkKiezen;
@property (weak, nonatomic) IBOutlet UIView *meedoen;

@end

@implementation glWijkInfoView

- (void)didMoveToSuperview {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"userID"]!=nil) {
        [self.placeholder addSubview:self.meedoen];
    } else {
        [self.placeholder addSubview:self.wijkKiezen];
    }
}

- (IBAction)DITISMIJNWIJK:(id)sender {
    [self.eindbaas goToRegister:sender];
}

- (IBAction)ANDEREWIJK:(id)sender {
    [self.eindbaas goToAndereWijk:sender];
}

- (IBAction)goToDistrictPage:(id)sender {
    NSURL *fanPageURL = [NSURL URLWithString:@"fb://profile/1450066045229608"];
    
    if (![[UIApplication sharedApplication] canOpenURL:fanPageURL])
    {
        fanPageURL =   [ NSURL URLWithString:@"https://www.facebook.com/glasvezelpaleiskwartier"];
    }else
    {
        [[UIApplication sharedApplication] openURL:fanPageURL];
    }
}
@end
