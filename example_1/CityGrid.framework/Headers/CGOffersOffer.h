//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"
#import "CGOffersType.h"
#import "CGOffersDetail.h"

@interface CGOffersOffer : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* offerId;
@property (nonatomic, assign, readonly) NSInteger referenceId;
@property (nonatomic, retain, readonly) NSString* impressionId;
@property (nonatomic, retain, readonly) NSString* title;
@property (nonatomic, retain, readonly) NSString* offerDescription;
@property (nonatomic, assign, readonly) NSInteger redemptionTypeId;
@property (nonatomic, retain, readonly) NSString* redemptionType;
@property (nonatomic, retain, readonly) NSURL* redemptionUrl;
@property (nonatomic, retain, readonly) NSString* terms;
@property (nonatomic, retain, readonly) NSString* source;
@property (nonatomic, retain, readonly) NSArray* types; // NSNumber of CGOffersType
@property (nonatomic, retain, readonly) NSURL* imageUrl;
@property (nonatomic, retain, readonly) NSDate* startDate;
@property (nonatomic, retain, readonly) NSDate* expirationDate;
@property (nonatomic, assign, readonly) NSInteger popularity;
@property (nonatomic, assign, readonly) Float32 faceValue;
@property (nonatomic, assign, readonly) Float32 discountValue;
@property (nonatomic, retain, readonly) NSArray* locations; // CGOffersLocation
@property (nonatomic, retain, readonly) NSString* attributionSource;
@property (nonatomic, retain, readonly) NSURL* attributionLogo;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSString*) offerId referenceId:(NSInteger) referenceId impressionId:(NSString*) impressionId
			   title:(NSString*) title offerDescription:(NSString*) offerDescription redemptionTypeId:(NSInteger) redemptionTypeId
	  redemptionType:(NSString*) redemptionType redemptionUrl:(NSURL*) redemptionUrl terms:(NSString*) terms
			  source:(NSString*) source types:(NSArray*) types imageUrl:(NSURL*) imageUrl
		   startDate:(NSDate*) startDate expirationDate:(NSDate*) expirationDate
		  popularity:(NSInteger) popularity faceValue:(Float32) faceValue discountValue:(Float32) discountValue
		   locations:(NSArray*) locations attributionSource:(NSString*) attributionSource attributionLogo:(NSURL*) attributionLogo;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToOffersOffer:(CGOffersOffer*) other;

#pragma mark -
#pragma mark Offers Helpers

- (CGOffersDetail*) offersDetail;
- (CGOffersOffer*) offersDetailOffer:(NSArray**) errors;

@end
