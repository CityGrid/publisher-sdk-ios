//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailTip.h"

@interface CGPlacesDetailTip ()

@property (nonatomic, retain, readwrite) NSString* name;
@property (nonatomic, retain, readwrite) NSString* text;

@end

@implementation CGPlacesDetailTip

@synthesize name = name_;
@synthesize text = text_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSString*) name text:(NSString*) text {
	self = [super init];
	
	if (self) {
		self.name = name;
		self.text = text;
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;
	self.text = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.name = [decoder decodeObjectForKey:@"name"];
		self.text = [decoder decodeObjectForKey:@"text"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.text forKey:@"text"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailTip* copy = [super copyWithZone:zone];
	if (copy) {
		copy.name = [[self.name copyWithZone:zone] autorelease];
		copy.text = [[self.text copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailTip:(CGPlacesDetailTip*) other {
	return
	[self isEqualWithNull:self.name other:other.name] &&
	[self isEqualWithNull:self.text other:other.text];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailTip:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.name hash];
	h += [self.text hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailTip name=%@,text=%@>", self.name, self.text];
}

@end
