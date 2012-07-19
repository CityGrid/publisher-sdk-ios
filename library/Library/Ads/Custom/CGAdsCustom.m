//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGAdsCustom.h"
#import "CGShared.h"
#import "CGConstants.h"
#import "CGAdsCustom.h"
#import "CGAdsCustomAd.h"
#import "CGAdsCustomResults.h"

#define CGAdsCustomWhereUri @"ads/custom/v2/where"
#define CGAdsCustomLatLonUri @"ads/custom/v2/latlon"

@implementation CGAdsCustom

@synthesize publisher = publisher_;
@synthesize what = what_;
@synthesize where = where_;
@synthesize rawWhat = rawWhat_;
@synthesize rawWhere = rawWhere_;
@synthesize clientIp = clientIp_;
@synthesize ua = ua_;
@synthesize serveUrl = serveUrl_;
@synthesize max = max_;
@synthesize placement = placement_;
@synthesize impressionId = impressionId_;
@synthesize latlon = latlon_;
@synthesize radius = radius_;
@synthesize timeout = timeout_;

#pragma mark -
#pragma mark Lifecycle

- (id) init:(NSString*) publisher {
	self = [super init];
	
	if (self) {
		self.publisher = publisher;
		self.what = nil;
		self.where = nil;
        self.rawWhat = nil;
		self.rawWhere = nil;
        self.clientIp = nil;
        self.ua = nil;
        self.serveUrl = nil;
		self.max = CG_NSINTEGER_UNKNOWN;
		self.placement = nil;
		self.impressionId = nil;
		self.latlon = nil;
		self.radius = CG_FLOAT32_UNKNOWN;
		self.timeout = [CGShared sharedInstance].timeout;
	}
	
	return self;
}

+ (id) adsCustom {
	return [[self class] adsCustomWithPublisher:nil placement:nil];
}

+ (id) adsCustomWithPublisher:(NSString*) publisher {
	return [[self class] adsCustomWithPublisher:publisher placement:nil];
}

+ (id) adsCustomWithPlacement:(NSString*) placement {
	return [[self class] adsCustomWithPublisher:nil placement:placement];
}

+ (id) adsCustomWithPublisher:(NSString*) publisher placement:(NSString*) placement {
	NSString* resolvedPublisher = publisher ? publisher : [CGShared sharedInstance].publisher;
	NSString* resolvedPlacement = placement ? placement : [CGShared sharedInstance].placement;
	
	CGAdsCustom* builder = [[[[self class] alloc] init:resolvedPublisher] autorelease];
	builder.placement = resolvedPlacement;
	return builder;
}

- (void) dealloc {
	self.publisher = nil;
	self.what = nil;
	self.where = nil;
    self.rawWhat = nil;
    self.rawWhere = nil;
    self.clientIp = nil;
    self.ua = nil;
    self.serveUrl = nil;
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
		self.what = [decoder decodeObjectForKey:@"what"];
		self.where = [decoder decodeObjectForKey:@"where"];
        self.rawWhat = [decoder decodeObjectForKey:@"rawWhat"];
		self.rawWhere = [decoder decodeObjectForKey:@"rawWhere"];
        self.clientIp = [decoder decodeObjectForKey:@"clientIp"];
        self.ua = [decoder decodeObjectForKey:@"ua"];
        self.serveUrl = [decoder decodeObjectForKey:@"serveUrl"];
		self.max = [decoder decodeIntegerForKey:@"max"];
		self.placement = [decoder decodeObjectForKey:@"placement"];
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
		self.latlon = [decoder decodeObjectForKey:@"latlon"];
		self.radius = [decoder decodeFloatForKey:@"radius"];
		self.timeout = [decoder decodeDoubleForKey:@"timeout"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.publisher forKey:@"publisher"];
	[encoder encodeObject:self.what forKey:@"what"];
	[encoder encodeObject:self.where forKey:@"where"];
    [encoder encodeObject:self.rawWhat forKey:@"rawWhat"];
	[encoder encodeObject:self.rawWhere forKey:@"rawWhere"];
    [encoder encodeObject:self.clientIp forKey:@"clientIp"];
    [encoder encodeObject:self.ua forKey:@"ua"];
    [encoder encodeObject:self.serveUrl forKey:@"serveUrl"];
	[encoder encodeInteger:self.max forKey:@"max"];
	[encoder encodeObject:self.placement forKey:@"placement"];
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
	[encoder encodeObject:self.latlon forKey:@"latlon"];
	[encoder encodeFloat:self.radius forKey:@"radius"];
	[encoder encodeDouble:self.timeout forKey:@"timeout"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGAdsCustom* copy = [super copyWithZone:zone];
	if (copy) {
		copy.publisher = [[self.publisher copyWithZone:zone] autorelease];
		copy.what = [[self.what copyWithZone:zone] autorelease];
		copy.where = [[self.where copyWithZone:zone] autorelease];
        copy.rawWhat = [[self.rawWhat copyWithZone:zone] autorelease];
		copy.rawWhere = [[self.rawWhere copyWithZone:zone] autorelease];
        copy.clientIp = [[self.clientIp copyWithZone:zone] autorelease];
        copy.ua = [[self.ua copyWithZone:zone] autorelease];
        copy.serveUrl = [[self.serveUrl copyWithZone:zone] autorelease];
		copy.max = self.max;
		copy.placement = [[self.placement copyWithZone:zone] autorelease];
		copy.impressionId = [[self.impressionId copyWithZone:zone] autorelease];
		copy.latlon = [[self.latlon copyWithZone:zone] autorelease];
		copy.radius = self.radius;
		copy.timeout = self.timeout;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsCustom:(CGAdsCustom*) other {
	return
	[self isEqualWithNull:self.publisher other:other.publisher] &&
	[self isEqualWithNull:self.what other:other.what] &&
	[self isEqualWithNull:self.where other:other.where] &&
    [self isEqualWithNull:self.rawWhat other:other.rawWhat] &&
	[self isEqualWithNull:self.rawWhere other:other.rawWhere] &&
    [self isEqualWithNull:self.clientIp other:other.clientIp] &&
    [self isEqualWithNull:self.ua other:other.ua] &&
    [self isEqualWithNull:self.serveUrl other:other.serveUrl] &&
	self.max == other.max &&
	[self isEqualWithNull:self.placement other:other.placement] &&
	[self isEqualWithNull:self.impressionId other:other.impressionId] &&
	[self isEqualCoordinates:self.latlon other:other.latlon] &&
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
	
	return [self isEqualToAdsCustom:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.publisher hash];
	h += [self.what hash];
	h += [self.where hash];
    h += [self.rawWhat hash];
	h += [self.rawWhere hash];
    h += [self.clientIp hash];
    h += [self.ua hash];
    h += [self.serveUrl hash];
	h += self.max;
	h += [self.placement hash];
	h += [self.impressionId hash];
	h += [self.latlon hash];
	h += (NSUInteger) self.radius;
	h += (NSUInteger) self.timeout;
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendString:@"<CGAdsCustom "];
	[description appendFormat:@"publisher=%@", self.publisher];
	[description appendFormat:@",what=%@", self.what];
	[description appendFormat:@",where=%@", self.where];
    [description appendFormat:@",rawWhat=%@", self.rawWhat];
	[description appendFormat:@",rawWhere=%@", self.rawWhere];
    [description appendFormat:@",clientIp=%@", self.clientIp];
    [description appendFormat:@",ua=%@", self.ua];
    [description appendFormat:@",serveUrl=%@", self.serveUrl];
	[description appendFormat:@",max=%i", self.max];
	[description appendFormat:@",placement=%@", self.placement];
	[description appendFormat:@",impressionId=%@", self.impressionId];
	[description appendFormat:@",latlon=%@", self.latlon];
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
	if ([self.what length] == 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumUnderspecified]];
	}
    else {
        NSArray *splitWhat = [self.what componentsSeparatedByString:@" "];
        if ([splitWhat count] > 3) {
            [errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumMaxWhatOutOfRange]];
        }
    }
	if (self.max != CG_NSINTEGER_UNKNOWN && (self.max < 1 || self.max > 10)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumMaxOutOfRange]];
	}
	if ([self.where length] == 0 && (self.latlon == nil || self.radius == CG_FLOAT32_UNKNOWN) && [self.clientIp length] == 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumGeographyUnderspecified]];
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

- (NSDictionary*) build {
	NSMutableDictionary* parameters = [[NSMutableDictionary alloc] initWithCapacity:10];
	if ([self.publisher length] > 0) {
		[parameters setObject:self.publisher forKey:@"publisher"];
	}
	if ([self.what length] > 0) {
		[parameters setObject:self.what forKey:@"what"];
        NSArray *splitWhat = [self.what componentsSeparatedByString:@" "];
        [parameters setObject:splitWhat forKey:@"what"];
	}
	if ([self.where length] > 0) {
		[parameters setObject:self.where forKey:@"where"];
	}
    if ([self.rawWhat length] > 0) {
		[parameters setObject:self.rawWhat forKey:@"raw_what"];
	}
	if ([self.rawWhere length] > 0) {
		[parameters setObject:self.rawWhere forKey:@"raw_where"];
	}
    //if ([self.clientIp length] > 0) {
    //    [parameters setObject:self.clientIp forKey:@"client_ip"]; 
    //}
	//[parameters setObject:[self ipAddress] forKey:@"client_ip"];       // Retrieving local ip
    if ([self.ua length] > 0) {
        [parameters setObject:self.ua forKey:@"ua"];
    }
    if ([self.serveUrl length] > 0) {
        [parameters setObject:self.serveUrl forKey:@"serve_url"];
    }
	if (self.max != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.max] forKey:@"max"];
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
	if (self.radius != CG_FLOAT32_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%f", self.radius] forKey:@"radius"];
	}
	[parameters setObject:@"json" forKey:@"format"];
	
	return [parameters autorelease];
}

- (NSArray*) processAds:(NSArray*) parsedAds {
	if (parsedAds == nil) {
		return nil;
	}
	
	NSMutableArray* ads = [NSMutableArray arrayWithCapacity:[parsedAds count]];
	for (NSDictionary* parsedAd in parsedAds) {
		NSInteger locationId = [[self objectForParsed:parsedAd key:@"listingId"] integerValue];
		NSString* impressionId = [self objectForParsed:parsedAd key:@"impressionId"];
		NSString* name = [self objectForParsed:parsedAd key:@"name"];
		id address = [self processLocationAddress:parsedAd useZip:YES];
		CLLocation* latlon = [self locationForParsed:parsedAd latitudeKey:@"latitude" longitudeKey:@"longitude"];
		NSURL* image = nil;
		NSString* phone = [self objectForParsed:parsedAd key:@"phone"];
		NSInteger rating = [[self objectForParsed:parsedAd key:@"overallReviewRating"] integerValue];
		
		NSInteger adId = [[self objectForParsed:parsedAd key:@"id"] integerValue];
		NSString* type = [self objectForParsed:parsedAd key:@"type"];
		NSString* tagline = [self objectForParsed:parsedAd key:@"tagline"];
		NSString* businessDescription = [self objectForParsed:parsedAd key:@"description"];
		NSURL* destinationUrl = [self urlForParsed:parsedAd key:@"adDestinationUrl"];
		NSURL* displayUrl = [self urlForParsed:parsedAd key:@"adDisplayUrl"];
		Float32 ppe = [[self objectForParsed:parsedAd key:@"net_ppe"] floatValue];
		NSInteger reviews = [[self objectForParsed:parsedAd key:@"reviews"] integerValue];
		NSString* offers = [self objectForParsed:parsedAd key:@"offers"];
		Float32 distance = [[self objectForParsed:parsedAd key:@"distance"] floatValue];
        NSString* attributionText = [self objectForParsed:parsedAd key:@"attributionText"];
		
		CGAdsCustomAd* ad =
		[[[CGAdsCustomAd alloc] initImmutable:locationId impressionId:impressionId name:name
									  address:address latlon:latlon image:image phone:phone
									   rating:rating adId:adId type:type tagline:tagline
						  businessDescription:businessDescription destinationUrl:destinationUrl
								   displayUrl:displayUrl ppe:ppe reviews:reviews offers:offers
									 distance:distance attributionText:attributionText] autorelease];
		[ads addObject:ad];
	}
	return ads;
}

- (CGAdsCustomResults*) processResults:(NSDictionary*) parsedJson {
	NSArray* ads = [self processAds:[parsedJson objectForKey:@"ads"]];
	
	CGAdsCustomResults* results = [[[CGAdsCustomResults alloc] initImmutable:ads] autorelease];
	return results;
}

- (CGAdsCustomResults*) search:(NSArray**) errors {
	NSArray* validationErrors = [self validate];
	if (validationErrors) {
		if (errors != NULL) {
			*errors = validationErrors;
		}
		return nil;
	}
	
    NSURL* url = [[CGShared sharedInstance].url URLByAppendingPathComponent:[self.where length] > 0 ? CGAdsCustomWhereUri : CGAdsCustomLatLonUri];
    
	NSDictionary* parameters = [self build];
	
	NSDictionary* parsed = [[CGShared sharedInstance] sendSynchronousRequest:url parameters:parameters timeout:self.timeout errors:errors];
	if (parsed == nil) {
		return nil;
	}
	
	CGAdsCustomResults* results = [self processResults:parsed];
	return results;
}

@end
