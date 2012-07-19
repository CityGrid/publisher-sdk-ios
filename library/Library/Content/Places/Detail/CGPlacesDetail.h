//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGContentBuilder.h"
#import "CGPlacesDetailType.h"

@class CGPlacesDetailResults;

@interface CGPlacesDetail : CGContentBuilder

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain) NSString* publisher;
@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, retain) NSString* publicId;
@property (nonatomic, assign) NSInteger infoUsaId;
@property (nonatomic, retain) NSString* placeId;  //id in Place Detail API
//@property (nonatomic, assign) CGPlacesDetailType idType;
@property (nonatomic, assign) NSString* idType;
@property (nonatomic, retain) NSString* phone;
@property (nonatomic, assign) BOOL customerOnly;
@property (nonatomic, assign) BOOL allResults;
@property (nonatomic, assign) NSInteger reviewCount;
@property (nonatomic, retain) NSString* placement;
@property (nonatomic, assign) NSTimeInterval timeout;
@property (nonatomic, retain) NSString* impressionId;
@property (nonatomic, retain) NSString* clientIp;

#pragma mark -
#pragma mark Initialization

- (id) init:(NSString*) publisher;
+ (id) placesDetail;
+ (id) placesDetailWithPublisher:(NSString*) publisher;
+ (id) placesDetailWithPlacement:(NSString*) placement;
+ (id) placesDetailWithPublisher:(NSString*) publisher placement:(NSString*) placement;

#pragma mark -
#pragma mark Actions

- (CGPlacesDetailResults*) detail:(NSArray**) errors;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetail:(CGPlacesDetail*) other;

@end
