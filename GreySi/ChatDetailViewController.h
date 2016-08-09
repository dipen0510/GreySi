//
//  ChatDetailViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 08/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JSQMessagesViewController.h"
#import "JSQMessages.h"

@interface ChatDetailViewController : JSQMessagesViewController {
    
    NSMutableArray* messages;
    JSQMessagesBubbleImage* outgoingBubbleImageView;
    JSQMessagesBubbleImage* incomingBubbleImageView;
    JSQMessagesAvatarImage* outgoingAvtarImageView;
    JSQMessagesAvatarImage* incomingAvtarImageView;
    
}

@property (weak, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

- (IBAction)backButtonTapped:(id)sender;

@end
