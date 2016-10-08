//
//  BidsReceivedListViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "BidsReceivedListViewController.h"
#import "BidsReceivedTableViewCell.h"

@interface BidsReceivedListViewController ()

@end

@implementation BidsReceivedListViewController

@synthesize projectId;

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
    
    bidsArr = [[NSMutableArray alloc] init];
    self.projectsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self startFetchBidService];
    
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

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) awardProjectButtonTapped:(UIButton *) sender {
    
    selectedIndexPath = sender.tag;
    [self startAwardProjectService];
    
}


#pragma mark - UITableView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return bidsArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* identifier = @"BidsReceivedTableViewCell";
    BidsReceivedTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"BidsReceivedTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    
    [self displayContentForCell:cell atIndexPath:indexPath];
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
}

- (void) displayContentForCell:(BidsReceivedTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableDictionary* dict = [bidsArr objectAtIndex:indexPath.row];
    
    cell.nameLabel.text = dict[@"Name"];
    cell.amountLabel.text = [NSString stringWithFormat:@"Amount : $%@",dict[@"Amount"]];
    cell.awardButton.tag = indexPath.row;
    [cell.awardButton addTarget:self action:@selector(awardProjectButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    __weak UIImageView* weakImageView = cell.profileImageView;
    [cell.profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[dict valueForKey:@"Profile_pi"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
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


- (void) startFetchBidService {
    
    [SVProgressHUD showWithStatus:@"Fetching Bids..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kCustomerFetchBidService,projectId];
    manager.delegate = self;
    [manager startGETWebServices];
    
}

- (void) startAwardProjectService {
    
    [SVProgressHUD showWithStatus:@"Awarding project..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kCustomerAssignProjectService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForAssignProject]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:[NSString stringWithFormat:@"%@%@",kCustomerFetchBidService,projectId]]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Bids fetched Successfully"];
        
        bidsArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"info"]];
        [self.projectsTableView reloadData];
        
    }
    else if ([requestServiceKey isEqualToString:kCustomerAssignProjectService]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Project Awarded successfully"];
        [self.navigationController popViewControllerAnimated:YES];
        
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
    
    
    [alert show];
    
    return;
    
}

#pragma mark - Modalobject

- (NSMutableDictionary *) prepareDictionaryForAssignProject {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:projectId forKey:@"Project_id"];
    [dict setObject:[[bidsArr objectAtIndex:selectedIndexPath] valueForKey:@"User_id"] forKey:@"Hairdresser_id"];
    [dict setObject:[[SharedClass sharedInstance] userObj].user_id forKey:@"User_id"];
    
    return dict;
    
}


@end
