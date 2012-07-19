//
//
//  Copyright 2011 CityGrid Media LLC All rights reserved.
//
#import "CGEAppDelegate.h"
#import <CityGrid/CityGrid.h>

@interface CGEAppDelegate ()

@property (nonatomic, assign, readwrite) NSUInteger activityCount;

@end

@implementation CGEAppDelegate

@synthesize window=window_;
@synthesize navigationController=navigationController_;
@synthesize activityCount = activityCount_;

- (BOOL) application:(UIApplication*) application didFinishLaunchingWithOptions:(NSDictionary*) launchOptions {
	self.activityCount = 0;
	
	[CityGrid setPublisher:@"test"];
	[CityGrid setPlacement:@"ios-example"];
	[CityGrid setDebug:YES];
	
	self.window.rootViewController = self.navigationController;
	[self.window makeKeyAndVisible];
    return YES;
}

- (void) dealloc {
	self.window = nil;
	self.navigationController = nil;
    [super dealloc];
}

- (void) showActivity:(id) sender {
	if (self.activityCount == 0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
	}
	self.activityCount += 1;
}

- (void) hideActivity:(id) sender {
	if (self.activityCount > 0) {
		self.activityCount -= 1;
	}
	if (self.activityCount == 0) {
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}

+ (CGEAppDelegate*) sharedAppDelegate {
	return [UIApplication sharedApplication].delegate;
}

@end
