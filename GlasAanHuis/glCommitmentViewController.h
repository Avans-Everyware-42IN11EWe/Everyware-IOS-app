//
//  glCommitmentViewController.h
//  GlasAanHuis
//
//  Created by leon on 25/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface glCommitmentViewController : UIViewController
- (IBAction)committed:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtNaam;
@property (strong, nonatomic) IBOutlet UITextField *txtAdres;
@property (strong,nonatomic)NSString *authtoken;
@property (strong,nonatomic)NSString *userID;
@end
