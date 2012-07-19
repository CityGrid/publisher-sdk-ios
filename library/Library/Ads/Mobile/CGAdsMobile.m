//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CGAdsMobile.h"
#import "CGShared.h"
#import "CGConstants.h"
#import "CGAdsMobileAd.h"
#import "CGAdsMobileResults.h"

#define CGAdsMobileBannerUri @"ads/mobile/v2/banner"

@implementation CGAdsMobile

@synthesize publisher = publisher_;
@synthesize collection = collection_;
@synthesize what = what_;
@synthesize where = where_;
@synthesize rawWhat = rawWhat_;
@synthesize rawWhere = rawWhere_;
@synthesize clientIp = clientIp_;
@synthesize ua = ua_;
@synthesize placement = placement_;
@synthesize impressionId = impressionId_;
@synthesize latlon = latlon_;
@synthesize radius = radius_;
@synthesize max = max_;
@synthesize size = size_;
@synthesize timeout = timeout_;

#pragma mark -
#pragma mark Lifecycle

- (id) init:(NSString*) publisher {
	self = [super init];
	
	if (self) {
		self.publisher = publisher;
		self.collection = CGAdsMobileCollectionUnknown;
		self.what = nil;
		self.where = nil;
        self.rawWhat = nil;
		self.rawWhere = nil;
        self.clientIp = nil;
        self.ua = nil;
		self.placement = nil;
		self.impressionId = nil;
		self.latlon = nil;
		self.radius = CG_FLOAT32_UNKNOWN;
		self.max = CG_NSINTEGER_UNKNOWN;
		self.size = CGSizeZero;
		self.timeout = [CGShared sharedInstance].timeout;
	}
	
	return self;
}

+ (id) adsMobile {
	return [[self class] adsMobileWithPublisher:nil placement:nil];
}

+ (id) adsMobileWithPublisher:(NSString*) publisher {
	return [[self class] adsMobileWithPublisher:publisher placement:nil];
}

+ (id) adsMobileWithPlacement:(NSString*) placement {
	return [[self class] adsMobileWithPublisher:nil placement:placement];
}

+ (id) adsMobileWithPublisher:(NSString*) publisher placement:(NSString*) placement {
	NSString* resolvedPublisher = publisher ? publisher : [CGShared sharedInstance].publisher;
	NSString* resolvedPlacement = placement ? placement : [CGShared sharedInstance].placement;
	
	CGAdsMobile* builder = [[[[self class] alloc] init:resolvedPublisher] autorelease];
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
	self.latlon = nil;
	self.placement = nil;
	self.impressionId = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.publisher = [decoder decodeObjectForKey:@"publisher"];
		self.collection = [decoder decodeIntegerForKey:@"collection"];
		self.what = [decoder decodeObjectForKey:@"what"];
		self.where = [decoder decodeObjectForKey:@"where"];
        self.rawWhat = [decoder decodeObjectForKey:@"rawWhat"];
		self.rawWhere = [decoder decodeObjectForKey:@"rawWhere"];
        self.clientIp = [decoder decodeObjectForKey:@"clientIp"];
        self.ua = [decoder decodeObjectForKey:@"ua"];
		self.latlon = [decoder decodeObjectForKey:@"latlon"];
		self.radius = [decoder decodeFloatForKey:@"radius"];
		self.max = [decoder decodeIntegerForKey:@"max"];
		self.placement = [decoder decodeObjectForKey:@"placement"];
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
		self.size = CGSizeMake([decoder decodeFloatForKey:@"width"], [decoder decodeFloatForKey:@"height"]);
		self.timeout = [decoder decodeDoubleForKey:@"timeout"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.publisher forKey:@"publisher"];
	[encoder encodeInteger:self.collection forKey:@"collection"];
	[encoder encodeObject:self.what forKey:@"what"];
	[encoder encodeObject:self.where forKey:@"where"];
    [encoder encodeObject:self.rawWhat forKey:@"rawWhat"];
	[encoder encodeObject:self.rawWhere forKey:@"rawWhere"];
    [encoder encodeObject:self.clientIp forKey:@"clientIp"];
    [encoder encodeObject:self.ua forKey:@"ua"];
	[encoder encodeObject:self.latlon forKey:@"latlon"];
	[encoder encodeFloat:self.radius forKey:@"radius"];
	[encoder encodeInteger:self.max forKey:@"max"];
	[encoder encodeObject:self.placement forKey:@"placement"];
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
	[encoder encodeFloat:self.size.width forKey:@"width"];
	[encoder encodeFloat:self.size.height forKey:@"height"];
	[encoder encodeDouble:self.timeout forKey:@"timeout"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGAdsMobile* copy = [super copyWithZone:zone];
	if (copy) {
		copy.publisher = [[self.publisher copyWithZone:zone] autorelease];
		copy.collection = self.collection;
		copy.what = [[self.what copyWithZone:zone] autorelease];
		copy.where = [[self.where copyWithZone:zone] autorelease];
        copy.rawWhat = [[self.rawWhat copyWithZone:zone] autorelease];
		copy.rawWhere = [[self.rawWhere copyWithZone:zone] autorelease];
        copy.clientIp = [[self.clientIp copyWithZone:zone] autorelease];
        copy.ua = [[self.ua copyWithZone:zone] autorelease];
		copy.latlon = [[self.latlon copyWithZone:zone] autorelease];
		copy.radius = self.radius;
		copy.max = self.max;
		copy.placement = [[self.placement copyWithZone:zone] autorelease];
		copy.impressionId = [[self.impressionId copyWithZone:zone] autorelease];
		copy.size = self.size;
		copy.timeout = self.timeout;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsMobile:(CGAdsMobile*) other {
	return
	[self isEqualWithNull:self.publisher other:other.publisher] &&
	self.collection == other.collection &&
	[self isEqualWithNull:self.what other:other.what] &&
	[self isEqualWithNull:self.where other:other.where] &&
    [self isEqualWithNull:self.rawWhat other:other.rawWhat] &&
	[self isEqualWithNull:self.rawWhere other:other.rawWhere] &&
    [self isEqualWithNull:self.clientIp other:other.clientIp] &&
    [self isEqualWithNull:self.ua other:other.ua] &&
	[self isEqualCoordinates:self.latlon other:other.latlon] &&
	self.radius == other.radius &&
	self.max == other.max &&
	[self isEqualWithNull:self.placement other:other.placement] &&
	[self isEqualWithNull:self.impressionId other:other.impressionId] &&
	CGSizeEqualToSize(self.size, other.size) &&
	self.timeout == other.timeout;
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToAdsMobile:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.publisher hash];
	h += self.collection;
	h += [self.what hash];
	h += [self.where hash];
    h += [self.rawWhat hash];
	h += [self.rawWhere hash];
    h += [self.clientIp hash];
    h += [self.ua hash];
	h += [self.placement hash];
	h += [self.impressionId hash];
	h += [self.latlon hash];
	h += (NSUInteger) self.radius;
	h += self.max;
	h += self.size.width;
	h += self.size.height;
	h += (NSUInteger) self.timeout;
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendString:@"<CGAdsMobile "];
	[description appendFormat:@"publisher=%@", self.publisher];
	[description appendFormat:@",collection=%i", self.collection];
	[description appendFormat:@",what=%@", self.what];
	[description appendFormat:@",where=%@", self.where];
    [description appendFormat:@",rawWhat=%@", self.rawWhat];
	[description appendFormat:@",rawWhere=%@", self.rawWhere];
    [description appendFormat:@",clientIp=%@", self.clientIp];
    [description appendFormat:@",ua=%@", self.ua];
	[description appendFormat:@",latlon=%@", self.latlon];
	[description appendFormat:@",radius=%f", self.radius];
	[description appendFormat:@",max=%i", self.max];
	[description appendFormat:@",placement=%@", self.placement];
	[description appendFormat:@",impressionId=%@", self.impressionId];
	[description appendFormat:@",size={%f,%f}", self.size.width, self.size.height];
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
	if (self.collection == CGAdsMobileCollectionUnknown) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumCollectionRequired]];
	}
	if ([self.where length] == 0 && (self.latlon == nil || self.radius == CG_FLOAT32_UNKNOWN)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumGeographyUnderspecified]];
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
	if (self.latlon && (self.latlon.coordinate.latitude > 180.0 || self.latlon.coordinate.latitude < -180.0)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumLatitudeIllegal]];
	}
	if (self.latlon && (self.latlon.coordinate.longitude > 180.0 || self.latlon.coordinate.longitude < -180.0)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumLongitudeIllegal]];
	}
	if (self.radius != CG_FLOAT32_UNKNOWN && ! (self.radius >= 1.0 && self.radius <= 50.0)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumRadiusOutOfRange]];
	}
	if (self.max != CG_NSINTEGER_UNKNOWN && (self.max < 1 || self.max > 10)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumMaxOutOfRange]];
	}
	if (CGSizeEqualToSize(self.size, CGSizeZero)) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumSizeRequired]];
	}
	
	[errors autorelease];
	return [errors count] == 0 ? nil : errors;
}

- (NSString*) parameterForCollection:(CGAdsMobileCollection) collection {
	NSString* parameter = nil;
	switch (collection) {
		case CGAdsMobileCollection300x250:
			parameter = @"mobile-003-300x250";
			break;
		case CGAdsMobileCollection300x50:
			parameter = @"mobile-002-300x50";
			break;
		case CGAdsMobileCollection320x50:
			parameter = @"mobile-001-320x50";
			break;
		case CGAdsMobileCollection640x100:
			parameter = @"mobile-004-320x50";
			break;
        case CGAdsMobileCollection320x50cat:
            parameter = @"mobile-006-320x50";
            break;
        case CGAdsMobileCollection300x50cat:
            parameter = @"mobile-007-300x50";
            break;
		default:
			break;
	}
	return parameter;
}

- (NSDictionary*) build {
	NSMutableDictionary* parameters = [[NSMutableDictionary alloc] initWithCapacity:10];
	if ([self.publisher length] > 0) {
		[parameters setObject:self.publisher forKey:@"publisher"];
	}
	if (self.collection != CGAdsMobileCollectionUnknown) {
		[parameters setObject:[self parameterForCollection:self.collection] forKey:@"collection_id"];
	}
	if ([self.what length] > 0) {
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
    if ([self.ua length] > 0) {
        [parameters setObject:self.ua forKey:@"ua"];
    }
	if (self.latlon) {
		[parameters setObject:[NSString stringWithFormat:@"%f", self.latlon.coordinate.latitude] forKey:@"lat"];
		[parameters setObject:[NSString stringWithFormat:@"%f", self.latlon.coordinate.longitude] forKey:@"lon"];
	}
	if (self.radius != CG_FLOAT32_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%f", self.radius] forKey:@"radius"];
	}
    //if ([self.clientIp length] > 0) {
    //    [parameters setObject:self.clientIp forKey:@"client_ip"];
    //}
	//[parameters setObject:[self ipAddress] forKey:@"client_ip"];     //Retrieving local IP
	if (self.max != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.max] forKey:@"max"];
	}
	if ([self.placement length] > 0) {
		[parameters setObject:self.placement forKey:@"placement"];
	}
	if ([self.impressionId length] > 0) {
		[parameters setObject:self.impressionId forKey:@"i"];
	}
	if (! CGSizeEqualToSize(self.size, CGSizeZero)) {
		[parameters setObject:[NSString stringWithFormat:@"%i", (NSInteger)self.size.width] forKey:@"width"];
		[parameters setObject:[NSString stringWithFormat:@"%i", (NSInteger)self.size.height] forKey:@"height"];
	}
	[parameters setObject:[[UIDevice currentDevice] uniqueIdentifier] forKey:@"muid"];
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
		NSString* adId = [self objectForParsed:parsedAd key:@"id"];
		NSURL* destinationUrl = [self urlForParsed:parsedAd key:@"adDestinationUrl"];
		NSURL* image = [self urlForParsed:parsedAd key:@"adImageUrl"];
		
		CGAdsMobileAd* ad =
		[[[CGAdsMobileAd alloc] initImmutable:locationId impressionId:impressionId adId:adId destinationUrl:destinationUrl image:image] autorelease];
		[ads addObject:ad];
	}
	return ads;
}

- (CGAdsMobileResults*) processResults:(NSDictionary*) parsedJson {
	NSArray* ads = [self processAds:[parsedJson objectForKey:@"ads"]];
	
	CGAdsMobileResults* results = [[[CGAdsMobileResults alloc] initImmutable:ads] autorelease];
	return results;
}

- (CGAdsMobileResults*) banner:(NSArray**) errors {
	NSArray* validationErrors = [self validate];
	if (validationErrors) {
		if (errors != NULL) {
			*errors = validationErrors;
		}
		return nil;
	}
	
	NSURL* url = [[CGShared sharedInstance].url URLByAppendingPathComponent:CGAdsMobileBannerUri];
	NSDictionary* parameters = [self build];
	
	NSDictionary* parsed = [[CGShared sharedInstance] sendSynchronousRequest:url parameters:parameters timeout:self.timeout errors:errors];
	if (parsed == nil) {
		return nil;
	}
	
	CGAdsMobileResults* results = [self processResults:parsed];
	return results;
}

@end
