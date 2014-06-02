//
//  glRegisterViewController.m
//  GlasAanHuis
//
//  Created by leroy on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glRegisterViewController.h"

@interface glRegisterViewController ()
@end

@implementation glRegisterViewController
-(void)setDistrictID:(NSString *)districtID
{
    _districtID = districtID;
}

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
    self.facbookLoginBTN.delegate = self;
    self.facbookLoginBTN.readPermissions = @[@"public_profile", @"email"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
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
// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}
- (IBAction)loginBTN:(id)sender {
    NSArray * result = [self registerUser];
    NSLog(@"%@", [ result valueForKey:@"user_id"]);
    NSString * userID = [ result valueForKey:@"user_id"];
    //[[_districts objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    if (userID !=nil && ![_emailTV.text isEqualToString:@""]) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:userID forKey:@"userID"];
        [defaults setValue:_districtID forKeyPath:@"districtID"];
        //WEGHALEN
        [defaults setValue:@"1" forKey:@"userStatus"];
        [defaults synchronize];
        [self performSegueWithIdentifier:@"start" sender:self];
    }
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    NSLog(@"facebook result: %@", @"You're logged in as");
    [FBRequestConnection startForMeWithCompletionHandler:
    ^(FBRequestConnection *connection, id result, NSError *error)
    {
    NSLog(@"facebook result: %@", result);
    }];
    NSString *fbAccessToken = [[[FBSession activeSession] accessTokenData] accessToken];
    NSLog(@"facebook result: %@", fbAccessToken);
    //
    NSArray * result = [self registerUserFacbook:fbAccessToken];
    
    NSString * userID = [ result valueForKey:@"user_id"];
    NSLog(@"USERID!!!!%@", userID );
    //[[_districts objectAtIndex:indexPath.row] valueForKey:@"name"];
    
    if (userID !=nil) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setValue:fbAccessToken forKey:@"userID"];
        [defaults setValue:_districtID forKeyPath:@"districtID"];
        //WEGHALEN
        [defaults setValue:@"1" forKey:@"userStatus"];
        [defaults synchronize];
        [self performSegueWithIdentifier:@"start" sender:self];
    }
}

-(NSArray*)registerUser
{
    NSDictionary *tmp = [[NSDictionary alloc]initWithObjectsAndKeys:_emailTV.text,@"email",@"HOEFT NIET",@"name",@"lat",@"latlong",_districtID,@"district_id", nil];
    NSError *postError;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:NSASCIIStringEncoding error:&postError];
    
    NSURL *url = [NSURL URLWithString:@"http://glas.mycel.nl/register"];
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
-(NSArray *)registerUserFacbook:(NSString*)token
{
    NSDictionary *tmp = [[NSDictionary alloc]initWithObjectsAndKeys:token,@"access_token",_districtID,@"district_id", nil];
    NSError *postError;
    NSData *postdata = [NSJSONSerialization dataWithJSONObject:tmp options:NSASCIIStringEncoding error:&postError];
    
    NSURL *url = [NSURL URLWithString:@"http://glas.mycel.nl/facebook"];
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

@end
