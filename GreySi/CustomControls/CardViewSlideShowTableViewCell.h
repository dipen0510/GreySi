//
//  CardViewSlideShowTableViewCell.h
//  GreySi
//
//  Created by Dipen Sekhsaria on 12/11/16.
//  Copyright © 2016 GreyScissors. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FXPageControl.h"

@interface CardViewSlideShowTableViewCell : UITableViewCell {
    NSMutableArray *items;
}

@property (weak, nonatomic) IBOutlet UICollectionView *slideShowCollectioView;
@property (weak, nonatomic) IBOutlet FXPageControl *pageControl;

@end
