//
//  HairPostAdViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HairPostAdViewController : UIViewController <DataSyncManagerDelegate> {
    
    int tblCount;
    NSString* treatmentList;
    NSString* budgetList;
    
}

@property (weak, nonatomic) IBOutlet UITableView *adsTblView;
@property BOOL isOpenedFromSideMenu;

- (IBAction)backButtonTapped:(id)sender;

@end
