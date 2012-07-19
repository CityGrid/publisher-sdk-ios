//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGAddress.h"
#import "CGErrorNum.h"
#import "CGHistogram.h"
#import "CGHistogramItem.h"
#import "CGLocation.h"
#import "CGRegion.h"
#import "CGReview.h"
#import "CGReviewType.h"
#import "CGTag.h"

#import "CGAdsTracker.h"
#import "CGAdsTrackerActionTarget.h"

#import "CGAdsCustom.h"
#import "CGAdsCustomAd.h"
#import "CGAdsCustomResults.h"

#import "CGAdsMobile.h"
#import "CGAdsMobileAd.h"
#import "CGAdsMobileCollection.h"
#import "CGAdsMobileResults.h"

#import "CGOffersOffer.h"
#import "CGOffersLocation.h"
#import "CGOffersType.h"

#import "CGOffersDetail.h"
#import "CGOffersDetailResults.h"

#import "CGOffersSearch.h"
#import "CGOffersSearchResults.h"
#import "CGOffersSearchSort.h"
#import "CGOffersSearchTagOperation.h"

#import "CGReviewsSearch.h"
#import "CGReviewsSearchResults.h"
#import "CGReviewsSearchReview.h"

#import "CGPlacesDetail.h"
#import "CGPlacesDetailAddress.h"
#import "CGPlacesDetailAttribute.h"
#import "CGPlacesDetailCategory.h"
#import "CGPlacesDetailCustomerContent.h"
#import "CGPlacesDetailCustomerMessage.h"
#import "CGPlacesDetailEditorial.h"
#import "CGPlacesDetailGroup.h"
#import "CGPlacesDetailImage.h"
#import "CGPlacesDetailImageType.h"
#import "CGPlacesDetailLocation.h"
#import "CGPlacesDetailOffer.h"
#import "CGPlacesDetailResults.h"
#import "CGPlacesDetailReviews.h"
#import "CGPlacesDetailTip.h"
#import "CGPlacesDetailUrls.h"

#import "CGPlacesSearch.h"
#import "CGPlacesSearchLocation.h"
#import "CGPlacesSearchResults.h"
#import "CGPlacesSearchSort.h"
#import "CGPlacesSearchType.h"

/*!
 @header
 @abstract CityGrid SDK
 @discussion An Objective-C library that provides an interface to the CityGrid REST API's as
 documented at http://docs.citygridmedia.com/display/citygridv2/CityGrid+APIs.
 */

@interface CityGrid : NSObject

#pragma mark -
#pragma mark Initialization

/*!
 @methodgroup Configuration for the CityGrid SDK
 */

/*!
 @method
 @discussion Gets the global publisher that identifies a developer.
 */
+ (NSString*) publisher;

/*!
 @method
 @discussion Sets the global publisher that identifies a developer.
 */
+ (void) setPublisher:(NSString*) publisher;

/*!
 @method
 @discussion Gets the global placement that assists a developer in breakdowns for publisher reports
 */
+ (NSString*) placement;

/*!
 @method
 @discussion Sets the global placement that assists a developer in breakdowns for publisher reports
 */
+ (void) setPlacement:(NSString*) placement;

/*!
 @method
 @discussion Gets the global network timeout for all server calls.
 */
+ (NSTimeInterval) timeout;

/*!
 @method
 @discussion Sets the global network timeout for all server calls.
 */
+ (void) setTimeout:(NSTimeInterval) timeout;

/*!
 @method
 @discussion Gets whether any debug information is displayed.
 */
+ (BOOL) debug;

/*!
 @method
 @discussion Sets whether any calls are made to the API or all network activity is simulated.
 */
+ (void) setSimulation:(BOOL) simulation;

/*!
 @method
 @discussion Gets whether any calls are made to the API or all network activity is simulated.
 */
+ (BOOL) simulation;

/*!
 @method
 @discussion Sets whether any debug information is displayed.
 */
+ (void) setDebug:(BOOL) debug;

#pragma mark -
#pragma mark Search Builders

/*!
 @methodgroup Content Builders
 */

/*!
 @method
 @discussion Gets the builder for invoking place searches. The builder will default
 to the global publisher and timeout.
 */
+ (CGPlacesSearch*) placesSearch;

/*!
 @method
 @discussion Gets the builder for getting a detail for a place. The builder will default
 to the global publisher and timeout.
 */
+ (CGPlacesDetail*) placesDetail;

/*!
 @method
 @discussion Gets the builder for invoking offers searches. The builder will default
 to the global publisher and timeout.
 */
+ (CGOffersSearch*) offersSearch;

/*!
 @method
 @discussion Gets the builder for getting an offer for a specific location. The builder
 will default to the global publisher and timeout.
 */
+ (CGOffersDetail*) offersDetail;
+ (CGReviewsSearch*) reviewsSearch;

/*!
 @methodgroup Ads Builders
 */

/*!
 @method
 @discussion Gets the builder for invoking ad searches. The builder will default
 to the global publisher and timeout.
 */
+ (CGAdsCustom*) adsCustom;

/*!
 @method
 @discussion Gets the builder for invoking ad searches that return a mobile banner.
 The builder will default to the global publisher and timeout.
 */
+ (CGAdsMobile*) adsMobile;

/*!
 @method
 @discussion Gets the builder for invoking ad searches that return a mobile banner.
 The builder will default to the global publisher and timeout.
 */
+ (CGAdsTracker*) adsTracker;

@end
