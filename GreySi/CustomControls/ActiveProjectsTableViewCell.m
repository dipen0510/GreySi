//
//  ActiveProjectsTableViewCell.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ActiveProjectsTableViewCell.h"

@implementation ActiveProjectsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.completedButton.layer.cornerRadius = 2.0;
    self.profileImageView.layer.cornerRadius = self.profileImageView.frame.size.height/2.;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
