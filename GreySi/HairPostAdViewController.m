//
//  HairPostAdViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/09/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "HairPostAdViewController.h"
#import "HairPostAdTableViewCell.h"
#import "HomeViewController.h"

@interface HairPostAdViewController ()

@end

@implementation HairPostAdViewController

@synthesize isOpenedFromSideMenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    tblCount = 3;
    self.adsTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    [self.adsTblView addGestureRecognizer:gesture];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tblCount;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* identifier = @"HairPostAdTableViewCell";
    HairPostAdTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"HairPostAdTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    [cell.addMoreButton addTarget:self action:@selector(addMoreButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [cell.submitButton addTarget:self action:@selector(submitButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    cell.priceTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    [self displayContentForCell:cell atIndexPath:indexPath];
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
}

- (void) displayContentForCell:(HairPostAdTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.submitButton.layer.cornerRadius = 5.0;
    
    if (indexPath.row == tblCount-1) {
        cell.treatmentNameTextField.hidden = YES;
        cell.priceTextField.hidden = YES;
        cell.addMoreButton.hidden = YES;
        cell.submitButton.hidden = NO;
    }
    else if (indexPath.row == tblCount-2) {
        cell.treatmentNameTextField.hidden = YES;
        cell.priceTextField.hidden = YES;
        cell.addMoreButton.hidden = NO;
        cell.submitButton.hidden = YES;
    }
    else {
        cell.treatmentNameTextField.hidden = NO;
        cell.priceTextField.hidden = NO;
        cell.addMoreButton.hidden = YES;
        cell.submitButton.hidden = YES;
    }
    
}

- (void) addMoreButtonTapped {
    
    tblCount++;
    [self.adsTblView reloadData];
    
}

- (void) submitButtonTapped {
    [self startPostAdService];
}


#pragma mark - API handlers

- (void) startPostAdService {
    
    [SVProgressHUD showWithStatus:@"Posting treatment..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kHairPostAdService;
    manager.delegate = self;
    [manager startPOSTWebServicesWithParams:[self prepareDictionaryForAddTreatment]];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(SignUpResponseModal *)responseData andServiceKey:(NSString *)requestServiceKey {
    
    [SVProgressHUD showSuccessWithStatus:@"Ad Posted Successfully..."];
    
    if ([requestServiceKey isEqualToString:kHairPostAdService]) {
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
    
    [self calculateTreatmentAndBudgetList];
    
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    
    [dict setObject:[[SharedClass sharedInstance] userObj].user_id forKey:@"User_id"];
    [dict setObject:treatmentList forKey:@"Treatment"];
    [dict setObject:budgetList forKey:@"Budget"];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    
    [dict setObject:[dateFormatter stringFromDate:[NSDate date]] forKey:@"Today"];
    
    return dict;
    
}

- (void) calculateTreatmentAndBudgetList {
    
    treatmentList = @"{\"treatmentsArray\":[";
    budgetList = @"{\"pricesArray\":[";
    
    for (int i = 0; i<tblCount-2; i++) {
        
        HairPostAdTableViewCell* cell = [self.adsTblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        
        if (![cell.treatmentNameTextField.text isEqualToString:@""] && cell.treatmentNameTextField.text) {
            
            if (i>0) {
                treatmentList = [treatmentList stringByAppendingString:[NSString stringWithFormat:@",{\"name\":\"%@\"}",cell.treatmentNameTextField.text]];
                budgetList = [budgetList stringByAppendingString:[NSString stringWithFormat:@",{\"name\":\"%@\"}",cell.priceTextField.text]];
            }
            else {
                treatmentList = [treatmentList stringByAppendingString:[NSString stringWithFormat:@"{\"name\":\"%@\"}",cell.treatmentNameTextField.text]];
                budgetList = [budgetList stringByAppendingString:[NSString stringWithFormat:@"{\"name\":\"%@\"}",cell.priceTextField.text]];
            }
            
        }
        
    }
    
    treatmentList = [treatmentList stringByAppendingString:@"]}"];
    budgetList = [budgetList stringByAppendingString:@"]}"];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endEditing];
}

- (void) endEditing {
    
    [self.view endEditing:YES];
    
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
