//
//  ForgotPasswordViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 21/11/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController<DataSyncManagerDelegate, UITextFieldDelegate> {
    
    NSString* emailText;
    
    BOOL showKeyboardAnimation;
    CGPoint viewCenter;
    
}


@property (weak, nonatomic) IBOutlet UITableView *loginTableView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)submitButtonTapped:(id)sender;


@end
