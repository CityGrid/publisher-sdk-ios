//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGTag.h"

@interface CGTag ()

@property (nonatomic, assign, readwrite) NSInteger tagId;
@property (nonatomic, retain, readwrite) NSString* name;

@end

@implementation CGTag

@synthesize tagId = tagId_;
@synthesize name = name_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSInteger) tagId name:(NSString*) name {
	self = [super init];
	
	if (self) {
		self.tagId = tagId;
		self.name = name;
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.tagId = [decoder decodeIntegerForKey:@"tagId"];
		self.name = [decoder decodeObjectForKey:@"name"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeInteger:self.tagId forKey:@"tagId"];
	[encoder encodeObject:self.name forKey:@"name"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGTag* copy = [super copyWithZone:zone];
	if (copy) {
		copy.tagId = self.tagId;
		copy.name = [[self.name copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToTag:(CGTag*) other {
	return
	self.tagId == other.tagId &&
	[self isEqualWithNull:self.name other:other.name];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToTag:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += self.tagId;
	h += [self.name hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGTag tagId=%i,name=%@>", self.tagId, self.name];
}

@end
