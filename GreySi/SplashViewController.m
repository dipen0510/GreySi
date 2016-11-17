//
//  SplashViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 24/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "SplashViewController.h"
#import "SignUpResponseModal.h"

@interface SplashViewController ()

@end

@implementation SplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    NSString* attendStr = [[SharedClass sharedInstance] loadDataForService:kLoginService];
    
    if (attendStr) {
        NSMutableDictionary* dict = [[SharedClass sharedInstance] getDictionaryFromJSONString:attendStr];
        SignUpResponseModal* userObj = [[SignUpResponseModal alloc] initWithDictionary:[[dict valueForKey:@"info"] objectAtIndex:0]];
        [[SharedClass sharedInstance] setUserObj:userObj];
        [self performSegueWithIdentifier:@"showHomeSegue" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"showLoginSegue" sender:nil];
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
         {
             self.view.alpha = 0;
         }
                         completion:^(BOOL finished){
                             
                             
                             
                         }];
        
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
