//
//  glProviderViewController.h
//  GlasAanHuis
//
//  Created by leon on 25/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface glProviderViewController : UIViewController
- (IBAction)providerChosen:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *ProviderListView;

@end
NSJSONSerialization *providers;