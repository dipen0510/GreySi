//
//  LoginViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<DataSyncManagerDelegate, UITextFieldDelegate> {
    
    NSString* emailText;
    NSString* passwordText;
    
    BOOL showKeyboardAnimation;
    CGPoint viewCenter;
    
}

@property (weak, nonatomic) IBOutlet UITableView *loginTableView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *splashImgView;
@property (weak, nonatomic) IBOutlet UIImageView *loginBgImgView;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)submitButtonTapped:(id)sender;

@end
