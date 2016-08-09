//
//  ProfileSubDetailViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 09/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileSubDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIButton *priceListButton;

- (IBAction)backButtonTapped:(id)sender;

@end
