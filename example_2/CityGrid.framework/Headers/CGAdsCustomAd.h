//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGLocation.h"

@interface CGAdsCustomAd : CGLocation

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) NSInteger adId;
@property (nonatomic, retain, readonly) NSString* type;
@property (nonatomic, retain, readonly) NSString* tagline;
@property (nonatomic, retain, readonly) NSString* businessDescription;
@property (nonatomic, retain, readonly) NSURL* destinationUrl;
@property (nonatomic, retain, readonly) NSURL* displayUrl;
@property (nonatomic, assign, readonly) Float32 ppe;
@property (nonatomic, assign, readonly) NSInteger reviews;
@property (nonatomic, retain, readonly) NSString* offers;
@property (nonatomic, assign, readonly) Float32 distance;
@property (nonatomic, retain, readonly) NSString* attributionText;


#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSInteger) locationId impressionId:(NSString*) impressionId name:(NSString*) name
			 address:(id) address latlon:(CLLocation*) latlon image:(NSURL*) image phone:(NSString*) phone
			  rating:(NSUInteger) rating adId:(NSInteger) adId type:(NSString*) type tagline:(NSString*) tagline
		 businessDescription:(NSString*) businessDescription destinationUrl:(NSURL*) destinationUrl
		  displayUrl:(NSURL*) displayUrl ppe:(Float32) ppe reviews:(NSUInteger) reviews offers:(NSString*) offers
			distance:(Float32) distance attributionText:(NSString*) attributionText;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsCustomAd:(CGAdsCustomAd*) other;

@end
