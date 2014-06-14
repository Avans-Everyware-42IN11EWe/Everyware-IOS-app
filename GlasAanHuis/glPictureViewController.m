//
//  glPictureViewController.m
//  GlasAanHuis
//
//  Created by leon on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glPictureViewController.h"


@interface glPictureViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *plaatje;
- (IBAction)voegToe:(id)sender;
- (IBAction)veranderPlaatje:(id)sender;

- (IBAction)gaVerder:(id)sender;

@end

@implementation glPictureViewController
- (void)setRegController:(glRegisterViewController *)controller
{
    _regController = controller;
}
//-(void)setDistrictID:(NSString *)districtID
//{
//    _districtID = districtID;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)voegToe:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentModalViewController:picker animated:YES];
}

//-(void)viewWillDisappear:(BOOL)animated{
//    //if([self.navigationController.viewControllers indexOfObject:self]==NSNotFound){
//        //iets doen
//        glRegisterViewController *regController = nil;
//        NSInteger myIndex = [self.navigationController.viewControllers indexOfObject:self];
//        
//        if ( myIndex != 0 && myIndex != NSNotFound ) {
//            regController = [self.navigationController.viewControllers objectAtIndex:myIndex-1];
//        }
//        if(regController != nil){
//            [regController setProfileFoto:_plaatje.image];
//        }
//
//    //}
//}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];

	_plaatje.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}


- (IBAction)gaVerder:(id)sender {
    [_regController setProfileFoto:_plaatje.image];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
