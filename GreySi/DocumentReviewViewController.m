//
//  DocumentReviewViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 26/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "DocumentReviewViewController.h"

@interface DocumentReviewViewController ()

@end

@implementation DocumentReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupInitialUI];
    [self setupActionSheet];
    
}

- (void) setupInitialUI {
    
    self.diplomaImageView.hidden = YES;
    self.sendForReviewButton.hidden = YES;
    diplomaImage = self.diplomaImageView.image;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)uploadDiplomaButtonTapped:(id)sender {
    
    if ([actSheet isVisible]) {
        [actSheet dismissWithClickedButtonIndex:0 animated:YES];
    }
    else {
        [actSheet showInView:self.view];
    }
    
}

- (IBAction)skipButtonTapped:(id)sender {
}

- (IBAction)sendForReviewButtonTapped:(id)sender {
}


#pragma mark - Profile Image Change

- (void) setupActionSheet {
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        actSheet = [[UIActionSheet alloc] initWithTitle:nil
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@"Photo Library", nil];
    }
    else {
        actSheet = [[UIActionSheet alloc] initWithTitle:nil
                                               delegate:self
                                      cancelButtonTitle:@"Cancel"
                                 destructiveButtonTitle:nil
                                      otherButtonTitles:@"Photo Library", @"Camera", nil];
    }
    
}



- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (actionSheet == actSheet) {
        //FLOG(@"Button %d", buttonIndex);
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            
            switch (buttonIndex) {
                    
                case 0:
                {
                    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
                    imgPicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                    imgPicker.delegate = self;
                    [self presentViewController:imgPicker animated:YES completion:nil];
                    break;
                }
                    
                default:
                    
                    break;
            }
            
        }
        else {
            
            switch (buttonIndex) {
                    
                case 0:
                {
                    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
                    imgPicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
                    imgPicker.delegate = self;
                    [self presentViewController:imgPicker animated:YES completion:nil];
                    break;
                }
                    
                case 1:
                {
                    UIImagePickerController *imgPicker = [[UIImagePickerController alloc] init];
                    imgPicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                    imgPicker.delegate = self;
                    [self presentViewController:imgPicker animated:YES completion:nil];
                    break;
                }
                    
                default:
                    
                    break;
            }
            
        }
        
        
        
        
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image1 = info[UIImagePickerControllerOriginalImage];
    self.diplomaImageView.image = image1;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        [self openEditor:nil];
        
    } else {
        [picker dismissViewControllerAnimated:YES completion:^{
            [self openEditor:nil];
        }];
    }
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark - PECropViewControllerDelegate methods

-(void)cropViewController:(PECropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage {
    
    self.diplomaImageView.hidden = NO;
    self.sendForReviewButton.hidden = NO;
    
    self.diplomaImageView.image = croppedImage;
    diplomaImage = croppedImage;
    
    //[[SharedClass sharedInstance] saveProfileImage:profileImage forStudentId:[[studentObj.getStudentsInfoDetails objectAtIndex:0] valueForKey:StudentsIdKey]];
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
    
    
}

- (void)cropViewControllerDidCancel:(PECropViewController *)controller
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        // [self updateEditButtonEnabled];
    }
    
    [controller dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Action methods
//#GD: 2015_0318 added method to crop the profile pic
- (IBAction)openEditor:(id)sender
{
    PECropViewController *controller = [[PECropViewController alloc] init];
    controller.delegate = self;
    controller.image = self.diplomaImageView.image;
    
    UIImage *image = self.diplomaImageView.image;
    CGFloat width = image.size.width;
    CGFloat height = image.size.height;
    CGFloat length = MIN(width, height);
    controller.imageCropRect = CGRectMake((width - length) / 2,
                                          (height - length) / 2,
                                          length,
                                          length);
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
    }
    
    [self presentViewController:navigationController animated:YES completion:NULL];
    
    
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
