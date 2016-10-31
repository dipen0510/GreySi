//
//  AppTutorialViewController.h
//  Happ Post
//
//  Created by Dipen Sekhsaria on 30/10/15.
//  Copyright © 2015 Stardeep. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppTutorialThirdPageViewController.h"

@interface AppTutorialPageViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate,AppTutorialThirdPageViewControllerDelegate> {
    int currentIndex;
    BOOL movedToNewPage;
    int transitionToIndex;
}

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) IBOutlet UIButton *previousButton;
@property (strong, nonatomic) IBOutlet UIButton *nextButton;

- (IBAction)previousButtonTapped:(id)sender;
- (IBAction)nextButtonTapped:(id)sender;

@end
