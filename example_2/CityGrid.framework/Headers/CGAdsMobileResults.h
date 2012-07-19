//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@class CGAdsMobileAd;

@interface CGAdsMobileResults : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSArray* ads; // CGAdsMobileAd
@property (nonatomic, retain, readonly) CGAdsMobileAd* ad;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSArray*) ads;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsMobileResults:(CGAdsMobileResults*) other;

@end
