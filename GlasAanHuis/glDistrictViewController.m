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
    lblMovie = [[UILabel alloc]initWithFrame:CGRectMake(5, 580, 100, 50)];
    lblMovie.text = @"Buurt video";
    lblMovie.textColor= [UIColor whiteColor];
    ContMovie = [[UIView alloc]initWithFrame:self.view.frame];
    [ContMovie setFrame:CGRectMake(5, 620, 310, 160)];
    [ContMovie setBackgroundColor:[UIColor colorWithRed:(173/255.0) green:(173/255.0) blue:(173/255.0) alpha:0.4]];
  
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Comp2" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    movie = [[MPMoviePlayerController alloc] initWithContentURL:url];
    [movie.view setFrame:CGRectMake(0, 0, 310, 160)];
    
    //[movie play];
    [movie prepareToPlay];
    //[movie pause];
    movie.shouldAutoplay = false;
    [ContMovie addSubview:movie.view];
    [scroller addSubview:ContMovie];
    [scroller addSubview:lblMovie];
    
    
    //Kaartje voor de wijk
    lblBuurt = [[UILabel alloc]initWithFrame:CGRectMake(5, 780, 100, 50)];
    lblBuurt.text = @"Buurt kaart";
    lblBuurt.textColor= [UIColor whiteColor];
    map = [[MKMapView alloc]initWithFrame:self.view.frame];
    [map setFrame:CGRectMake(5, 820, 310, 180)];
    [scroller addSubview:map];
    [scroller addSubview:lblBuurt];
    
    //Goede doelen
    lblGoedeDoel = [[UILabel alloc]initWithFrame:CGRectMake(5, 1010, 150, 30)];
    lblGoedeDoel.text = @"Goede doel";
    lblGoedeDoel.textColor = [UIColor whiteColor];
    ContGoedeDoel = [[UIView alloc]initWithFrame:self.view.frame];
    progGoedeDoel = [[UIProgressView alloc] initWithFrame:CGRectMake(5, 80, 300, 20)];
    progGoedeDoel.progressViewStyle = UIProgressViewStyleBar;
    progGoedeDoel.progress = 0.3;
    progGoedeDoel.progressTintColor = [UIColor greenColor];
    progGoedeDoel.backgroundColor = [UIColor whiteColor];
    lblDoel = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 300, 50)];
    lblDoel.text = @"Gratis glasvezel voor de Avans";
    lblDoel.textColor = [UIColor whiteColor];
    lblProcentDoel = [[UILabel alloc]initWithFrame:CGRectMake(5, 50, 150, 30)];
    lblProcentDoel.text = @"30%";
    lblProcentDoel.textColor = [UIColor whiteColor];
    
    [ContGoedeDoel setFrame:CGRectMake(5, 1040, 310, 100)];
    [ContGoedeDoel.layer setBorderWidth:1.0];
    ContGoedeDoel.layer.BorderColor = [UIColor grayColor].CGColor;
    [ContGoedeDoel setBackgroundColor:[UIColor colorWithRed:(173/255.0) green:(173/255.0) blue:(173/255.0) alpha:0.4]];
    [ContGoedeDoel addSubview:progGoedeDoel];
    [ContGoedeDoel addSubview:lblDoel];
    [ContGoedeDoel addSubview:lblProcentDoel];
    [scroller addSubview:lblGoedeDoel];
    [scroller addSubview:ContGoedeDoel];
    
    //Faq
    lblFaq = [[UILabel alloc]initWithFrame:CGRectMake(5, 1150, 300, 30)];
    lblFaq.text = @"Veel gestelde vragen";
    lblFaq.textColor = [UIColor whiteColor];
    
    txtFaq = [[UITextView alloc]initWithFrame:CGRectMake(5, 10, 310, 80)];
    txtFaq.text = @"Hier vindt u de meest gestelde vragen omtrent de app en glasvezel.";
    txtFaq.textColor = [UIColor whiteColor];
    txtFaq.font = [UIFont systemFontOfSize:17];
    txtFaq.editable = NO;
    [txtFaq setBackgroundColor:[UIColor colorWithRed:(173/255.0) green:(173/255.0) blue:(173/255.0) alpha:0]];
    ContFaq = [[UIView alloc]initWithFrame:self.view.frame];
    [ContFaq setFrame:CGRectMake(5, 1180, 310, 80)];
    [ContFaq.layer setBorderWidth:1.0];
    ContFaq.layer.BorderColor = [UIColor grayColor].CGColor;
    [ContFaq setBackgroundColor:[UIColor colorWithRed:(173/255.0) green:(173/255.0) blue:(173/255.0) alpha:0.4]];
    [ContFaq addSubview:txtFaq];
    [scroller addSubview:lblFaq];
    [scroller addSubview:ContFaq];
    
    //vraag
    lblVraag = [[UILabel alloc]initWithFrame:CGRectMake(5, 1270, 300, 30)];
    lblVraag.text = @"Stel uw vraag";
    lblVraag.textColor = [UIColor whiteColor];
    
    txtVraag = [[UITextView alloc]initWithFrame:CGRectMake(5, 10, 310, 80)];
    txtVraag.text = @"Hier kunt u vragen stellen over de app en glasvezel.";
    txtVraag.textColor = [UIColor whiteColor];
    txtVraag.font = [UIFont systemFontOfSize:17];
    txtVraag.editable = NO;
    [txtVraag setBackgroundColor:[UIColor colorWithRed:(173/255.0) green:(173/255.0) blue:(173/255.0) alpha:0]];
    ContVraag = [[UIView alloc]initWithFrame:self.view.frame];
    [ContVraag setFrame:CGRectMake(5, 1300, 310, 80)];
    [ContVraag.layer setBorderWidth:1.0];
    ContVraag.layer.BorderColor = [UIColor grayColor].CGColor;
    [ContVraag setBackgroundColor:[UIColor colorWithRed:(173/255.0) green:(173/255.0) blue:(173/255.0) alpha:0.4]];
    [ContVraag addSubview:txtVraag];
    [scroller addSubview:lblVraag];
    [scroller addSubview:ContVraag];
    
    
    //Stappen
    ContStappen = [[UIView alloc]initWithFrame:self.view.frame];
    lblStappen = [[UILabel alloc]initWithFrame:CGRectMake(5, 1390, 150, 30)];
    lblStappen.text = @"Stappen";
    lblStappen.textColor = [UIColor whiteColor];
    lblStap1 = [[UILabel alloc]initWithFrame:CGRectMake(5, 10, 300, 30)];
    [lblStap1 setFont:[UIFont systemFontOfSize:17]];
    lblStap1.text = @"1. Bewoners verzamelen 22%";
    lblStap1.textColor = [UIColor whiteColor];
    lblStap2 = [[UILabel alloc]initWithFrame:CGRectMake(5, 50, 300, 30)];
    [lblStap2 setFont:[UIFont systemFontOfSize:17]];
    lblStap2.text = @"2. Inschrijven 9%";
    lblStap2.textColor = [UIColor whiteColor];
    lblStap3 = [[UILabel alloc]initWithFrame:CGRectMake(5, 90, 300, 30)];
    [lblStap3 setFont:[UIFont systemFontOfSize:17]];
    lblStap3.text = @"3. Provider selecteren 2%";
    lblStap3.textColor = [UIColor whiteColor];
    lblStap4 = [[UILabel alloc]initWithFrame:CGRectMake(5, 130, 300, 30)];
    [lblStap4 setFont:[UIFont systemFontOfSize:17]];
    lblStap4.text = @"4. Glasvezel aanleggen 0%";
    lblStap4.textColor = [UIColor whiteColor];
    lblStap5 = [[UILabel alloc]initWithFrame:CGRectMake(5, 170, 300, 30)];
    [lblStap5 setFont:[UIFont systemFontOfSize:17]];
    lblStap5.text = @"5. Overstappen naar glasvezel 0%";
    lblStap5.textColor = [UIColor whiteColor];
    
    progStap1 = [[UIProgressView alloc] initWithFrame:CGRectMake(5, 40, 300, 20)];
    progStap1.progressViewStyle = UIProgressViewStyleBar;
    progStap1.progress = 0.22;
    progStap1.progressTintColor = [UIColor greenColor];
    progStap1.backgroundColor = [UIColor whiteColor];
    progStap2 = [[UIProgressView alloc] initWithFrame:CGRectMake(5, 80, 300, 20)];
    progStap2.progressViewStyle = UIProgressViewStyleBar;
    progStap2.progress = 0.09;
    progStap2.progressTintColor = [UIColor greenColor];
    progStap2.backgroundColor = [UIColor whiteColor];
    progStap3 = [[UIProgressView alloc] initWithFrame:CGRectMake(5, 120, 300, 20)];
    progStap3.progressViewStyle = UIProgressViewStyleBar;
    progStap3.progress = 0.02;
    progStap3.progressTintColor = [UIColor greenColor];
    progStap3.backgroundColor = [UIColor whiteColor];
    progStap4 = [[UIProgressView alloc] initWithFrame:CGRectMake(5, 160, 300, 20)];
    progStap4.progressViewStyle = UIProgressViewStyleBar;
    progStap4.progress = 0.0;
    progStap4.progressTintColor = [UIColor greenColor];
    progStap4.backgroundColor = [UIColor whiteColor];
    progStap5 = [[UIProgressView alloc] initWithFrame:CGRectMake(5, 200, 300, 20)];
    progStap5.progressViewStyle = UIProgressViewStyleBar;
    progStap5.progress = 0.0;
    progStap5.progressTintColor = [UIColor greenColor];
    progStap5.backgroundColor = [UIColor whiteColor];
    [ContStappen setFrame:CGRectMake(5, 1420, 310, 240)];
    [ContStappen setBackgroundColor:[UIColor colorWithRed:(173/255.0) green:(173/255.0) blue:(173/255.0) alpha:0.4]];
    [ContStappen.layer setBorderWidth:1.0];
    ContStappen.layer.BorderColor = [UIColor grayColor].CGColor;
    [scroller addSubview:lblStappen];
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
    
    
    
    //percentage
    lblPerDeelname = [[UILabel alloc]initWithFrame:CGRectMake(220, 1680, 150, 50)];
    [lblPerDeelname setFont:[UIFont systemFontOfSize:45]];
    lblPerDeelname.textColor = [UIColor whiteColor];
    lblPerDeelname.text = @"55%";
    [scroller addSubview:lblPerDeelname];
    
    lblDeelname = [[UILabel alloc]initWithFrame:CGRectMake(85, 1688, 200, 50)];
    [lblDeelname setFont:[UIFont systemFontOfSize:25]];
    lblDeelname.textColor = [UIColor whiteColor];
    lblDeelname.text = @"deelnemers";
    [scroller addSubview:lblDeelname];
    
    lblAantalDeelname = [[UILabel alloc]initWithFrame:CGRectMake(5, 1680, 150, 50)];
    [lblAantalDeelname setFont:[UIFont systemFontOfSize:45]];
    lblAantalDeelname.textColor = [UIColor whiteColor];
    lblAantalDeelname.text = @"106";
    [scroller addSubview:lblAantalDeelname];
    
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
        //[self performSegueWithIdentifier:@"register" sender:self];
    [self performSegueWithIdentifier:@"buddyDetail" sender:self];
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
    plainView.wijkPercent.text = [NSString stringWithFormat:@"%g%@",[[district valueForKey:@"percentage"] doubleValue]*100,@"%"];
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
