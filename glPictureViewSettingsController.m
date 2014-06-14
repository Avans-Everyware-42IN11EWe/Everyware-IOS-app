//
//  glPictureViewSettingsController.m
//  GlasAanHuis
//
//  Created by leroy on 14/06/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glPictureViewSettingsController.h"

@interface glPictureViewSettingsController ()
@property (strong, nonatomic) IBOutlet UIImageView *plaatje;
- (IBAction)gaVerder:(id)sender;
- (IBAction)voegToe:(id)sender;



@end
//glMyProfileSettingsChangeViewController
@implementation glPictureViewSettingsController
- (void)setRegController:(glMyProfileSettingsChangeViewController *)controller
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
