//
//  glWijkInfoView.h
//  GlasAanHuis
//
//  Created by Nanne on 18-05-14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "glDistrictViewController.h"

@interface glWijkInfoView : UIView
@property (weak, nonatomic) IBOutlet UILabel *wijkName;
@property (weak, nonatomic) IBOutlet UILabel *wijkPercent;
@property (weak, nonatomic) IBOutlet UILabel *wijkDeelnemers;
@property (weak, nonatomic) IBOutlet NSString *fbId;
@property (strong, nonatomic) IBOutlet NSString *fbName;
@property glDistrictViewController *eindbaas;
@end
