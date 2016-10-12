//
//  SideMenuViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SideMenuTableViewCell.h"
#import "PostNewAdViewController.h"
#import "HairPostAdViewController.h"
#import "ProfileDetailViewController.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self generateDataSource];
    
}

- (void) setupUI {
    
    self.profileImgView.layer.masksToBounds = YES;
    self.profileImgView.layer.cornerRadius = self.profileImgView.frame.size.height/2.;
    
    self.profileName.text = [[SharedClass sharedInstance] userObj].name;
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showEditProfileScreen)];
    self.profileImgView.userInteractionEnabled = YES;
    [self.profileImgView addGestureRecognizer:tapGesture];
    
    UITapGestureRecognizer* tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showEditProfileScreen)];
    self.profileName.userInteractionEnabled = YES;
    [self.profileName addGestureRecognizer:tapGesture1];
    
    __weak UIImageView* weakImageView = self.profileImgView;
    [self.profileImgView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[[SharedClass sharedInstance] userObj].profile_pi stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
                                                                   cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                               timeoutInterval:60.0] placeholderImage:[UIImage imageNamed:@"blankProfile"] success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        
        
        weakImageView.alpha = 0.0;
        weakImageView.image = image;
        [UIView animateWithDuration:0.25
                         animations:^{
                             weakImageView.alpha = 1.0;
                         }];
    } failure:NULL];
    
}

- (void) generateDataSource {
    
    tableArr = [[NSMutableArray alloc] init];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"PROJECTS" forKey:@"title"];
    [dict setObject:@"projects.png" forKey:@"image"];
    [tableArr addObject:dict];
    
    NSMutableDictionary* dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setObject:@"MESSAGES" forKey:@"title"];
    [dict1 setObject:@"messages.png" forKey:@"image"];
    [tableArr addObject:dict1];
    
    NSMutableDictionary* dict3 = [[NSMutableDictionary alloc] init];
    [dict3 setObject:@"POST AN AD" forKey:@"title"];
    [dict3 setObject:@"postAd.png" forKey:@"image"];
    [tableArr addObject:dict3];
    
    NSMutableDictionary* dict4 = [[NSMutableDictionary alloc] init];
    [dict4 setObject:@"BOOKINGS" forKey:@"title"];
    [dict4 setObject:@"booking_navigation_drawer_image.png" forKey:@"image"];
    [tableArr addObject:dict4];
    
    NSMutableDictionary* dict5 = [[NSMutableDictionary alloc] init];
    [dict5 setObject:@"LOCATION" forKey:@"title"];
    [dict5 setObject:@"myLocation.png" forKey:@"image"];
    [tableArr addObject:dict5];
    
    NSMutableDictionary* dict2 = [[NSMutableDictionary alloc] init];
    [dict2 setObject:@"LOG OUT" forKey:@"title"];
    [dict2 setObject:@"logout.png" forKey:@"image"];
    [tableArr addObject:dict2];
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return tableArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString* identifier = @"SideMenuCell";
    SideMenuTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"SideMenuTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    cell.tabImageView.image = [UIImage imageNamed:[[tableArr objectAtIndex:indexPath.row] valueForKey:@"image"]];
    cell.tabLabel.text = [[tableArr objectAtIndex:indexPath.row] valueForKey:@"title"];
    
    return cell;
    
    
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"showProjectsSegue" sender:nil];
            break;
            
        case 1:
            [self performSegueWithIdentifier:@"showChatSegue" sender:nil];
            break;
            
            
        case 2:
            if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
                [self performSegueWithIdentifier:@"showHairPostAdSegue" sender:nil];
            }
            else {
                [self performSegueWithIdentifier:@"showPostAdSegue" sender:nil];
            }
            break;
        
        case 3:
            [self performSegueWithIdentifier:@"showBookingsSegue" sender:nil];
            break;
            
        case 4:
            [self performSegueWithIdentifier:@"showLocationSegue" sender:nil];
            break;
            
        case 5:
            [self showLogoutAlert];
            break;
            
        default:
            break;
    }
    
}

- (void) showLogoutAlert {
    
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil
                                                  message:NSLocalizedString(@"Are you sure wou want to logout?", nil)
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"NO", nil)
                                        otherButtonTitles:@"YES", nil];
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        
        [[SharedClass sharedInstance] removeServiceData:kLoginService];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showPostAdSegue"]) {
        
        PostNewAdViewController* controller = (PostNewAdViewController *)[segue destinationViewController];
        controller.isOpenedFromSideMenu = YES;
        
    }
    if ([[segue identifier] isEqualToString:@"showHairPostAdSegue"]) {
        
        HairPostAdViewController* controller = (HairPostAdViewController *)[segue destinationViewController];
        controller.isOpenedFromSideMenu = YES;
        
    }
    
    if ([[segue identifier] isEqualToString:@"showEditProfileSegue"]) {
        
        ProfileDetailViewController* controller = (ProfileDetailViewController *)[segue destinationViewController];
        controller.userId = [[SharedClass sharedInstance] userObj].user_id;
        if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
            controller.isEditable = YES;
        }
        controller.isOpenedFromSideMenu = YES;
    }

}

- (void) showEditProfileScreen {
    
    [self performSegueWithIdentifier:@"showEditProfileSegue" sender:nil];
    
}

@end
