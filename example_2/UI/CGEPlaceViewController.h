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
@property (nonatomic, retain) IBOutlet UILabel* publicIdLabel;
@property (nonatomic, retain) IBOutlet UIImageView* imageView;
@property (nonatomic, retain) IBOutlet UIButton* adButton;

- (id) initWithLocationId:(NSInteger)locationId andWithPublicId: (NSString*)publicId andWithIp:(NSString*) clientIp andWithRawWhat:(NSString*) rawWhat;
- (IBAction)goToLink;

@end
