//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import <CoreGraphics/CoreGraphics.h>
#import "CGBuilder.h"
#import "CGAdsMobileCollection.h"

@class CGAdsMobileResults;

@interface CGAdsMobile : CGBuilder

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain) NSString* publisher;
@property (nonatomic, assign) CGAdsMobileCollection collection;
@property (nonatomic, retain) NSString* what;
@property (nonatomic, retain) NSString* where;
@property (nonatomic, retain) NSString* rawWhat;
@property (nonatomic, retain) NSString* rawWhere;
@property (nonatomic, retain) NSString* clientIp;
@property (nonatomic, retain) NSString* ua;
@property (nonatomic, retain) CLLocation* latlon;
@property (nonatomic, assign) Float32 radius;
@property (nonatomic, assign) NSInteger max;
@property (nonatomic, retain) NSString* placement;
@property (nonatomic, retain) NSString* impressionId;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) NSTimeInterval timeout;

#pragma mark -
#pragma mark Initialization

- (id) init:(NSString*) publisher;
+ (id) adsMobile;
+ (id) adsMobileWithPublisher:(NSString*) publisher;
+ (id) adsMobileWithPlacement:(NSString*) placement;
+ (id) adsMobileWithPublisher:(NSString*) publisher placement:(NSString*) placement;

#pragma mark -
#pragma mark Actions

- (CGAdsMobileResults*) banner:(NSArray**) errors;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsMobile:(CGAdsMobile*) other;

@end
