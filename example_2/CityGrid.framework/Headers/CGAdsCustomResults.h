//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@class CGAdsCustomAd;

@interface CGAdsCustomResults : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSArray* ads; // CGAdsCustomAd
@property (nonatomic, retain, readonly) CGAdsCustomAd* ad;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSArray*) ads;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsCustomResults:(CGAdsCustomResults*) other;

@end
