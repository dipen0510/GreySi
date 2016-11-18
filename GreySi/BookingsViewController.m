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
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
        [self startHairBookingsService];
    }
    else {
        [self startCustomerBookingsService];
    }
    
    
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

- (void) startHairBookingsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Bookings..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = [NSString stringWithFormat:@"%@%@",kHairBookingsService,[[SharedClass sharedInstance] userObj].user_id];;
    manager.delegate = self;
    [manager startGETWebServices];
    
}

- (void) startHairProjectCompletedService {
    
    [SVProgressHUD showWithStatus:@"Completing project..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kHairProjectComplete;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForHairCompleteProject]];
    
}

- (void) startCancelBookingsService {
    
    [SVProgressHUD showWithStatus:@"Cancelling project..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kCancelBookingService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForCancelBooking]];
    
}

- (void) startAcceptProjectService {
    
    [SVProgressHUD showWithStatus:@"Accepting project..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kAcceptBookingService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForAcceptBooking]];
    
}


#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@""];
    
    if ([requestServiceKey isEqualToString:[NSString stringWithFormat:@"%@%@",kCustomerBookingsService,[[SharedClass sharedInstance] userObj].user_id]]) {
        
        bookingsArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"info"]];
        
        [self.bookingsTblView reloadData];
        
    }
    if ([requestServiceKey isEqualToString:[NSString stringWithFormat:@"%@%@",kHairBookingsService,[[SharedClass sharedInstance] userObj].user_id]]) {
        
        bookingsArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"info"]];
        
        [self.bookingsTblView reloadData];
        
    }
    if ([requestServiceKey isEqualToString:kHairProjectComplete]) {
        [SVProgressHUD showSuccessWithStatus:@"Booking completed successfully"];
        [self performSelector:@selector(setupInitialUI) withObject:nil afterDelay:0.3];
    }
    if ([requestServiceKey isEqualToString:kAcceptBookingService] || [requestServiceKey isEqualToString:kCancelBookingService]) {
        [SVProgressHUD showSuccessWithStatus:@"Booking updated successfully"];
        [self performSelector:@selector(setupInitialUI) withObject:nil afterDelay:0.3];
    }
    
    
    
}


- (void) didFinishServiceWithFailure:(NSString *)errorMsg {
    
    
    [SVProgressHUD dismiss];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil
                                                  message:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)
                                                 delegate:nil
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

- (NSMutableDictionary *) prepareDictionaryForHairCompleteProject {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:selectedProjectBookingId forKey:@"Booking_id"];
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForCancelBooking {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:selectedProjectBookingId forKey:@"Booking_id"];
    [dict setObject:selectedProjectBookingId forKey:@"Hairdresser_id"];
    
    return dict;
    
}

- (NSMutableDictionary *) prepareDictionaryForAcceptBooking {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:selectedProjectBookingId forKey:@"Booking_id"];
    
    return dict;
    
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
    return 90.0;
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
    cell.dateLabel.text = [NSString stringWithFormat:@"%@ %@",[dict valueForKey:@"Date"],[dict valueForKey:@"Booking_Time"]];
    
    cell.acceptButotn.tag = indexPath.row;
    [cell.acceptButotn addTarget:self action:@selector(acceptProjectsCompletedtButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    cell.cancelButton.tag = indexPath.row;
    [cell.cancelButton addTarget:self action:@selector(cancelProjectsCompletedtButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
        
        cell.acceptButotn.hidden = YES;
        cell.cancelButton.hidden = YES;
        
        if ([[dict valueForKey:@"Status"] intValue] == 1) {
            cell.completedButton.hidden = NO;
            cell.completedButton.tag = indexPath.row;
            [cell.completedButton addTarget:self action:@selector(projectsCompletedtButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
        }
        else {
            cell.completedButton.hidden = YES;
            
            if ([[dict valueForKey:@"Status"] intValue] == 0) {
                cell.acceptButotn.hidden = NO;
                cell.cancelButton.hidden = NO;
            }
            
        }
        
    }
    else {
        cell.completedButton.hidden = YES;
        cell.acceptButotn.hidden = YES;
        
        if ([[dict valueForKey:@"Status"] intValue] == 2) {
            cell.cancelButton.hidden = YES;
        }
        else if ([[dict valueForKey:@"Status"] intValue] == 1) {
            cell.cancelButton.hidden = NO;
        }
        else
        {
            cell.cancelButton.hidden = NO;
        }
        
    }
    
    
    if ([dict valueForKey:@"Profile_pi"] && ![[dict valueForKey:@"Profile_pi"] isEqual:[NSNull null]]) {
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
    
    
    
    
    
}



- (IBAction)backButtonTapped:(id)sender {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    HomeViewController* controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"homeViewController"];
    [self.revealViewController setFrontViewController:controller animated:YES];
    
}

- (void) projectsCompletedtButtonTapped:(UIButton *)sender {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:[bookingsArr objectAtIndex:sender.tag]];
    selectedProjectBookingId = [dict valueForKey:@"Booking_id"];
    
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil
                                                  message:NSLocalizedString(@"Are you sure you want to mark this as complete?", nil)
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"NO", nil)
                                        otherButtonTitles:@"YES", nil];

    [alert show];
    
}

- (void) cancelProjectsCompletedtButtonTapped:(UIButton *)sender {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:[bookingsArr objectAtIndex:sender.tag]];
    selectedProjectBookingId = [dict valueForKey:@"Booking_id"];
    if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
        selectedUserId = [dict valueForKey:@"Booker_id"];
    }
    else {
        selectedUserId = [dict valueForKey:@"Hairdresser_id"];
    }
    
    [self startCancelBookingsService];
    
}

- (void) acceptProjectsCompletedtButtonTapped:(UIButton *)sender {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] initWithDictionary:[bookingsArr objectAtIndex:sender.tag]];
    selectedProjectBookingId = [dict valueForKey:@"Booking_id"];
    [self startAcceptProjectService];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        [self startHairProjectCompletedService];
    }
    
}
@end
