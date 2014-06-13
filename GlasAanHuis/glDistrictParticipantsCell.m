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

-(void) setVideo:(NSInteger *)hasVideo {
    NSInteger one = 1;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(28, 28, 20, 20)];
    if(hasVideo == one){
       
        imageView.image = [UIImage imageNamed:@"cameraicon.png"];
        [_imageView addSubview:imageView];
    }else{
        // With some valid UIView *view:
        for(UIView *subview in [_imageView subviews]) {
            [subview removeFromSuperview];
        }
    }
}

@end
