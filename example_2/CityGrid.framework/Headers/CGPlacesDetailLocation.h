//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGLocation.h"
#import "CGAdsTrackerActionTarget.h"

@class CGPlacesDetailContactInfo;
@class CGPlacesDetailUrls;
@class CGPlacesDetailCustomerContent;
@class CGPlacesDetailReviews;
@class CGAdsTracker;

@interface CGPlacesDetailLocation : CGLocation <NSCoding, NSCopying>

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) NSInteger referenceId;
@property (nonatomic, retain, readonly) NSString* publicId;
@property (nonatomic, assign, readonly) BOOL displayAd;
@property (nonatomic, assign, readonly) NSInteger infoUsaId;
@property (nonatomic, retain, readonly) NSString* teaser;
@property (nonatomic, retain, readonly) NSString* callPhone;
@property (nonatomic, retain, readonly) NSURL* displayUrl;
@property (nonatomic, retain, readonly) NSArray* markets; // NSString*
@property (nonatomic, retain, readonly) NSArray* neighborhoods; // NSString*
@property (nonatomic, retain, readonly) CGPlacesDetailUrls* urls;
@property (nonatomic, retain, readonly) CGPlacesDetailCustomerContent* customerContent;
@property (nonatomic, retain, readonly) NSArray* offers; // CGPlacesDetailOffer*
@property (nonatomic, retain, readonly) NSArray* categories; // CGPlacesDetailCategory*
@property (nonatomic, retain, readonly) NSArray* attributes; // CGPlacesDetailAttribute*
@property (nonatomic, retain, readonly) NSString* businessHours;
@property (nonatomic, retain, readonly) NSString* parking;
@property (nonatomic, retain, readonly) NSArray* tips; // CGPlacesDetailTip*
@property (nonatomic, retain, readonly) NSArray* images; // CGPlacesDetailImage*
@property (nonatomic, retain, readonly) NSArray* editorials; // CGPlacesDetailEditorial*
@property (nonatomic, retain, readonly) CGPlacesDetailReviews* reviews;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSInteger) locationId impressionId:(NSString*) impressionId name:(NSString*) name
			 address:(id) address latlon:(CLLocation*) latlon image:(NSURL*) image phone:(NSString*) phone
			  rating:(NSInteger) rating publicId:(NSString*) publicId referenceId:(NSInteger) referenceId displayAd:(BOOL) displayAd
		   infoUsaId:(NSInteger) infoUsaId teaser:(NSString*) teaser
		   callPhone:(NSString*) callPhone displayUrl:(NSURL*) displayUrl markets:(NSArray*) markets
	   neighborhoods:(NSArray*) neighborhoods urls:(CGPlacesDetailUrls*) urls
	 customerContent:(CGPlacesDetailCustomerContent*) customerContent offers:(NSArray*) offers
		  categories:(NSArray*) categories attributes:(NSArray*) attributes businessHours:(NSString*) businessHours
			 parking:(NSString*) parking tips:(NSArray*) tips images:(NSArray*) images
		  editorials:(NSArray*) editorials reviews:(CGPlacesDetailReviews*) reviews;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailLocation:(CGPlacesDetailLocation*) other;

#pragma mark -
#pragma mark Tracking Helpers

- (CGAdsTracker*) adsTracker;
- (NSArray*) track:(CGAdsTrackerActionTarget) actionTarget; // returns errors
- (NSArray*) track:(CGAdsTrackerActionTarget) actionTarget placement:(NSString*) placement; // returns errors

@end
