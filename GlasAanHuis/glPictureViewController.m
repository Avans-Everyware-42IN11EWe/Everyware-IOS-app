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
- (IBAction)gaVerder:(id)sender;

@end

@implementation glPictureViewController
- (void)setRegController:(glRegisterViewController *)controller
{
    _regController = controller;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)voegToe:(id)sender {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
	picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentModalViewController:picker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];

	_plaatje.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}

- (IBAction)gaVerder:(id)sender {
    [_regController setProfileFoto:_plaatje.image];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
