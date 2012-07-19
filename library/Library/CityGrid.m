//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CityGrid.h"
#import "CGShared.h"

@implementation CityGrid

#pragma mark -
#pragma mark Initialization

+ (NSString*) publisher {
	return [CGShared sharedInstance].publisher;
}

+ (void) setPublisher:(NSString*) publisher {
	[CGShared sharedInstance].publisher = publisher;
}

+ (NSString*) placement {
	return [CGShared sharedInstance].placement;
}

+ (void) setPlacement:(NSString*) placement {
	[CGShared sharedInstance].placement = placement;
}

+ (NSTimeInterval) timeout {
	return [CGShared sharedInstance].timeout;
}

+ (void) setTimeout:(NSTimeInterval) timeout {
	[CGShared sharedInstance].timeout = timeout;
}

+ (BOOL) debug {
	return [CGShared sharedInstance].debug;
}

+ (void) setDebug:(BOOL) debug {
	[CGShared sharedInstance].debug = debug;
}

+ (BOOL) simulation {
	return [CGShared sharedInstance].simulation;
}

+ (void) setSimulation:(BOOL) simulation {
	[CGShared sharedInstance].simulation = simulation;
}

#pragma mark -
#pragma mark Search Builders

+ (CGPlacesSearch*) placesSearch {
	return [CGPlacesSearch placesSearch];
}

+ (CGPlacesDetail*) placesDetail {
	return [CGPlacesDetail placesDetail];
}

+ (CGOffersSearch*) offersSearch {
	return [CGOffersSearch offersSearch];
}

+ (CGOffersDetail*) offersDetail {
	return [CGOffersDetail offersDetail];
}

+ (CGReviewsSearch*) reviewsSearch {
	return [CGReviewsSearch reviewsSearch];
}

+ (CGAdsCustom*) adsCustom {
	return [CGAdsCustom adsCustom];
}

+ (CGAdsMobile*) adsMobile {
	return [CGAdsMobile adsMobile];
}

+ (CGAdsTracker*) adsTracker {
	return [CGAdsTracker adsTracker];
}

@end
