//
//  CGESearchTypeViewController.h
//  CityGridExample
//
//  Created by Christophe Vong on 8/29/11.
//  Copyright 2011 CityGrid Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CityGrid/CityGrid.h>
#import "CGEParametersViewController.h"
#import "CGEReviewsViewController.h"

@interface CGESearchTypeViewController : UITableViewController {
    NSArray* types;
    CGEParametersViewController *parametersViewController;
    CGEReviewsViewController *reviewViewController;
}

@property (nonatomic, retain) NSArray* types;
@property (nonatomic, retain) CGEParametersViewController* parametersViewController;
@property (nonatomic, retain) CGEReviewsViewController *reviewViewController;

@end 
