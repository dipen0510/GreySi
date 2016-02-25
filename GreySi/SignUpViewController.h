//
//  SignUpViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *profileButton;
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

- (IBAction)profileButtonTapped:(id)sender;
- (IBAction)submitButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;

@end
