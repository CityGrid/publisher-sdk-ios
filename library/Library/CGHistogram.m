//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGHistogram.h"

@interface CGHistogram ()

@property (nonatomic, retain, readwrite) NSString* name;
@property (nonatomic, retain, readwrite) NSArray* items; // CGHistogramItem

@end

@implementation CGHistogram

@synthesize name = name_;
@synthesize items = items_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSString*) name items:(NSArray*) items {
	self = [super init];
	
	if (self) {
		self.name = name;
		self.items = items;
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;
	self.items = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.name = [decoder decodeObjectForKey:@"name"];
		self.items = [decoder decodeObjectForKey:@"items"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.items forKey:@"items"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGHistogram* copy = [[[self class] allocWithZone:zone] init];
	if (copy) {
		copy.name = [[self.name copyWithZone:zone] autorelease];
		copy.items = [[self.items copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToHistogram:(CGHistogram*) other {
	return
	[self isEqualWithNull:self.name other:other.name] &&
	[self isEqualWithNull:self.items other:other.items];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToHistogram:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.name hash];
	h += [self.items hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGHistogram name=%@,items=%@>", self.name, self.items];
}

@end
