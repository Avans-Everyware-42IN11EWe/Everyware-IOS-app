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
#import "glBlurView.h"
#import "glMapViewDelegate.h"

@interface glDistrictViewController : UIViewController <UIScrollViewDelegate>{
    IBOutlet glBlurView *backgroundView ;
    IBOutlet UIScrollView *scroller;
    IBOutlet UIView *wijk;
    IBOutlet UIImageView *imageView;
    IBOutlet UIImage *backGround;
    IBOutlet MKMapView *map;
    IBOutlet UIView *ContGoedeDoel;
    IBOutlet UIView *ContFaq;
    IBOutlet UIView *ContVraag;
    IBOutlet UIView *ContStappen;
    IBOutlet UIView *ContMovie;
    IBOutlet MPMoviePlayerController *movie;
    
    IBOutlet UILabel *lblMovie;
    IBOutlet UILabel *lblBuurt;
    IBOutlet UILabel *lblFaq;
    IBOutlet UITextView *txtFaq;
    
    IBOutlet UILabel *lblVraag;
    IBOutlet UITextView *txtVraag;
    
    IBOutlet UILabel *lblGoedeDoel;
    IBOutlet UILabel *lblDoel;
    IBOutlet UILabel *lblProcentDoel;
    IBOutlet UILabel *lblStappen;
    IBOutlet UILabel *lblStap1;
    IBOutlet UILabel *lblStap2;
    IBOutlet UILabel *lblStap3;
    IBOutlet UILabel *lblStap4;
    IBOutlet UILabel *lblStap5;
    IBOutlet UILabel *lblPerDeelname;
    IBOutlet UILabel *lblDeelname;
    IBOutlet UILabel *lblAantalDeelname;
    
    
    
    IBOutlet UIProgressView *progGoedeDoel;
    IBOutlet UIProgressView *progStap1;
    IBOutlet UIProgressView *progStap2;
    IBOutlet UIProgressView *progStap3;
    IBOutlet UIProgressView *progStap4;
    IBOutlet UIProgressView *progStap5;
    
   
    
    NSInteger currentDistrict;
}
@property (strong, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@property glMapViewDelegate *mapDelegate;
@property (strong, nonatomic) NSJSONSerialization *selectedDistrictNOTCURREND;
- (void)setSelectedDistrictNOTCURREND:(NSJSONSerialization *)selectedDistrict;
@property (strong, nonatomic)NSMutableArray *districts;
- (IBAction)showWelcome:(id)sender;
- (IBAction)goToRegister:(id)sender;
- (IBAction)goToAndereWijk:(id)sender;
- (IBAction)goToCommitment:(id)sender;
- (IBAction)goToProvider:(id)sender;
-(void)goToBuddyDetail;
@end

