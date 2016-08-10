//
//  ProjectsListViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "ProjectsListViewController.h"
#import "HomeViewController.h"
#import "PostedProjectsTableViewCell.h"
#import "ActiveProjectsTableViewCell.h"
#import "CompletedProjectsTableViewCell.h"

@interface ProjectsListViewController ()

@end

@implementation ProjectsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupUI {
    
    self.postedProjectsButton.layer.cornerRadius = 2.0;
    self.activeProjectsButton.layer.cornerRadius = 2.0;
    self.completedProjectsButton.layer.cornerRadius = 2.0;
    
    self.postedProjectsButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.postedProjectsButton.layer.borderWidth = 0.5;
    self.activeProjectsButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.activeProjectsButton.layer.borderWidth = 0.5;
    self.completedProjectsButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.completedProjectsButton.layer.borderWidth = 0.5;
    
    [self setupLayoutForTabIndex:selectedIndex];
    
    
}

- (void) setupLayoutForTabIndex:(int)index {
    
    if (index == 0) {
        
        self.postedProjectsButton.backgroundColor = [UIColor whiteColor] ;
        [self.postedProjectsButton setTitleColor:[UIColor colorWithRed:103./255. green:19./255. blue:140./255. alpha:1.0] forState:UIControlStateNormal];
        self.activeProjectsButton.backgroundColor =  [UIColor colorWithRed:103./255. green:19./255. blue:140./255. alpha:1.0];
        [self.activeProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.completedProjectsButton.backgroundColor =  [UIColor colorWithRed:103./255. green:19./255. blue:140./255. alpha:1.0];
        [self.completedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        
        
    }
    else if (index == 1) {
        
        self.activeProjectsButton.backgroundColor = [UIColor whiteColor] ;
        [self.activeProjectsButton setTitleColor:[UIColor colorWithRed:103./255. green:19./255. blue:140./255. alpha:1.0] forState:UIControlStateNormal];
        self.postedProjectsButton.backgroundColor =  [UIColor colorWithRed:103./255. green:19./255. blue:140./255. alpha:1.0];
        [self.postedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.completedProjectsButton.backgroundColor =  [UIColor colorWithRed:103./255. green:19./255. blue:140./255. alpha:1.0];
        [self.completedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }
    else if (index == 2) {
        
        self.completedProjectsButton.backgroundColor = [UIColor whiteColor] ;
        [self.completedProjectsButton setTitleColor:[UIColor colorWithRed:103./255. green:19./255. blue:140./255. alpha:1.0] forState:UIControlStateNormal];
        self.activeProjectsButton.backgroundColor =  [UIColor colorWithRed:103./255. green:19./255. blue:140./255. alpha:1.0];
        [self.activeProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.postedProjectsButton.backgroundColor =  [UIColor colorWithRed:103./255. green:19./255. blue:140./255. alpha:1.0];
        [self.postedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }
    
    [self.projectsTableView reloadData];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - User Action Events

- (IBAction)postedProjectsButtonTapped:(id)sender {
    
    selectedIndex = 0;
    [self setupLayoutForTabIndex:selectedIndex];
    
}

- (IBAction)activeProjectsButtonTapped:(id)sender {
    
    selectedIndex = 1;
    [self setupLayoutForTabIndex:selectedIndex];
    
}

- (IBAction)completedProjectsButtonTapped:(id)sender {
    
    selectedIndex = 2;
    [self setupLayoutForTabIndex:selectedIndex];
    
}

- (IBAction)backButtonTapped:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HomeViewController* controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"homeViewController"];
    [self.revealViewController setFrontViewController:controller animated:YES];
    
}


#pragma mark - UITableView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (selectedIndex == 0) {
        NSString* identifier = @"PostedProjectsTableViewCell";
        PostedProjectsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"PostedProjectsTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        
        [self displayContentForPostedProjectCell:cell atIndexPath:indexPath];
        
        return cell;
        
    }
    else if (selectedIndex == 1) {
        
        NSString* identifier = @"ActiveProjectsTableViewCell";
        ActiveProjectsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"ActiveProjectsTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        
        [self displayContentForActiveProjectCell:cell atIndexPath:indexPath];
        
        return cell;
        
    }
    
    NSString* identifier = @"CompletedProjectsTableViewCell";
    CompletedProjectsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"CompletedProjectsTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    
    [self displayContentForCompletedProjectCell:cell atIndexPath:indexPath];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if (selectedIndex == 0) {
        [self performSegueWithIdentifier:@"showBidsReceivedSegue" sender:nil];
    }
    
    
    
}

- (void) displayContentForPostedProjectCell:(PostedProjectsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2 || indexPath.row == 4) {
        cell.backgroundColor = [UIColor colorWithRed:205./255. green:205./255. blue:205./255. alpha:1.0];
    }
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
}

- (void) displayContentForActiveProjectCell:(ActiveProjectsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
}

- (void) displayContentForCompletedProjectCell:(CompletedProjectsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    
}

@end
