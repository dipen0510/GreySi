//
//  BidsReceivedListViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BidsReceivedListViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *projectsTableView;

- (IBAction)backButtonTapped:(id)sender;


@end
