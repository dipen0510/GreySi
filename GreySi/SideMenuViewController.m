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
#import "ALContactService.h"
#import "ALUserService.h"

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    [self generateDataSource];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self setupUI];
    
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
    
    
//    ALContactService* contactService = [ALContactService new];
//    ALContact *contact = [contactService loadContactByKey:@"userId" value:[[SharedClass sharedInstance] userObj].email];
//    unreadCount = [contact unreadCount];

    ALUserService * alUserService = [[ALUserService alloc] init];
    unreadCount = [alUserService getTotalUnreadCount];
    
    [_menuTblView reloadData];
    
    if (![[[SharedClass sharedInstance] userObj].profile_pi isEqual:[NSNull null]]) {
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

}

- (void) generateDataSource {
    
    tableArr = [[NSMutableArray alloc] init];
    NSMutableDictionary* dict = [[NSMutableDictionary alloc] init];
    [dict setObject:@"Behandlingar" forKey:@"title"];
    [dict setObject:@"projects.png" forKey:@"image"];
    [tableArr addObject:dict];
    
    NSMutableDictionary* dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setObject:@"Meddelanden" forKey:@"title"];
    [dict1 setObject:@"messages.png" forKey:@"image"];
    [tableArr addObject:dict1];
    
    NSMutableDictionary* dict3 = [[NSMutableDictionary alloc] init];
    [dict3 setObject:@"Lägg in annons" forKey:@"title"];
    [dict3 setObject:@"postAd.png" forKey:@"image"];
    [tableArr addObject:dict3];
    
    NSMutableDictionary* dict4 = [[NSMutableDictionary alloc] init];
    [dict4 setObject:@"Bokningar" forKey:@"title"];
    [dict4 setObject:@"booking_navigation_drawer_image.png" forKey:@"image"];
    [tableArr addObject:dict4];
    
    NSMutableDictionary* dict5 = [[NSMutableDictionary alloc] init];
    [dict5 setObject:@"Min plats" forKey:@"title"];
    [dict5 setObject:@"myLocation.png" forKey:@"image"];
    [tableArr addObject:dict5];
    
    NSMutableDictionary* dict6 = [[NSMutableDictionary alloc] init];
    [dict6 setObject:@"TUTORIAL" forKey:@"title"];
    [dict6 setObject:@"book-open-page-variant.png" forKey:@"image"];
    [tableArr addObject:dict6];
    
    NSMutableDictionary* dict2 = [[NSMutableDictionary alloc] init];
    [dict2 setObject:@"Logga ut" forKey:@"title"];
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
    
    if (indexPath.row == 1 && [unreadCount intValue]>0 && unreadCount) {
        cell.unreadMsgCountLabel.hidden = NO;
        cell.unreadMsgCountLabel.text = [NSString stringWithFormat:@"%@",unreadCount];
    }
    else {
        cell.unreadMsgCountLabel.hidden = YES;
    }
    
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
            //[self performSegueWithIdentifier:@"showChatSegue" sender:nil];
            [[[SharedClass sharedInstance] chatManager] launchChat:self];
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
            [self performSegueWithIdentifier:@"showTutorialSegue" sender:nil];
            break;
            
        case 6:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowLogoutView" object:nil];
            break;
            
        default:
            break;
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
//        if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
            controller.isEditable = YES;
//        }
        controller.isOpenedFromSideMenu = YES;
    }

}

- (void) showEditProfileScreen {
    
//    if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
        [self performSegueWithIdentifier:@"showEditProfileSegue" sender:nil];
//    }
    
    
}

@end
