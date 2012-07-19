//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailAddress.h"

@interface CGPlacesDetailAddress ()

@property (nonatomic, retain, readwrite) NSString* deliveryPoint;
@property (nonatomic, retain, readwrite) NSString* crossStreet;

@end

@implementation CGPlacesDetailAddress

@synthesize deliveryPoint = deliveryPoint_;
@synthesize crossStreet = crossStreet_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSString*) street city:(NSString*) city state:(NSString*) state zip:(NSString*) zip
	   deliveryPoint:(NSString*) deliveryPoint crossStreet:(NSString*) crossStreet {
	self = [super initImmutable:street city:city state:state zip:zip];
	
	if (self) {
		self.deliveryPoint = deliveryPoint;
		self.crossStreet = crossStreet;
	}
	
	return self;
}

- (void) dealloc {
	self.deliveryPoint = nil;
	self.crossStreet = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.deliveryPoint = [decoder decodeObjectForKey:@"deliveryPoint"];
		self.crossStreet = [decoder decodeObjectForKey:@"crossStreet"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	
	[encoder encodeObject:self.deliveryPoint forKey:@"deliveryPoint"];
	[encoder encodeObject:self.crossStreet forKey:@"crossStreet"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailAddress* copy = [super copyWithZone:zone];
	if (copy) {
		copy.deliveryPoint = [[self.deliveryPoint copyWithZone:zone] autorelease];
		copy.crossStreet = [[self.crossStreet copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailAddress:(CGPlacesDetailAddress*) other {
	return
	[super isEqualToAddress:other] &&
	[self isEqualWithNull:self.deliveryPoint other:other.deliveryPoint] &&
	[self isEqualWithNull:self.crossStreet other:other.crossStreet];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailAddress:other];
}

- (NSUInteger) hash {
	NSUInteger h = [super hash];
	h += [self.deliveryPoint hash];
	h += [self.crossStreet hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailAddress %@ deliveryPoint=%@,crossStreet=%@>",
			[super description], self.deliveryPoint, self.crossStreet];
}

@end
