//
//
//  Copyright 2011 CityGrid Media LLC All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CGEPlaceViewController : UIViewController

@property (nonatomic, retain) IBOutlet UILabel* streetLabel;
@property (nonatomic, retain) IBOutlet UILabel* cityLabel;
@property (nonatomic, retain) IBOutlet UILabel* stateLabel;
@property (nonatomic, retain) IBOutlet UILabel* zipLabel;
@property (nonatomic, retain) IBOutlet UIImageView* imageView;

- (id) initWithLocationId:(NSInteger) locationId;

@end
