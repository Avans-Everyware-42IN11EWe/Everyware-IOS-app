//
//  glDistrictParticipantsCell.m
//  GlasAanHuis
//
//  Created by leroy on 27/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glDistrictParticipantsCell.h"

@implementation glDistrictParticipantsCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_imageView];
    }
    return self;
}

-(void) setPhoto:(UIImage *)image {
    self.imageView.image = image;
}

-(void) setBuddy:(NSInteger *)isBuddy {
    NSInteger one = 1;
    if (isBuddy==one) {
        [_imageView.layer setBorderColor: [[UIColor greenColor] CGColor]];
        [_imageView.layer setBorderWidth: 2.0];
    }else
    {
        [_imageView.layer setBorderColor: [[UIColor clearColor] CGColor]];
        [_imageView.layer setBorderWidth: 2.0];
        
    }
}
@end
