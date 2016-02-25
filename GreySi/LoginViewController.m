//
//  LoginViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setupInitialUI];

}

- (void) setupInitialUI {
    
    UIView *paddingView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    UIView *paddingView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    
    self.emailTextField.layer.borderColor = [[UIColor colorWithRed:91./255. green:91./255. blue:91./255. alpha:1.0] CGColor];
    self.emailTextField.layer.borderWidth = 1.0;
    self.emailTextField.leftView = paddingView1;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.passwordTextField.layer.borderColor = [[UIColor colorWithRed:91./255. green:91./255. blue:91./255. alpha:1.0] CGColor];
    self.passwordTextField.layer.borderWidth = 1.0;
    self.passwordTextField.leftView = paddingView2;
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)submitButtonTapped:(id)sender {
}

- (IBAction)cancelButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

@end
