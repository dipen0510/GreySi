//
//  ProfileReviewTableViewCell.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ProfileReviewTableViewCell.h"

@implementation ProfileReviewTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.imgView.layer.masksToBounds = YES;
    self.imgView.layer.cornerRadius = self.imgView.frame.size.height/2.;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
