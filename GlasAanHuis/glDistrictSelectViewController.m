//
//  glDistrictSelectViewController.m
//  GlasAanHuis
//
//  Created by leroy on 06/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glDistrictSelectViewController.h"

@interface glDistrictSelectViewController ()
@property NSMutableArray *districts;
@property NSJSONSerialization *selectedDistrict;

@end

@implementation glDistrictSelectViewController

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
    //NSArray * myArray = @[@"one", @"two", @"three"];
    //_districts = [myArray mutableCopy];
    [_searchTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [_searchTF setDelegate:self];
    
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
-(void)textFieldDidChange :(UITextField *)theTextField{
    //NSLog( @"text changed: %@", _searchTF.text);
    
    NSString* zipcode = _searchTF.text;
    
    NSString *path = [NSString stringWithFormat:@"http://glas.mycel.nl/districts?search=%@",zipcode];
    
    NSURL* url = [NSURL URLWithString:path];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:url];
    req.HTTPMethod = @"GET";
    
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    queue.name = @"eennaam";
    
    [NSURLConnection sendAsynchronousRequest:req queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError != nil) {
            // doe iets met url
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            self.districts = [[NSJSONSerialization JSONObjectWithData:data options:0 error:nil] mutableCopy];
            
            [self.districtTABLE reloadData];
        }];
        
    }];}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [[_districts objectAtIndex:indexPath.row] valueForKey:@"name"];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_districts count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSJSONSerialization *district = [self.districts objectAtIndex:indexPath.row];
    _selectedDistrict = district;
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"backstart"]) {
        [segue.destinationViewController setSelectedDistrict:_selectedDistrict];
    }
    
}


- (IBAction)doneBTN:(id)sender {
    if(_selectedDistrict != nil){
        NSLog( @"selectedDistrict: %@", _selectedDistrict);
        [self performSegueWithIdentifier:@"backstart" sender:self];
    }
}
@end
