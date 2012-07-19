//
//  CGEReviewsViewController.h
//  CityGridExample
//
//  Created by Christophe Vong on 8/24/11.
//  Copyright 2011 CityGrid Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CGEReviewsViewController : UIViewController <CLLocationManagerDelegate>{
    
    IBOutlet UITableView* reviewsTableView;
    IBOutlet UISwitch* sortSwitch;
}

@property (nonatomic, retain) IBOutlet UITableView* reviewsTableView;
@property (nonatomic, retain) IBOutlet UISwitch* sortSwitch;

- (IBAction) switchChanged;
- (CGEReviewsViewController*) initWithWhat:(NSString*) what andWithWhere:(NSString*) where;

@end
