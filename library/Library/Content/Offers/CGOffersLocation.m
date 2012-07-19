//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGOffersLocation.h"

@interface CGOffersLocation ()

@property (nonatomic, retain, readwrite) NSString* businessHours;
@property (nonatomic, retain, readwrite) NSArray* tags; // CGTag*

@end

@implementation CGOffersLocation

@synthesize businessHours = businessHours_;
@synthesize tags = tags_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSUInteger) locationId impressionId:(NSString*) impressionId name:(NSString*) name
			 address:(id) address latlon:(CLLocation*) latlon image:(NSURL*) image phone:(NSString*) phone
			  rating:(NSUInteger) rating businessHours:(NSString*) businessHours tags:(NSArray*) tags {
	self = [super initImmutable:locationId impressionId:impressionId name:name
						address:address latlon:latlon image:image phone:phone rating:rating];
	
	if (self) {
		self.businessHours = businessHours;
		self.tags = tags;
	}
	
	return self;
}

- (void) dealloc {
	self.businessHours = nil;
	self.tags = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.businessHours = [decoder decodeObjectForKey:@"businessHours"];
		self.tags = [decoder decodeObjectForKey:@"tags"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	
	[encoder encodeObject:self.businessHours forKey:@"businessHours"];
	[encoder encodeObject:self.tags forKey:@"tags"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGOffersLocation* copy = [super copyWithZone:zone];
	if (copy) {
		copy.businessHours = [[self.businessHours copyWithZone:zone] autorelease];
		copy.tags = [[self.tags copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToOffersLocation:(CGOffersLocation*) other {
	return
	[super isEqualToLocation:other] &&
	[super isEqualWithNull:self.businessHours other:other.businessHours] &&
	[self isEqualWithNull:self.tags other:other.tags];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToOffersLocation:other];
}

- (NSUInteger) hash {
	NSUInteger h = [super hash];
	h += [self.businessHours hash];
	h += [self.tags hash];
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendFormat:@"<CGOffersLocation %@ ", [super description]];
	[description appendFormat:@",businessHours=%@", self.businessHours];
	[description appendFormat:@",tags=%@", self.tags];
	[description appendString:@">"];
	return [description autorelease];
}

@end
