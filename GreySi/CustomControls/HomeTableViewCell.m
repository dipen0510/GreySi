//
//  HomeTableViewCell.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 30/03/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2.;
    self.priceButton.layer.cornerRadius = 2.0;
    self.addButton.layer.cornerRadius = self.addButton.frame.size.height/2.;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end