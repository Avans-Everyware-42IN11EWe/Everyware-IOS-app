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
@end

@implementation glDistrictParticipants

- (void)didMoveToSuperview {
    _users = [[NSMutableArray alloc]init];
    //_users  = [@[@"obama.jpg",@"obama.jpg",@"obama.jpg",@"obama.jpg",@"obama.jpg",@"obama.jpg"] mutableCopy];
    _usersView.delegate = self;
    _usersView.dataSource = self;
    [_usersView registerClass:[glDistrictParticipantsCell class] forCellWithReuseIdentifier:@"districtCell"];
    
    
    [_usersView reloadData];
    //[_usersView reloadInputViews];
}

- (void)setUsers:(NSMutableArray *)array
{
    _users = array;
    [_usersView reloadData];
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
    glDistrictParticipantsCell *myCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"districtCell" forIndexPath:indexPath];
    NSURL *urlplaatje = [NSURL URLWithString:[_users[indexPath.row] valueForKey:@"plaatje"]];
    NSData *dataplaatje = [NSData dataWithContentsOfURL:urlplaatje];
    [myCell setPhoto:[UIImage imageWithData:dataplaatje]];
    [myCell setBuddy:[[_users[indexPath.row]valueForKey:@"is_buddy"]integerValue]];
    myCell.backgroundColor = [UIColor whiteColor];
    
    return myCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[_users[indexPath.row]valueForKey:@"is_buddy"]integerValue]==1) {
        [_eindbaas goToBuddyDetail];
    }else if([[_users[indexPath.row]valueForKey:@"has_video"]integerValue]==1)
    {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"Comp2" ofType:@"mp4"];
        [_eindbaas goTouserVideo:path];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake(50, 50);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,0,0);
}

@end
