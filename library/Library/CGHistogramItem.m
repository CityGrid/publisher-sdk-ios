//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGHistogramItem.h"

@interface CGHistogramItem ()

@property (nonatomic, retain, readwrite) NSString* name;
@property (nonatomic, assign, readwrite) NSInteger count;
@property (nonatomic, retain, readwrite) NSURL* uri;
@property (nonatomic, retain, readwrite) NSArray* tagIds;

@end

@implementation CGHistogramItem

@synthesize name = name_;
@synthesize count = count_;
@synthesize uri = uri_;
@synthesize tagIds = tagIds_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSString*) name count:(NSInteger) count uri:(NSURL*) uri tagIds:(NSArray*) tagIds {
	self = [super init];
	
	if (self) {
		self.name = name;
		self.count = count;
		self.uri = uri;
		self.tagIds = tagIds;
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;
	self.uri = nil;
	self.tagIds = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.name = [decoder decodeObjectForKey:@"name"];
		self.count = [decoder decodeIntegerForKey:@"count"];
		self.uri = [decoder decodeObjectForKey:@"uri"];
		self.tagIds = [decoder decodeObjectForKey:@"tagIds"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeInteger:self.count forKey:@"count"];
	[encoder encodeObject:self.uri forKey:@"uri"];
	[encoder encodeObject:self.tagIds forKey:@"tagIds"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGHistogramItem* copy = [super copyWithZone:zone];
	if (copy) {
		copy.name = [[self.name copyWithZone:zone] autorelease];
		copy.count = self.count;
		copy.uri = [[self.uri copyWithZone:zone] autorelease];
		copy.tagIds = [[self.tagIds copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToHistogramItem:(CGHistogramItem*) other {
	return
	[self isEqualWithNull:self.name other:other.name] &&
	self.count == other.count &&
	[self isEqualWithNull:self.uri other:other.uri] &&
	[self isEqualWithNull:self.tagIds other:other.tagIds];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToHistogramItem:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.name hash];
	h += self.count;
	h += [self.uri hash];
	h += [self.tagIds hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGHistogramItem name=%@,count=%i,uri=%@,tagIds=%@>", self.name, self.count, self.uri, self.tagIds];
}

@end
