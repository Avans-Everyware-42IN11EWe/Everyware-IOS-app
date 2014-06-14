//
//  glMyProfileSettingsChangeViewController.m
//  GlasAanHuis
//
//  Created by leroy on 14/06/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glMyProfileSettingsChangeViewController.h"
#import "glPictureViewSettingsController.h"

@interface glMyProfileSettingsChangeViewController ()

@end

@implementation glMyProfileSettingsChangeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)setProfileFoto:(UIImage *)profileFoto
{
    _profileFoto = profileFoto;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"settingsfotokiezen"]) {
        [segue.destinationViewController setRegController:self];
    }
}
- (IBAction)save:(id)sender {
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults valueForKey:@"userID"];
    NSString *authToken = [defaults valueForKey:@"authToken"];
    [self postUserData: userID: authToken];
    
    if(_profileFoto != nil){
        CGSize newSize = CGSizeMake(400.0f, 400.0f);
        UIGraphicsBeginImageContext(newSize);
        [_profileFoto drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        [self pictureUpload: newImage: userID: authToken];
    }
    [self performSegueWithIdentifier:@"terugMyprofile" sender:self];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *senderID = [defaults valueForKey:@"userID"];
    NSJSONSerialization *user =[self getUser:senderID];
    //NSJSONSerialization *user =[self getUser:@"238"];
    self.MyProfileName.text = [user valueForKey:@"naam"];
    self.MyProfileAge.text = [NSString stringWithFormat:@"%@",[user valueForKey:@"leeftijd"]];
    self.MyProfileLocation.text = [NSString stringWithFormat:@"%@",[user valueForKey:@"adres"]];
    self.MyProfileEmail.text = [NSString stringWithFormat:@"%@",[user valueForKey:@"email"]];
    self.MyProfilePhone.text = [NSString stringWithFormat:@"%@",[user valueForKey:@"telefoon"]];
    
    NSString *isbuddy = [NSString stringWithFormat:@"%@",[user valueForKey:@"is_buddy"]];

    if([isbuddy isEqualToString:@"false"]){
        [self.IWantToBeABuddy setOn:NO];
    }else if ([isbuddy isEqualToString:@"true"]){
        [self.IWantToBeABuddy setOn:YES];
    }
    
    self.MyProfileName.delegate = self;
    self.MyProfileAge.delegate = self;
    self.MyProfileLocation.delegate = self;
    self.MyProfileEmail.delegate = self;
    self.MyProfilePhone.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSJSONSerialization*)getUser:(NSString *)userId
{
    NSString *path = [NSString stringWithFormat:@"http://glas.mycel.nl/buddy?id=%@",userId];
    NSString *urlstring = [NSString stringWithFormat:path];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"GET";
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    NSJSONSerialization *user = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] mutableCopy];
    
    if (error == nil)
    {
        
    }
    NSLog(@"%@",user);
    return user;
}

-(NSArray*)postUserData:(NSString *) userID:(NSString *) authToken
{
    NSString *naam = self.MyProfileName.text;
    NSString *leeftijd = self.MyProfileAge.text;
    NSString *adres = self.MyProfileLocation.text;
    NSString *telefoon = self.MyProfilePhone.text ;
    NSString *email = self.MyProfileEmail.text;
    NSString *is_buddy = @"false";
    if(self.IWantToBeABuddy.on){
         is_buddy = @"true";
    }

    
    NSDictionary *tmp = [[NSDictionary alloc]initWithObjectsAndKeys:
                         naam,@"naam",
                         leeftijd,@"leeftijd",
                         adres,@"adres",
                         telefoon,@"telefoon",
                         email,@"email",
                         is_buddy,@"is_buddy", nil];
    NSError *postError;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:NSASCIIStringEncoding error:&postError];
    
    NSString *path = [NSString stringWithFormat:@"http://glas.mycel.nl/profile?user_id=%@&auth_token=%@",userID,authToken];
    
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:url];
    
    req.HTTPMethod=@"POST";
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setHTTPBody:postdata];
    
    NSData *data;
    NSURLResponse *response = nil;
    data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:nil];
    if (data == nil) {
        return [[NSArray alloc]init];
    }
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

-(void)pictureUpload:(UIImage*)image:(NSString *) userID:(NSString *) authToken
{
    //userID,@"id",authToken,@"auth_token",
    
    NSData *imageData = UIImagePNGRepresentation(image);//delegate.dataBean.image
    NSString *path = [NSString stringWithFormat:@"http://glas.mycel.nl/image?id=%@&auth_token=%@",userID,authToken];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:path]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"test.png\"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog([NSString stringWithFormat:@"Image Return String: %@", returnString]);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
