//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGRegion.h"

@interface CGRegion ()

@property (nonatomic, retain, readwrite) NSString* type;
@property (nonatomic, retain, readwrite) NSString* name;
@property (nonatomic, retain, readwrite) CLLocation* latlon;
@property (nonatomic, assign, readwrite) Float32 radius;

@end

@implementation CGRegion

@synthesize type = type_;
@synthesize name = name_;
@synthesize latlon = latlon_;
@synthesize radius = radius_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSString*) type name:(NSString*) name latlon:(CLLocation*) latlon
			  radius:(Float32) radius {
	self = [super init];
	
	if (self) {
		self.type = type;
		self.name = name;
		self.latlon = latlon;
		self.radius = radius;
	}
	
	return self;
}

- (void) dealloc {
	self.type = nil;
	self.name = nil;
	self.latlon = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.type = [decoder decodeObjectForKey:@"type"];
		self.name = [decoder decodeObjectForKey:@"name"];
		self.latlon = [decoder decodeObjectForKey:@"latlon"];
		self.radius = [decoder decodeFloatForKey:@"radius"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.type forKey:@"type"];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.latlon forKey:@"latlon"];
	[encoder encodeFloat:self.radius forKey:@"radius"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGRegion* copy = [super copyWithZone:zone];
	if (copy) {
		copy.type = [[self.type copyWithZone:zone] autorelease];
		copy.name = [[self.name copyWithZone:zone] autorelease];
		copy.latlon = [[self.latlon copyWithZone:zone] autorelease];
		copy.radius = self.radius;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToRegion:(CGRegion*) other {
	return
	[self isEqualWithNull:self.type other:other.type] &&
	[self isEqualWithNull:self.name other:other.name] &&
	[self isEqualCoordinates:self.latlon other:other.latlon] &&
	self.radius == other.radius;
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToRegion:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.type hash];
	h += [self.name hash];
	h += [self.latlon hash];
	h += (NSUInteger) self.radius;
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGRegion type=%@,name=%@,latlon=%@,radius=%f>",
			self.type, self.name, self.latlon, self.radius];
}

@end
