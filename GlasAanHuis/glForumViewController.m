//
//  glForumViewController.m
//  GlasAanHuis
//
//  Created by leon on 07/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import "glForumViewController.h"

@interface glForumViewController ()

@end

@implementation glForumViewController
NSArray *menuItems;
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
    menuItems = @[@"ForumItem1",@"ForumItem12",@"ForumItem13",@"ForumItem14",@"ForumItem15",@"6"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [menuItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    /*
     // Set the title of navigation bar by using the menu items
     NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
     UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
     destViewController.title = [[menuItems objectAtIndex:indexPath.row] capitalizedString];
     
     // Set the photo if it navigates to the PhotoView
     if ([segue.identifier isEqualToString:@"showPhoto"]) {
     PhotoViewController *photoController = (PhotoViewController*)segue.destinationViewController;
     NSString *photoFilename = [NSString stringWithFormat:@"%@_photo.jpg", [menuItems objectAtIndex:indexPath.row]];
     photoController.photoFilename = photoFilename;
     }
     
     if ( [segue isKindOfClass: [SWRevealViewControllerSegue class]] ) {
     SWRevealViewControllerSegue *swSegue = (SWRevealViewControllerSegue*) segue;
     
     swSegue.performBlock = ^(SWRevealViewControllerSegue* rvc_segue, UIViewController* svc, UIViewController* dvc) {
     
     UINavigationController* navController = (UINavigationController*)self.revealViewController.frontViewController;
     [navController setViewControllers: @[dvc] animated: NO ];
     [self.revealViewController setFrontViewPosition: FrontViewPositionLeft animated: YES];
     };
     
     }
     */
}

@end
