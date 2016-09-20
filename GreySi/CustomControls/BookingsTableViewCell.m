//
//  BookingsTableViewCell.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 20/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "BookingsTableViewCell.h"

@implementation BookingsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.profileImgView.layer.masksToBounds = YES;
    self.profileImgView.layer.cornerRadius = self.profileImgView.frame.size.height/2.;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
