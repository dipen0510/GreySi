//
//  PostedProjectsTableViewCell.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "PostedProjectsTableViewCell.h"

@implementation PostedProjectsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    _cancelButton.layer.cornerRadius = 5.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
