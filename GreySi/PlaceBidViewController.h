//
//  PlaceBidViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 09/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceBidViewController : UIViewController<DataSyncManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *amountTxtField;
@property (weak, nonatomic) IBOutlet UIButton *placeBidButton;

@property (strong, nonatomic) NSString* projectId;

- (IBAction)placeBidButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;

@end
