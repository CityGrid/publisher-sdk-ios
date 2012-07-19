//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"
#import "CGAdsTrackerActionTarget.h"

@interface CGAdsTracker : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain) NSString* publisher;
@property (nonatomic, assign) CGAdsTrackerActionTarget actionTarget;
@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, assign) NSInteger referenceId;
@property (nonatomic, retain) NSString* impressionId;
@property (nonatomic, retain) NSString* placement;
@property (nonatomic, retain) NSString* sourcePhone;
@property (nonatomic, retain) NSString* dialPhone;
@property (nonatomic, assign) NSTimeInterval timeout;

#pragma mark -
#pragma mark Initialization

- (id) init:(NSString*) publisher;
+ (id) adsTracker;
+ (id) adsTrackerWithPublisher:(NSString*) publisher;
+ (id) adsTrackerWithPlacement:(NSString*) placement;
+ (id) adsTrackerWithPublisher:(NSString*) publisher placement:(NSString*) placement;

#pragma mark -
#pragma mark Actions

- (NSArray*) track; // returns errors

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsTracker:(CGAdsTracker*) other;

@end
