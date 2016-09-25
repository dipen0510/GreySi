//
//  HairPostAdTableViewCell.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HairPostAdTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *treatmentNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UIButton *addMoreButton;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@end
