//
//  ProfileDetailViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIButton *rateReviewButton;

- (IBAction)backButtonTapped:(id)sender;

@end
