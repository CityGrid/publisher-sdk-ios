//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGContentBuilder.h"
#import "CGPlacesSearchType.h"
#import "CGPlacesSearchSort.h"

/*!
 @header
 @abstract Builder to invoke the Places Search
 @discussion A builder for invoking the CityGrid Places Search API as documented at http://docs.citygridmedia.com/display/citygridv2/Places+API
 */
@class CGPlacesSearchResults;

@interface CGPlacesSearch : CGContentBuilder

#pragma mark -
#pragma mark Properties
/*!
 @methodgroup Properties
 */

/*!
 @property publisher
 @brief The publisher code that identifies you. This is required.
 */
@property (nonatomic, retain) NSString* publisher;
/*!
 @property type
 @brief Restricts results to listings of the given type.
 */
@property (nonatomic, assign) CGPlacesSearchType type;
/*!
 @property what
 @brief Search term text.
 */
@property (nonatomic, retain) NSString* what;
/*!
 @property tag
 @brief Restricts search to listings with the given tag id.
 @discussion Tag ids are internal CityGrid identifiers and subject to change.
 This parameter should only be used in queries that are obtained as "refinement urls"
 from previous searches.
 */
@property (nonatomic, assign) NSInteger tag;
/*!
 @property chain
 @brief Restricts search to listings with the given chain id.
 @discussion Chain ids are internal CityGrid identifiers and subject to change.
 This parameter should only be used in queries that are obtained as "chain expansion
 urls" from previous searches.
 */
@property (nonatomic, assign) NSInteger chain;
/*!
 @property first
 @brief Restricts search to entities whose name begins with the given character, or if
 "#", then to entities beginning with any digit.
 */
@property (nonatomic, retain) NSString* first;
/*!
 @property where
 @brief The geographic location
 @discussion Address-based search is performed when this parameter starts with a number
 and contains non-numeric characters; it is much slower than searching a named region
 */
@property (nonatomic, retain) NSString* where;
/*!
 @property radius
 @brief Radius of a circle search.
 @discussion If larger than 50 it defaults to 50.
 */
@property (nonatomic, assign) Float32 radius;
/*!
 @property page
 @brief The page number of the result set to display.
 */
@property (nonatomic, assign) NSInteger page;
/*!
 @property resultsPerPage
 @brief The number of results to be displayed/returned in a page.
 */
@property (nonatomic, assign) NSInteger resultsPerPage;
/*!
 @property sort
 @brief Sort criterion for the results.
 @discussion Use alpha to sort results alphabetically, and dist to sort by increasing
 distance from the center of the search region. The dist request is only valid for
 address-based and circle searches.  
 If this parameter is omitted, the results will be ranked by relevance for keyword
 searches and distance for latitude and longitude
 */
@property (nonatomic, assign) CGPlacesSearchSort sort;
/*!
 @property placement
 @brief An optional property for storing additional information you would like CityGrid
 Media to log for this view.
 @discussion An example: if you run a search engine marketing campaign for, say, Google
 and Yahoo!, you can set the placement property to "sem_google" or "sem_yahoo".
 Alternatively, if you publish CityGrid listings in different locations in your own site,
 you can set the placement property to values such as "home_page" or "search" (all up to
 you). CityGrid will organize reports for you by placement
 */
@property (nonatomic, retain) NSString* placement;
/*!
 @property offers
 @brief Whether to return only listings that have offers associated with them.
 */
@property (nonatomic, assign) BOOL offers;
/*!
 @property histograms
 @brief An optional property for providing information on how many listings are
 in given groups and categories.
 @discussion Turning on histograms can affect performance.
 */
@property (nonatomic, assign) BOOL histograms;
/*!
 @property latlon
 @brief Latitude and longitude of the center of a circle for a geographic search.
 */
@property (nonatomic, retain) CLLocation* latlon;
/*!
 @property latlon2
 @brief Second latitude and longitude used when performing a manual box search.
 */
@property (nonatomic, retain) CLLocation* latlon2;
/*!
 @property timeout
 @brief The network timeout used when performing a search.
 */
@property (nonatomic, assign) NSTimeInterval timeout;
/*!
 @property impressionId
 @brief An optional property for grouping API calls for tracking purposes.
 @discussion The value should be set when making subsequent calls that are related to
 a previously made call. The user should never supply their own generated value for
 the impression_id.
 */
@property (nonatomic, retain) NSString* impressionId;

#pragma mark -
#pragma mark Initialization
/*!
 @methodgroup Initialization
 */

/*!
 @method
 @discussion Create a places search with the publisher. Although, this is available to use it's recommended to use one of the following:
 1. +[CityGrid placesSearch]
 2. -[CGPlacesSearch placesSearch]
 3. -[CGPlacesSearch placesSearchWithPublisher:]
 */
- (id) init:(NSString*) publisher;

/*!
 @method
 @discussion Returns a search builder that is initialized to the global +[CityGrid publisher] and +[CityGrid timeout] values.
 @result An autoreleased places search builder.
 */
+ (id) placesSearch;

/*!
 @method Returns a search builder that is initialized to the global +[CityGrid timeout] values.
 @result An autoreleased places search builder
 */
+ (id) placesSearchWithPublisher:(NSString*) publisher;

/*!
 @method Returns a search builder that is initialized to the global +[CityGrid timeout] values.
 @result An autoreleased places search builder
 */
+ (id) placesSearchWithPlacement:(NSString*) placement;

/*!
 @method Returns a search builder that is initialized to the global +[CityGrid timeout] values.
 @result An autoreleased places search builder
 */
+ (id) placesSearchWithPublisher:(NSString*) publisher placement:(NSString*) placement;

#pragma mark -
#pragma mark Actions
/*!
 @methodgroup Actions
 */

/*!
 @method
 @discussion Performs a where search as documented by http://docs.citygridmedia.com/display/citygridv2/Places+API#PlacesAPI-SearchUsingWhere
 @param errors An output array of any errors that occurred
 @result The autoreleased search results or nil if an error occurred.
 */
- (CGPlacesSearchResults*) search:(NSArray**) errors;

#pragma mark -
#pragma mark NSObject
/*!
 @methodgroup NSObject
 */

/*!
 @method
 @discussion Compares this builder to another. This is faster than -[CityGrid isEqual:]
 @result YES if equivalent
 */
- (BOOL) isEqualToPlacesSearch:(CGPlacesSearch*) other;

@end
