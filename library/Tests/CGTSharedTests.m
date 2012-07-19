//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGTSharedTests.h"
#import "CGShared.h"

@implementation CGTSharedTests

- (void) testSharedInstance {
	CGShared* instance = [CGShared sharedInstance];
	STAssertNotNil(instance, @"Shared is not supposed to be nil");
}

@end
