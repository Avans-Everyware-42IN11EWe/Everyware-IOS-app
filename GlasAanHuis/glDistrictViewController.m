//
//  glDistrictViewController.m
//  GlasAanHuis
//
//  Created by leroy on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
///Users/leon/Everyware-IOS-app/GlasAanHuis/WijkInfo.xib

#import "glDistrictViewController.h"
#import "glRegisterViewController.h"
#import "glBlurView.h"
#import "SWRevealViewController.h"
#import "glWijkInfoView.h"
#define kDKTableViewDefaultContentInset 0.0f

@interface glDistrictViewController ()

@end

@implementation glDistrictViewController

glWijkInfoView *plainView;
-(void)setSelectedDistrict:(NSJSONSerialization *)selectedDistrict
{
    _selectedDistrict = selectedDistrict;
}

- (IBAction)showWelcome:(id)sender {
    [MTPopupWindow showWindowWithHTMLFile:@"info.html" insideView:self.view];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    
////    NSDictionary *jsonDictionary = [[NSDictionary alloc]initWithObjectsAndKeys:@"2.123",@"distance",@"2",@"id",@"Den Bosch Centrum",@"name",@"0.4",@"percentage",@"unknown",@"status", nil];
////    _selectedDistrict = [NSJSONSerialization dataWithJSONObject:jsonDictionary options:NSJSONWritingPrettyPrinted error:nil];
////    NSLog( @"selectedDistrict: %@", _selectedDistrict);
//    
//}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


- (void)oneFingerSwipeLeft:(UITapGestureRecognizer *)recognizer {
    NSLog(@"LEFT");
    // Insert your own code to handle swipe left
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromRight];
    [animation setDuration:0.50];
    [animation setTimingFunction:
     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [scroller.layer addAnimation:animation forKey:kCATransition];
    
    
    currentDistrict++;
    if(currentDistrict >= [self.districts count]){
        currentDistrict = 0;
    }
    
    [self setDistrictView:[self.districts[currentDistrict] valueForKey:@"id"]];
}

- (void)oneFingerSwipeRight:(UITapGestureRecognizer *)recognizer {
    NSLog(@"RIGHT");
    CATransition *animation = [CATransition animation];
    [animation setDelegate:self];
    [animation setType:kCATransitionPush];
    [animation setSubtype:kCATransitionFromLeft];
    [animation setDuration:0.40];
    [animation setTimingFunction:
     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [scroller.layer addAnimation:animation forKey:kCATransition];
    
    if(currentDistrict -1 < 0){
        currentDistrict = [self.districts count]-1;
    }else{
        currentDistrict--;
    }
    
    [self setDistrictView:[self.districts[currentDistrict] valueForKey:@"id"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    // Add swipeGestures
    UISwipeGestureRecognizer *oneFingerSwipeLeft = [[UISwipeGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(oneFingerSwipeLeft:)];
    [oneFingerSwipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [[self view] addGestureRecognizer:oneFingerSwipeLeft];
    
    UISwipeGestureRecognizer *oneFingerSwipeRight = [[UISwipeGestureRecognizer alloc]
                                                      initWithTarget:self
                                                      action:@selector(oneFingerSwipeRight:)];
    [oneFingerSwipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [[self view] addGestureRecognizer:oneFingerSwipeRight];
    
    
    
    

    scroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320,1800)];
    //UIView *masterView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    //[scroller addSubview:scroller];
    
    glBlurView *backgroundView = [[glBlurView alloc] initWithFrame: self.view.bounds];
    backgroundView.originalImage = [UIImage imageNamed:@"1979672_1451730748396471_1888089831_n.jpg"];
    backgroundView.scrollView = scroller;
    backgroundView.isGlassEffectOn = YES;
    
    
    [self.view addSubview:backgroundView];
    scroller.contentInset = UIEdgeInsetsMake(kDKTableViewDefaultContentInset, 0, 0, 0);
    //self.tableView.contentInset = UIEdgeInsetsMake(kDKTableViewDefaultContentInset, 0, 0, 0);
    
    
    [self.view addSubview:scroller];
    
    //[scroller setScrollEnabled:YES];
    //[scroller setContentSize:CGSizeMake(320,1800)];
    
    // Instantiate the nib content without any reference to it.
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"WijkInfo" owner:nil options:nil];
    
    // Find the view among nib contents (not too hard assuming there is only one view in it).
    plainView = [nibContents firstObject];
    plainView.eindbaas = self;
    
    // Some hardcoded layout.
    //CGSize padding = (CGSize){ 22.0, 22.0 };
   // plainView.frame = (CGRect){padding.width, padding.height, plainView.frame.size};
    
    // Add to the view hierarchy (thus retain).
    [scroller addSubview:plainView];
    
//    wijk = [[UIView alloc]initWithFrame:self.view.frame];
    
//    [wijk setFrame:CGRectMake(0, 0, 320, 575)];
//    [scroller addSubview:wijk];
    
    
    //Hoofdplaatje
//    imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imgres.jpg"]];
    
    
//    [imageView setFrame:CGRectMake(0,90,320,570)];
//    backGround = imageView.image;
//    
//    scroller.backgroundColor = [UIColor clearColor];
//    self.view.backgroundColor = [UIColor colorWithPatternImage:backGround];
//    
//    //[scroller addSubview:imageView];
    
    
    //video
    ContMovie = [[UIView alloc]initWithFrame:self.view.frame];
    [ContMovie setFrame:CGRectMake(30, 670, 260, 160)];
    [ContMovie setBackgroundColor:[UIColor colorWithRed:(173/255.0) green:(173/255.0) blue:(173/255.0) alpha:0.4]];
  
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Comp2" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    movie = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [movie.view setFrame:CGRectMake(0, 0, 260, 160)];
    
    //[movie play];
    [movie prepareToPlay];
    //[movie pause];
    movie.shouldAutoplay = false;
    [ContMovie addSubview:movie.view];
    [scroller addSubview:ContMovie];
    
    
    //Kaartje voor de wijk
    map = [[MKMapView alloc]initWithFrame:self.view.frame];
    [map setFrame:CGRectMake(30, 850, 260, 220)];
    [scroller addSubview:map];
    
    //Goede doelen
    ContGoedeDoel = [[UIView alloc]initWithFrame:self.view.frame];
    progGoedeDoel = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 120, 220, 20)];
    progGoedeDoel.progressViewStyle = UIProgressViewStyleBar;
    progGoedeDoel.progress = 0.3;
    lblGoedeDoel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 150, 30)];
    lblGoedeDoel.text = @"Goede doelen";
    [ContGoedeDoel setFrame:CGRectMake(30, 1080, 260, 160)];
    [ContGoedeDoel setBackgroundColor:[UIColor colorWithRed:(173/255.0) green:(173/255.0) blue:(173/255.0) alpha:0.4]];
    [ContGoedeDoel addSubview:progGoedeDoel];
    [ContGoedeDoel addSubview:lblGoedeDoel];
    [scroller addSubview:ContGoedeDoel];
    
    //Stappen
    ContStappen = [[UIView alloc]initWithFrame:self.view.frame];
    lblStappen = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 150, 30)];
    lblStappen.text = @"Stappen";
    lblStap1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 150, 30)];
    [lblStap1 setFont:[UIFont systemFontOfSize:8]];
    lblStap1.text = @"Stap 1";
    lblStap2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 90, 150, 30)];
    [lblStap2 setFont:[UIFont systemFontOfSize:8]];
    lblStap2.text = @"Stap 2";
    lblStap3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 130, 150, 30)];
    [lblStap3 setFont:[UIFont systemFontOfSize:8]];
    lblStap3.text = @"Stap 3";
    lblStap4 = [[UILabel alloc]initWithFrame:CGRectMake(10, 170, 150, 30)];
    [lblStap4 setFont:[UIFont systemFontOfSize:8]];
    lblStap4.text = @"Stap 4";
    lblStap5 = [[UILabel alloc]initWithFrame:CGRectMake(10, 210, 150, 30)];
    [lblStap5 setFont:[UIFont systemFontOfSize:8]];
    lblStap5.text = @"Stap 5";
    
    progStap1 = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 80, 220, 20)];
    progStap1.progressViewStyle = UIProgressViewStyleBar;
    progStap1.progress = 0.8;
    progStap2 = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 120, 220, 20)];
    progStap2.progressViewStyle = UIProgressViewStyleBar;
    progStap2.progress = 0.5;
    progStap3 = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 160, 220, 20)];
    progStap3.progressViewStyle = UIProgressViewStyleBar;
    progStap3.progress = 0.2;
    progStap4 = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 200, 220, 20)];
    progStap4.progressViewStyle = UIProgressViewStyleBar;
    progStap4.progress = 0.1;
    progStap5 = [[UIProgressView alloc] initWithFrame:CGRectMake(10, 240, 220, 20)];
    progStap5.progressViewStyle = UIProgressViewStyleBar;
    progStap5.progress = 0.05;
    [ContStappen setFrame:CGRectMake(30, 1250, 260, 260)];
    [ContStappen setBackgroundColor:[UIColor colorWithRed:(173/255.0) green:(173/255.0) blue:(173/255.0) alpha:0.4]];
    [ContStappen addSubview:lblStappen];
    [ContStappen addSubview:lblStap1];
    [ContStappen addSubview:lblStap2];
    [ContStappen addSubview:lblStap3];
    [ContStappen addSubview:lblStap4];
    [ContStappen addSubview:lblStap5];
    [ContStappen addSubview:progStap1];
    [ContStappen addSubview:progStap2];
    [ContStappen addSubview:progStap3];
    [ContStappen addSubview:progStap4];
    [ContStappen addSubview:progStap5];
    [scroller addSubview:ContStappen];
    
    //Buttons
    btnFaq = [[UIButton alloc] initWithFrame:CGRectMake(110, 1530, 120, 40)];
    [btnFaq setTitle:@"FAQ" forState:UIControlStateNormal];
    [btnFaq setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnFaq setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btnFaq setBackgroundColor:[UIColor blackColor]];
    btnForum = [[UIButton alloc] initWithFrame:CGRectMake(110, 1580, 120, 40)];
    [btnForum setTitle:@"Forum" forState:UIControlStateNormal];
    [btnForum setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnForum setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btnForum setBackgroundColor:[UIColor blackColor]];
    
    [scroller addSubview:btnFaq];
    [scroller addSubview:btnForum];
    
    //percentage
    lblDeelname = [[UILabel alloc]initWithFrame:CGRectMake(10, 1660, 150, 50)];
    [lblDeelname setFont:[UIFont systemFontOfSize:45]];
    lblDeelname.text = @"55%";
    [scroller addSubview:lblDeelname];
    
    // Change button color
    _sideBarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sideBarButton.target = self.revealViewController;
    _sideBarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    //[self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    [self getDistricts];
    
    NSLog(@"%@",self.districts);
   
    currentDistrict = 0;
    [self setDistrictView:[self.districts[0] valueForKey:@"id"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if ([segue.identifier isEqualToString:@"register"]) {
        //NSString * userID = [ _selectedDistrict valueForKey:@"id"];
        [segue.destinationViewController setDistrictID:@"testid"];
    }
}
- (IBAction)goToRegister:(id)sender {
    //if(_selectedDistrict != nil){
        [self performSegueWithIdentifier:@"register" sender:self];
    //}
}

- (IBAction)goToAndereWijk:(id)sender {
    //if(_selectedDistrict != nil){
    [self performSegueWithIdentifier:@"anders" sender:self];
    //}
}
-(void)setDistrictView:(NSInteger)index
{
    
    NSJSONSerialization *district =[self getDistrict:index];
    
    plainView.wijkName.text = [district valueForKey:@"name"];
    plainView.wijkPercent.text = [NSString stringWithFormat:@"%@%@",[[district valueForKey:@"percentage"]stringValue],@"%"];
    plainView.wijkDeelnemers.text = [[district valueForKey:@"participants"]stringValue];
    
}
-(void)getDistricts
{
    //NSDictionary *tmp = [[NSDictionary alloc]initWithObjectsAndKeys:_emailTV.text,@"email",_nameTV.text,@"name",@"lat",@"latlong",@"1",@"district_id", nil];
    //NSError *postError;
    //NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:NSASCIIStringEncoding error:&postError];
    
    NSURL *url = [NSURL URLWithString:@"http://glas.mycel.nl/districts?lat=51.983333&long=5.916667"];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"GET";
    //[req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[req setHTTPBody:postdata];
    
//    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
//    queue.name = @"eennaam";
//    
//    [NSURLConnection sendAsynchronousRequest:req queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//        if(connectionError != nil) {
//            // doe iets met url
//        }
//        
//        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//            self.districts = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] mutableCopy];
//        }];
//        
//    }];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    self.districts = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] mutableCopy];
    if (error == nil)
    {
        
    }
}
-(NSJSONSerialization*)getDistrict:(NSInteger)wijkId
{
    //NSDictionary *tmp = [[NSDictionary alloc]initWithObjectsAndKeys:_emailTV.text,@"email",_nameTV.text,@"name",@"lat",@"latlong",@"1",@"district_id", nil];
    //NSError *postError;
    //NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:NSASCIIStringEncoding error:&postError];
    NSString *path = [NSString stringWithFormat:@"http://glas.mycel.nl/district?id=%@",wijkId];
    NSString *urlstring = [NSString stringWithFormat:path];
    
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"GET";
    //[req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[req setHTTPBody:postdata];
    
    //    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    //    queue.name = @"eennaam";
    //
    //    [NSURLConnection sendAsynchronousRequest:req queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    //        if(connectionError != nil) {
    //            // doe iets met url
    //        }
    //
    //        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    //            self.districts = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] mutableCopy];
    //        }];
    //
    //    }];
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    NSJSONSerialization *district = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] mutableCopy];
    
    if (error == nil)
    {
        
    }
    NSLog(@"%@",district);
    return district;
}

@end
