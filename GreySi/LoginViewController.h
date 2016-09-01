//
//  LoginViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<DataSyncManagerDelegate> {
    
    NSString* emailText;
    NSString* passwordText;
    
}

@property (weak, nonatomic) IBOutlet UITableView *loginTableView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)submitButtonTapped:(id)sender;

@end
