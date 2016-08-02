//
//  SignUpViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 25/02/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "SignUpViewController.h"
#import "LoginTableViewCell.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addGradientToBGView];
    [self setupInitialUI];
    [self setupActionSheet];
}

- (void) addGradientToBGView {
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:150./255. green:24./255. blue:206./255. alpha:1.0] CGColor], (id)[[UIColor colorWithRed:183./255. green:10./255. blue:197./255. alpha:1.0] CGColor], nil];
    [self.view.layer insertSublayer:gradient atIndex:0];
    
}

- (void) setupInitialUI {
    
    self.registerTableView.layer.cornerRadius = 5.0;
    self.signUpButton.layer.cornerRadius = 5.0;
    
}

#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString* identifier = @"RegisterCell";
    LoginTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = (LoginTableViewCell *)[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    if (indexPath.row == 0) {
        cell.txtField.placeholder = @"Name";
        cell.separatorView.hidden = NO;
    }
    else if (indexPath.row == 1) {
        cell.txtField.placeholder = @"Email";
        cell.separatorView.hidden = NO;
    }
    else if (indexPath.row == 2) {
        cell.txtField.placeholder = @"Password";
        cell.separatorView.hidden = NO;
    }
    else if (indexPath.row == 3) {
        cell.txtField.placeholder = @"Confirm Password";
        cell.separatorView.hidden = YES;
    }
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    
    
}


- (IBAction)profileButtonTapped:(id)sender {
    
    if ([actSheet isVisible]) {
        [actSheet dismissWithClickedButtonIndex:0 animated:YES];
    }
    else {
        [actSheet showInView:self.view];
    }
    
}

- (IBAction)submitButtonTapped:(id)sender {
    
    [SVProgressHUD showSuccessWithStatus:@"Registered successfully"];
    
}

- (IBAction)backButtonTapped:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
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
    [self.profileButton setImage:image1 forState:UIControlStateNormal];
    
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
    
    [self.profileButton setImage:croppedImage forState:UIControlStateNormal];
    profileImage = croppedImage;
    
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
    controller.image = self.profileButton.imageView.image;
    
    UIImage *image = self.profileButton.imageView.image;
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
