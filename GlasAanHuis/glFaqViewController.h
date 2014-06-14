//
//  glFaqViewController.h
//  GlasAanHuis
//
//  Created by leon on 07/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface glFaqViewController : UIViewController
@property(nonatomic,strong)NSString*districtID;
@property (strong, nonatomic) IBOutlet UIWebView *faqView;
@end
