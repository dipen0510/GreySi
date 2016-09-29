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
@property (weak, nonatomic) IBOutlet UILabel *serviceTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLeftLabel;
@property (weak, nonatomic) IBOutlet UIImageView *timeLeftImageView;
@property (weak, nonatomic) IBOutlet UIButton *priceButton;
@end
