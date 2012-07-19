//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesSearch.h"
#import "CGShared.h"
#import "CGConstants.h"
#import "CGPlacesSearchResults.h"
#import "CGPlacesSearchLocation.h"

#define CGPlacesSearchWhereUri @"content/places/v2/search/where"
#define CGPlacesSearchLatLonUri @"content/places/v2/search/latlon"

@implementation CGPlacesSearch

@synthesize publisher = publisher_;
@synthesize type = type_;
@synthesize what = what_;
@synthesize tag = tag_;
@synthesize chain = chain_;
@synthesize first = first_;
@synthesize where = where_;
@synthesize radius = radius_;
@synthesize page = page_;
@synthesize resultsPerPage = resultsPerPage_;
@synthesize sort = sort_;
@synthesize placement = placement_;
@synthesize offers = offers_;
@synthesize histograms = histograms_;
@synthesize latlon = latlon_;
@synthesize latlon2 = latlon2_;
@synthesize timeout = timeout_;
@synthesize impressionId = impressionId_;

#pragma mark -
#pragma mark Lifecycle

- (id) init:(NSString*) publisher {
	self = [super init];
	
	if (self) {
		self.publisher = publisher;
		self.type = CGPlacesSearchTypeUnknown;
		self.what = nil;
		self.tag = CG_NSINTEGER_UNKNOWN;
		self.chain = CG_NSINTEGER_UNKNOWN;
		self.first = nil;
		self.where = nil;
		self.radius = CG_FLOAT32_UNKNOWN;
		self.page = CG_NSINTEGER_UNKNOWN;
		self.resultsPerPage = CG_NSINTEGER_UNKNOWN;
		self.sort = CGPlacesSearchSortUnknown;
		self.placement = nil;
		self.offers = NO;
		self.histograms = NO;
		self.latlon = nil;
		self.latlon2 = nil;
		self.timeout = [CGShared sharedInstance].timeout;
		self.impressionId = nil;
	}
	
	return self;
}

+ (id) placesSearch {
	return [[self class] placesSearchWithPublisher:nil placement:nil];
}

+ (id) placesSearchWithPublisher:(NSString*) publisher {
	return [[self class] placesSearchWithPublisher:publisher placement:nil];
}

+ (id) placesSearchWithPlacement:(NSString*) placement {
	return [[self class] placesSearchWithPublisher:nil placement:placement];
}

+ (id) placesSearchWithPublisher:(NSString*) publisher placement:(NSString*) placement {
	NSString* resolvedPublisher = publisher ? publisher : [CGShared sharedInstance].publisher;
	NSString* resolvedPlacement = placement ? placement : [CGShared sharedInstance].placement;
	
	CGPlacesSearch* builder = [[[[self class] alloc] init:resolvedPublisher] autorelease];
	builder.placement = resolvedPlacement;
	return builder;
}

- (void) dealloc {
	self.publisher = nil;
	self.what = nil;
	self.first = nil;
	self.where = nil;
	self.placement = nil;
	self.latlon = nil;
	self.latlon2 = nil;
	self.impressionId = nil;
	
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
		self.chain = [decoder decodeIntegerForKey:@"chain"];
		self.first = [decoder decodeObjectForKey:@"first"];
		self.where = [decoder decodeObjectForKey:@"where"];
		self.radius = [decoder decodeFloatForKey:@"radius"];
		self.page = [decoder decodeIntegerForKey:@"page"];
		self.resultsPerPage = [decoder decodeIntegerForKey:@"resultsPerPage"];
		self.sort = [decoder decodeIntegerForKey:@"sort"];
		self.placement = [decoder decodeObjectForKey:@"placement"];
		self.offers = [decoder decodeBoolForKey:@"offers"];
		self.histograms = [decoder decodeBoolForKey:@"histograms"];
		self.latlon = [decoder decodeObjectForKey:@"latlon"];
		self.latlon2 = [decoder decodeObjectForKey:@"latlon2"];
		self.timeout = [decoder decodeDoubleForKey:@"timeout"];
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.publisher forKey:@"publisher"];
	[encoder encodeInteger:self.type forKey:@"type"];
	[encoder encodeObject:self.what forKey:@"what"];
	[encoder encodeInteger:self.tag forKey:@"tag"];
	[encoder encodeInteger:self.chain forKey:@"chain"];
	[encoder encodeObject:self.first forKey:@"first"];
	[encoder encodeObject:self.where forKey:@"where"];
	[encoder encodeFloat:self.radius forKey:@"radius"];
	[encoder encodeInteger:self.page forKey:@"page"];
	[encoder encodeInteger:self.resultsPerPage forKey:@"resultsPerPage"];
	[encoder encodeInteger:self.sort forKey:@"sort"];
	[encoder encodeObject:self.placement forKey:@"placement"];
	[encoder encodeBool:self.offers forKey:@"offers"];
	[encoder encodeBool:self.histograms forKey:@"histograms"];
	[encoder encodeObject:self.latlon forKey:@"latlon"];
	[encoder encodeObject:self.latlon2 forKey:@"latlon2"];
	[encoder encodeDouble:self.timeout forKey:@"timeout"];
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesSearch* copy = [super copyWithZone:zone];
	if (copy) {
		copy.publisher = [[self.publisher copyWithZone:zone] autorelease];
		copy.type = self.type;
		copy.what = [[self.what copyWithZone:zone] autorelease];
		copy.tag = self.tag;
		copy.chain = self.chain;
		copy.first = [[self.first copyWithZone:zone] autorelease];
		copy.where = [[self.where copyWithZone:zone] autorelease];
		copy.radius = self.radius;
		copy.page = self.page;
		copy.resultsPerPage = self.resultsPerPage;
		copy.sort = self.sort;
		copy.placement = [[self.placement copyWithZone:zone] autorelease];
		copy.offers = self.offers;
		copy.histograms = self.histograms;
		copy.latlon = [[self.latlon copyWithZone:zone] autorelease];
		copy.latlon2 = [[self.latlon2 copyWithZone:zone] autorelease];
		copy.timeout = self.timeout;
		copy.impressionId = [[self.impressionId copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesSearch:(CGPlacesSearch*) other {
	return
	[self isEqualWithNull:self.publisher other:other.publisher] &&
	self.type == other.type &&
	[self isEqualWithNull:self.what other:other.what] &&
	self.tag == other.tag &&
	self.chain == other.chain &&
	[self isEqualWithNull:self.first other:other.first] &&
	[self isEqualWithNull:self.where other:other.where] &&
	self.radius == other.radius &&
	self.page == other.page &&
	self.resultsPerPage == other.resultsPerPage &&
	self.sort == other.sort &&
	[self isEqualWithNull:self.placement other:other.placement] &&
	self.offers == other.offers &&
	self.histograms == other.histograms &&
	[self isEqualCoordinates:self.latlon other:other.latlon] &&
	[self isEqualCoordinates:self.latlon2 other:other.latlon2] &&
	self.timeout == other.timeout &&
	[self isEqualWithNull:self.impressionId other:other.impressionId];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesSearch:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.publisher hash];
	h += self.type;
	h += [self.what hash];
	h += self.tag;
	h += self.chain;
	h += [self.first hash];
	h += [self.where hash];
	h += (NSUInteger) self.radius;
	h += self.page;
	h += self.resultsPerPage;
	h += self.sort;
	h += [self.placement hash];
	h += self.offers;
	h += self.histograms;
	h += [self.latlon hash];
	h += [self.latlon2 hash];
	h += (NSUInteger) self.timeout;
	h += [self.impressionId hash];
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendString:@"<CGPlacesSearch "];
	[description appendFormat:@"publisher=%@", self.publisher];
	[description appendFormat:@",type=%i", self.type];
	[description appendFormat:@",what=%@", self.what];
	[description appendFormat:@",tag=%i", self.tag];
	[description appendFormat:@",chain=%i", self.chain];
	[description appendFormat:@",first=%@", self.first];
	[description appendFormat:@",where=%@", self.where];
	[description appendFormat:@",radius=%f", self.radius];
	[description appendFormat:@",page=%i", self.page];
	[description appendFormat:@",resultsPerPage=%i", self.resultsPerPage];
	[description appendFormat:@",sort=%i", self.sort];
	[description appendFormat:@",placement=%@", self.placement];
	[description appendFormat:@",offers=%i", self.offers];
	[description appendFormat:@",histograms=%i", self.histograms];
	[description appendFormat:@",latlon=%@", self.latlon];
	[description appendFormat:@",latlon2=%@", self.latlon2];
	[description appendFormat:@",timeout=%f", self.timeout];
	[description appendFormat:@",impressionId=%@", self.impressionId];
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
	if ([self.what length] == 0 && self.type == CGPlacesSearchTypeUnknown && self.tag == CG_NSINTEGER_UNKNOWN && self.chain == CG_NSINTEGER_UNKNOWN) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumUnderspecified]];
	}
	if (self.tag != CG_NSINTEGER_UNKNOWN && self.tag < 1) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumTagIllegal]];
	}
	if (self.chain != CG_NSINTEGER_UNKNOWN && self.chain < 1) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumChainIllegal]];
	}
	if (self.resultsPerPage != CG_NSINTEGER_UNKNOWN && (self.resultsPerPage < 1 || self.resultsPerPage > 50)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumResultsPerPageOutOfRange]];
	}
	if (self.page != CG_NSINTEGER_UNKNOWN && self.page < 1) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumPageOutOfRange]];
	}
	if ([self.first length] > 1) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumFirstIllegal]];
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
		case CGPlacesSearchTypeMovie:
			value = @"movie";
			break;
		case CGPlacesSearchTypeMovieTheater:
			value = @"movietheater";
			break;
		case CGPlacesSearchTypeRestaurant:
			value = @"restaurant";
			break;
		case CGPlacesSearchTypeHotel:
			value = @"hotel";
			break;
		case CGPlacesSearchTypeTravel:
			value = @"travel";
			break;
		case CGPlacesSearchTypeBarClub:
			value = @"barclub";
			break;
		case CGPlacesSearchTypeSpaBeauty:
			value = @"spabeauty";
			break;
		case CGPlacesSearchTypeShopping:
			value = @"shopping";
			break;
		default:
			break;
	}
	
	return value;
}

- (NSString*) sortAsParameter {
	NSString* value = nil;
	
	switch (self.sort) {
		case CGPlacesSearchSortDistance:
			value = @"dist";
			break;
		case CGPlacesSearchSortAlphabetical:
			value = @"alpha";
			break;
		case CGPlacesSearchSortHighestRated:
			value = @"highestrated";
			break;
		case CGPlacesSearchSortMostReviewed:
			value = @"mostreviewed";
			break;
		case CGPlacesSearchSortTopMatches:
			value = @"topmatches";
			break;
		case CGPlacesSearchSortOffers:
			value = @"offers";
			break;
		default:
			break;
	}
	
	return value;
}

- (NSDictionary*) build {
	NSMutableDictionary* parameters = [[NSMutableDictionary alloc] initWithCapacity:10];
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
	if (self.chain != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.chain] forKey:@"chain"];
	}
	if ([self.first length] > 0) {
		[parameters setObject:self.first forKey:@"first"];
	}
	if ([self.where length] > 0) {
		[parameters setObject:self.where forKey:@"where"];
	}
	if (self.latlon) {
		[parameters setObject:[NSString stringWithFormat:@"%f", self.latlon.coordinate.latitude] forKey:@"lat"];
		[parameters setObject:[NSString stringWithFormat:@"%f", self.latlon.coordinate.longitude] forKey:@"lon"];
	}
	if (self.radius != CG_FLOAT32_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%f", self.radius] forKey:@"radius"];
	}
	if (self.latlon2) {
		[parameters setObject:[NSString stringWithFormat:@"%f", self.latlon2.coordinate.latitude] forKey:@"lat2"];
		[parameters setObject:[NSString stringWithFormat:@"%f", self.latlon2.coordinate.longitude] forKey:@"lon2"];
	}
	if (self.page != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.page] forKey:@"page"];
	}
	if (self.resultsPerPage != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.resultsPerPage] forKey:@"rpp"];
	}
	NSString* sortString = [self sortAsParameter];
	if ([sortString length] > 0) {
		[parameters setObject:sortString forKey:@"sort"];
	}
	if ([self.publisher length] > 0) {
		[parameters setObject:self.publisher forKey:@"publisher"];
	}
	[parameters setObject:@"json" forKey:@"format"];
	if ([self.placement length] > 0) {
		[parameters setObject:self.placement forKey:@"placement"];
	}
	[parameters setObject:self.offers ? @"true" : @"false" forKey:@"has_offers"];
	[parameters setObject:self.histograms ? @"true" : @"false" forKey:@"histograms"];
	if ([self.impressionId length] > 0) {
		[parameters setObject:self.impressionId forKey:@"i"];
	}
	
	return [parameters autorelease];
}

- (NSArray*) processLocations:(NSArray*) parsedLocations {
	if (parsedLocations == nil) {
		return nil;
	}
	
	NSMutableArray* locations = [NSMutableArray arrayWithCapacity:[parsedLocations count]];
	for (NSDictionary* parsedLocation in parsedLocations) {
		NSInteger locationId = [[self objectForParsed:parsedLocation key:@"id"] integerValue];
        NSString* publicId = [self objectForParsed:parsedLocation key:@"public_id"];
		NSString* impressionId = [self objectForParsed:parsedLocation key:@"impression_id"];
		NSString* name = [self objectForParsed:parsedLocation key:@"name"];
		id address = [self processLocationAddress:[parsedLocation objectForKey:@"address"] useZip:NO];
		CLLocation* latlon = [self locationForParsed:parsedLocation latitudeKey:@"latitude" longitudeKey:@"longitude"];
		NSURL* image = nil;
		NSString* phone = [self objectForParsed:parsedLocation key:@"phone_number"];
		NSInteger rating = [[self objectForParsed:parsedLocation key:@"rating"] integerValue];
		BOOL featured = [[self objectForParsed:parsedLocation key:@"featured"] boolValue];
		NSString* neighborhood = [self objectForParsed:parsedLocation key:@"neighborhood"];
		NSString* fax = [self objectForParsed:parsedLocation key:@"fax_number"];
		NSURL* profile = [self handleUrlFields:[self urlForParsed:parsedLocation key:@"profile"] publisher:self.publisher impressionId:impressionId placement:self.placement];
		NSURL* website = [self urlForParsed:parsedLocation key:@"website"];
		BOOL hasVideo = [[self objectForParsed:parsedLocation key:@"has_video"] boolValue];
		BOOL hasOffers = [[self objectForParsed:parsedLocation key:@"has_offers"] boolValue];
		NSString* offers = [self objectForParsed:parsedLocation key:@"offers"];
		NSInteger reviews = [[self objectForParsed:parsedLocation key:@"user_review_count"] integerValue];
		NSArray* categories = [self trimAndSplit:[self objectForParsed:parsedLocation key:@"sample_categories"]];
		NSString* tagline = [self objectForParsed:parsedLocation key:@"tagline"];
		NSArray* tags = [self processTags:[self objectForParsed:parsedLocation key:@"tags"]];
		
		CGPlacesSearchLocation* location =
		[[[CGPlacesSearchLocation alloc] initImmutable:locationId impressionId:impressionId name:name address:address latlon:latlon
												 image:image phone:phone rating:rating featured:featured publicId:publicId neighborhood:neighborhood
												   fax:fax profile:profile website:website hasVideo:hasVideo hasOffers:hasOffers
												offers:offers reviews:reviews categories:categories tagline:tagline tags:tags] autorelease];
		[locations addObject:location];
	}
	
	return locations;
}

- (CGPlacesSearchResults*) processResults:(NSDictionary*) parsedJson {
	NSDictionary* parsedResults = [self objectForParsed:parsedJson key:@"results"];
	
	NSInteger firstHit = [[self objectForParsed:parsedResults key:@"first_hit"] integerValue];
	NSInteger lastHit = [[self objectForParsed:parsedResults key:@"last_hit"] integerValue];
	NSInteger totalHits = [[self objectForParsed:parsedResults key:@"total_hits"] integerValue];
	NSInteger page = [[self objectForParsed:parsedResults key:@"page"] integerValue];
	NSInteger resultsPerPage = [[self objectForParsed:parsedResults key:@"rpp"] integerValue];
	NSString* didYouMean = [self objectForParsed:parsedResults key:@"did_you_mean"];
	NSURL* uri = [self urlForParsed:parsedResults key:@"uri"];
	NSArray* regions = [self processRegions:[self objectForParsed:parsedResults key:@"regions"]];
	NSArray* locations = [self processLocations:[self objectForParsed:parsedResults key:@"locations"]];
	NSArray* histograms = [self processHistograms:[self objectForParsed:parsedResults key:@"histograms"]];
	
	CGPlacesSearchResults* results =
	[[[CGPlacesSearchResults alloc] initImmutable:firstHit lastHit:lastHit totalHits:totalHits
											 page:page resultsPerPage:resultsPerPage uri:uri didYouMean:didYouMean
										  regions:regions locations:locations histograms:histograms] autorelease];
	return results;
}

- (CGPlacesSearchResults*) search:(NSArray**) errors {
	NSArray* validationErrors = [self validate];
	if (validationErrors) {
		if (errors != NULL) {
			*errors = validationErrors;
		}
		return nil;
	}
	
	NSURL* url = [[CGShared sharedInstance].url URLByAppendingPathComponent:[self.where length] > 0 ? CGPlacesSearchWhereUri : CGPlacesSearchLatLonUri];
	NSDictionary* parameters = [self build];
	
	NSDictionary* parsed = [[CGShared sharedInstance] sendSynchronousRequest:url parameters:parameters timeout:self.timeout errors:errors];
	if (parsed == nil) {
		return nil;
	}
	
	CGPlacesSearchResults* results = [self processResults:parsed];
	return results;
}

@end
