//
//  LoginViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)submitButtonTapped:(id)sender;
- (IBAction)cancelButtonTapped:(id)sender;

@end
