//
//  PostNewAdViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 10/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "PostNewAdViewController.h"
#import "TreatmentTabTableViewCell.h"

@interface PostNewAdViewController ()

@end

@implementation PostNewAdViewController

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
    
    treatmentOptionsArr = [[NSMutableArray alloc] initWithObjects:@"Women's Hair",@"Men's Hair",@"Manicure",@"Pedicure",@"Beauty",@"Massage",@"Other", nil];
    
    self.treatmentButton.layer.cornerRadius = 2.0;
    self.platsButton.layer.cornerRadius = 2.0;
    self.budgetButton.layer.cornerRadius = 2.0;
    
    [self setupLayoutForTabIndex:0];
    
}

- (void) setupLayoutForTabIndex:(int)index {
    
    if (index == 0) {
        self.treatmentButton.backgroundColor = [UIColor colorWithRed:202./255. green:202./255. blue:202./255. alpha:1.0];
        self.platsButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
        self.budgetButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
    }
    else if (index == 1) {
        self.platsButton.backgroundColor = [UIColor colorWithRed:202./255. green:202./255. blue:202./255. alpha:1.0];
        self.treatmentButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
        self.budgetButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
    }
    else if (index == 2) {
        self.budgetButton.backgroundColor = [UIColor colorWithRed:202./255. green:202./255. blue:202./255. alpha:1.0];
        self.platsButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
        self.treatmentButton.backgroundColor = [UIColor colorWithRed:225./255. green:225./255. blue:225./255. alpha:1.0];
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
    
    [self setupLayoutForTabIndex:0];
    
}

- (IBAction)platsButtonTapped:(id)sender {
    
    [self setupLayoutForTabIndex:1];
    
}

- (IBAction)budgetButtonTapped:(id)sender {
    
    [self setupLayoutForTabIndex:2];
    
}


#pragma mark - UITableView Datasource -

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
    
    
    
}

- (void) displayContentForCell:(TreatmentTabTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row %2 == 0) {
        cell.treatmentImgView.image = [UIImage imageNamed:@"womenhair.png"];
    }
    else {
        cell.treatmentImgView.image = [UIImage imageNamed:@"menhair.png"];
    }
    
    cell.treatmentLabel.text = treatmentOptionsArr[indexPath.row];
    
}

@end
