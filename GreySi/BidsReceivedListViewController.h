//
//  BidsReceivedListViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidsReceivedListViewController : UIViewController <DataSyncManagerDelegate> {
    NSMutableArray* bidsArr;
    long selectedIndexPath;
}

@property (weak, nonatomic) IBOutlet UITableView *projectsTableView;
@property (strong, nonatomic) NSString* projectId;

- (IBAction)backButtonTapped:(id)sender;


@end
