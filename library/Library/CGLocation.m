//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGLocation.h"
#import "CGPlacesDetail.h"
#import "CGPlacesDetailLocation.h"
#import "CGPlacesDetailResults.h"

@interface CGLocation ()

@property (nonatomic, assign, readwrite) NSInteger locationId;
@property (nonatomic, retain, readwrite) NSString* impressionId;
@property (nonatomic, retain, readwrite) NSString* name;
@property (nonatomic, retain, readwrite) id address; // CGAddress or CGPlacesDetailAddress
@property (nonatomic, retain, readwrite) CLLocation* latlon;
@property (nonatomic, retain, readwrite) NSURL* image;
@property (nonatomic, retain, readwrite) NSString* phone;
@property (nonatomic, assign, readwrite) NSInteger rating;

@end

@implementation CGLocation

@synthesize locationId = locationId_;
@synthesize impressionId = impressionId_;
@synthesize name = name_;
@synthesize address = address_;
@synthesize latlon = latlon_;
@synthesize image = image_;
@synthesize phone = phone_;
@synthesize rating = rating_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSInteger) locationId impressionId:(NSString*) impressionId name:(NSString*) name
			 address:(id) address latlon:(CLLocation*) latlon image:(NSURL*) image phone:(NSString*) phone
			  rating:(NSInteger) rating {
	self = [super init];
	
	if (self) {
		self.locationId = locationId;
		self.impressionId = impressionId;
		self.name = name;
		self.address = address;
		self.latlon = latlon;
		self.image = image;
		self.phone = phone;
		self.rating = rating;
	}
	
	return self;
}

- (void) dealloc {
	self.impressionId = nil;
	self.name = nil;
	self.address = nil;
	self.latlon = nil;
	self.image = nil;
	self.phone = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.locationId = [decoder decodeIntegerForKey:@"locationId"];
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
		self.name = [decoder decodeObjectForKey:@"name"];
		self.address = [decoder decodeObjectForKey:@"address"];
		self.latlon = [decoder decodeObjectForKey:@"latlon"];
		self.image = [decoder decodeObjectForKey:@"image"];
		self.phone = [decoder decodeObjectForKey:@"phone"];
		self.rating = [decoder decodeIntegerForKey:@"rating"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeInteger:self.locationId forKey:@"locationId"];
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.address forKey:@"address"];
	[encoder encodeObject:self.latlon forKey:@"latlon"];
	[encoder encodeObject:self.image forKey:@"image"];
	[encoder encodeObject:self.phone forKey:@"phone"];
	[encoder encodeInteger:self.rating forKey:@"rating"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGLocation* copy = [super copyWithZone:zone];
	if (copy) {
		copy.locationId = self.locationId;
		copy.impressionId = [[self.impressionId copyWithZone:zone] autorelease];
		copy.name = [[self.name copyWithZone:zone] autorelease];
		copy.address = [[self.address copyWithZone:zone] autorelease];
		copy.latlon = [[self.latlon copyWithZone:zone] autorelease];
		copy.image = [[self.image copyWithZone:zone] autorelease];
		copy.phone = [[self.phone copyWithZone:zone] autorelease];
		copy.rating = self.rating;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToLocation:(CGLocation*) other {
	return
	self.locationId == other.locationId &&
	[self isEqualWithNull:self.impressionId other:other.impressionId] &&
	[self isEqualWithNull:self.name other:other.name] &&
	[self isEqualWithNull:self.address other:other.address] &&
	[self isEqualCoordinates:self.latlon other:other.latlon] &&
	[self isEqualWithNull:self.image other:other.image] &&
	[self isEqualWithNull:self.phone other:other.phone] &&
	self.rating == other.rating;
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToLocation:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += self.locationId;
	h += [self.impressionId hash];
	h += [self.name hash];
	h += [self.address hash];
	h += [self.latlon hash];
	h += [self.image hash];
	h += [self.phone hash];
	h += self.rating;
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGLocation locationId=%i,impressionId=%@,name=%@,address=%@,latlon=%@,image=%@,phone=%@,rating=%i>",
			self.locationId, self.impressionId, self.name, self.address, self.latlon, self.image, self.phone, self.rating];
}

#pragma mark -
#pragma mark Detail Helpers

- (CGPlacesDetail*) placesDetail {
	CGPlacesDetail* detail = [CGPlacesDetail placesDetail];
	detail.locationId = self.locationId;
	detail.impressionId = self.impressionId;
	return detail;
}

- (CGPlacesDetailLocation*) placesDetailLocation:(NSArray**) errors {
	return [[self placesDetail] detail:errors].location;
}

@end
