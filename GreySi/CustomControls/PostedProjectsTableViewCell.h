//
//  PostedProjectsTableViewCell.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostedProjectsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *hairdresserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *bidsLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end
