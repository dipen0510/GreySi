//
//  SignUpViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"

@interface SignUpViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PECropViewControllerDelegate>  {
    UIActionSheet* actSheet;
    UIImage* profileImage;
}


@property (strong, nonatomic) IBOutlet UIButton *profileButton;
@property (weak, nonatomic) IBOutlet UITableView *registerTableView;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;

- (IBAction)profileButtonTapped:(id)sender;
- (IBAction)submitButtonTapped:(id)sender;
- (IBAction)backButtonTapped:(id)sender;

@end
