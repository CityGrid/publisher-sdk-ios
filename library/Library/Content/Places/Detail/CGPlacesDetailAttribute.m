//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailAttribute.h"

@interface CGPlacesDetailAttribute ()

@property (nonatomic, assign, readwrite) NSInteger attributeId;
@property (nonatomic, retain, readwrite) NSString* name;
@property (nonatomic, retain, readwrite) NSString* value;

@end

@implementation CGPlacesDetailAttribute

@synthesize attributeId = attributeId_;
@synthesize name = name_;
@synthesize value = value_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSInteger) attributeId name:(NSString*) name value:(NSString*) value {
	self = [super init];
	
	if (self) {
		self.attributeId = attributeId;
		self.name = name;
		self.value = value;
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;
	self.value = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.attributeId = [decoder decodeIntegerForKey:@"attributeId"];
		self.name = [decoder decodeObjectForKey:@"name"];
		self.value = [decoder decodeObjectForKey:@"value"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeInteger:self.attributeId forKey:@"attributeId"];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.value forKey:@"value"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailAttribute* copy = [super copyWithZone:zone];
	if (copy) {
		copy.attributeId = self.attributeId;
		copy.name = [[self.name copyWithZone:zone] autorelease];
		copy.value = [[self.value copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailAttribute:(CGPlacesDetailAttribute*) other {
	return
	self.attributeId == other.attributeId &&
	[self isEqualWithNull:self.name other:other.name] &&
	[self isEqualWithNull:self.value other:other.value];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailAttribute:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += self.attributeId;
	h += [self.name hash];
	h += [self.value hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailAttribute attributeId=%i,name=%@,value=%@>",
			self.attributeId, self.name, self.value];
}

@end
