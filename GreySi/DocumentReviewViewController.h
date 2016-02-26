//
//  DocumentReviewViewController.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 26/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PECropViewController.h"

@interface DocumentReviewViewController : UIViewController<UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PECropViewControllerDelegate> {
    UIActionSheet* actSheet;
    UIImage* diplomaImage;
}

@property (strong, nonatomic) IBOutlet UIImageView *diplomaImageView;
@property (strong, nonatomic) IBOutlet UIButton *sendForReviewButton;

- (IBAction)backButtonTapped:(id)sender;
- (IBAction)uploadDiplomaButtonTapped:(id)sender;
- (IBAction)skipButtonTapped:(id)sender;
- (IBAction)sendForReviewButtonTapped:(id)sender;

@end
