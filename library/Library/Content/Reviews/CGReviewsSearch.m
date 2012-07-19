//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGReviewsSearch.h"
#import "CGShared.h"
#import "CGConstants.h"
#import "CGReviewsSearchResults.h"
#import "CGJSON.h"
#import "CGReviewsSearchReview.h"

#define CGReviewsSearchWhereUri @"content/reviews/v2/search/where"
#define CGReviewsSearchLatLonUri @"content/reviews/v2/search/latlon"

@implementation CGReviewsSearch

@synthesize publisher = publisher_;
@synthesize type = type_;
@synthesize sort = sort_;
@synthesize what = what_;
@synthesize tag = tag_;
@synthesize where = where_;
@synthesize radius = radius_;
@synthesize page = page_;
@synthesize resultsPerPage = resultsPerPage_;
@synthesize placement = placement_;
@synthesize impressionId = impressionId_;
@synthesize latlon = latlon_;
@synthesize rating = rating_;
@synthesize days = days_;
@synthesize customerOnly = customerOnly_;
@synthesize locationId = locationId;
@synthesize timeout = timeout_;

#pragma mark -
#pragma mark Lifecycle

- (id) init:(NSString*) publisher {
	self = [super init];
	
	if (self) {
		self.publisher = publisher;
		self.type = CGReviewTypeUnknown;
        self.sort = CGReviewsSearchSortUnknown;
		self.what = nil;
		self.tag = CG_NSINTEGER_UNKNOWN;
		self.where = nil;
		self.radius = CG_FLOAT32_UNKNOWN;
		self.page = CG_NSINTEGER_UNKNOWN;
		self.resultsPerPage = CG_NSINTEGER_UNKNOWN;
		self.placement = nil;
		self.impressionId = nil;
		self.latlon = nil;
		self.rating = CG_NSINTEGER_UNKNOWN;
		self.days = CG_NSINTEGER_UNKNOWN;
		self.customerOnly = NO;
		self.locationId = CG_NSINTEGER_UNKNOWN;
		self.timeout = [CGShared sharedInstance].timeout;
	}
	
	return self;
}

+ (id) reviewsSearch {
	return [[self class] reviewsSearchWithPublisher:nil placement:nil];
}

+ (id) reviewsSearchWithPublisher:(NSString*) publisher {
	return [[self class] reviewsSearchWithPublisher:publisher placement:nil];
}

+ (id) reviewsSearchWithPlacement:(NSString*) placement {
	return [[self class] reviewsSearchWithPublisher:nil placement:placement];
}

+ (id) reviewsSearchWithPublisher:(NSString*) publisher placement:(NSString*) placement {
	NSString* resolvedPublisher = publisher ? publisher : [CGShared sharedInstance].publisher;
	NSString* resolvedPlacement = placement ? placement : [CGShared sharedInstance].placement;
	
	CGReviewsSearch* builder = [[[[self class] alloc] init:resolvedPublisher] autorelease];
	builder.placement = resolvedPlacement;
	return builder;
}

- (void) dealloc {
	self.publisher = nil;
	self.what = nil;
	self.where = nil;
	self.placement = nil;
	self.impressionId = nil;
	self.latlon = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.publisher = [decoder decodeObjectForKey:@"publisher"];
		self.type = [decoder decodeIntegerForKey:@"type"];
        self.sort = [decoder decodeIntegerForKey:@"sort"];
		self.what = [decoder decodeObjectForKey:@"what"];
		self.tag = [decoder decodeIntegerForKey:@"tag"];
		self.where = [decoder decodeObjectForKey:@"where"];
		self.radius = [decoder decodeFloatForKey:@"radius"];
		self.page = [decoder decodeIntegerForKey:@"page"];
		self.resultsPerPage = [decoder decodeIntegerForKey:@"resultsPerPage"];
		self.placement = [decoder decodeObjectForKey:@"placement"];
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
		self.latlon = [decoder decodeObjectForKey:@"latlon"];
		self.rating = [decoder decodeIntegerForKey:@"rating"];
		self.days = [decoder decodeIntegerForKey:@"days"];
		self.customerOnly = [decoder decodeBoolForKey:@"customerOnly"];
		self.locationId = [decoder decodeIntegerForKey:@"locationId"];
		self.timeout = [decoder decodeDoubleForKey:@"timeout"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.publisher forKey:@"publisher"];
	[encoder encodeInteger:self.type forKey:@"type"];
    [encoder encodeInteger:self.sort forKey:@"sort"];
	[encoder encodeObject:self.what forKey:@"what"];
	[encoder encodeInteger:self.tag forKey:@"tag"];
	[encoder encodeObject:self.where forKey:@"where"];
	[encoder encodeFloat:self.radius forKey:@"radius"];
	[encoder encodeInteger:self.page forKey:@"page"];
	[encoder encodeInteger:self.resultsPerPage forKey:@"resultsPerPage"];
	[encoder encodeObject:self.placement forKey:@"placement"];
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
	[encoder encodeObject:self.latlon forKey:@"latlon"];
	[encoder encodeInteger:self.rating forKey:@"rating"];
	[encoder encodeInteger:self.days forKey:@"days"];
	[encoder encodeBool:self.customerOnly forKey:@"customerOnly"];
	[encoder encodeInteger:self.locationId forKey:@"locationId"];
	[encoder encodeDouble:self.timeout forKey:@"timeout"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGReviewsSearch* copy = [super copyWithZone:zone];
	if (copy) {
		copy.publisher = [[self.publisher copyWithZone:zone] autorelease];
		copy.type = self.type;
        copy.sort = self.sort;
		copy.what = [[self.what copyWithZone:zone] autorelease];
		copy.tag = self.tag;
		copy.where = [[self.where copyWithZone:zone] autorelease];
		copy.radius = self.radius;
		copy.page = self.page;
		copy.resultsPerPage = self.resultsPerPage;
		copy.placement = [[self.placement copyWithZone:zone] autorelease];
		copy.impressionId = [[self.impressionId copyWithZone:zone] autorelease];
		copy.latlon = [[self.latlon copyWithZone:zone] autorelease];
		copy.rating = self.rating;
		copy.days = self.days;
		copy.customerOnly = self.customerOnly;
		copy.locationId = self.locationId;
		copy.timeout = self.timeout;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToReviewsSearch:(CGReviewsSearch*) other {
	return
	[self isEqualWithNull:self.publisher other:other.publisher] &&
	self.type == other.type &&
    self.sort == other.sort &&
	[self isEqualWithNull:self.what other:other.what] &&
	self.tag == other.tag &&
	[self isEqualWithNull:self.where other:other.where] &&
	self.radius == other.radius &&
	self.page == other.page &&
	self.resultsPerPage == other.resultsPerPage &&
	[self isEqualWithNull:self.placement other:other.placement] &&
	[self isEqualWithNull:self.impressionId other:other.impressionId] &&
	[self isEqualCoordinates:self.latlon other:other.latlon] &&
	self.rating == other.rating &&
	self.days == other.days &&
	self.customerOnly == other.customerOnly &&
	self.locationId == other.locationId &&
	self.timeout == other.timeout;
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToReviewsSearch:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.publisher hash];
	h += self.type;
    h += self.sort;
	h += [self.what hash];
	h += self.tag;
	h += [self.where hash];
	h += (NSUInteger) self.radius;
	h += self.page;
	h += self.resultsPerPage;
	h += [self.placement hash];
	h += self.rating;
	h += self.days;
	h += self.customerOnly;
	h += self.locationId;
	h += [self.impressionId hash];
	h += [self.latlon hash];
	h += (NSUInteger) self.timeout;
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendString:@"<CGPlacesSearch "];
	[description appendFormat:@"publisher=%@", self.publisher];
	[description appendFormat:@",type=%i", self.type];
    [description appendFormat:@",sort=%i", self.sort];
	[description appendFormat:@",what=%@", self.what];
	[description appendFormat:@",tag=%i", self.tag];
	[description appendFormat:@",where=%@", self.where];
	[description appendFormat:@",radius=%f", self.radius];
	[description appendFormat:@",page=%i", self.page];
	[description appendFormat:@",resultsPerPage=%i", self.resultsPerPage];
	[description appendFormat:@",placement=%@", self.placement];
	[description appendFormat:@",impressionId=%@", self.impressionId];
	[description appendFormat:@",latlon=%@", self.latlon];
	[description appendFormat:@",rating=%i", self.rating];
	[description appendFormat:@",days=%i", self.days];
	[description appendFormat:@",customerOnly=%i", self.customerOnly];
	[description appendFormat:@",locationId=%i", self.locationId];
	[description appendFormat:@",timeout=%f", self.timeout];
	[description appendString:@">"];
	return [description autorelease];
}

#pragma mark -
#pragma mark Actions

- (NSArray*) validate {
	NSMutableArray* errors = [[NSMutableArray alloc] initWithCapacity:0];
	
	if ([self.publisher length] == 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumPublisherRequired]];
	}
	if ([self.where length] == 0 && (self.latlon == nil || self.radius == CG_FLOAT32_UNKNOWN)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumGeographyUnderspecified]];
	}
	if ([self.what length] == 0 && self.type == CGReviewTypeUnknown && self.tag == CG_NSINTEGER_UNKNOWN && self.locationId == CG_NSINTEGER_UNKNOWN) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumUnderspecified]];
	}
	if (self.tag != CG_NSINTEGER_UNKNOWN && self.tag < 1) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumTagIllegal]];
	}
	if (self.resultsPerPage != CG_NSINTEGER_UNKNOWN && (self.resultsPerPage < 1 || self.resultsPerPage > 50)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumResultsPerPageOutOfRange]];
	}
	if (self.page != CG_NSINTEGER_UNKNOWN && self.page < 1) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumPageOutOfRange]];
	}
	if (self.locationId != CG_NSINTEGER_UNKNOWN && self.locationId < 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumLocationIdOutOfRange]];
	}
	if (self.rating != CG_NSINTEGER_UNKNOWN && (self.rating < 1 || self.rating > 10)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumReviewRatingOutOfRange]];
	}
	if (self.days != CG_NSINTEGER_UNKNOWN && self.days < 1) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumReviewDaysOutOfRange]];
	}
	if (self.latlon && (self.latlon.coordinate.latitude > 180.0 || self.latlon.coordinate.latitude < -180.0)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumLatitudeIllegal]];
	}
	if (self.latlon && (self.latlon.coordinate.longitude > 180.0 || self.latlon.coordinate.longitude < -180.0)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumLongitudeIllegal]];
	}
	if (self.radius != CG_FLOAT32_UNKNOWN && ! (self.radius >= 1.0 && self.radius <= 50.0)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumRadiusOutOfRange]];
	}
	
	[errors autorelease];
	return [errors count] == 0 ? nil : errors;
}

- (NSString*) typeAsParameter {
	NSString* value = nil;
	
	switch (self.type) {
		case CGReviewTypeEditorialReview:
			value = @"editorial_review";
			break;
		case CGReviewTypeUserReview:
			value = @"user_review";
			break;
		default:
			break;
	}
	
	return value;
}

- (NSString*) sortAsParameter {
	NSString* value = nil;
	
	switch (self.sort) {
		case CGReviewsSearchSortCreateDate:
			value = @"createdate";
			break;
		case CGReviewTypeUserReview:
			value = @"reviewRating";
			break;
		default:
			break;
	}
	
	return value;
}

- (NSDictionary*) build {
	NSMutableDictionary* parameters = [[NSMutableDictionary alloc] initWithCapacity:10];
	NSString* typeString = [self typeAsParameter];
	if ([self.publisher length] > 0) {
		[parameters setObject:self.publisher forKey:@"publisher"];
	}
	if ([typeString length] > 0) {
		[parameters setObject:typeString forKey:@"review_type"];
	}
	if ([self.what length] > 0) {
		[parameters setObject:self.what forKey:@"what"];
	}
	if (self.tag != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.tag] forKey:@"tag"];
	}
	if ([self.where length] > 0) {
		[parameters setObject:self.where forKey:@"where"];
	}
	if (self.radius != CG_FLOAT32_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%f", self.radius] forKey:@"radius"];
	}
	if (self.page != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.page] forKey:@"page"];
	}
	if (self.resultsPerPage != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.resultsPerPage] forKey:@"rpp"];
	}
    NSString* sortString = [self sortAsParameter];
    if ([sortString length] >0 ) {
        [parameters setObject:sortString forKey:@"sort"];
    }
	if ([self.placement length] > 0) {
		[parameters setObject:self.placement forKey:@"placement"];
	}
	if ([self.impressionId length] > 0) {
		[parameters setObject:self.impressionId forKey:@"i"];
	}
	if (self.latlon) {
		[parameters setObject:[NSString stringWithFormat:@"%f", self.latlon.coordinate.latitude] forKey:@"lat"];
		[parameters setObject:[NSString stringWithFormat:@"%f", self.latlon.coordinate.longitude] forKey:@"lon"];
	}
	if (self.rating != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.rating] forKey:@"rating"];
	}
	if (self.days != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.rating] forKey:@"days"];
	}
	[parameters setObject:self.customerOnly ? @"true" : @"false" forKey:@"customerOnly"];
	if (self.locationId != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.rating] forKey:@"listing_id"];
	}
	[parameters setObject:@"json" forKey:@"format"];
	
	return [parameters autorelease];
}

- (CGReviewType) processType:(NSString*) parsedType {
	if ([parsedType isEqualToString:@"editorial_review"]) {
		return CGReviewTypeEditorialReview;
	} else if ([parsedType isEqualToString:@"user_review"]) {
		return CGReviewTypeUserReview;
	} else {
		return CGReviewTypeUnknown;
	}
}

- (NSArray*) processReviews:(NSArray*) parsedReviews {
	NSMutableArray* reviews = [NSMutableArray arrayWithCapacity:[parsedReviews count]];
	for (NSDictionary* parsedReview in parsedReviews) {
		NSString* reviewId = [self objectForParsed:parsedReview key:@"review_id"];
		NSURL* url = [self urlForParsed:parsedReview key:@"review_url"];
		NSString* title = [self objectForParsed:parsedReview key:@"review_title"];
		NSString* author = [self objectForParsed:parsedReview key:@"review_author"];
		NSString* text = [self objectForParsed:parsedReview key:@"review_text"];
		NSString* pros = [self objectForParsed:parsedReview key:@"pros"];
		NSString* cons = [self objectForParsed:parsedReview key:@"cons"];
		NSDate* date = [self dateForParsed:parsedReview key:@"review_date"];
		NSInteger rating = [[self objectForParsed:parsedReview key:@"review_rating"] integerValue];
		NSInteger helpfulTotal = [[self objectForParsed:parsedReview key:@"helpfulness_total_count"] integerValue];
		NSInteger helpful = [[self objectForParsed:parsedReview key:@"helpful_count"] integerValue];
		NSInteger unhelpful = [[self objectForParsed:parsedReview key:@"unhelpful_count"] integerValue];
		NSString* attributionText = [self objectForParsed:parsedReview key:@"attribution_text"];
		NSURL* attributionLogo = [self urlForParsed:parsedReview key:@"attribution_logo"];
		NSInteger attributionSource = [[self objectForParsed:parsedReview key:@"attribution_source"] integerValue];
		NSURL* attributionUrl = [self urlForParsed:parsedReview key:@"attribution_url"];
		NSString* impressionId = [self objectForParsed:parsedReview key:@"impression_id"];
		NSInteger referenceId = [[self objectForParsed:parsedReview key:@"reference_id"] integerValue];
		NSInteger sourceId = [[self objectForParsed:parsedReview key:@"source_id"] integerValue];
		NSInteger reviewLocationId = [[self objectForParsed:parsedReview key:@"listing_id"] integerValue];
		NSString* businessName = [self objectForParsed:parsedReview key:@"business_name"];
		NSURL* authorUrl = [self urlForParsed:parsedReview key:@"review_author_url"];
		CGReviewType type = [self processType:[self objectForParsed:parsedReview key:@"type"]];
		
		CGReviewsSearchReview* review =
		[[[CGReviewsSearchReview alloc] initImmutable:reviewId url:url title:title author:author text:text
												 pros:pros cons:cons date:date rating:rating helpful:helpful
											unhelpful:unhelpful attributionText:attributionText
									  attributionLogo:attributionLogo attributionSource:attributionSource
									  attributionUrl:attributionUrl
										 impressionId:impressionId referenceId:referenceId sourceId:sourceId
										   locationId:reviewLocationId businessName:businessName authorUrl:authorUrl
												 type:type] autorelease];
		[reviews addObject:review];
	}
	return reviews;
}

- (CGReviewsSearchResults*) processResults:(NSDictionary*) parsedJson {
	NSDictionary* parsedResults = [self objectForParsed:parsedJson key:@"results"];
	
	NSInteger firstHit = [[self objectForParsed:parsedResults key:@"first_hit"] integerValue];
	NSInteger lastHit = [[self objectForParsed:parsedResults key:@"last_hit"] integerValue];
	NSInteger totalHits = [[self objectForParsed:parsedResults key:@"total_hits"] integerValue];
	NSInteger page = [[self objectForParsed:parsedResults key:@"page"] integerValue];
	NSInteger resultsPerPage = [[self objectForParsed:parsedResults key:@"rpp"] integerValue];
	NSString* didYouMean = [self objectForParsed:parsedResults key:@"did_you_mean"];
	NSURL* uri = [self urlForParsed:parsedResults key:@"uri"];
	NSArray* regions = [self processRegions:[self objectForParsed:parsedResults key:@"regions"]];
	NSArray* reviews = [self processReviews:[self objectForParsed:parsedResults key:@"reviews"]];
	NSArray* histograms = [self processHistograms:[self objectForParsed:parsedResults key:@"histograms"]];
	
	CGReviewsSearchResults* results =
	[[[CGReviewsSearchResults alloc] initImmutable:firstHit lastHit:lastHit totalHits:totalHits page:page
									resultsPerPage:resultsPerPage uri:uri didYouMean:didYouMean regions:regions
										   reviews:reviews histograms:histograms] autorelease];
	return results;
}

- (CGReviewsSearchResults*) search:(NSArray**) errors {
	NSArray* validationErrors = [self validate];
	if (validationErrors) {
		if (errors != NULL) {
			*errors = validationErrors;
		}
		return nil;
	}
	
	NSURL* url = [[CGShared sharedInstance].url URLByAppendingPathComponent:[self.where length] > 0 ? CGReviewsSearchWhereUri : CGReviewsSearchLatLonUri];
	NSDictionary* parameters = [self build];
	
	NSDictionary* parsed = [[CGShared sharedInstance] sendSynchronousRequest:url parameters:parameters timeout:self.timeout errors:errors];
	if (parsed == nil) {
		return nil;
	}
	
	CGReviewsSearchResults* results = [self processResults:parsed];
	return results;
}

@end
