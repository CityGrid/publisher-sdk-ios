//
//
//  Copyright 2011 CityGrid Media LLC All rights reserved.
//
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface CGEPlacesViewController : UITableViewController <CLLocationManagerDelegate>

- (CGEPlacesViewController*) initWithWhere:(NSString*)where andWithWhat:(NSString*) what;

@end

