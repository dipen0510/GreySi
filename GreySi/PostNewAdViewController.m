//
//  PostNewAdViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 10/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "PostNewAdViewController.h"
#import "TreatmentTabTableViewCell.h"
#import "AddTreatmentRequestModal.h"
#import "HomeViewController.h"

@interface PostNewAdViewController ()

@end

@implementation PostNewAdViewController

@synthesize isOpenedFromSideMenu;

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
    
    treatmentOptionsArr = [[NSMutableArray alloc] initWithObjects:@"Womens Hair",@"Mens Hair",@"Manicure",@"Pedicure",@"Beauty",@"Massage",@"Other", nil];
    treatmentOptionsImgArr = [[NSMutableArray alloc] initWithObjects:@"new_womens_hair_logo.png",@"new_mens_hair_logo.png",@"new_manicure_logo.png",@"new_padicure_logo.png",@"new_beauty_logo.png",@"new_massage_logo.png",@"new_others_logo.png", nil];
    cityOptionsArr = [[NSMutableArray alloc] initWithObjects:@"Stockholm",@"Manchester",@"Hamburg",@"Sussex", nil];
    selectedTreamentsArr = [[NSMutableArray alloc] init];
    
    //self.treatmentButton.layer.cornerRadius = 2.0;
    //self.platsButton.layer.cornerRadius = 2.0;
    //self.budgetButton.layer.cornerRadius = 2.0;
    self.selectCityButton.layer.cornerRadius = 2.0;
    self.selectDateTimeButton.layer.cornerRadius = 2.0;
    
    self.budgetTxtField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.adTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    self.descriptionTxtView.layer.cornerRadius = 10.0;
    self.descriptionTxtView.layer.borderColor = [UIColor colorWithRed:211./255. green:211./255. blue:211./255. alpha:1.0].CGColor;
    self.descriptionTxtView.layer.borderWidth = 1.0;
    
    [self.tabBarView layoutIfNeeded];
    [self.tabBarView setNeedsLayout];
    
    UIImageView* firstArrImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.treatmentButton.frame.origin.x + self.treatmentButton.frame.size.width, self.treatmentButton.frame.origin.y, 0.362*self.treatmentButton.frame.size.height, self.treatmentButton.frame.size.height)];
    firstArrImgView.image = [UIImage imageNamed:@"addTreatMentTopMenuArrow.png"];
    
    UIImageView* secondArrImgView = [[UIImageView alloc] initWithFrame:CGRectMake(self.platsButton.frame.origin.x + self.platsButton.frame.size.width, self.platsButton.frame.origin.y, 0.362*self.platsButton.frame.size.height, self.platsButton.frame.size.height)];
    secondArrImgView.image = [UIImage imageNamed:@"addTreatMentTopMenuArrow.png"];
    
    [self.tabBarView addSubview:firstArrImgView];
    [self.tabBarView addSubview:secondArrImgView];
    
    [self setupLayoutForTabIndex:0];
    
    
}

- (void) setupLayoutForTabIndex:(int)index {
    
    if (index == 0) {
        
//        self.treatmentButton.backgroundColor = [UIColor colorWithRed:202./255. green:202./255. blue:202./255. alpha:1.0];
//        self.platsButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
//        self.budgetButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
        
        self.treatmentTabView.hidden = NO;
        self.platsTabView.hidden = YES;
        self.budgetTabView.hidden = YES;
        
    }
    else if (index == 1) {
        
//        self.platsButton.backgroundColor = [UIColor colorWithRed:202./255. green:202./255. blue:202./255. alpha:1.0];
//        self.treatmentButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
//        self.budgetButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
        
        self.treatmentTabView.hidden = YES;
        self.platsTabView.hidden = NO;
        self.budgetTabView.hidden = YES;
        
        
    }
    else if (index == 2) {
//        self.budgetButton.backgroundColor = [UIColor colorWithRed:202./255. green:202./255. blue:202./255. alpha:1.0];
//        self.platsButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
//        self.treatmentButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
        
        self.treatmentTabView.hidden = YES;
        self.platsTabView.hidden = YES;
        self.budgetTabView.hidden = NO;
        
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

#pragma mark - User Action Events

- (IBAction)treatmentButtonTapped:(id)sender {
    
    //[self setupLayoutForTabIndex:0];
    
}

- (IBAction)platsButtonTapped:(id)sender {
    
    //[self setupLayoutForTabIndex:1];
    
}

- (IBAction)budgetButtonTapped:(id)sender {
    
    //[self setupLayoutForTabIndex:2];
    
}

- (IBAction)selectCityButtonTapped:(id)sender {
    
    [ActionSheetStringPicker showPickerWithTitle:@"Select a City"
                                            rows:cityOptionsArr
                                initialSelection:0
                                       doneBlock:^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
                                           
                                           NSLog(@"Picker: %@, Index: %ld, value: %@", picker, (long)selectedIndex, selectedValue);
                                           [self.selectCityButton setTitle:selectedValue forState:UIControlStateNormal];
                                           
                                       }
                                     cancelBlock:^(ActionSheetStringPicker *picker) {
                                         NSLog(@"Block Picker Canceled");
                                     }
                                          origin:sender];
    
}

- (IBAction)selectDateTimeButtonTapped:(id)sender {
    
    if (self.specificTimeButton.selected) {
        [ActionSheetDatePicker showPickerWithTitle:@"Select a Date"
                                    datePickerMode:UIDatePickerModeDateAndTime
                                      selectedDate:[NSDate date] minimumDate:[NSDate date] maximumDate:nil
                                         doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                             
                                             NSDateFormatter* format1 = [[NSDateFormatter alloc] init];
                                             format1.dateFormat = @"dd/MM/yyyy";
                                             
                                             NSDateFormatter* format2 = [[NSDateFormatter alloc] init];
                                             format2.dateFormat = @"HH:mm";
                                             
                                             finalSelectedDate = [format1 stringFromDate:selectedDate];
                                             finalSelectedTime = [format2 stringFromDate:selectedDate];
                                             
                                             NSString *dateString = [NSDateFormatter localizedStringFromDate:selectedDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
                                             NSLog(@"Picker: value: %@",dateString);
                                             [self.selectDateTimeButton setTitle:dateString forState:UIControlStateNormal];
                                             
                                         }
                                       cancelBlock:^(ActionSheetDatePicker *picker) {
                                           NSLog(@"Block Picker Canceled");
                                       }
                                            origin:sender];
    }
    else if (self.timeSlotButton.selected) {
        [ActionSheetDatePicker showPickerWithTitle:@"Select initial Date"
                                    datePickerMode:UIDatePickerModeDateAndTime
                                      selectedDate:[NSDate date] minimumDate:[NSDate date] maximumDate:nil
                                         doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                             
                                             NSDateFormatter* format1 = [[NSDateFormatter alloc] init];
                                             format1.dateFormat = @"dd/MM/yyyy";
                                             
                                             NSDateFormatter* format2 = [[NSDateFormatter alloc] init];
                                             format2.dateFormat = @"HH:mm";
                                             
                                             finalSelectedDate = [format1 stringFromDate:selectedDate];
                                             finalSelectedTime = [format2 stringFromDate:selectedDate];
                                             
                                             [ActionSheetDatePicker showPickerWithTitle:@"Select final Date"
                                                                         datePickerMode:UIDatePickerModeTime
                                                                           selectedDate:selectedDate minimumDate:selectedDate maximumDate:nil
                                                                              doneBlock:^(ActionSheetDatePicker *picker, id selectedDate, id origin) {
                                                                                  
                                                                                  NSDateFormatter* format1 = [[NSDateFormatter alloc] init];
                                                                                  format1.dateFormat = @"dd/MM/yyyy";
                                                                                  
                                                                                  NSDateFormatter* format2 = [[NSDateFormatter alloc] init];
                                                                                  format2.dateFormat = @"HH:mm";
                                                                                  
                                                                                  finalSelectedTime = [NSString stringWithFormat:@"%@-%@",finalSelectedTime,[format2 stringFromDate:selectedDate]];
                                                                                  
                                                                                  NSString *dateString = [NSDateFormatter localizedStringFromDate:selectedDate dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
                                                                                  NSLog(@"Picker: value: %@",dateString);
                                                                                  [self.selectDateTimeButton setTitle:[NSString stringWithFormat:@"%@, %@",finalSelectedDate,finalSelectedTime] forState:UIControlStateNormal];
                                                                                  
                                                                              }
                                                                            cancelBlock:^(ActionSheetDatePicker *picker) {
                                                                                NSLog(@"Block Picker Canceled");
                                                                            }
                                                                                 origin:sender];
                                             
                                         }
                                       cancelBlock:^(ActionSheetDatePicker *picker) {
                                           NSLog(@"Block Picker Canceled");
                                       }
                                            origin:sender];
    }
    else {
        [self didFinishServiceWithFailure:@"Please select all options to proceed"];
    }
    

    
}

- (IBAction)backButtonTapped:(id)sender {
    
    if (isOpenedFromSideMenu) {
        UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        HomeViewController* controller = (HomeViewController*)[mainStoryboard instantiateViewControllerWithIdentifier:@"homeViewController"];
        [self.revealViewController setFrontViewController:controller animated:YES];
    }
    else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}

- (IBAction)treatmentTabNextButtonTapped:(id)sender {
    
    if (selectedTreamentsArr.count > 0) {
        [self setupLayoutForTabIndex:1];
    }
    else {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Select Treatment" message:@"Please select at least one treatment to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    
}

- (IBAction)myPlaceButtonTapped:(id)sender {
    
    [self.myPlaceButton setSelected:!self.myPlaceButton.selected];
    
}

- (IBAction)yourPlaceButtonTapped:(id)sender {
    
    [self.yourPlaceButton setSelected:!self.yourPlaceButton.selected];
    
}

- (IBAction)placeTabNextButtonTapped:(id)sender {
    
    if ([self.selectCityButton.titleLabel.text isEqualToString:@"Select a City"] || [self.selectDateTimeButton.titleLabel.text isEqualToString:@"Select Date & Time"] || (!self.myPlaceButton.isSelected && !self.yourPlaceButton.isSelected)) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Select Options" message:@"Please select all options to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else {
        [self setupLayoutForTabIndex:2];
    }
    
}

- (IBAction)addButtonTapped:(id)sender {
    
    [self startAddTreatmentService];
    
}

- (IBAction)specificTimeButtonTapped:(id)sender {
    
    [self.timeSlotButton setSelected:NO];
    [self.specificTimeButton setSelected:YES];
    [self.selectDateTimeButton setTitle:@"Select Date & Time" forState:UIControlStateNormal];
    
}

- (IBAction)timeSlotButtonTapped:(id)sender {
    
    [self.specificTimeButton setSelected:NO];
    [self.timeSlotButton setSelected:YES];
    [self.selectDateTimeButton setTitle:@"Select Date & Time" forState:UIControlStateNormal];
    
}



#pragma mark - UIPickerView Delegate


#pragma mark - UIPickerView Datasource



#pragma mark - UITableView Datasource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* identifier = @"TreatmentTabTableViewCell";
    TreatmentTabTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"TreatmentTabTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    
    [self displayContentForCell:cell atIndexPath:indexPath];
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if([selectedTreamentsArr containsObject:[treatmentOptionsArr objectAtIndex:indexPath.row]]){
        [selectedTreamentsArr removeObject:[treatmentOptionsArr objectAtIndex:indexPath.row]];
    } else {
        [selectedTreamentsArr removeAllObjects];
        [selectedTreamentsArr addObject:[treatmentOptionsArr objectAtIndex:indexPath.row]];
    }
    
    [tableView reloadData];
    
}

- (void) displayContentForCell:(TreatmentTabTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.treatmentImgView.image = [UIImage imageNamed:treatmentOptionsImgArr[indexPath.row]];
    cell.treatmentLabel.text = treatmentOptionsArr[indexPath.row];
    
    if([selectedTreamentsArr containsObject:[treatmentOptionsArr objectAtIndex:indexPath.row]]){
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
}

#pragma mark - API handlers

- (void) startAddTreatmentService {
    
    [SVProgressHUD showWithStatus:@"Posting treatment..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kCustomerAddTreatmentService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForAddTreatment]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(SignUpResponseModal *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    //[SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@"Ad Posted Successfully"];
    
    if ([requestServiceKey isEqualToString:kCustomerAddTreatmentService]) {
        [self performSelector:@selector(backButtonTapped:) withObject:nil afterDelay:0.3];
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

- (NSMutableDictionary *) prepareDictionaryForAddTreatment {
    
    AddTreatmentRequestModal* obj = [[AddTreatmentRequestModal alloc] init];
    
    obj.user_id = [[SharedClass sharedInstance] userObj].user_id;
    obj.treatment = [selectedTreamentsArr componentsJoinedByString:@","];
    obj.city = self.selectCityButton.titleLabel.text;
    obj.place = (self.myPlaceButton.selected) ? @"My Place" : @"Your Place";
    obj.date = finalSelectedDate;
    obj.time = finalSelectedTime;
    obj.budget = self.budgetTxtField.text;
    obj.desc = self.descriptionTxtView.text;
    
    return [obj createRequestDictionary];
    
}

@end
