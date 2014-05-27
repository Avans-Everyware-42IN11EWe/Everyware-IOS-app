//
//  glDistrictParticipants.h
//  GlasAanHuis
//
//  Created by leon on 25/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "glDistrictViewController.h"
@interface glDistrictParticipants : UIView<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *usersView;
@property glDistrictViewController *eindbaas;
@end


