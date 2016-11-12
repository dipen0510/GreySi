//
//  CardViewSlideShowTableViewCell.m
//  GreySi
//
//  Created by Dipen Sekhsaria on 12/11/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import "CardViewSlideShowTableViewCell.h"
#import "SlideShowCollectionViewCell.h"

@implementation CardViewSlideShowTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [_slideShowCollectioView registerNib:[UINib nibWithNibName:@"SlideShowCollectionViewCell" bundle:nil]   forCellWithReuseIdentifier: @"SlideShowCollectionViewCell"];
    _slideShowCollectioView.layer.cornerRadius = 8.0;
    items = [[NSMutableArray alloc] initWithObjects:@"slide1.jpg", @"slide2.jpg", @"slide3.jpg", @"slide4.jpg", nil];
    
    _pageControl.dotSize = 7.0;
    _pageControl.numberOfPages = 4;
    _pageControl.defersCurrentPageDisplay = YES;
    _pageControl.dotColor = [UIColor clearColor];
    _pageControl.selectedDotColor = [UIColor whiteColor];
    _pageControl.dotSpacing = 5.0;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma mark - CollectionView Datasource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return items.count;
    
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString* CollectionViewCellIdentifier = @"SlideShowCollectionViewCell";
    
    SlideShowCollectionViewCell *cell = (SlideShowCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
    
    [self populateContentForCell:cell atIndexPath:indexPath];
    
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //You may want to create a divider to scale the size by the way..
    //    return CGSizeMake(self.view.frame.size.width/2, self.view.frame.size.width/2);
    
   return CGSizeMake([UIScreen mainScreen].bounds.size.width - 32, 200);
    
    
}


#pragma mark - CollectionView Delegates

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGRect visibleRect = (CGRect){.origin = self.slideShowCollectioView.contentOffset, .size = self.slideShowCollectioView.bounds.size};
    CGPoint visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
    NSIndexPath *visibleIndexPath = [self.slideShowCollectioView indexPathForItemAtPoint:visiblePoint];
    
    [_pageControl setCurrentPage:visibleIndexPath.row];
    
}

#pragma mark - Populate Content

- (void) populateContentForCell:(SlideShowCollectionViewCell *) cell atIndexPath:(NSIndexPath *)indexPath {
    
    cell.slideShowImageView.image = [UIImage imageNamed:[items objectAtIndex:indexPath.row]];

}


@end
