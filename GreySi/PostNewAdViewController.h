//
//  PostNewAdViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 10/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostNewAdViewController : UIViewController {
    
    NSMutableArray* treatmentOptionsArr;
    
}

@property (weak, nonatomic) IBOutlet UIButton *treatmentButton;
@property (weak, nonatomic) IBOutlet UIButton *platsButton;
@property (weak, nonatomic) IBOutlet UIButton *budgetButton;
- (IBAction)treatmentButtonTapped:(id)sender;
- (IBAction)platsButtonTapped:(id)sender;
- (IBAction)budgetButtonTapped:(id)sender;
@end
