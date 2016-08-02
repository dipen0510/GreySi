//
//  SideMenuViewController.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 03/08/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "SideMenuViewController.h"
#import "SideMenuTableViewCell.h"

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
    
    NSMutableDictionary* dict2 = [[NSMutableDictionary alloc] init];
    [dict2 setObject:@"LOG OUT" forKey:@"title"];
    [dict2 setObject:@"logout.png" forKey:@"image"];
    [tableArr addObject:dict2];
    
    NSMutableDictionary* dict3 = [[NSMutableDictionary alloc] init];
    [dict3 setObject:@"POST AN AD" forKey:@"title"];
    [dict3 setObject:@"postAd.png" forKey:@"image"];
    [tableArr addObject:dict3];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView Datasource -

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
    
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
    
//    switch (indexPath.row) {
//        case 0:
//            [self performSegueWithIdentifier:@"showHomeSegue" sender:nil];
//            break;
//            
//        case 1:
//            [self performSegueWithIdentifier:@"showAttendanceSegue" sender:nil];
//            break;
//            
//        case 2:
//            [self performSegueWithIdentifier:@"showCommentsSegue" sender:nil];
//            break;
//            
//        case 3:
//            [self performSegueWithIdentifier:@"showAnnouncementSegue" sender:nil];
//            break;
//            
//        case 4:
//            [self performSegueWithIdentifier:@"showContactUsSegue" sender:nil];
//            break;
//            
//        case 5:
//            [self performSegueWithIdentifier:@"showFreebiesSegue" sender:nil];
//            break;
//            
//        case 6:
//            [self performSegueWithIdentifier:@"showAddMoreSegue" sender:nil];
//            break;
//            
//        default:
//            break;
//    }
    
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
