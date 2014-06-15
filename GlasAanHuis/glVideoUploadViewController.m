//
//  glVideoUploadViewController.m
//  GlasAanHuis
//
//  Created by leon on 07/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glVideoUploadViewController.h"
#import "SWRevealViewController.h"
@interface glVideoUploadViewController ()

@end

@implementation glVideoUploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _sideBarButton.tintColor = [UIColor colorWithWhite:0.1f alpha:0.9f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sideBarButton.target = self.revealViewController;
    _sideBarButton.action = @selector(revealToggle:);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)save:(id)sender {
}

- (IBAction)leukeVideoToevoegen:(id)sender {
    //[self performSegueWithIdentifier:@"playView" sender:self];
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

- (IBAction)leukeVideoOpnemen:(id)sender {
    //[self performSegueWithIdentifier:@"recView" sender:self];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        
        [self presentViewController:picker animated:YES completion:NULL];
    }
}



-(BOOL)startMediaBrowserFromViewController:(UIViewController*)controller usingDelegate:(id )delegate {
    // 1 - Validations
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    // 2 - Get image picker
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc] init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mediaUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = delegate;
    // 3 - Display image picker
    [controller presentModalViewController:mediaUI animated:YES];
    return YES;
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // 1 - Get media type
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    // 2 - Dismiss image picker
    [self dismissModalViewControllerAnimated:NO];
//    // Handle a movie capture
//    if (CFStringCompare ((__bridge_retained CFStringRef)mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
//        // 3 - Play the video
//        MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc]
//                                                 initWithContentURL:[info objectForKey:UIImagePickerControllerMediaURL]];
//        [self presentMoviePlayerViewControllerAnimated:theMovie];
//        // 4 - Register for the playback finished notification
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myMovieFinishedCallback:)
//                                                     name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
//    }
    
    NSURL *videoURL = info[UIImagePickerControllerMediaURL];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    _mc = [[MPMoviePlayerController alloc] init];
    [_mc setContentURL:videoURL];
    [_mc.view setFrame:CGRectMake (0, 0, 260, 160)];
    [_videoView addSubview:_mc.view];
    //[_mc play];
    [_mc prepareToPlay];
    _mc.shouldAutoplay = false;
}

//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
//    
//    self.videoURL = info[UIImagePickerControllerMediaURL];
//    [picker dismissViewControllerAnimated:YES completion:NULL];
//    
//    self.videoController = [[MPMoviePlayerController alloc] init];
//    
//    [self.videoController setContentURL:self.videoURL];
//    [self.videoController.view setFrame:CGRectMake (0, 0, 320, 460)];
//    [self.view addSubview:self.videoController.view];
//    
//    [self.videoController play];
//    
//}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}


@end
