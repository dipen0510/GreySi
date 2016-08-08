//
//  ChatDetailViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 08/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSQMessagesViewController.h"

@interface ChatDetailViewController : JSQMessagesViewController

@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

- (IBAction)backButtonTapped:(id)sender;

@end
