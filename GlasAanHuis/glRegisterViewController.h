//
//  glRegisterViewController.h
//  GlasAanHuis
//
//  Created by leroy on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface glRegisterViewController : UIViewController <FBLoginViewDelegate>

@property (strong, nonatomic) NSString *districtID;
- (void)setDistrictID:(NSString *)districtID;

//@property (strong, nonatomic) IBOutlet UITextField *nameTV;
@property (strong, nonatomic) IBOutlet UITextField *emailTV;
@property (strong, nonatomic) IBOutlet UISwitch *buddySW;
@property (strong, nonatomic) IBOutlet UIButton *doneBTN;
- (IBAction)loginBTN:(id)sender;
-(NSArray *)registerUser;
@property (strong, nonatomic) IBOutlet FBLoginView *facbookLoginBTN;
-(NSArray *)registerUserFacbook:(NSString*)token;

@end
