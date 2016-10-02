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


@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet SwipeView *swipeView;
@property (nonatomic, strong) NSMutableArray *items;
@property (weak, nonatomic) IBOutlet MKMapView *homeMapView;
@property (weak, nonatomic) IBOutlet UISearchBar *homeSearchBar;

- (IBAction)backButtonTapped:(id)sender;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //configure swipe view
    _swipeView.alignment = SwipeViewAlignmentCenter;
    _swipeView.pagingEnabled = YES;
    _swipeView.itemsPerPage = 1;
    _swipeView.truncateFinalPage = YES;
    
    [self setupInitialUI];
    
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

- (void) setupInitialUI {
    
    addContentArr = [[NSMutableArray alloc] init];
    self.adsTblView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.addButton.layer.cornerRadius = self.addButton.frame.size.height/2.;
    
    for (UIView *subview in [[self.homeSearchBar.subviews lastObject] subviews]) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
    
    [self sideMenuSetup];
    
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
        
        [self.adsTblView reloadData];
        
    }
    if ([requestServiceKey isEqualToString:kHairFetchProjectsService]) {
        
        addContentArr = [[NSMutableArray alloc] initWithArray:[responseData valueForKey:@"info"]];
        
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

- (void) profileImageTapped:(UITapGestureRecognizer *) sender {
    
    selectedIndex = sender.view.tag;
    [self performSegueWithIdentifier:@"showProfileSegue" sender:nil];
    
}

#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return addContentArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* identifier = @"HomeTableViewCell";
    HomeTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    
    
    [self displayContentForCell:cell atIndexPath:indexPath];
    
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80.0;
}

#pragma mark - UITableView Delegate -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    selectedIndex = indexPath.row;
    [self performSegueWithIdentifier:@"showProfileSubDetailSegue" sender:nil];
    
}

- (void) displayContentForCell:(HomeTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
       //POPULATE CONTENT
        
        if ([[[SharedClass sharedInstance] userObj].flag intValue]== 1) {
            
            NSMutableDictionary* objDict = [[NSMutableDictionary alloc] initWithDictionary:[addContentArr objectAtIndex:indexPath.row]];
            
            cell.timeLeftImageView.image = [UIImage imageNamed:@"pin.png"];
            
            cell.nameLabel.text = [objDict valueForKey:@"Name"];
            cell.serviceTypeLabel.text = [objDict valueForKey:@"Treatment"];
            [cell.priceButton setTitle:[NSString stringWithFormat:@"$%@",[objDict valueForKey:@"Budget"]] forState:UIControlStateNormal];
            cell.timeLeftLabel.text = [objDict valueForKey:@"Place"];
            
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
            AdSIngleModal* modal = [[AdSIngleModal alloc] initWithDictionary:[addContentArr objectAtIndex:indexPath.row]];
            
            id budgetDict = [NSJSONSerialization JSONObjectWithData:[modal.budget dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            id treatmentDict = [NSJSONSerialization JSONObjectWithData:[modal.treatment dataUsingEncoding:NSUTF8StringEncoding] options:0 error:nil];
            
            cell.nameLabel.text = modal.name;
            cell.serviceTypeLabel.text = [[[treatmentDict valueForKey:@"treatmentsArray"] objectAtIndex:0] valueForKey:@"name"];
            [cell.priceButton setTitle:[NSString stringWithFormat:@"$%@",[[[budgetDict valueForKey:@"pricesArray"] objectAtIndex:0] valueForKey:@"name"]] forState:UIControlStateNormal];
            cell.timeLeftLabel.text = [NSString stringWithFormat:@"%@ hours left",modal.hours];
            
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

#pragma mark - Map View


- (void) loadInitialSetup {
    
    for (int i = 0; i<addContentArr.count; i++) {
        
        AdSIngleModal* modal = [[AdSIngleModal alloc] initWithDictionary:[addContentArr objectAtIndex:i]];
        
        if (modal.lat && modal.longi && ([modal.lat floatValue]<=90 && [modal.lat floatValue]>=-90) && ([modal.longi floatValue]<=180 && [modal.longi floatValue]>=-180)) {
            CLLocationCoordinate2D coord = CLLocationCoordinate2DMake([modal.lat floatValue], [modal.longi floatValue]);
            
            MKCoordinateSpan span = MKCoordinateSpanMake(10.0, 10.0);
            MKCoordinateRegion region = {coord, span};
            
            MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
            [annotation setCoordinate:coord];
            
            [self.homeMapView setRegion:region];
            [self.homeMapView addAnnotation:annotation];
        }
        
        
        
    }
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showProfileSubDetailSegue"]) {
        
        ProfileSubDetailViewController* controller = (ProfileSubDetailViewController *)[segue destinationViewController];
        controller.adDict = [addContentArr objectAtIndex:selectedIndex];
        
    }
    if ([segue.identifier isEqualToString:@"showProfileSegue"]) {
        
        ProfileDetailViewController* controller = (ProfileDetailViewController *)[segue destinationViewController];
        controller.userId = [[addContentArr objectAtIndex:selectedIndex] valueForKey:@"User_id"];
        
    }
    
}


@end
