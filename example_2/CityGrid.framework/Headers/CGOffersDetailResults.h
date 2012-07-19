//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@class CGOffersOffer;

@interface CGOffersDetailResults : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) CGOffersOffer* offer;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(CGOffersOffer*) offer;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToOffersDetailResults:(CGOffersDetailResults*) other;

@end
