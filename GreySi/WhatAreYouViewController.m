//
//  WhatAreYouViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 26/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "WhatAreYouViewController.h"
#import "SignUpViewController.h"

@interface WhatAreYouViewController ()

@end

@implementation WhatAreYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addGradientToBGView];
    [self setupInitialUI];
    
}

- (void) addGradientToBGView {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:150./255. green:24./255. blue:206./255. alpha:1.0] CGColor], (id)[[UIColor colorWithRed:183./255. green:10./255. blue:197./255. alpha:1.0] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (void) setupInitialUI {
    
    self.hairdresserButton.layer.cornerRadius = 5.0;
    self.customerButton.layer.cornerRadius = 5.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)hairDresserButtonTapped:(id)sender {
    
    userType = 1;
    [self performSegueWithIdentifier:@"showRegisterSegue" sender:nil];
    
}

- (IBAction)customerButtonTapped:(id)sender {
    
    userType = 2;
    [self performSegueWithIdentifier:@"showRegisterSegue" sender:nil];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showRegisterSegue"]) {
        
        SignUpViewController* controller = (SignUpViewController *)[segue destinationViewController];
        controller.userType = userType;
        
    }
    
}


@end
