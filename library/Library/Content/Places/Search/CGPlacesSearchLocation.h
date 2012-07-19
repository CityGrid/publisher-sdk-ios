//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGLocation.h"

@interface CGPlacesSearchLocation : CGLocation <NSCoding, NSCopying>

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) BOOL featured;
@property (nonatomic, retain, readonly) NSString* publicId;
@property (nonatomic, retain, readonly) NSString* neighborhood;
@property (nonatomic, retain, readonly) NSString* fax;
@property (nonatomic, retain, readonly) NSURL* profile;
@property (nonatomic, retain, readonly) NSURL* website;
@property (nonatomic, assign, readonly) BOOL hasVideo;
@property (nonatomic, assign, readonly) BOOL hasOffers;
@property (nonatomic, retain, readonly) NSString* offers;
@property (nonatomic, assign, readonly) NSInteger reviews;
@property (nonatomic, retain, readonly) NSArray* categories; // NSString*
@property (nonatomic, retain, readonly) NSString* tagline;
@property (nonatomic, retain, readonly) NSArray* tags; // CGTag*

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSUInteger) locationId impressionId:(NSString*) impressionId name:(NSString*) name
			 address:(id) address latlon:(CLLocation*) latlon image:(NSURL*) image phone:(NSString*) phone
			  rating:(NSUInteger) rating featured:(BOOL) featured publicId:(NSString*) publicId neighborhood:(NSString*) neighborhood
				 fax:(NSString*) fax profile:(NSURL*) profile website:(NSURL*) website hasVideo:(BOOL) hasVideo
		   hasOffers:(BOOL) hasOffers offers:(NSString*) offers reviews:(NSInteger) reviews
		  categories:(NSArray*) categories tagline:(NSString*) tagline tags:(NSArray*) tags;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesSearchLocation:(CGPlacesSearchLocation*) other;

@end
