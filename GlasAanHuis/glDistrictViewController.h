//
//  glDistrictViewController.h
//  GlasAanHuis
//
//  Created by leroy on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MapKit/MapKit.h>
#import "MTPopupWindow.h"


@interface glDistrictViewController : UIViewController <UIScrollViewDelegate>{
    IBOutlet UIScrollView *scroller;
    IBOutlet UIView *wijk;
    IBOutlet UIImageView *imageView;
    IBOutlet UIImage *backGround;
    IBOutlet MKMapView *map;
    IBOutlet UIView *ContGoedeDoel;
    IBOutlet UIView *ContStappen;
    IBOutlet UIView *ContMovie;
    IBOutlet MPMoviePlayerController *movie;
    
    IBOutlet UILabel *lblGoedeDoel;
    IBOutlet UILabel *lblStappen;
    IBOutlet UILabel *lblStap1;
    IBOutlet UILabel *lblStap2;
    IBOutlet UILabel *lblStap3;
    IBOutlet UILabel *lblStap4;
    IBOutlet UILabel *lblStap5;
    IBOutlet UILabel *lblDeelname;
    
    IBOutlet UIProgressView *progGoedeDoel;
    IBOutlet UIProgressView *progStap1;
    IBOutlet UIProgressView *progStap2;
    IBOutlet UIProgressView *progStap3;
    IBOutlet UIProgressView *progStap4;
    IBOutlet UIProgressView *progStap5;
    
    IBOutlet UIButton *btnFaq;
    IBOutlet UIButton *btnForum;
    
    NSInteger currentDistrict;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property (strong, nonatomic) NSJSONSerialization *selectedDistrict;
- (void)setSelectedDistrict:(NSJSONSerialization *)selectedDistrict;
@property (strong, nonatomic)NSMutableArray *districts;
- (IBAction)showWelcome:(id)sender;
- (IBAction)goToRegister:(id)sender;
- (IBAction)goToAndereWijk:(id)sender;
@end

