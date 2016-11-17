//
//  SideMenuViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController <UIAlertViewDelegate> {
    
    NSMutableArray* tableArr;
    NSNumber *unreadCount;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *profileImgView;
@property (weak, nonatomic) IBOutlet UILabel *profileName;
@property (weak, nonatomic) IBOutlet UITableView *menuTblView;

@end
