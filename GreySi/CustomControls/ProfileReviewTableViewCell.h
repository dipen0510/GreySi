//
//  ProfileReviewTableViewCell.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileReviewTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *headingLabel;
@property (weak, nonatomic) IBOutlet UILabel *subHeadingLabel;
@property (weak, nonatomic) IBOutlet UIImageView *firstStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *secondStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *thirdStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *forthStarImgView;
@property (weak, nonatomic) IBOutlet UIImageView *fifthStarImgView;

@end
