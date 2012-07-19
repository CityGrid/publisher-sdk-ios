//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGContentBuilder.h"

@class CGOffersOffer;

@interface CGOffersBuilder : CGContentBuilder

- (NSArray*) processOfferTypes:(NSArray*) parsedTypes;
- (NSArray*) processOffersLocations:(NSArray*) parsedLocations;
- (CGOffersOffer*) processOffer:(NSDictionary*) parsedOffer;

@end
