//
//
//  Copyright 2011 CityGrid Media LLC All rights reserved.
//
#import <UIKit/UIKit.h>

@interface CGEAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow* window;
@property (nonatomic, retain) IBOutlet UINavigationController* navigationController;

- (void) showActivity:(id) sender;
- (void) hideActivity:(id) sender;

+ (CGEAppDelegate*) sharedAppDelegate;

@end
