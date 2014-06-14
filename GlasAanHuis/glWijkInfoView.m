//
//  glWijkInfoView.m
//  GlasAanHuis
//
//  Created by Nanne on 18-05-14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glWijkInfoView.h"

@interface glWijkInfoView ()
- (IBAction)goToDistrictPage:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *placeholder;
@property (weak, nonatomic) IBOutlet UIView *wijkKiezen;
@property (weak, nonatomic) IBOutlet UIView *meedoen;
@property (weak, nonatomic) IBOutlet UIView *providerKiezen;
@property (weak, nonatomic) IBOutlet UIView *wachten;
@end

@implementation glWijkInfoView

- (void)didMoveToSuperview {
    int status = [self getUserStatus];
    switch (status) {
        case 0:
            [self.placeholder addSubview:self.wijkKiezen];
            break;
        case 2:
            [self.placeholder addSubview:self.meedoen];
            break;
        case 3:
            [self.placeholder addSubview:self.providerKiezen];
            break;
        case 4:
            [self.placeholder addSubview:self.wachten];
            break;
        default:
            [self.placeholder addSubview:self.wijkKiezen];
            break;
    }
}

- (IBAction)DITISMIJNWIJK:(id)sender {
    [self.eindbaas goToRegister:sender];
}

- (IBAction)kiesprovider:(id)sender {
    [self.eindbaas goToProvider:sender];
}

- (IBAction)ANDEREWIJK:(id)sender {
    [self.eindbaas goToAndereWijk:sender];
}

- (IBAction)ikdoemee:(id)sender {
    [self.eindbaas goToCommitment:sender];
}

- (IBAction)goToDistrictPage:(id)sender {
    NSString *str = [NSString stringWithFormat:@"fb://profile/%@", _fbId];
    NSURL *fburl = [NSURL URLWithString:str];
    
    if (![[UIApplication sharedApplication] openURL:fburl])
    {
        fburl =   [ NSURL URLWithString:_fbName];
    }
    [[UIApplication sharedApplication] openURL:fburl];
}
-(int)getUserStatus
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *_userID = [defaults valueForKey:@"userID"];
    NSString *_authtoken = [defaults valueForKey:@"authToken"];
    NSString *path = [NSString stringWithFormat:@"http://glas.mycel.nl/progress?id=%@&auth_token=%@",_userID,_authtoken];
    NSString *urlstring = [NSString stringWithFormat:path];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"GET";
    NSURLResponse * response = nil;
    NSError * error = nil;
    NSData * data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    NSJSONSerialization *statuses = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] mutableCopy];
    
    if (error == nil)
    {
        
    }
    int status = [[statuses valueForKey:@"status"] intValue];
    
    return status;

}
@end
