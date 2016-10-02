//
//  PriceListViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "PriceListViewController.h"

@interface PriceListViewController ()

@end

@implementation PriceListViewController

@synthesize priceArr,treatmentArr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.listTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [priceArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"ListAssetFieldCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        
    }
    
    // Configure the cell...
    cell.textLabel.font = [UIFont systemFontOfSize:14.0];
    cell.textLabel.text = [[treatmentArr objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0];
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"$%@",[[priceArr objectAtIndex:indexPath.row] valueForKey:@"name"]];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
@end
