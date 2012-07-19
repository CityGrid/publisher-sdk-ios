//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGOffersSearch.h"
#import "CGShared.h"
#import "CGConstants.h"
#import "CGOffersSearchResults.h"
#import "CGOffersOffer.h"
#import "CGOffersLocation.h"

#define CGOffersSearchWhereUri @"content/offers/v2/search/where"
#define CGOffersSearchLatLonUri @"content/offers/v2/search/latlon"

@implementation CGOffersSearch

@synthesize publisher = publisher_;
@synthesize type = type_;
@synthesize what = what_;
@synthesize tag = tag_;
@synthesize where = where_;
@synthesize tagOperation = tagOperation_;
@synthesize excludeTag = excludeTag_;
@synthesize page = page_;
@synthesize resultsPerPage = resultsPerPage_;
@synthesize startDate = startDate_;
@synthesize expiresBefore = expiresBefore_;
@synthesize hasBudget = hasBudget_;
@synthesize sort = sort_;
@synthesize source = source_;
@synthesize popularity = popularity_;
@synthesize histograms = histograms_;
@synthesize placement = placement_;
@synthesize impressionId = impressionId_;
@synthesize latlon = latlon_;
@synthesize latlon2 = latlon2_;
@synthesize radius = radius_;
@synthesize timeout = timeout_;

#pragma mark -
#pragma mark Lifecycle

- (id) init:(NSString*) publisher {
	self = [super init];
	
	if (self) {
		self.publisher = publisher;
		self.type = CGOffersTypeUnknown;
		self.what = nil;
		self.tag = CG_NSINTEGER_UNKNOWN;
		self.where = nil;
		self.tagOperation = CGOffersSearchTagOperationUnknown;
		self.excludeTag = CG_NSINTEGER_UNKNOWN;
		self.page = CG_NSINTEGER_UNKNOWN;
		self.resultsPerPage = CG_NSINTEGER_UNKNOWN;
		self.startDate = nil;
		self.expiresBefore = nil;
		self.hasBudget = NO;
		self.sort = CGOffersSearchSortUnknown;
		self.source = nil;
		self.popularity = CG_NSINTEGER_UNKNOWN;
		self.histograms = NO;
		self.placement = nil;
		self.impressionId = nil;
		self.latlon = nil;
		self.latlon2 = nil;
		self.radius = CG_FLOAT32_UNKNOWN;
		self.timeout = [CGShared sharedInstance].timeout;
	}
	
	return self;
}

+ (id) offersSearch {
	return [[self class] offersSearchWithPublisher:nil placement:nil];
}

+ (id) offersSearchWithPublisher:(NSString*) publisher {
	return [[self class] offersSearchWithPublisher:publisher placement:nil];
}

+ (id) offersSearchWithPlacement:(NSString*) placement {
	return [[self class] offersSearchWithPublisher:nil placement:placement];
}

+ (id) offersSearchWithPublisher:(NSString*) publisher placement:(NSString*) placement {
	NSString* resolvedPublisher = publisher ? publisher : [CGShared sharedInstance].publisher;
	NSString* resolvedPlacement = placement ? placement : [CGShared sharedInstance].placement;
	
	CGOffersSearch* builder = [[[[self class] alloc] init:resolvedPublisher] autorelease];
	builder.placement = resolvedPlacement;
	return builder;
}

- (void) dealloc {
	self.publisher = nil;
	self.what = nil;
	self.where = nil;
	self.source = nil;
	self.placement = nil;
	self.impressionId = nil;
	self.latlon = nil;
	self.latlon2 = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.publisher = [decoder decodeObjectForKey:@"publisher"];
		self.type = [decoder decodeIntegerForKey:@"type"];
		self.what = [decoder decodeObjectForKey:@"what"];
		self.tag = [decoder decodeIntegerForKey:@"tag"];
		self.where = [decoder decodeObjectForKey:@"where"];
		self.tagOperation = [decoder decodeIntegerForKey:@"tagOperation"];
		self.excludeTag = [decoder decodeIntegerForKey:@"excludeTag"];
		self.page = [decoder decodeIntegerForKey:@"page"];
		self.resultsPerPage = [decoder decodeIntegerForKey:@"resultsPerPage"];
		self.startDate = [decoder decodeObjectForKey:@"startDate"];
		self.expiresBefore = [decoder decodeObjectForKey:@"expiresBefore"];
		self.hasBudget = [decoder decodeBoolForKey:@"hasBudget"];
		self.sort = [decoder decodeIntegerForKey:@"sort"];
		self.source = [decoder decodeObjectForKey:@"source"];
		self.popularity = [decoder decodeIntegerForKey:@"popularity"];
		self.histograms = [decoder decodeBoolForKey:@"histograms"];
		self.placement = [decoder decodeObjectForKey:@"placement"];
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
		self.latlon = [decoder decodeObjectForKey:@"latlon"];
		self.latlon2 = [decoder decodeObjectForKey:@"latlon2"];
		self.radius = [decoder decodeFloatForKey:@"radius"];
		self.timeout = [decoder decodeDoubleForKey:@"timeout"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.publisher forKey:@"publisher"];
	[encoder encodeInteger:self.type forKey:@"type"];
	[encoder encodeObject:self.what forKey:@"what"];
	[encoder encodeInteger:self.tag forKey:@"tag"];
	[encoder encodeObject:self.where forKey:@"where"];
	[encoder encodeInteger:self.tagOperation forKey:@"tagOperation"];
	[encoder encodeInteger:self.excludeTag forKey:@"excludeTag"];
	[encoder encodeInteger:self.page forKey:@"page"];
	[encoder encodeInteger:self.resultsPerPage forKey:@"resultsPerPage"];
	[encoder encodeObject:self.startDate forKey:@"startDate"];
	[encoder encodeObject:self.expiresBefore forKey:@"expiresBefore"];
	[encoder encodeBool:self.hasBudget forKey:@"hasBudget"];
	[encoder encodeInteger:self.sort forKey:@"sort"];
	[encoder encodeObject:self.source forKey:@"source"];
	[encoder encodeInteger:self.popularity forKey:@"popularity"];
	[encoder encodeBool:self.histograms forKey:@"histograms"];
	[encoder encodeObject:self.placement forKey:@"placement"];
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
	[encoder encodeObject:self.latlon forKey:@"latlon"];
	[encoder encodeObject:self.latlon2 forKey:@"latlon2"];
	[encoder encodeFloat:self.radius forKey:@"radius"];
	[encoder encodeDouble:self.timeout forKey:@"timeout"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGOffersSearch* copy = [super copyWithZone:zone];
	if (copy) {
		copy.publisher = [[self.publisher copyWithZone:zone] autorelease];
		copy.type = self.type;
		copy.what = [[self.what copyWithZone:zone] autorelease];
		copy.tag = self.tag;
		copy.where = [[self.where copyWithZone:zone] autorelease];
		copy.tagOperation = self.tagOperation;
		copy.excludeTag = self.excludeTag;
		copy.page = self.page;
		copy.resultsPerPage = self.resultsPerPage;
		copy.startDate = [[self.startDate copyWithZone:zone] autorelease];
		copy.expiresBefore = [[self.expiresBefore copyWithZone:zone] autorelease];
		copy.hasBudget = self.hasBudget;
		copy.sort = self.sort;
		copy.source = [[self.source copyWithZone:zone] autorelease];
		copy.popularity = self.popularity;
		copy.histograms = self.histograms;
		copy.placement = [[self.placement copyWithZone:zone] autorelease];
		copy.impressionId = [[self.impressionId copyWithZone:zone] autorelease];
		copy.latlon = [[self.latlon copyWithZone:zone] autorelease];
		copy.latlon2 = [[self.latlon2 copyWithZone:zone] autorelease];
		copy.radius = self.radius;
		copy.timeout = self.timeout;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToOffersSearch:(CGOffersSearch*) other {
	return
	[self isEqualWithNull:self.publisher other:other.publisher] &&
	self.type == other.type &&
	[self isEqualWithNull:self.what other:other.what] &&
	self.tag == other.tag &&
	[self isEqualWithNull:self.where other:other.where] &&
	self.tagOperation == other.tagOperation &&
	self.excludeTag == other.excludeTag &&
	self.page == other.page &&
	self.resultsPerPage == other.resultsPerPage &&
	[self isEqualWithNull:self.startDate other:other.startDate] &&
	[self isEqualWithNull:self.expiresBefore other:other.expiresBefore] &&
	self.hasBudget == other.hasBudget &&
	self.sort == other.sort &&
	[self isEqualWithNull:self.source other:other.source] &&
	self.popularity == other.popularity &&
	self.histograms == other.histograms &&
	[self isEqualWithNull:self.placement other:other.placement] &&
	[self isEqualWithNull:self.impressionId other:other.impressionId] &&
	[self isEqualCoordinates:self.latlon other:other.latlon] &&
	[self isEqualCoordinates:self.latlon2 other:other.latlon2] &&
	self.radius == other.radius &&
	self.timeout == other.timeout;
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToOffersSearch:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.publisher hash];
	h += self.type;
	h += [self.what hash];
	h += self.tag;
	h += [self.where hash];
	h += self.tagOperation;
	h += self.excludeTag;
	h += self.page;
	h += self.resultsPerPage;
	h += [self.startDate hash];
	h += [self.expiresBefore hash];
	h += self.hasBudget;
	h += self.sort;
	h += [self.source hash];
	h += self.popularity;
	h += self.histograms;
	h += [self.placement hash];
	h += [self.impressionId hash];
	h += [self.latlon hash];
	h += [self.latlon2 hash];
	h += (NSUInteger) self.radius;
	h += (NSUInteger) self.timeout;
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendString:@"<CGOffersSearch "];
	[description appendFormat:@"publisher=%@", self.publisher];
	[description appendFormat:@",type=%i", self.type];
	[description appendFormat:@",what=%@", self.what];
	[description appendFormat:@",tag=%i", self.tag];
	[description appendFormat:@",where=%@", self.where];
	[description appendFormat:@",tagOperation=%i", self.tagOperation];
	[description appendFormat:@",excludeTag=%i", self.excludeTag];
	[description appendFormat:@",page=%i", self.page];
	[description appendFormat:@",resultsPerPage=%i", self.resultsPerPage];
	[description appendFormat:@",startDate=%@", self.startDate];
	[description appendFormat:@",expiresBefore=%@", self.expiresBefore];
	[description appendFormat:@",hasBudget=%u", self.hasBudget];
	[description appendFormat:@",sort=%i", self.sort];
	[description appendFormat:@",source=%@", self.source];
	[description appendFormat:@",popularity=%i", self.popularity];
	[description appendFormat:@",histograms=%u", self.histograms];
	[description appendFormat:@",placement=%@", self.placement];
	[description appendFormat:@",impressionId=%@", self.impressionId];
	[description appendFormat:@",latlon=%@", self.latlon];
	[description appendFormat:@",latlon2=%@", self.latlon2];
	[description appendFormat:@",radius=%f", self.radius];
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
	if ([self.where length] == 0 && (self.latlon == nil || (self.radius == CG_FLOAT32_UNKNOWN && self.latlon2 == nil))) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumGeographyUnderspecified]];
	}
	if ([self.what length] == 0 && self.type == CGOffersTypeUnknown && self.tag == CG_NSINTEGER_UNKNOWN) {
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
	if (self.latlon && (self.latlon.coordinate.latitude > 180.0 || self.latlon.coordinate.latitude < -180.0)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumLatitudeIllegal]];
	}
	if (self.latlon && (self.latlon.coordinate.longitude > 180.0 || self.latlon.coordinate.longitude < -180.0)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumLongitudeIllegal]];
	}
	if (self.latlon2 && (self.latlon2.coordinate.latitude > 180.0 || self.latlon2.coordinate.latitude < -180.0)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumLatitudeIllegal]];
	}
	if (self.latlon2 && (self.latlon2.coordinate.longitude > 180.0 || self.latlon2.coordinate.longitude < -180.0)) {
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
		case CGOffersTypePercentOff:
			value = @"percentoff";
			break;
		case CGOffersTypeFree:
			value = @"free";
			break;
		case CGOffersTypeDollarsOff:
			value = @"dollarsoff";
			break;
		case CGOffersTypeGift:
			value = @"gift";
			break;
		case CGOffersTypeBuy1Get1:
			value = @"buy1get1";
			break;
		case CGOffersTypePurchase:
			value = @"purchase";
			break;
		case CGOffersTypeOther:
			value = @"other";
			break;
		case CGOffersTypePrintableCoupon:
			value = @"printablecoupon";
			break;
		case CGOffersTypeGroupBuy:
			value = @"groupbuy";
			break;
		case CGOffersTypeDailyDeal:
			value = @"dailydeal";
			break;
		default:
			break;
	}
	
	return value;
}

- (NSString*) sortAsParameter {
	NSString* value = nil;
	
	switch (self.sort) {
		case CGOffersSearchSortDistance:
			value = @"dist";
			break;
		case CGOffersSearchSortRelevance:
			value = @"relevance";
			break;
		case CGOffersSearchSortStartDate:
			value = @"startdate";
			break;
		case CGOffersSearchSortExpiryDate:
			value = @"expirydate";
			break;
		case CGOffersSearchSortPopularity:
			value = @"popularity";
			break;
		case CGOffersSearchSortAlphabetical:
			value = @"alpha";
			break;
		default:
			break;
	}
	
	return value;
}

- (NSString*) tagOperationAsParameter {
	NSString* value = nil;
	
	switch (self.tagOperation) {
		case CGOffersSearchTagOperationAnd:
			value = @"and";
			break;
		case CGOffersSearchTagOperationOr:
			value = @"or";
			break;
		default:
			break;
	}
	
	return value;
}

- (NSDictionary*) build {
	NSMutableDictionary* parameters = [[NSMutableDictionary alloc] initWithCapacity:10];
	if ([self.publisher length] > 0) {
		[parameters setObject:self.publisher forKey:@"publisher"];
	}
	NSString* typeString = [self typeAsParameter];
	if ([typeString length] > 0) {
		[parameters setObject:typeString forKey:@"type"];
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
	NSString* tagOperation = [self tagOperationAsParameter];
	if ([tagOperation length] > 0) {
		[parameters setObject:tagOperation forKey:@"tag_op"];
	}
	if (self.excludeTag != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.excludeTag] forKey:@"exclude_tag"];
	}
	if (self.page != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.page] forKey:@"page"];
	}
	if (self.resultsPerPage != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.resultsPerPage] forKey:@"rpp"];
	}
	NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
	[formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZ"];
	if (self.startDate) {
		[parameters setObject:[formatter stringFromDate:self.startDate] forKey:@"start_date"];
	}
	if (self.expiresBefore) {
		[parameters setObject:[formatter stringFromDate:self.expiresBefore] forKey:@"expires_before"];
	}
	[parameters setObject:self.hasBudget ? @"true" : @"false" forKey:@"has_budget"];
	NSString* sortString = [self sortAsParameter];
	if ([sortString length] > 0) {
		[parameters setObject:sortString forKey:@"sort"];
	}
	if ([self.source length] > 0) {
		[parameters setObject:self.source forKey:@"source"];
	}
	if (self.popularity != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.popularity] forKey:@"popularity"];
	}
	[parameters setObject:self.histograms ? @"true" : @"false" forKey:@"histograms"];
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
	if (self.latlon2) {
		[parameters setObject:[NSString stringWithFormat:@"%f", self.latlon2.coordinate.latitude] forKey:@"lat2"];
		[parameters setObject:[NSString stringWithFormat:@"%f", self.latlon2.coordinate.longitude] forKey:@"lon2"];
	}
	if (self.radius != CG_FLOAT32_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%f", self.radius] forKey:@"radius"];
	}
	[parameters setObject:@"json" forKey:@"format"];
	
	return [parameters autorelease];
}

- (NSArray*) processOffers:(NSArray*) parsedOffers {
	if (parsedOffers == nil) {
		return nil;
	}
	
	NSMutableArray* offers = [NSMutableArray arrayWithCapacity:[parsedOffers count]];
	for (NSDictionary* parsedOffer in parsedOffers) {
		CGOffersOffer* offer = [self processOffer:parsedOffer];
		[offers addObject:offer];
	}
	
	return offers;
}

- (CGOffersSearchResults*) processResults:(NSDictionary*) parsedJson {
	NSDictionary* parsedResults = [self objectForParsed:parsedJson key:@"results"];
	
	NSInteger firstHit = [[self objectForParsed:parsedResults key:@"first_hit"] integerValue];
	NSInteger lastHit = [[self objectForParsed:parsedResults key:@"last_hit"] integerValue];
	NSInteger totalHits = [[self objectForParsed:parsedResults key:@"total_hits"] integerValue];
	NSInteger page = [[self objectForParsed:parsedResults key:@"page"] integerValue];
	NSInteger resultsPerPage = [[self objectForParsed:parsedResults key:@"rpp"] integerValue];
	NSString* didYouMean = [self objectForParsed:parsedResults key:@"did_you_mean"];
	NSURL* uri = [self urlForParsed:parsedResults key:@"uri"];
	NSArray* regions = [self processRegions:[self objectForParsed:parsedResults key:@"regions"]];
	NSArray* offers = [self processOffers:[self objectForParsed:parsedResults key:@"offers"]];
	NSArray* histograms = [self processHistograms:[self objectForParsed:parsedResults key:@"histograms"]];
	
	CGOffersSearchResults* results =
	[[[CGOffersSearchResults alloc] initImmutable:firstHit lastHit:lastHit totalHits:totalHits
											 page:page resultsPerPage:resultsPerPage uri:uri didYouMean:didYouMean
										  regions:regions histograms:histograms offers:offers] autorelease];
	return results;
}

- (CGOffersSearchResults*) search:(NSArray**) errors {
	NSArray* validationErrors = [self validate];
	if (validationErrors) {
		if (errors != NULL) {
			*errors = validationErrors;
		}
		return nil;
	}
	
	NSURL* url = [[CGShared sharedInstance].url URLByAppendingPathComponent:[self.where length] > 0 ? CGOffersSearchWhereUri : CGOffersSearchLatLonUri];
	NSDictionary* parameters = [self build];
	
	NSDictionary* parsed = [[CGShared sharedInstance] sendSynchronousRequest:url parameters:parameters timeout:self.timeout errors:errors];
	if (parsed == nil) {
		return nil;
	}
	
	CGOffersSearchResults* results = [self processResults:parsed];
	return results;
}

@end
