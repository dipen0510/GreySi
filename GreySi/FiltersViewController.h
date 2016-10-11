//
//  FiltersViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 11/10/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FiltersViewDelegate <NSObject>

- (void) didTapOnApplyFilterWithBudget:(NSString *)budget withCities:(NSMutableArray *)citiesArr withTreatments:(NSMutableArray *)treatmentsArr;

@end

@interface FiltersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray* budgetArr;
    NSMutableArray* citiesArr;
    NSMutableArray* treatmentArr;
    NSMutableArray* selectedBudgetArr;
    NSMutableArray* selectedCitiesArr;
    NSMutableArray* selectedTreatmentArr;
}

@property (weak, nonatomic) IBOutlet UITableView *filterTableView;
@property (weak, nonatomic) id<FiltersViewDelegate> delegate;

@property (strong, nonatomic) NSMutableArray* allRedundantCities;
@property (strong, nonatomic) NSMutableArray* allRedundantTreatments;

- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)applyButtonTapped:(id)sender;

@end
