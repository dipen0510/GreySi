//
//  RateViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *firstStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *secondStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *forthStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *fifthStarImgView;
@property (weak, nonatomic) IBOutlet UITextView *reviewTvtView;

@property (strong, nonatomic) NSMutableDictionary* adDict;

- (IBAction)submitButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;

@end
