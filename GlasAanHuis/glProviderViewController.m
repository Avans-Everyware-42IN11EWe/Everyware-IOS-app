//
//  glProviderViewController.m
//  GlasAanHuis
//
//  Created by leon on 25/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glProviderViewController.h"

@interface glProviderViewController ()

@end

@implementation glProviderViewController

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
    providers = [self getProviders];
    
    switchArray = [NSMutableArray array];
    
    NSUserDefaults*defaults =[NSUserDefaults standardUserDefaults];
    
    lijst = [self executeProviders:[defaults valueForKey:@"userID"]];
    ////lijst = providers;
    NSLog(@"%@",lijst);
    for (int i = 0; i < lijst.count; i++) {
        NSLog(@"%@",[lijst[i] valueForKey:@"name"]);
        NSString *str = [NSString stringWithFormat:@"%@",[lijst[i] valueForKey:@"name"]];
        UISwitch *switc = [[UISwitch alloc]initWithFrame:CGRectMake(50, 200+(i*40), 60, 40)];
        switc.tag = [[lijst[i] valueForKey:@"id"]intValue];
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(120, 200+(i*40), 300, 40)];
        lbl.text = str;
        [switchArray addObject:switc];
        [self.view addSubview:lbl];
        [self.view addSubview:switc];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSJSONSerialization*)getProviders
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [defaults valueForKey:@"userID"];
    NSString *path = [NSString stringWithFormat:@"http://glas.mycel.nl/providers?user_id=%@",userId];
    NSURL *url = [NSURL URLWithString:path];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"GET";
    NSURLResponse * response = nil;
    NSError * error = nil;
    
    NSData * data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    //lijst = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    return [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] mutableCopy];
}

-(NSArray*)executeProviders:(NSString*)MyID
{
    NSString *urlstring = [NSString stringWithFormat:@"http://glas.mycel.nl/providers?user_id=%@",MyID];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:url];
    
    NSData *data;
    NSError *error;
    NSURLResponse *response = nil;
    data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:&error];
    if (data == nil) {
        return [[NSArray alloc]init];
    }
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
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

- (IBAction)providerChosen:(id)sender {
    [self postProviders];

}
-(void)postProviders
{
    NSMutableArray *providerArray = [NSMutableArray array];
    for (UISwitch*sw in switchArray) {
        if ([sw isOn]) {
            int integer = sw.tag;
            NSString*string = [NSString stringWithFormat:@"%d",integer];
            [providerArray addObject:string];
        }
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [defaults valueForKey:@"userID"];
    NSString *authtoken = [defaults valueForKey:@"authToken"];
    NSLog(@"%@",userID);
    NSError *postError;
    NSString *str = [providerArray componentsJoinedByString:@","];
    NSLog(@"%@",str);
    NSString *postArray = [NSString stringWithFormat:@"[%@]",str];
    NSData *postdata = [postArray dataUsingEncoding:NSUTF8StringEncoding];
    NSString *urlstring = [NSString stringWithFormat:@"http://glas.mycel.nl/providers?user_id=%@&auth_token=%@",userID,authtoken];
    NSURL *url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:url];
    
    req.HTTPMethod=@"POST";
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setHTTPBody:postdata];
    
    NSData *data;
    NSURLResponse *response = nil;
    data = [NSURLConnection sendSynchronousRequest:req returningResponse:&response error:nil];
}
@end
