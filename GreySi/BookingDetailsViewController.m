//
//  BookingDetailsViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 10/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "BookingDetailsViewController.h"

@interface BookingDetailsViewController ()

@end

@implementation BookingDetailsViewController
@synthesize treatmentArr,hairDresserId,budgetArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    selectedTreatmentArr = [[NSMutableArray alloc] init];
    finalSelectedDate = @"";
    finalSelectedTime = @"";
    self.listTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    _selectDateButton.layer.masksToBounds = YES;
    _selectDateButton.layer.cornerRadius = 8.0;
    _bookButton.layer.masksToBounds = YES;
    _bookButton.layer.cornerRadius = 8.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [treatmentArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ListAssetFieldCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    cell.textLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:13.0];
    cell.textLabel.textColor = [UIColor darkGrayColor];
    cell.textLabel.text = [[treatmentArr objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    cell.detailTextLabel.font = [UIFont fontWithName:@"Montserrat-Light" size:13.0];
    cell.detailTextLabel.textColor = [UIColor darkGrayColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@:-",[[budgetArr objectAtIndex:indexPath.row] valueForKey:@"name"]];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    if([selectedTreatmentArr containsObject:[treatmentArr objectAtIndex:indexPath.row]]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if([selectedTreatmentArr containsObject:[treatmentArr objectAtIndex:indexPath.row]]){
        [selectedTreatmentArr removeObject:[treatmentArr objectAtIndex:indexPath.row]];
    } else {
        [selectedTreatmentArr addObject:[treatmentArr objectAtIndex:indexPath.row]];
    }
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];

    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 60.0;
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)backButtonTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectDateButtonTapped:(id)sender {
    
    [ActionSheetDatePicker showPickerWithTitle:@"Select a Date"
                                datePickerMode:UIDatePickerModeDateAndTime
                                  selectedDate:[NSDate date] minimumDate:[NSDate date] maximumDate:nil
                                     doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                         
                                         NSDateFormatter* format1 = [[NSDateFormatter alloc] init];
                                         
                                         format1.dateFormat = @"dd/MM/yyyy";
                                         finalSelectedDate = [format1 stringFromDate:selectedDate];
                                         
                                         format1.dateFormat = @"HH:mm";
                                         finalSelectedTime = [format1 stringFromDate:selectedDate];
                                         
                                        NSString *dateString = [NSDateFormatter localizedStringFromDate:selectedDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
                                         NSLog(@"Picker: value: %@",dateString);
                                         [self.selectDateButton setTitle:finalSelectedDate forState:UIControlStateNormal];
                                         
                                     }
                                   cancelBlock:^(ActionSheetDatePicker *picker) {
                                       NSLog(@"Block Picker Canceled");
                                   }
                                        origin:sender];
    
    
}

- (IBAction)bookButtonTapped:(id)sender {
    
    if (selectedTreatmentArr.count > 0 && ![finalSelectedDate isEqualToString:@""]) {
        [self startBookProjectService];
    }
    else {
        [self didFinishServiceWithFailure:@"Please enter all option to proceed."];
    }
    
}


- (void) startBookProjectService {
    
    [SVProgressHUD showWithStatus:@"Booking project..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kCustomerBookProjectService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForBookProject]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    
    if ([requestServiceKey isEqualToString:kCustomerBookProjectService]) {
        
        [SVProgressHUD showSuccessWithStatus:@"Project Booked successfully"];
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

- (NSMutableDictionary *) prepareDictionaryForBookProject {
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[[selectedTreatmentArr valueForKey:@"name"] componentsJoinedByString:@","] forKey:@"Treatment"];
    [dict setObject:[[SharedClass sharedInstance] userObj].user_id forKey:@"Booker_id"];
    [dict setObject:hairDresserId forKey:@"Hairdresser_id"];

    
    [dict setObject:finalSelectedDate forKey:@"Date"];
    [dict setObject:finalSelectedTime forKey:@"Booking_Time"];
    
    return dict;
    
}

@end
