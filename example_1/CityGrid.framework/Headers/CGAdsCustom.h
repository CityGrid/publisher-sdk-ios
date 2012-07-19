//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGContentBuilder.h"

@class CGAdsCustomResults;

@interface CGAdsCustom : CGContentBuilder

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain) NSString* publisher;
@property (nonatomic, retain) NSString* what;
@property (nonatomic, retain) NSString* where;
@property (nonatomic, retain) NSString* rawWhat;
@property (nonatomic, retain) NSString* rawWhere;
@property (nonatomic, retain) NSString* clientIp;
@property (nonatomic, retain) NSString* ua;
@property (nonatomic, retain) NSString* serveUrl;
@property (nonatomic, assign) NSInteger max;
@property (nonatomic, retain) NSString* placement;
@property (nonatomic, retain) NSString* impressionId;
@property (nonatomic, retain) CLLocation* latlon;
@property (nonatomic, assign) Float32 radius;
@property (nonatomic, assign) NSTimeInterval timeout;

#pragma mark -
#pragma mark Initialization

- (id) init:(NSString*) publisher;
+ (id) adsCustom;
+ (id) adsCustomWithPublisher:(NSString*) publisher;
+ (id) adsCustomWithPlacement:(NSString*) placement;
+ (id) adsCustomWithPublisher:(NSString*) publisher placement:(NSString*) placement;

#pragma mark -
#pragma mark Actions

- (CGAdsCustomResults*) search:(NSArray**) errors;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsCustom:(CGAdsCustom*) other;

@end
