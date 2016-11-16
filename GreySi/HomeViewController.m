//
//  HomeViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 30/03/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "HomeViewController.h"
#import "SwipeView.h"
#import "HomeTableViewCell.h"
#import "AdSIngleModal.h"
#import "ProfileSubDetailViewController.h"
#import "ProfileDetailViewController.h"
#import <Applozic/ALUser.h>
#import "CardViewSlideShowTableViewCell.h"
#import "CardViewNewAdTableViewCell.h"
#import "LogoutViewController.h"


@interface HomeViewController ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (nonatomic, strong) NSMutableArray *items;
@property (weak, nonatomic) IBOutlet MKMapView *homeMapView;
@property (weak, nonatomic) IBOutlet UISearchBar *homeSearchBar;
@property FiltersViewController* filtersView;
@property (nonatomic,strong) MKAnnotationView *selectedAnnotationView;
@property (nonatomic,strong) MultiRowAnnotation *calloutAnnotation;
@property LogoutViewController* logoutView;

- (IBAction)backButtonTapped:(id)sender;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLogoutViewPopup) name:@"ShowLogoutView" object:nil];
    
    //configure swipe view
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    
    [self setupInitialUI];
    [self setupChatUser];
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
        [self startHairFetchProjectsService];
    }
    else {
        [self startCustomerGetAdService];
    }
    
    
}

- (void)dealloc
{
    _swipeView.delegate = nil;
    _swipeView.dataSource = nil;
}

- (void) setupChatUser {
    
    ALUser *alUser = [[ALUser alloc] init];
    [alUser setUserId:[[SharedClass sharedInstance] userObj].email]; //NOTE : +,*,? are not allowed chars in userId.
    [alUser setDisplayName:[[SharedClass sharedInstance] userObj].name]; // Display name of user
    [alUser setContactNumber:@""];// formatted contact no
    [alUser setImageLink:[[[SharedClass sharedInstance] userObj].profile_pi stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];// User's profile image link.
    
    ALChatManager * chatManager = [[ALChatManager alloc] init];
    [chatManager registerUser:alUser];
    
    [[SharedClass sharedInstance] setAlUser:alUser];
    [[SharedClass sharedInstance] setChatManager:chatManager];
    
    
}

- (void) setupInitialUI {
    
    [self.view setNeedsLayout];
    [self.view layoutIfNeeded];
    
    addContentArr = [[NSMutableArray alloc] init];
    filteredAddContentArr = [[NSMutableArray alloc] init];
    newAdArr = [[NSMutableArray alloc] init];
    self.homeSearchBar.delegate = self;
    self.adsTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.addButton.layer.cornerRadius = self.addButton.frame.size.height/2.;
    self.homeMapView.delegate = self;
    for (UIView *subview in [[self.homeSearchBar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
    
    UIStoryboard *filtersStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.filtersView = (FiltersViewController*)[filtersStoryboard instantiateViewControllerWithIdentifier:@"FiltersViewController"];
    self.filtersView.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ;
    self.filtersView.delegate  = self;
    
    UIStoryboard *logoutStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.logoutView = (LogoutViewController*)[logoutStoryboard instantiateViewControllerWithIdentifier:@"LogoutViewController"];
    self.logoutView.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) ;
    
    [self sideMenuSetup];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:appRunSecondTime]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:appRunSecondTime];
        [self performSegueWithIdentifier:@"showTutorialSegue" sender:nil];
    }
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Adbackground.png"]];
    [tempImageView setFrame:self.adsTblView.frame];
    
    self.adsTblView.backgroundView = tempImageView;
    
}

- (void)sideMenuSetup
{
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.revealButtonItem addTarget:self.revealViewController action:@selector( revealToggle: ) forControlEvents:UIControlEventTouchUpInside];
        //[self.navigationController.navigationBar addGestureRecognizer: self.revealViewController.panGestureRecognizer];
        //[self.view addGestureRecognizer:revealViewController.panGestureRecognizer];
        [self.view addGestureRecognizer:revealViewController.tapGestureRecognizer];
        [revealViewController setFrontViewShadowRadius:10.0];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void) startCustomerGetAdService {
    
    [SVProgressHUD showWithStatus:@"Fetching Ads..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kCustomerGetAdService;
    manager.delegate = self;
    [manager startGETWebServices];
    
}

- (void) startHairFetchProjectsService {
    
    [SVProgressHUD showWithStatus:@"Fetching Ads..."];
    
    DataSyncManager* manager = [[DataSyncManager alloc] init];
    manager.serviceKey = kHairFetchProjectsService;
    manager.delegate = self;
    [manager startGETWebServices];
    
}

#pragma mark - DATASYNCMANAGER Delegates

-(void) didFinishServiceWithSuccess:(id)responseData andServiceKey:(NSString *)requestServiceKey {
    
    [SVProgressHUD dismiss];
    [SVProgressHUD showSuccessWithStatus:@""];
    
    if ([requestServiceKey isEqualToString:kCustomerGetAdService]) {
        
        addContentArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"info"]];
        filteredAddContentArr = [[NSMutableArray alloc] initWithArray:addContentArr];
        [self prepareNewAdArrContent];
        [self.adsTblView reloadData];
        
    }
    if ([requestServiceKey isEqualToString:kHairFetchProjectsService]) {
        
        addContentArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"info"]];
        filteredAddContentArr = [[NSMutableArray alloc] initWithArray:addContentArr];
        [self prepareNewAdArrContent];
        [self.adsTblView reloadData];
        
    }
    
    
    
}


- (void) didFinishServiceWithFailure:(NSString *)errorMsg {
    
    
    [SVProgressHUD dismiss];
    UIAlertView* alert=[[UIAlertView alloc] initWithTitle:nil
                                                  message:NSLocalizedString(@"An issue occured while processing your request. Please try again later.", nil)
                                                 delegate:self
                                        cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                        otherButtonTitles: nil];
    
    if (![errorMsg isEqualToString:@""]) {
        [alert setMessage:errorMsg];
    }
    
    if ([errorMsg isEqualToString:NSLocalizedString(@"Verify your internet connection and try again", nil)]) {
        [alert setTitle:NSLocalizedString(@"Connection unsuccessful", nil)];
    }
    
    
    [alert show];
    
    return;
    
}



#pragma mark - SwipeView Delegate

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
    //generate 100 item views
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    return 2;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (index == 0)
    {
        //load new item view instance from nib
        //control events are bound to view controller in nib file
        //note that it is only safe to use the reusingView if we return the same nib for each
        //item view, if different items have different contents, ignore the reusingView value
        view = [[NSBundle mainBundle] loadNibNamed:@"HomeTableView" owner:self options:nil][0];
    }
    else {
        
        view = [[NSBundle mainBundle] loadNibNamed:@"HomeMapView" owner:self options:nil][0];
        [self loadInitialSetup];
        
    }
    return view;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView
{
    return self.swipeView.bounds.size;
}

#pragma mark -
#pragma mark Control events
- (IBAction)backButtonTapped:(id)sender {
    
    [self.swipeView scrollToItemAtIndex:0 duration:0.5];
    
}

- (IBAction)locationButtonTapped:(id)sender {
    
    [self.swipeView scrollToPage:1 duration:1.0];
    
}

- (IBAction)addButtonTapped:(id)sender {
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue]==1) {
        [self performSegueWithIdentifier:@"showHairPostAdSegue" sender:nil];
    }
    else {
        [self performSegueWithIdentifier:@"showNewAdSegue" sender:nil];
    }
    
}

- (IBAction)filterButtonTapped:(id)sender {
    [self showFilterViewPopup];
}

- (void) profileImageTapped:(UITapGestureRecognizer *) sender {
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue]!=1) {
        selectedIndex = sender.view.tag;
        [self performSegueWithIdentifier:@"showProfileSegue" sender:nil];
    }
    
}

#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue]!= 1) {
        return filteredAddContentArr.count + newAdArr.count + 1;
    }
    
    return filteredAddContentArr.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0 && [[[SharedClass sharedInstance] userObj].flag intValue]!= 1) {
        NSString* identifier = @"CardViewSlideShowTableViewCell";
        CardViewSlideShowTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"CardViewSlideShowTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        
        return cell;
    }
    
    if (indexPath.row%5 == 1 && indexPath.row > 1 && [[[SharedClass sharedInstance] userObj].flag intValue]!= 1) {
        NSString* identifier = @"CardViewNewAdTableViewCell";
        CardViewNewAdTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (cell == nil) {
            NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"CardViewNewAdTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        return cell;
    }
    
    NSString* identifier = @"HomeTableViewCell";
    HomeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    
    [self displayContentForCell:cell atIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue]!= 1) {
        if ( indexPath.row == 0) {
            return  220.;
        }
        
        if (indexPath.row%5 == 1 && indexPath.row > 1) {
            return 150.;
        }

    }
    
    return 120.0;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue]!= 1) {
        if (indexPath.row == 0) {
            //DO NOTHING
        }
        else if (indexPath.row%5 == 1 && indexPath.row > 1) {
            [self addButtonTapped:nil];
        }
        else {
            long indexForCell = indexPath.row - 1;
            if (indexPath.row > 5) {
                indexForCell = indexForCell - (int)(indexPath.row/5);
            }
            selectedIndex = indexForCell;
            [self performSegueWithIdentifier:@"showProfileSubDetailSegue" sender:nil];
        }
    }
    else {
    
            selectedIndex = indexPath.row;
            [self performSegueWithIdentifier:@"showProfileSubDetailSegue" sender:nil];

    }
    
    
    
}

- (void) displayContentForCell:(HomeTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.containerHomeView.layer.cornerRadius = 4.0;
    cell.containerHomeView.layer.masksToBounds = NO;
    cell.containerHomeView.layer.shadowOffset = CGSizeMake(0, 0);
    cell.containerHomeView.layer.shadowRadius = 3;
    cell.containerHomeView.layer.shadowOpacity = 0.3;
    cell.myPlaceYourPlaceLabel.layer.cornerRadius = 2.0;
    cell.myPlaceYourPlaceLabel.clipsToBounds = YES;
    
    long indexForCell;
    if ([[[SharedClass sharedInstance] userObj].flag intValue]!= 1) {
        indexForCell = indexPath.row - 1;
        
        if (indexPath.row > 5) {
            indexForCell = indexForCell - (int)(indexPath.row/5);
        }
    }
    else {
        indexForCell = indexPath.row;
    }

    
       //POPULATE CONTENT
        
        if ([[[SharedClass sharedInstance] userObj].flag intValue]== 1) {
            
            NSMutableDictionary* objDict = [[NSMutableDictionary alloc] initWithDictionary:[filteredAddContentArr objectAtIndex:indexForCell]];
            
            cell.firstStarImgView.hidden = YES;
            cell.secondStarImgView.hidden = YES;
            cell.thirdStarImgView.hidden = YES;
            cell.forthStarImgView.hidden = YES;
            cell.fifthStarImgView.hidden = YES;
            cell.timeLeftImageView.hidden = YES;
            
            cell.nameLabel.text = [objDict valueForKey:@"Name"];
            cell.serviceTypeLabel.text = [objDict valueForKey:@"Treatment"];
            [cell.priceButton setTitle:[NSString stringWithFormat:@"%@:-",[objDict valueForKey:@"Budget"]] forState:UIControlStateNormal];
            cell.timeLeftLabel.text = [objDict valueForKey:@"City"];
            
            if ([[objDict valueForKey:@"Place"] containsString:@"my"] || [[objDict valueForKey:@"Place"] containsString:@"My"] || [[objDict valueForKey:@"Place"] containsString:@"MY"]) {
                cell.myPlaceYourPlaceLabel.text = @"MP";
            }
            else {
                cell.myPlaceYourPlaceLabel.text = @"YP";
            }
            
            cell.timeLeftLabelLeadingConstraint.constant = - 10;
            
            __weak UIImageView* weakImageView = cell.profileImageView;
            [cell.profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[[objDict valueForKey:@"Profile_pi"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
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
        else {
            AdSIngleModal* modal = [[AdSIngleModal alloc] initWithDictionary:[filteredAddContentArr objectAtIndex:indexForCell]];
            
            id budgetDict = [NSJSONSerialization JSONObjectWithData:[modal.budget dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            id treatmentDict = [NSJSONSerialization JSONObjectWithData:[modal.treatment dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            
            cell.myPlaceYourPlaceLabel.hidden = YES;
            cell.nameLabel.text = modal.name;
            cell.serviceTypeLabel.text = [[[treatmentDict valueForKey:@"treatmentsArray"] objectAtIndex:0] valueForKey:@"name"];
            [cell.priceButton setTitle:[NSString stringWithFormat:@"%@:-",[[[budgetDict valueForKey:@"pricesArray"] objectAtIndex:0] valueForKey:@"name"]] forState:UIControlStateNormal];
            cell.timeLeftLabel.text = [NSString stringWithFormat:@"%@ Hours left",modal.hours];
            
            [self updateReviewStarUIForCell:cell withRating:[modal.average_Rating doubleValue]];
            
            __weak UIImageView* weakImageView = cell.profileImageView;
            [cell.profileImageView setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[modal.profile_pi stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]
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
    
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileImageTapped:)];
    [cell.profileImageView addGestureRecognizer:gesture];
    [cell.profileImageView setUserInteractionEnabled:YES];
    cell.profileImageView.tag = indexPath.row;
    
    
    
    
    
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showProfileSubDetailSegue"]) {
        
        ProfileSubDetailViewController* controller = (ProfileSubDetailViewController *)[segue destinationViewController];
        controller.adDict = [filteredAddContentArr objectAtIndex:selectedIndex];
        
    }
    if ([segue.identifier isEqualToString:@"showProfileSegue"]) {
        
        ProfileDetailViewController* controller = (ProfileDetailViewController *)[segue destinationViewController];
        controller.userId = [[filteredAddContentArr objectAtIndex:selectedIndex] valueForKey:@"User_id"];
        
    }
    
}


#pragma mark - Search Delegate

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if ([searchText length] == 0) {
        [self performSelector:@selector(hideKeyboardWithSearchBar:) withObject:searchBar afterDelay:0];
    }
    
    [self filterAdContentForSearchText:searchText];
    
}

- (void) filterAdContentForSearchText:(NSString *)text {
    
    filteredAddContentArr = [[NSMutableArray alloc] init];
    
    if (![text isEqualToString:@""]) {
        for (int i = 0; i<addContentArr.count; i++) {
            if ([[[[addContentArr objectAtIndex:i] valueForKey:@"Name"] lowercaseString] containsString:[text lowercaseString]]) {
                
                [filteredAddContentArr addObject:[addContentArr objectAtIndex:i]];
                
            }
        }
    }
    else {
        filteredAddContentArr = [[NSMutableArray alloc] initWithArray:addContentArr];
        [self.homeSearchBar resignFirstResponder];
    }
    
    [self prepareNewAdArrContent];
    [self.adsTblView reloadData];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.view endEditing:YES];
}

- (void)hideKeyboardWithSearchBar:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
}


#pragma  mark - Filter View Action


-(void)didTapOnApplyFilterWithBudget:(NSMutableArray *)actBudgetArr withCities:(NSMutableArray *)citiesArr withTreatments:(NSMutableArray *)treatmentsArr {

    int flag = 0;

    self.homeSearchBar.text = @"";

    NSMutableArray* tmpFilterArr = [[NSMutableArray alloc] initWithArray:addContentArr];
    filteredAddContentArr = [[NSMutableArray alloc] init];
    
    NSMutableArray* tmpSelectedTreatmentArr = [[NSMutableArray alloc] init];
    NSMutableArray* tmpSelectedCitiesArr = [[NSMutableArray alloc] init];
    NSMutableArray* tmpSelectedBudgetArr = [[NSMutableArray alloc] init];

    for (int i = 0; i<treatmentsArr.count; i++) {

        flag = 1;

        for (int j = 0; j<tmpFilterArr.count; j++) {

            if ([[[tmpFilterArr valueForKey:@"Treatment"] objectAtIndex:j] containsString:[treatmentsArr objectAtIndex:i]]) {

                if (![tmpSelectedTreatmentArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
                    [tmpSelectedTreatmentArr addObject:[tmpFilterArr objectAtIndex:j]];
                }


            }

        }

    }

    for (int i = 0; i<citiesArr.count; i++) {

        flag = 1;

        for (int j = 0; j<tmpFilterArr.count; j++) {

            if ([[[tmpFilterArr valueForKey:@"City"] objectAtIndex:j] containsString:[citiesArr objectAtIndex:i]]) {

                if (![tmpSelectedCitiesArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
                    [tmpSelectedCitiesArr addObject:[tmpFilterArr objectAtIndex:j]];
                }



            }

        }

    }


    for (int i = 0; i<actBudgetArr.count; i++) {
        flag = 1;
        NSMutableArray* tmpbudgetArr = [[NSMutableArray alloc] initWithArray:[[actBudgetArr objectAtIndex:i] componentsSeparatedByString:@" - "]];
        if (tmpbudgetArr.count > 1) {

            int min = [[[tmpbudgetArr objectAtIndex:0] stringByReplacingOccurrencesOfString:@"$" withString:@""] intValue];
            int max = [[[tmpbudgetArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"$" withString:@""] intValue];

            for (int j = 0; j<tmpFilterArr.count; j++) {


                if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
                    int currentBudget  =[[[tmpFilterArr valueForKey:@"Budget"] objectAtIndex:j] intValue];

                    if (currentBudget >= min && currentBudget <max) {

                        if (![tmpSelectedBudgetArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
                            [tmpSelectedBudgetArr addObject:[tmpFilterArr objectAtIndex:j]];
                        }


                    }
                }
                else {

                    id budgetDict = [NSJSONSerialization JSONObjectWithData:[[[tmpFilterArr objectAtIndex:j] valueForKey:@"Budget"]  dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
                    NSMutableArray* tmpBudgetArr = [[NSMutableArray alloc] initWithArray:[budgetDict valueForKey:@"pricesArray"]];

                    for (int k = 0; k<tmpBudgetArr.count; k++) {
                        int currentBudget  = [[[tmpBudgetArr valueForKey:@"name"] objectAtIndex:k] intValue];

                        if (currentBudget >= min && currentBudget <max) {

                            if (![tmpSelectedBudgetArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
                                [tmpSelectedBudgetArr addObject:[tmpFilterArr objectAtIndex:j]];
                            }


                        }
                    }


                }




            }

        }
        else {
            int min = [[[tmpbudgetArr objectAtIndex:0] stringByReplacingOccurrencesOfString:@"$" withString:@""] intValue];

            for (int j = 0; j<tmpFilterArr.count; j++) {

                if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
                    int currentBudget  =[[[tmpFilterArr valueForKey:@"Budget"] objectAtIndex:j] intValue];

                    if (currentBudget >= min ) {

                        if (![tmpSelectedBudgetArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
                            [tmpSelectedBudgetArr addObject:[tmpFilterArr objectAtIndex:j]];
                        }


                    }
                }
                else {

                    id budgetDict = [NSJSONSerialization JSONObjectWithData:[[[tmpFilterArr objectAtIndex:j] valueForKey:@"Budget"]  dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
                    NSMutableArray* tmpBudgetArr = [[NSMutableArray alloc] initWithArray:[budgetDict valueForKey:@"pricesArray"]];

                    for (int k = 0; k<tmpBudgetArr.count; k++) {
                        int currentBudget  = [[[tmpBudgetArr valueForKey:@"name"] objectAtIndex:k] intValue];

                        if (currentBudget >= min) {

                            if (![tmpSelectedBudgetArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
                                [tmpSelectedBudgetArr addObject:[tmpFilterArr objectAtIndex:j]];
                            }


                        }
                    }


                }


            }
        }
    }

    if (flag == 0) {
        filteredAddContentArr = [[NSMutableArray alloc] initWithArray:addContentArr];
    }
    else {
        
        NSMutableSet* set1;
        NSMutableSet* set2;
        NSMutableSet* set3;
        
        if (tmpSelectedTreatmentArr.count > 0) {
            
            if (tmpSelectedCitiesArr.count > 0) {
                
                if (tmpSelectedBudgetArr.count > 0) {
                    set1 = [NSMutableSet setWithArray:tmpSelectedTreatmentArr];
                    set2 = [NSMutableSet setWithArray:tmpSelectedCitiesArr];
                    set3 = [NSMutableSet setWithArray:tmpSelectedBudgetArr];
                    [set1 intersectSet:set2]; //this will give you only the obejcts that are in both sets
                    [set1 intersectSet:set3];
                }
                else {
                    set1 = [NSMutableSet setWithArray:tmpSelectedTreatmentArr];
                    set2 = [NSMutableSet setWithArray:tmpSelectedCitiesArr];
                    [set1 intersectSet:set2];
                }
                
            }
            else {
                
                if (tmpSelectedBudgetArr.count > 0) {
                    set1 = [NSMutableSet setWithArray:tmpSelectedTreatmentArr];
                    set3 = [NSMutableSet setWithArray:tmpSelectedBudgetArr];
                    [set1 intersectSet:set3];
                }
                else {
                    set1 = [NSMutableSet setWithArray:tmpSelectedTreatmentArr];
                }
                
            }
            
        }
        else {
            
            if (tmpSelectedCitiesArr.count > 0) {
                
                if (tmpSelectedBudgetArr.count > 0) {
                    set1 = [NSMutableSet setWithArray:tmpSelectedCitiesArr];
                    set2 = [NSMutableSet setWithArray:tmpSelectedBudgetArr];
                    [set1 intersectSet:set2];
                }
                else {
                    set1 = [NSMutableSet setWithArray:tmpSelectedCitiesArr];
                }
                
            }
            else {
                
                if (tmpSelectedBudgetArr.count > 0) {
                    set1 = [NSMutableSet setWithArray:tmpSelectedBudgetArr];
                }
                else {
                    
                }
                
            }
            
        }
        
        
        
        NSArray* result = [set1 allObjects];
        
        filteredAddContentArr = [[NSMutableArray alloc] initWithArray:result];
        
    }

    [self prepareNewAdArrContent];
    [self.adsTblView reloadData];

}


//-(void)didTapOnApplyFilterWithBudget:(NSMutableArray *)actBudgetArr withCities:(NSMutableArray *)citiesArr withTreatments:(NSMutableArray *)treatmentsArr {
//    
//    int flag = 0;
//    
//    self.homeSearchBar.text = @"";
//
//    NSMutableArray* tmpFilterArr = [[NSMutableArray alloc] initWithArray:addContentArr];
//    filteredAddContentArr = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i<treatmentsArr.count; i++) {
//        
//        flag = 1;
//            
//        for (int j = 0; j<tmpFilterArr.count; j++) {
//                
//            if ([[[tmpFilterArr valueForKey:@"Treatment"] objectAtIndex:j] containsString:[treatmentsArr objectAtIndex:i]]) {
//                
//                if (![filteredAddContentArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
//                    [filteredAddContentArr addObject:[tmpFilterArr objectAtIndex:j]];
//                }
//                
//                    
//            }
//                
//        }
//        
//    }
//    
//    for (int i = 0; i<citiesArr.count; i++) {
//        
//        flag = 1;
//                
//        for (int j = 0; j<tmpFilterArr.count; j++) {
//                    
//            if ([[[tmpFilterArr valueForKey:@"City"] objectAtIndex:j] containsString:[citiesArr objectAtIndex:i]]) {
//                
//                if (![filteredAddContentArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
//                    [filteredAddContentArr addObject:[tmpFilterArr objectAtIndex:j]];
//                }
//                
//                
//                        
//            }
//                    
//        }
//                
//    }
//    
//    
//    for (int i = 0; i<actBudgetArr.count; i++) {
//        flag = 1;
//        NSMutableArray* tmpbudgetArr = [[NSMutableArray alloc] initWithArray:[[actBudgetArr objectAtIndex:i] componentsSeparatedByString:@" - "]];
//        if (tmpbudgetArr.count > 1) {
//            
//            int min = [[[tmpbudgetArr objectAtIndex:0] stringByReplacingOccurrencesOfString:@"$" withString:@""] intValue];
//            int max = [[[tmpbudgetArr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"$" withString:@""] intValue];
//            
//            for (int j = 0; j<tmpFilterArr.count; j++) {
//                
//                
//                if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
//                    int currentBudget  =[[[tmpFilterArr valueForKey:@"Budget"] objectAtIndex:j] intValue];
//                    
//                    if (currentBudget >= min && currentBudget <max) {
//                        
//                        if (![filteredAddContentArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
//                            [filteredAddContentArr addObject:[tmpFilterArr objectAtIndex:j]];
//                        }
//                        
//                        
//                    }
//                }
//                else {
//                    
//                    id budgetDict = [NSJSONSerialization JSONObjectWithData:[[[tmpFilterArr objectAtIndex:j] valueForKey:@"Budget"]  dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
//                    NSMutableArray* tmpBudgetArr = [[NSMutableArray alloc] initWithArray:[budgetDict valueForKey:@"pricesArray"]];
//                    
//                    for (int k = 0; k<tmpBudgetArr.count; k++) {
//                        int currentBudget  = [[[tmpBudgetArr valueForKey:@"name"] objectAtIndex:k] intValue];
//                        
//                        if (currentBudget >= min && currentBudget <max) {
//                            
//                            if (![filteredAddContentArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
//                                [filteredAddContentArr addObject:[tmpFilterArr objectAtIndex:j]];
//                            }
//                            
//                            
//                        }
//                    }
//                    
//                    
//                }
//                
//                
//                
//                
//            }
//            
//        }
//        else {
//            int min = [[[tmpbudgetArr objectAtIndex:0] stringByReplacingOccurrencesOfString:@"$" withString:@""] intValue];
//            
//            for (int j = 0; j<tmpFilterArr.count; j++) {
//                
//                if ([[[SharedClass sharedInstance] userObj].flag intValue] == 1) {
//                    int currentBudget  =[[[tmpFilterArr valueForKey:@"Budget"] objectAtIndex:j] intValue];
//                    
//                    if (currentBudget >= min ) {
//                        
//                        if (![filteredAddContentArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
//                            [filteredAddContentArr addObject:[tmpFilterArr objectAtIndex:j]];
//                        }
//                        
//                        
//                    }
//                }
//                else {
//                    
//                    id budgetDict = [NSJSONSerialization JSONObjectWithData:[[[tmpFilterArr objectAtIndex:j] valueForKey:@"Budget"]  dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
//                    NSMutableArray* tmpBudgetArr = [[NSMutableArray alloc] initWithArray:[budgetDict valueForKey:@"pricesArray"]];
//                    
//                    for (int k = 0; k<tmpBudgetArr.count; k++) {
//                        int currentBudget  = [[[tmpBudgetArr valueForKey:@"name"] objectAtIndex:k] intValue];
//                        
//                        if (currentBudget >= min) {
//                            
//                            if (![filteredAddContentArr containsObject:[tmpFilterArr objectAtIndex:j]]) {
//                                [filteredAddContentArr addObject:[tmpFilterArr objectAtIndex:j]];
//                            }
//                            
//                            
//                        }
//                    }
//                    
//                    
//                }
//                
//                
//            }
//        }
//    }
//    
//    if (flag == 0) {
//        filteredAddContentArr = [[NSMutableArray alloc] initWithArray:addContentArr];
//    }
//    
//    [self prepareNewAdArrContent];
//    [self.adsTblView reloadData];
//    
//}


- (void) showFilterViewPopup {
    
    self.filtersView.view.alpha = 0;
    
    self.filtersView.allRedundantCities = [filteredAddContentArr valueForKey:@"City"];
    self.filtersView.allRedundantTreatments = [filteredAddContentArr valueForKey:@"Treatment"];
    
    [self.view addSubview:self.filtersView.view];
    
//    [uploadSuccessPopup.okButton addTarget:self action:@selector(uploadSuccessOkButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.filtersView.view.alpha = 1;
     }
                     completion:nil];
    
}



#pragma mark - Map View


- (void) loadInitialSetup {
    
    for (int i = 0; i<filteredAddContentArr.count; i++) {
        
        AdSIngleModal* modal = [[AdSIngleModal alloc] initWithDictionary:[filteredAddContentArr objectAtIndex:i]];
        [self convertTreatmentAndPriceArrToStr:modal];
        
        if (modal.lat && modal.longi && ([modal.lat floatValue]<=90 && [modal.lat floatValue]>=-90) && ([modal.longi floatValue]<=180 && [modal.longi floatValue]>=-180)) {
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([modal.lat floatValue], [modal.longi floatValue]);
            
            MKCoordinateSpan span = MKCoordinateSpanMake(10.0, 10.0);
            MKCoordinateRegion region = {coord, span};
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            [annotation setCoordinate:coord];
            
            [self.homeMapView setRegion:region];
            [self.homeMapView addAnnotation:[District districtWithCoordinate:coord title:modal.name representatives:nil subtitle:treatmentStr budget:budgetStr userImg:modal.profile_pi]];
        }
        
        
        
    }
    
}

- (void) convertTreatmentAndPriceArrToStr:(AdSIngleModal *)modal {
    
    if ([[[SharedClass sharedInstance] userObj].flag intValue]==1) {
        treatmentStr = modal.treatment;
        budgetStr = [NSString stringWithFormat:@"Budget : $%@",modal.budget ];
    }
    else {
        id treatmentDict = [NSJSONSerialization JSONObjectWithData:[modal.treatment dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        id budgetDict = [NSJSONSerialization JSONObjectWithData:[modal.budget dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
        
        treatmentStr = [[[treatmentDict valueForKey:@"treatmentsArray"] valueForKey:@"name"] componentsJoinedByString:@", "];
        
        NSNumber *max=[[[budgetDict valueForKey:@"pricesArray"] valueForKey:@"name"] valueForKeyPath:@"@max.self"];
        NSNumber *min=[[[budgetDict valueForKey:@"pricesArray"] valueForKey:@"name"] valueForKeyPath:@"@min.self"];
        
        budgetArr = [[NSMutableArray alloc] initWithArray:[budgetDict valueForKey:@"pricesArray"]];
        treatmentArr = [[NSMutableArray alloc] initWithArray:[treatmentDict valueForKey:@"treatmentsArray"]];
        
        budgetStr = [NSString stringWithFormat:@"Budget : $%@ - $%@",min,max];
    }
    
    
    
}

#pragma mark - The Good Stuff

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    
    if (![annotation conformsToProtocol:@protocol(MultiRowAnnotationProtocol)])
        return nil;
    
    NSObject <MultiRowAnnotationProtocol> *newAnnotation = (NSObject <MultiRowAnnotationProtocol> *)annotation;
    if (newAnnotation == _calloutAnnotation)
    {
        MultiRowCalloutAnnotationView *annotationView = (MultiRowCalloutAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:MultiRowCalloutReuseIdentifier];
        if (!annotationView)
        {
            annotationView = [MultiRowCalloutAnnotationView calloutWithAnnotation:newAnnotation onCalloutAccessoryTapped:^(MultiRowCalloutCell *cell, UIControl *control, NSDictionary *userData) {
                // This is where I usually push in a new detail view onto the navigation controller stack, using the object's ID
                NSLog(@"Representative (%@) with ID '%@' was tapped.", cell.subtitle, userData[@"id"]);
            }];
        }
        else
        {
            annotationView.annotation = newAnnotation;
        }
        annotationView.parentAnnotationView = _selectedAnnotationView;
        annotationView.mapView = mapView;
        return annotationView;
    }
    GenericPinAnnotationView *annotationView = (GenericPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:GenericPinReuseIdentifier];
    if (!annotationView)
    {
        annotationView = [GenericPinAnnotationView pinViewWithAnnotation:newAnnotation];
    }
    annotationView.annotation = newAnnotation;
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)aView
{
    id<MKAnnotation> annotation = aView.annotation;
    if (!annotation || ![aView isSelected])
        return;
    if ( NO == [annotation isKindOfClass:[MultiRowCalloutCell class]] &&
        [annotation conformsToProtocol:@protocol(MultiRowAnnotationProtocol)] )
    {
        NSObject <MultiRowAnnotationProtocol> *pinAnnotation = (NSObject <MultiRowAnnotationProtocol> *)annotation;
        if (!_calloutAnnotation)
        {
            _calloutAnnotation = [[MultiRowAnnotation alloc] init];
            [_calloutAnnotation copyAttributesFromAnnotation:pinAnnotation];
            [mapView addAnnotation:_calloutAnnotation];
        }
        _selectedAnnotationView = aView;
        return;
    }
    [mapView setCenterCoordinate:annotation.coordinate animated:YES];
    _selectedAnnotationView = aView;
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)aView
{
    if ( NO == [aView.annotation conformsToProtocol:@protocol(MultiRowAnnotationProtocol)] )
        return;
    if ([aView.annotation isKindOfClass:[MultiRowAnnotation class]])
        return;
    GenericPinAnnotationView *pinView = (GenericPinAnnotationView *)aView;
    if (_calloutAnnotation && !pinView.preventSelectionChange)
    {
        [mapView removeAnnotation:_calloutAnnotation];
        _calloutAnnotation = nil;
    }
}

#pragma mark - Boilerplate Stuff


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    if (self.isViewLoaded && _homeMapView && _homeMapView.annotations)
    {
        [_homeMapView removeAnnotations:_homeMapView.annotations];
    }
}

- (void) prepareNewAdArrContent {
    
    newAdArr = [[NSMutableArray alloc] init];
    
    for ( int i = 0; i<filteredAddContentArr.count; i++) {
        
        if (i%5==4) {
            [newAdArr addObject:[NSNumber numberWithInt:i]];
        }
        
    }
    
}


#pragma mark - Logout Helpers

- (void) showLogoutViewPopup {
    
    [self.revealViewController revealToggle:nil];
    
    self.logoutView.view.alpha = 0;
    [self.view addSubview:self.logoutView.view];
    
    [self.logoutView.yesButton addTarget:self action:@selector(logoutViewYesButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    [self.logoutView.noButton addTarget:self action:@selector(logoutViewNoButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.logoutView.view.alpha = 1;
     }
                     completion:nil];
    
}

- (void) logoutViewYesButtonTapped {
    
    ALRegisterUserClientService * alUserClientService = [[ALRegisterUserClientService alloc]init];
    if([ALUserDefaultsHandler getDeviceKeyString]) {
        
        [alUserClientService logoutWithCompletionHandler:^{
        }];
    }
    
    
    [[SharedClass sharedInstance] removeServiceData:kLoginService];
    
    [self logoutViewNoButtonTapped];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void) logoutViewNoButtonTapped {
    
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^
     {
         self.logoutView.view.alpha = 0;
     }
                     completion:^(BOOL finished){
                         
                         [self.logoutView.view removeFromSuperview];
                         
                     }];
    
}


- (void) updateReviewStarUIForCell:(HomeTableViewCell *)cell withRating:(double) avgRating {
    
    
    cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    cell.forthStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    cell.fifthStarImgView.image = [UIImage imageNamed:@"feedback_rating.png"];
    
    if (avgRating>=0.5 && avgRating < 1.0) {
        cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
    }
    else if (avgRating>=1.0 && avgRating < 1.5) {
        cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    }
    else if (avgRating>=1.5 && avgRating < 2.0) {
        cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
    }
    else if (avgRating>=2.0 && avgRating < 2.5) {
        cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    }
    else if (avgRating>=2.5 && avgRating < 3.0) {
        cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
    }
    else if (avgRating>=3.0 && avgRating < 3.5) {
        cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    }
    else if (avgRating>=3.5 && avgRating < 4.0) {
        cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.forthStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
    }
    else if (avgRating>=4.0 && avgRating < 4.5) {
        cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    }
    else if (avgRating>=4.5 && avgRating < 5.0) {
        cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.fifthStarImgView.image = [UIImage imageNamed:@"feedback_ratinghalf.png"];
    }
    else if (avgRating>=5.0) {
        cell.firstStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.secondStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.thirdStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.forthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
        cell.fifthStarImgView.image = [UIImage imageNamed:@"feedback_rating_full.png"];
    }
    
    
}
@end
