//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGAddress.h"

@interface CGAddress ()

@property (nonatomic, retain, readwrite) NSString* street;
@property (nonatomic, retain, readwrite) NSString* city;
@property (nonatomic, retain, readwrite) NSString* state;
@property (nonatomic, retain, readwrite) NSString* zip;

@end

@implementation CGAddress

@synthesize street = street_;
@synthesize city = city_;
@synthesize state = state_;
@synthesize zip = zip_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSString*) street city:(NSString*) city state:(NSString*) state zip:(NSString*) zip {
	self = [super init];
	
	if (self) {
		self.street = street;
		self.city = city;
		self.state = state;
		self.zip = zip;
	}
	
	return self;
}

- (void) dealloc {
	self.street = nil;
	self.city = nil;
	self.state = nil;
	self.zip = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.street = [decoder decodeObjectForKey:@"street"];
		self.city = [decoder decodeObjectForKey:@"city"];
		self.state = [decoder decodeObjectForKey:@"state"];
		self.zip = [decoder decodeObjectForKey:@"zip"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.street forKey:@"street"];
	[encoder encodeObject:self.city forKey:@"city"];
	[encoder encodeObject:self.state forKey:@"state"];
	[encoder encodeObject:self.zip forKey:@"zip"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGAddress* copy = [super copyWithZone:zone];
	if (copy) {
		copy.street = [[self.street copyWithZone:zone] autorelease];
		copy.city = [[self.city copyWithZone:zone] autorelease];
		copy.state = [[self.state copyWithZone:zone] autorelease];
		copy.zip = [[self.zip copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAddress:(CGAddress*) other {
	return
	[self isEqualWithNull:self.street other:other.street] &&
	[self isEqualWithNull:self.city other:other.city] &&
	[self isEqualWithNull:self.state other:other.state] &&
	[self isEqualWithNull:self.zip other:other.zip];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToAddress:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.street hash];
	h += [self.city hash];
	h += [self.state hash];
	h += [self.zip hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGAddress street=%@,city=%@,state=%@,zip=%@>", self.street, self.city, self.state, self.zip];
}

@end
