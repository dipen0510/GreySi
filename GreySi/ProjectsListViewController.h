//
//  ProjectsListViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerGetProjectsResponseModal.h"

@interface ProjectsListViewController : UIViewController <DataSyncManagerDelegate> {
    
    int selectedIndex;
    NSMutableArray* projectsArr;
    int userType;
    NSString* selectedProjectId;
    NSString* selectedActiveProjectId;
    NSString* selectedHDId;
    NSString* selectedBidId;
    
}

@property (weak, nonatomic) IBOutlet UIView *postedProjectsTabView;
@property (weak, nonatomic) IBOutlet UIView *activeProjectsTabView;



@property (weak, nonatomic) IBOutlet UIButton *postedProjectsButton;
@property (weak, nonatomic) IBOutlet UIButton *activeProjectsButton;
@property (weak, nonatomic) IBOutlet UIButton *completedProjectsButton;

@property (weak, nonatomic) IBOutlet UITableView *projectsTableView;


- (IBAction)postedProjectsButtonTapped:(id)sender;
- (IBAction)activeProjectsButtonTapped:(id)sender;
- (IBAction)completedProjectsButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;

@end
