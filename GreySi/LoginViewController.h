//
//  LoginViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface LoginViewController : UIViewController<DataSyncManagerDelegate, UITextFieldDelegate> {
    
    NSString* emailText;
    NSString* passwordText;
    
    BOOL showKeyboardAnimation;
    CGPoint viewCenter;
    
    NSString* fbName;
    NSString* fbEmail;
    NSString* fbId;
    NSString* fbFlag;
    
}

@property (weak, nonatomic) IBOutlet UITableView *loginTableView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIImageView *splashImgView;
@property (weak, nonatomic) IBOutlet UIImageView *loginBgImgView;
@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)submitButtonTapped:(id)sender;
- (IBAction)fbLoginButtonTapped:(id)sender;

@end
