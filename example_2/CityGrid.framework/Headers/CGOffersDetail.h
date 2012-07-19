//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGOffersBuilder.h"

@class CGOffersDetailResults;

@interface CGOffersDetail : CGOffersBuilder

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain) NSString* publisher;
@property (nonatomic, retain) NSString* offerId;
@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, retain) NSString* impressionId;
@property (nonatomic, retain) NSString* placement;
@property (nonatomic, assign) NSTimeInterval timeout;

#pragma mark -
#pragma mark Initialization

- (id) init:(NSString*) publisher;
+ (id) offersDetail;
+ (id) offersDetailWithPublisher:(NSString*) publisher;
+ (id) offersDetailWithPlacement:(NSString*) placement;
+ (id) offersDetailWithPublisher:(NSString*) publisher placement:(NSString*) placement;

#pragma mark -
#pragma mark Actions

- (CGOffersDetailResults*) detail:(NSArray**) errors;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToOffersDetail:(CGOffersDetail*) other;

@end
