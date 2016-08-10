//
//  BidsReceivedTableViewCell.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidsReceivedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *awardButton;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end
