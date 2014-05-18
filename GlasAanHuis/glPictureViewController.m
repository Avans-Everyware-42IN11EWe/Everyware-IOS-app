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

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
	[picker dismissModalViewControllerAnimated:YES];
	_plaatje.image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
}


- (IBAction)gaVerder:(id)sender {
    [self performSegueWithIdentifier:@"register" sender:self];}


@end
