//
//  FiltersViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "FiltersViewController.h"

@interface FiltersViewController ()

@end

@implementation FiltersViewController

@synthesize allRedundantCities,allRedundantTreatments;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialDataSource];
    
}

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    if (([[[SharedClass sharedInstance] userObj].flag intValue] == 1)) {
        
        for (int i = 0; i<allRedundantCities.count; i++) {
            if (![citiesArr containsObject:[allRedundantCities objectAtIndex:i]]) {
                if (![[allRedundantCities objectAtIndex:i] isEqualToString:@""]) {
                    [citiesArr addObject:[allRedundantCities objectAtIndex:i]];
                }
            }
        }
        for (int i = 0; i<allRedundantTreatments.count; i++) {
            
            NSMutableArray* tmpArr;
            
            if ([[allRedundantTreatments objectAtIndex:i] containsString:@", "]) {
                tmpArr = [[NSMutableArray alloc] initWithArray:[[allRedundantTreatments objectAtIndex:i] componentsSeparatedByString:@", "]];
            }
            else {
                tmpArr = [[NSMutableArray alloc] initWithArray:[[allRedundantTreatments objectAtIndex:i] componentsSeparatedByString:@","]];
            }
            

            for (int j = 0; j<tmpArr.count; j++) {
                if (![treatmentArr containsObject:[tmpArr objectAtIndex:j]]) {
                    if (![[tmpArr objectAtIndex:j] isEqualToString:@""]) {
                        [treatmentArr addObject:[tmpArr objectAtIndex:j]];
                    }
                }
            }
        }

    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupInitialDataSource {
    
    budgetArr = [[NSMutableArray alloc] initWithObjects:@"$0 - $150",@"$150 - $300",@"$300 - $450",@"$450 - $700",@"$700 - $1000",@"$1000+", nil];
    
    
//    citiesArr = [[NSMutableArray alloc] initWithObjects:@"Stockholm",@"Manchester",@"Hamburg",@"Sussex", nil];
//    treatmentArr = [[NSMutableArray alloc] initWithObjects:@"Womens Hair",@"Mens Hair",@"Manicure",@"Pedicure",@"Beauty",@"Massage",@"Other", nil];
    
    selectedBudgetArr = [[NSMutableArray alloc] init];
    selectedCitiesArr = [[NSMutableArray alloc] init];
    selectedTreatmentArr = [[NSMutableArray alloc] init];
    citiesArr = [[NSMutableArray alloc] init];
    treatmentArr = [[NSMutableArray alloc] init];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)cancelButtonTapped:(id)sender {
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.view.alpha = 0;
     }
                     completion:^(BOOL finished){
                         
                         [self.view removeFromSuperview];
                         
                     }];
    
}

- (IBAction)applyButtonTapped:(id)sender {
    
    if (selectedBudgetArr.count>0) {
        [_delegate didTapOnApplyFilterWithBudget:[selectedBudgetArr objectAtIndex:0] withCities:selectedCitiesArr withTreatments:selectedTreatmentArr];
    }
    else {
        [_delegate didTapOnApplyFilterWithBudget:@"" withCities:selectedCitiesArr withTreatments:selectedTreatmentArr];
    }
    
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.view.alpha = 0;
     }
                     completion:^(BOOL finished){
                         
                         [self.view removeFromSuperview];
                         
                     }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
        return 3;
    }
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        return citiesArr.count;
    }
    else if (section == 2) {
        return treatmentArr.count;
    }
    
    return [budgetArr count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40.0)];
    [view setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(8, 8, self.view.frame.size.width - 8, 24.0)];
    label.textColor = [UIColor blackColor];
    [label setFont:[UIFont boldSystemFontOfSize:16.0]];
    if (section == 0) {
        label.text = @"Budget Range";
    }
    else if (section == 1) {
        label.text = @"Cities";
    }
    else if (section == 2) {
        label.text = @"Treatments";
    }
    
    [view addSubview:label];
    
    return view;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ListAssetFieldCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    if (indexPath.section == 0) {
        cell.textLabel.text = [budgetArr objectAtIndex:indexPath.row];
        if([selectedBudgetArr containsObject:[budgetArr objectAtIndex:indexPath.row]]){
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    else if (indexPath.section == 1) {
        cell.textLabel.text = [citiesArr objectAtIndex:indexPath.row];
        if([selectedCitiesArr containsObject:[citiesArr objectAtIndex:indexPath.row]]){
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    else if (indexPath.section == 2) {
        cell.textLabel.text = [treatmentArr objectAtIndex:indexPath.row];
        if([selectedTreatmentArr containsObject:[treatmentArr objectAtIndex:indexPath.row]]){
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0) {
        if([selectedBudgetArr containsObject:[budgetArr objectAtIndex:indexPath.row]]){
            [selectedBudgetArr removeObject:[budgetArr objectAtIndex:indexPath.row]];
        } else {
            [selectedBudgetArr removeAllObjects];
            [selectedBudgetArr addObject:[budgetArr objectAtIndex:indexPath.row]];
            [tableView reloadData];
        }
    }
    else if (indexPath.section == 1) {
        if([selectedCitiesArr containsObject:[citiesArr objectAtIndex:indexPath.row]]){
            [selectedCitiesArr removeObject:[citiesArr objectAtIndex:indexPath.row]];
        } else {
            [selectedCitiesArr addObject:[citiesArr objectAtIndex:indexPath.row]];
        }
    }
    else if (indexPath.section == 2) {
        if([selectedTreatmentArr containsObject:[treatmentArr objectAtIndex:indexPath.row]]){
            [selectedTreatmentArr removeObject:[treatmentArr objectAtIndex:indexPath.row]];
        } else {
            [selectedTreatmentArr addObject:[treatmentArr objectAtIndex:indexPath.row]];
        }
    }
    
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 40.0;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40.0;
    
}
@end
