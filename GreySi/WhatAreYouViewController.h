//
//  WhatAreYouViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 26/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhatAreYouViewController : UIViewController {
    
    int userType;
    
}

@property (weak, nonatomic) IBOutlet UIButton *hairdresserButton;
@property (weak, nonatomic) IBOutlet UIButton *customerButton;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)hairDresserButtonTapped:(id)sender;
- (IBAction)customerButtonTapped:(id)sender;

@end
