//
//  SplashViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 24/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "SplashViewController.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self performSegueWithIdentifier:@"showLoginSegue" sender:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
