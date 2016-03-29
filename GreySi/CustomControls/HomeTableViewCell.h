//
//  HomeTableViewCell.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 30/03/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *budgetNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *budgetValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *rateNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rateStarOneImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rateStarTwoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rateStarThreeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rateStarFourImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rateStarFiveeImageView;
@property (weak, nonatomic) IBOutlet UIButton *chatButton;
@property (weak, nonatomic) IBOutlet UIButton *bidButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end
