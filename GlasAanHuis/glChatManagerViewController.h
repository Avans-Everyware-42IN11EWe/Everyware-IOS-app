//
//  glChatManagerViewController.h
//  GlasAanHuis
//
//  Created by leon on 15/06/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface glChatManagerViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *myMessages;
@property (strong, nonatomic) NSString *messageClickedID;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sideBarButton;
@end
NSArray *myMessageArray;
NSTimer *timer;
int lastMessage;
NSString *userID;
BOOL loaded = FALSE;