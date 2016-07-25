//
//  GatewayViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 26/07/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "GatewayViewController.h"

@interface GatewayViewController ()

@end

@implementation GatewayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addGradientToBGView];
    [self setupInitialUI];
    
}

- (void) setupInitialUI {
    
    self.loginButton.layer.cornerRadius = 5.0;
    self.registerButton.layer.cornerRadius = 5.0;
    
}

- (void) addGradientToBGView {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:109./255. green:0./255. blue:183./255. alpha:1.0] CGColor], (id)[[UIColor colorWithRed:202./255. green:74./255. blue:254./255. alpha:1.0] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
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

@end
