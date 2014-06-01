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

- (IBAction)kiesprovider:(id)sender {
    [self.eindbaas goToProvider:sender];
}

- (IBAction)ANDEREWIJK:(id)sender {
    [self.eindbaas goToAndereWijk:sender];
}

- (IBAction)ikdoemee:(id)sender {
    [self.eindbaas goToCommitment:sender];
}

- (IBAction)aanbetaling:(id)sender {
    
}

- (IBAction)goToDistrictPage:(id)sender {
    NSString *str = [NSString stringWithFormat:@"fb://profile/%@", _fbId];
    NSURL *fburl = [NSURL URLWithString:str];
    
    if (![[UIApplication sharedApplication] openURL:fburl])
    {
        fburl =   [ NSURL URLWithString:_fbName];
    }
    [[UIApplication sharedApplication] openURL:fburl];
}

@end
