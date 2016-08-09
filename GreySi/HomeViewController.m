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
    
}

- (void)dealloc
{
    _swipeView.delegate = nil;
    _swipeView.dataSource = nil;
}

- (void) setupInitialUI {
    
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

- (void) addButtonTapped {
    
    [SVProgressHUD showSuccessWithStatus:@"Ad posted successfully"];
    
}

- (IBAction)locationButtonTapped:(id)sender {
    
    [self.swipeView scrollToPage:1 duration:1.0];
    
}

- (void) profileImageTapped {
    
    [self performSegueWithIdentifier:@"showProfileSegue" sender:nil];
    
}

#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 7;
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

    [self performSegueWithIdentifier:@"showProfileSubDetailSegue" sender:nil];
    
}

- (void) displayContentForCell:(HomeTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 6) {
        NSArray* arr = [NSArray arrayWithArray:[cell.contentView subviews]];
        for (UIView* view in arr) {
            view.hidden = YES;
        }
        cell.addButton.hidden = NO;
    }
    else {
        NSArray* arr = [NSArray arrayWithArray:[cell.contentView subviews]];
        for (UIView* view in arr) {
            view.hidden = NO;
        }
        cell.addButton.hidden = YES;
    }
    
    [cell.addButton addTarget:self action:@selector(addButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer* gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(profileImageTapped)];
    [cell.profileImageView addGestureRecognizer:gesture];
    [cell.profileImageView setUserInteractionEnabled:YES];
    
    
}

#pragma mark - Map View


- (void) loadInitialSetup {
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(28.619570, 77.088104);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(10.0, 10.0);
    MKCoordinateRegion region = {coord, span};
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coord];
    
    [self.homeMapView setRegion:region];
    [self.homeMapView addAnnotation:annotation];
    
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
