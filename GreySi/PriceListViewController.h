//
//  PriceListViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceListViewController : UIViewController

@property (strong, nonatomic) NSMutableArray* treatmentArr;
@property (strong, nonatomic) NSMutableArray* priceArr;

@property (weak, nonatomic) IBOutlet UITableView *listTblView;
- (IBAction)backButtonTapped:(id)sender;

@end
