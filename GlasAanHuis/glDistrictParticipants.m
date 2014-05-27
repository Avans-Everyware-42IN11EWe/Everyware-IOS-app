//
//  glDistrictParticipants.m
//  GlasAanHuis
//
//  Created by leon on 25/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glDistrictParticipants.h"
#import "glDistrictParticipantsCell.h"

@interface glDistrictParticipants ()

@property (strong, nonatomic) NSMutableArray *users;
@end

@implementation glDistrictParticipants

- (void)didMoveToSuperview {

    _users  = [@[@"obama.jpg"] mutableCopy];
    _usersView.delegate = self;
    _usersView.dataSource = self;
    //[_usersView registerClass:[glDistrictParticipantsCell class] forCellWithReuseIdentifier:@"myCell"];

}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _users.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    glDistrictParticipantsCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    //myCell.backgroundColor = [UIColor colorWithPatternImage:[_users objectAtIndex:indexPath.row]];
    
    UIImage *image;
    long row = [indexPath row];
    
    image = [UIImage imageNamed:_users[row]];
    myCell.imageView.image = image;
    
    
    //myCell.imageView.image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imgres.jpg"]];
    
    
    //UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"myCell" forIndexPath:indexPath];
    
    //UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    //recipeImageView.image = [UIImage imageNamed:[_users objectAtIndex:indexPath.row]];
    
    return myCell;
}


@end
