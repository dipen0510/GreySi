//
//  CardViewNewAdTableViewCell.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 13/11/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "CardViewNewAdTableViewCell.h"

@implementation CardViewNewAdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _contentContainerView.layer.cornerRadius = 8.0;
    _contentContainerView.layer.masksToBounds = NO;
    _contentContainerView.layer.shadowOffset = CGSizeMake(0, 0);
    _contentContainerView.layer.shadowRadius = 6;
    _contentContainerView.layer.shadowOpacity = 0.3;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
