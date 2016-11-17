//
//  SideMenuTableViewCell.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *tabImageView;
@property (weak, nonatomic) IBOutlet UILabel *tabLabel;
@property (weak, nonatomic) IBOutlet UILabel *unreadMsgCountLabel;

@end
