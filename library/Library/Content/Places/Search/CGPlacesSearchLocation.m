//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesSearchLocation.h"

@interface CGPlacesSearchLocation ()

@property (nonatomic, assign, readwrite) BOOL featured;
@property (nonatomic, retain, readwrite) NSString* publicId;
@property (nonatomic, retain, readwrite) NSString* neighborhood;
@property (nonatomic, retain, readwrite) NSString* fax;
@property (nonatomic, retain, readwrite) NSURL* profile;
@property (nonatomic, retain, readwrite) NSURL* website;
@property (nonatomic, assign, readwrite) BOOL hasVideo;
@property (nonatomic, assign, readwrite) BOOL hasOffers;
@property (nonatomic, retain, readwrite) NSString* offers;
@property (nonatomic, assign, readwrite) NSInteger reviews;
@property (nonatomic, retain, readwrite) NSArray* categories; // NSString*
@property (nonatomic, retain, readwrite) NSString* tagline;
@property (nonatomic, retain, readwrite) NSArray* tags; // CGTag*

@end

@implementation CGPlacesSearchLocation

@synthesize featured = featured_;
@synthesize publicId = publicId_;
@synthesize neighborhood = neighborhood_;
@synthesize fax = fax_;
@synthesize profile = profile_;
@synthesize website = website_;
@synthesize hasVideo = hasVideo_;
@synthesize hasOffers = hasOffers_;
@synthesize offers = offers_;
@synthesize reviews = reviews_;
@synthesize categories = categories_;
@synthesize tagline = tagline_;
@synthesize tags = tags_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSUInteger) locationId impressionId:(NSString*) impressionId name:(NSString*) name
			 address:(id) address latlon:(CLLocation*) latlon image:(NSURL*) image phone:(NSString*) phone
			  rating:(NSUInteger) rating featured:(BOOL) featured publicId:(NSString*) publicId neighborhood:(NSString*) neighborhood
				 fax:(NSString*) fax profile:(NSURL*) profile website:(NSURL*) website hasVideo:(BOOL) hasVideo
		   hasOffers:(BOOL) hasOffers offers:(NSString*) offers reviews:(NSInteger) reviews
		  categories:(NSArray*) categories tagline:(NSString*) tagline tags:(NSArray*) tags {
	self = [super initImmutable:locationId impressionId:impressionId name:name
						address:address latlon:latlon image:image phone:phone rating:rating];
	
	if (self) {
		self.featured = featured;
        self.publicId = publicId;
		self.neighborhood = neighborhood;
		self.fax = fax;
		self.profile = profile;
		self.website = website;
		self.hasVideo = hasVideo;
		self.hasOffers = hasOffers;
		self.offers = offers;
		self.reviews = reviews;
		self.categories = categories;
		self.tagline = tagline;
		self.tags = tags;
	}
	
	return self;
}

- (void) dealloc {
    self.publicId = nil;
	self.neighborhood = nil;
	self.fax = nil;
	self.profile = nil;
	self.website = nil;
	self.offers = nil;
	self.categories = nil;
	self.tagline = nil;
	self.tags = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.featured = [decoder decodeBoolForKey:@"featured"];
        self.publicId = [decoder decodeObjectForKey:@"publicId"];
		self.neighborhood = [decoder decodeObjectForKey:@"neighborhood"];
		self.fax = [decoder decodeObjectForKey:@"fax"];
		self.profile = [decoder decodeObjectForKey:@"profile"];
		self.website = [decoder decodeObjectForKey:@"website"];
		self.hasVideo = [decoder decodeBoolForKey:@"hasVideo"];
		self.hasOffers = [decoder decodeBoolForKey:@"hasOffers"];
		self.offers = [decoder decodeObjectForKey:@"offers"];
		self.reviews = [decoder decodeIntegerForKey:@"reviews"];
		self.categories = [decoder decodeObjectForKey:@"categories"];
		self.tagline = [decoder decodeObjectForKey:@"tagline"];
		self.tags = [decoder decodeObjectForKey:@"tags"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	
	[encoder encodeBool:self.featured forKey:@"featured"];
    [encoder encodeObject:self.publicId forKey:@"publicId"];
	[encoder encodeObject:self.neighborhood forKey:@"neighborhood"];
	[encoder encodeObject:self.fax forKey:@"fax"];
	[encoder encodeObject:self.profile forKey:@"profile"];
	[encoder encodeObject:self.website forKey:@"website"];
	[encoder encodeBool:self.hasVideo forKey:@"hasVideo"];
	[encoder encodeBool:self.hasOffers forKey:@"hasOffers"];
	[encoder encodeObject:self.offers forKey:@"offers"];
	[encoder encodeInteger:self.reviews forKey:@"reviews"];
	[encoder encodeObject:self.categories forKey:@"categories"];
	[encoder encodeObject:self.tagline forKey:@"tagline"];
	[encoder encodeObject:self.tags forKey:@"tags"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesSearchLocation* copy = [super copyWithZone:zone];
	if (copy) {
		copy.featured = self.featured;
        copy.publicId = [[self.publicId copyWithZone:zone] autorelease];
		copy.neighborhood = [[self.neighborhood copyWithZone:zone] autorelease];
		copy.fax = [[self.fax copyWithZone:zone] autorelease];
		copy.profile = [[self.profile copyWithZone:zone] autorelease];
		copy.website = [[self.website copyWithZone:zone] autorelease];
		copy.hasVideo = self.hasVideo;
		copy.hasOffers = self.hasOffers;
		copy.offers = [[self.offers copyWithZone:zone] autorelease];
		copy.reviews = self.reviews;
		copy.categories = [[self.categories copyWithZone:zone] autorelease];
		copy.tagline = [[self.tagline copyWithZone:zone] autorelease];
		copy.tags = [[self.tags copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesSearchLocation:(CGPlacesSearchLocation*) other {
	return
	[super isEqualToLocation:other] &&
	self.featured == other.featured &&
    [self isEqualWithNull:self.publicId other:other.publicId] &&
	[self isEqualWithNull:self.neighborhood other:other.neighborhood] &&
	[self isEqualWithNull:self.fax other:other.fax] &&
	[self isEqualWithNull:self.profile other:other.profile] &&
	[self isEqualWithNull:self.website other:other.website] &&
	self.hasVideo == other.hasVideo &&
	self.hasOffers == other.hasOffers &&
	[self isEqualWithNull:self.offers other:other.offers] &&
	self.reviews == other.reviews &&
	[self isEqualWithNull:self.categories other:other.categories] &&
	[self isEqualWithNull:self.tagline other:other.tagline] &&
	[self isEqualWithNull:self.tags other:other.tags];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesSearchLocation:other];
}

- (NSUInteger) hash {
	NSUInteger h = [super hash];
	h += self.featured;
    h += [self.publicId hash];
	h += [self.neighborhood hash];
	h += [self.fax hash];
	h += [self.profile hash];
	h += [self.website hash];
	h += self.hasVideo;
	h += self.hasOffers;
	h += [self.offers hash];
	h += self.reviews;
	h += [self.categories hash];
	h += [self.tagline hash];
	h += [self.tags hash];
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendFormat:@"<CGPlacesSearchLocation %@ ", [super description]];
	[description appendFormat:@"featured=%u", self.featured];
    [description appendFormat:@",publicId=%@", self.publicId];
	[description appendFormat:@",neighborhood=%@", self.neighborhood];
	[description appendFormat:@",fax=%@", self.fax];
	[description appendFormat:@",profile=%@", self.profile];
	[description appendFormat:@",website=%@", self.website];
	[description appendFormat:@",hasVideo=%u", self.hasVideo];
	[description appendFormat:@",hasOffers=%u", self.hasOffers];
	[description appendFormat:@",offers=%@", self.offers];
	[description appendFormat:@",reviews=%i", self.reviews];
	[description appendFormat:@",categories=%@", self.categories];
	[description appendFormat:@",tagline=%@", self.tagline];
	[description appendFormat:@",tags=%@", self.tags];
	[description appendString:@">"];
	return [description autorelease];
}

@end
