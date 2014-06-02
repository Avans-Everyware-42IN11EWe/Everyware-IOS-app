//
//  glBuddyChatViewController.h
//  GlasAanHuis
//
//  Created by leon on 24/05/14.
//  Copyright (c) 2014 GlasAanHuis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface glBuddyChatViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtMessageToSend;
- (IBAction)sendMessage:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *messageTable;
@property (strong, nonatomic) NSString *senderID;
@property (strong, nonatomic) NSString *recieverID;
@property (strong, nonatomic) IBOutlet UIImageView *ReceiverImage;
@property (strong, nonatomic) UIImage *cSenderImage;
@property (strong, nonatomic) UIImage *cReceiverImage;
@property (strong, nonatomic) IBOutlet UILabel *ReceiverName;
@end
NSArray *roomLines;
NSTimer *timer;
