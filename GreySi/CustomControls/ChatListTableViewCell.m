//
//  ChatListTableViewCell.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 08/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ChatListTableViewCell.h"

@implementation ChatListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.profileImageView.layer.masksToBounds = YES;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2.;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
