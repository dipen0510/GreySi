//
//  BookingsViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 20/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "BookingsViewController.h"
#import "BookingsTableViewCell.h"
#import "HomeViewController.h"

@interface BookingsViewController ()

@end

@implementation BookingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupInitialUI {
    
    bookingsArr = [[NSMutableArray alloc] init];
    self.bookingsTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self startCustomerBookingsService];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - API Helpers

- (void) startCustomerBookingsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Bookings..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kCustomerBookingsService,[[SharedClass sharedInstance] userObj].user_id];;
    manager.delegate = self;
    [manager startGETWebServices];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@""];
    
    if ([requestServiceKey isEqualToString:[NSString stringWithFormat:@"%@%@",kCustomerBookingsService,[[SharedClass sharedInstance] userObj].user_id]]) {
        
        bookingsArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"info"]];
        
        [self.bookingsTblView reloadData];
        
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


#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return bookingsArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* identifier = @"BookingsTableViewCell";
    BookingsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"BookingsTableViewCell" owner:self options:nil];
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

- (void) displayContentForCell:(BookingsTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
      //POPULATE CONTENT
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:[bookingsArr objectAtIndex:indexPath.row]];
        
    cell.headingLabel.text = [dict valueForKey:@"Name"];
    cell.subHeadingLabel.text = [dict valueForKey:@"Treatment"];
    cell.dateLabel.text = [dict valueForKey:@"Date"];
    
        __weak UIImageView* weakImageView = cell.profileImgView;
        [cell.profileImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[dict valueForKey:@"Profile_pi"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
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



- (IBAction)backButtonTapped:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HomeViewController* controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"homeViewController"];
    [self.revealViewController setFrontViewController:controller animated:YES];
    
}
@end
