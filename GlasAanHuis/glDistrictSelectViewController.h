//
//  glDistrictSelectViewController.h
//  GlasAanHuis
//
//  Created by leroy on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface glDistrictSelectViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITextField *searchTF;
@property (strong, nonatomic) IBOutlet UITableView *districtTABLE;
- (IBAction)doneBTN:(id)sender;




@end
