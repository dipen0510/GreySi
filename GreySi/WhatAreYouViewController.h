//
//  WhatAreYouViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 26/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WhatAreYouViewController : UIViewController<DataSyncManagerDelegate> {
    
    int userType;
    
}

@property (weak, nonatomic) IBOutlet UIButton *hairdresserButton;
@property (weak, nonatomic) IBOutlet UIButton *customerButton;

@property BOOL isFBLoginType;
@property (nonatomic, strong) NSString* fbName;
@property (nonatomic, strong) NSString* fbEmail;
@property (nonatomic, strong) NSString* fbId;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)hairDresserButtonTapped:(id)sender;
- (IBAction)customerButtonTapped:(id)sender;

@end
