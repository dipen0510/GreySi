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
#import "ProjectsSingleModal.h"
#import "BidsReceivedListViewController.h"
#import "RateViewController.h"

@interface ProjectsListViewController ()

@end

@implementation ProjectsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    [self setupUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupUI {
    
    projectsArr = [[NSMutableArray alloc] init];
    
    self.projectsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    userType = [[[SharedClass sharedInstance] userObj].flag intValue];
    
    self.postedProjectsButton.layer.cornerRadius = 5.0;
    self.activeProjectsButton.layer.cornerRadius = 5.0;
    self.completedProjectsButton.layer.cornerRadius = 5.0;
    
    self.postedProjectsButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.postedProjectsButton.layer.borderWidth = 0.5;
    self.activeProjectsButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.activeProjectsButton.layer.borderWidth = 0.5;
    self.completedProjectsButton.layer.borderColor = [[UIColor whiteColor] CGColor];
    self.completedProjectsButton.layer.borderWidth = 0.5;
    
    [self setupLayoutForTabIndex:selectedIndex];
    
    
}

- (void) refreshActiveProjectTabList {
    [self setupLayoutForTabIndex:1];
}

- (void) refreshBiddedProjectTabList {
    [self setupLayoutForTabIndex:0];
}

- (void) refreshPostedProjectTabList {
    [self setupLayoutForTabIndex:0];
}

- (void) setupLayoutForTabIndex:(int)index {
    
    if (userType == 1) {
        
        if (userType == 1) {
            [self.postedProjectsButton setTitle:@"Lämnade Bokningar" forState:UIControlStateNormal];
        }
        
        if (index == 0) {
            
            [self startHDGetBiddedProjectsService];
            
            self.postedProjectsButton.backgroundColor = [UIColor whiteColor] ;
            [self.postedProjectsButton setTitleColor:[UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0] forState:UIControlStateNormal];
            self.activeProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.activeProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.completedProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.completedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
            
        }
        else if (index == 1) {
            
            [self startHDGetActiveProjectsService];
            
            self.activeProjectsButton.backgroundColor = [UIColor whiteColor] ;
            [self.activeProjectsButton setTitleColor:[UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0] forState:UIControlStateNormal];
            self.postedProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.postedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.completedProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.completedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
        }
        else if (index == 2) {
            
            [self startHDrGetCompletedProjectsService];
            
            self.completedProjectsButton.backgroundColor = [UIColor whiteColor] ;
            [self.completedProjectsButton setTitleColor:[UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0] forState:UIControlStateNormal];
            self.activeProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.activeProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.postedProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.postedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        
    }
    else {
        
        if (index == 0) {
            
            [self startCustomerGetPostedProjectsService];
            
            self.postedProjectsButton.backgroundColor = [UIColor whiteColor] ;
            [self.postedProjectsButton setTitleColor:[UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0] forState:UIControlStateNormal];
            self.activeProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.activeProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.completedProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.completedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
            
        }
        else if (index == 1) {
            
            [self startCustomerGetActiveProjectsService];
            
            self.activeProjectsButton.backgroundColor = [UIColor whiteColor] ;
            [self.activeProjectsButton setTitleColor:[UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0] forState:UIControlStateNormal];
            self.postedProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.postedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.completedProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.completedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
            
        }
        else if (index == 2) {
            
            [self startCustomerGetCompletedProjectsService];
            
            self.completedProjectsButton.backgroundColor = [UIColor whiteColor] ;
            [self.completedProjectsButton setTitleColor:[UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0] forState:UIControlStateNormal];
            self.activeProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.activeProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.postedProjectsButton.backgroundColor =  [UIColor colorWithRed:123./255. green:27./255. blue:167./255. alpha:1.0];
            [self.postedProjectsButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            
        }
        
        
    }
    
    projectsArr = [[NSMutableArray alloc] init];
    [self.projectsTableView reloadData];
    
}


- (void) startCustomerGetPostedProjectsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Posted Projects..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kCustomerGetPostedProjectsService,[[SharedClass sharedInstance] userObj].user_id];
    manager.delegate = self;
    [manager startGETWebServices];
    
}

- (void) startCustomerGetActiveProjectsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Active Projects..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kCustomerGetActiveProjectsService,[[SharedClass sharedInstance] userObj].user_id];
    manager.delegate = self;
    [manager startGETWebServices];
    
}

- (void) startCustomerGetCompletedProjectsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Completed Projects..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kCustomerGetCompletedProjectsService,[[SharedClass sharedInstance] userObj].user_id];
    manager.delegate = self;
    [manager startGETWebServices];
    
}

- (void) startHDGetBiddedProjectsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Bidded Projects..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kHairGetBiddedProjectsService,[[SharedClass sharedInstance] userObj].user_id];
    manager.delegate = self;
    [manager startGETWebServices];
    
}

- (void) startHDGetActiveProjectsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Active Projects..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kHairGetActiveProjectsService,[[SharedClass sharedInstance] userObj].user_id];
    manager.delegate = self;
    [manager startGETWebServices];
    
}

- (void) startHDrGetCompletedProjectsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Completed Projects..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kHairGetCompletedProjectsService,[[SharedClass sharedInstance] userObj].user_id];
    manager.delegate = self;
    [manager startGETWebServices];
    
}


- (void) startCustomerProjectCompletedService {
    
    [SVProgressHUD showWithStatus:@"Completing project..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kCustomerProjectComplete;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForCustomerCompleteProject]];
    
}

- (void) startHairDresserCancelBidService {
    
    [SVProgressHUD showWithStatus:@"Cancelling bid..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kHairCancelBidService,selectedBidId];
    manager.delegate = self;
    [manager startGETWebServices];
    
}

- (void) startCustomerDeleteProjectServiceWithProjectId:(NSString *)projectId {
    
    [SVProgressHUD showWithStatus:@"Cancelling Project..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kCustomerDeleteProjectService,projectId];
    manager.delegate = self;
    [manager startGETWebServices];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(CustomerGetProjectsResponseModal *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@""];
    
    if ([requestServiceKey isEqualToString:[NSString stringWithFormat:@"%@%@",kCustomerGetPostedProjectsService,[[SharedClass sharedInstance] userObj].user_id]] || [requestServiceKey isEqualToString:[NSString stringWithFormat:@"%@%@",kCustomerGetActiveProjectsService,[[SharedClass sharedInstance] userObj].user_id]] || [requestServiceKey isEqualToString:[NSString stringWithFormat:@"%@%@",kCustomerGetCompletedProjectsService,[[SharedClass sharedInstance] userObj].user_id]]) {
        
        projectsArr = [[NSMutableArray alloc] initWithArray:responseData.info];
        [self.projectsTableView reloadData];
        
    }
    else if ([requestServiceKey isEqualToString:[NSString stringWithFormat:@"%@%@",kHairGetBiddedProjectsService,[[SharedClass sharedInstance] userObj].user_id]] || [requestServiceKey isEqualToString:[NSString stringWithFormat:@"%@%@",kHairGetActiveProjectsService,[[SharedClass sharedInstance] userObj].user_id]] || [requestServiceKey isEqualToString:[NSString stringWithFormat:@"%@%@",kHairGetCompletedProjectsService,[[SharedClass sharedInstance] userObj].user_id]]){
        
        projectsArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"info"]];
        [self.projectsTableView reloadData];
        
    }
    else if ([requestServiceKey isEqualToString:kCustomerProjectComplete]) {
        [SVProgressHUD showSuccessWithStatus:@"Project Completed successfully"];
        [self performSelector:@selector(refreshActiveProjectTabList) withObject:nil afterDelay:0.3];
        [self performSegueWithIdentifier:@"showRateSegueWithoutBack" sender:nil];
    }
    else if ([requestServiceKey containsString:kHairCancelBidService]) {
        [SVProgressHUD showSuccessWithStatus:@"Bid cancelled successfully"];
        [self performSelector:@selector(refreshBiddedProjectTabList) withObject:nil afterDelay:0.3];
    }
    else if ([requestServiceKey containsString:kCustomerDeleteProjectService]) {
        [SVProgressHUD showSuccessWithStatus:@"Project cancelled successfully"];
        [self performSelector:@selector(refreshPostedProjectTabList) withObject:nil afterDelay:0.3];
    }
    
    
}


- (void) didFinishServiceWithFailure:(NSString *)errorMsg {
    
    
    [SVProgressHUD dismiss];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil
                                                  message:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                        otherButtonTitles: nil];
    
    if (![errorMsg isEqualToString:@""]) {
        [alert setMessage:errorMsg];
    }
    
    if ([errorMsg isEqualToString:NSLocalizedString(@"Verify your internet connection and try again", nil)]) {
        [alert setTitle:NSLocalizedString(@"Connection unsuccessful", nil)];
    }
    
    if (alert.message) {
        [alert show];
    }
    
    return;
    
}

#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForCustomerCompleteProject {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:selectedActiveProjectId forKey:@"Project_id"];
    
    return dict;
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showBidsReceivedSegue"]) {
        
        BidsReceivedListViewController* controller = (BidsReceivedListViewController *)[segue destinationViewController];
        controller.projectId = selectedProjectId;
        
    }
    if ([segue.identifier isEqualToString:@"showRateSegue"]) {
        
        RateViewController* controller = (RateViewController *)[segue destinationViewController];
        controller.projectId = selectedProjectId;
        controller.hairDresserId = selectedHDId;
        
    }
    if ([segue.identifier isEqualToString:@"showRateSegueWithoutBack"]) {
        
        RateViewController* controller = (RateViewController *)[segue destinationViewController];
        controller.projectId = selectedActiveProjectId;
        controller.hairDresserId = selectedHDId;
        controller.isBackButttonHidden = YES;
    }
    
}


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

- (void) activeProjectsCompletedProjectButtonTapped:(UIButton *)sender {
    
    ProjectsSingleModal* singleProject = [[ProjectsSingleModal alloc] initWithDictionary:[projectsArr objectAtIndex:sender.tag]];
    selectedActiveProjectId = singleProject.project_id;
    selectedHDId = singleProject.hairdresser_id;
    [self startCustomerProjectCompletedService];
    
}

- (void) postedProjectsCancelProjectButtonTapped:(UIButton *)sender {
    
    ProjectsSingleModal* singleProject = [[ProjectsSingleModal alloc] initWithDictionary:[projectsArr objectAtIndex:sender.tag]];
    [self startCustomerDeleteProjectServiceWithProjectId:singleProject.project_id];
    
}


#pragma mark - UITableView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return projectsArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (selectedIndex == 0) {
        
        if ([[[SharedClass sharedInstance] userObj].flag intValue]==1) {
            
            NSString* identifier = @"CompletedProjectsTableViewCell";
            CompletedProjectsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            
            if (cell == nil) {
                NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"CompletedProjectsTableViewCell" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            
            
            [self displayContentForBiddedProjectCell:cell atIndexPath:indexPath];
            
            return cell;
            
        }
        
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
    
    if (selectedIndex == 0 && [[[SharedClass sharedInstance] userObj].flag intValue] != 1) {
        ProjectsSingleModal* singleProject = [[ProjectsSingleModal alloc] initWithDictionary:[projectsArr objectAtIndex:indexPath.row]];
        selectedProjectId = singleProject.project_id;
        [self performSegueWithIdentifier:@"showBidsReceivedSegue" sender:nil];
    }
    if (selectedIndex == 0 && [[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
        selectedBidId = [[projectsArr objectAtIndex:indexPath.row] valueForKey:@"Bid_id"];
        [self startHairDresserCancelBidService];
    }
    if (selectedIndex == 2 && [[[SharedClass sharedInstance] userObj].flag intValue] != 1) {
        
        if ([[[projectsArr objectAtIndex:indexPath.row] valueForKey:@"review"] intValue] == 0) {
            ProjectsSingleModal* singleProject = [[ProjectsSingleModal alloc] initWithDictionary:[projectsArr objectAtIndex:indexPath.row]];
            selectedProjectId = singleProject.project_id;
            selectedHDId = singleProject.hairdresser_id;
            [self performSegueWithIdentifier:@"showRateSegue" sender:nil];
        }
        
        
    }
    
    
    
}

- (void) displayContentForPostedProjectCell:(PostedProjectsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    ProjectsSingleModal* singleProject = [[ProjectsSingleModal alloc] initWithDictionary:[projectsArr objectAtIndex:indexPath.row]];
    
    cell.typeLabel.text = singleProject.treatment;
    //cell.statusLabel.text = singleProject.status;
    cell.hairdresserNameLabel.text = singleProject.hairdresser_id;
    cell.amountLabel.text = [NSString stringWithFormat:@"%@:-",singleProject.budget];
    cell.bidsLabel.text = singleProject.no_of_bids;
    
    cell.cancelButton.tag = indexPath.row;
    [cell.cancelButton addTarget:self action:@selector(postedProjectsCancelProjectButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([singleProject.time componentsSeparatedByString:@":"].count == 3) {
        cell.dateLabel.text = [NSString stringWithFormat:@"%@ %@:%@",singleProject.date,[[singleProject.time componentsSeparatedByString:@":"] objectAtIndex:0],[[singleProject.time componentsSeparatedByString:@":"] objectAtIndex:1]];
    }
    else {
        cell.dateLabel.text = [NSString stringWithFormat:@"%@ %@",singleProject.date,singleProject.time];
    }
    
    if ([singleProject.no_of_bids intValue] > 0) {
        cell.backgroundColor = [UIColor colorWithRed:220./255. green:220./255. blue:220./255. alpha:1.0];
    }
    else {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    
}

- (void) displayContentForActiveProjectCell:(ActiveProjectsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    ProjectsSingleModal* singleProject = [[ProjectsSingleModal alloc] initWithDictionary:[projectsArr objectAtIndex:indexPath.row]];
    
    cell.nameLabel.text = singleProject.name;
    cell.amountLabel.text = [NSString stringWithFormat:@"Summa : %@:-",singleProject.budget];
    cell.dateTimeLabel.text = [NSString stringWithFormat:@"%@ %@",singleProject.date,singleProject.time];
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue]==1) {
        cell.completedButton.hidden = YES;
    }
    else {
        cell.completedButton.hidden = NO;
        cell.completedButton.tag = indexPath.row;
        [cell.completedButton addTarget:self action:@selector(activeProjectsCompletedProjectButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    if (singleProject.profile_pic && ![singleProject.profile_pic isEqual:[NSNull null]]) {
        __weak UIImageView* weakImageView = cell.profileImageView;
        [cell.profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[singleProject.profile_pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                                       cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                                   timeoutInterval:60.0] placeholderImage:[UIImage imageNamed:@"blankProfile"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            
            weakImageView.alpha = 0.0;
            weakImageView.image = image;
            [UIView animateWithDuration:0.25
                             animations:^{
                                 weakImageView.alpha = 1.0;
                             }];
        } failure:NULL];
    }
    
    
    
}

- (void) displayContentForCompletedProjectCell:(CompletedProjectsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    ProjectsSingleModal* singleProject = [[ProjectsSingleModal alloc] initWithDictionary:[projectsArr objectAtIndex:indexPath.row]];
    
    cell.nameLabel.text = singleProject.name;
    cell.amountValueLabel.text = [NSString stringWithFormat:@"%@:-",singleProject.budget];
    cell.projectLabel.text = [NSString stringWithFormat:@"%@",singleProject.treatment];
    
    if ([[[projectsArr objectAtIndex:indexPath.row] valueForKey:@"review"] intValue] == 0) {
        
        if ([[[SharedClass sharedInstance] userObj].flag intValue]==1) {
            cell.writeAReviewLabel.hidden = YES;
        }
        else {
            cell.writeAReviewLabel.hidden = NO;
        }
        
    }
    else {
        
        cell.writeAReviewLabel.hidden = YES;
        
    }
    
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue]==1) {
        cell.completeTickImgView.hidden = NO;
        cell.amountLabelFromTopConstraint.constant = 42.;
        cell.amountValueLabel.textColor = [UIColor colorWithRed:83./255. green:168./255. blue:110./255. alpha:1.0];
    }
    else {
        cell.completeTickImgView.hidden = YES;
    }
    
    
    if (singleProject.profile_pic && ![singleProject.profile_pic isEqual:[NSNull null]]) {
        __weak UIImageView* weakImageView = cell.profileImageView;
        [cell.profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[singleProject.profile_pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                                       cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                                   timeoutInterval:60.0] placeholderImage:[UIImage imageNamed:@"blankProfile"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            
            weakImageView.alpha = 0.0;
            weakImageView.image = image;
            [UIView animateWithDuration:0.25
                             animations:^{
                                 weakImageView.alpha = 1.0;
                             }];
        } failure:NULL];
    }
    
    

    
}


- (void) displayContentForBiddedProjectCell:(CompletedProjectsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    ProjectsSingleModal* singleProject = [[ProjectsSingleModal alloc] initWithDictionary:[projectsArr objectAtIndex:indexPath.row]];
    
    cell.nameLabel.text = singleProject.name;
    cell.amountValueLabel.text = [NSString stringWithFormat:@"%@:-",singleProject.budget];
    cell.projectLabel.text = [NSString stringWithFormat:@"%@",singleProject.treatment];
    cell.writeAReviewLabel.hidden = NO;
    cell.writeAReviewLabel.text = @"Cancel";
    cell.amountValueLabel.textColor = [UIColor colorWithRed:83./255. green:168./255. blue:110./255. alpha:1.0];
    cell.completeTickImgView.hidden = YES;
    
    if (singleProject.profile_pic && ![singleProject.profile_pic isEqual:[NSNull null]]) {
        __weak UIImageView* weakImageView = cell.profileImageView;
        [cell.profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[singleProject.profile_pic stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                                       cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                                   timeoutInterval:60.0] placeholderImage:[UIImage imageNamed:@"blankProfile"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            
            weakImageView.alpha = 0.0;
            weakImageView.image = image;
            [UIView animateWithDuration:0.25
                             animations:^{
                                 weakImageView.alpha = 1.0;
                             }];
        } failure:NULL];
    }
    
    
    
    
}

@end
