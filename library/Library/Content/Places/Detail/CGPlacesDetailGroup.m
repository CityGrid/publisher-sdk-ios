//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailGroup.h"

@interface CGPlacesDetailGroup ()

@property (nonatomic, assign, readwrite) NSInteger groupId;
@property (nonatomic, retain, readwrite) NSString* name;

@end

@implementation CGPlacesDetailGroup

@synthesize groupId = groupId_;
@synthesize name = name_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSInteger) groupId name:(NSString*) name {
	self = [super init];
	
	if (self) {
		self.groupId = groupId;
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
		self.groupId = [decoder decodeIntegerForKey:@"groupId"];
		self.name = [decoder decodeObjectForKey:@"name"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeInteger:self.groupId forKey:@"groupId"];
	[encoder encodeObject:self.name forKey:@"name"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailGroup* copy = [super copyWithZone:zone];
	if (copy) {
		copy.groupId = self.groupId;
		copy.name = [[self.name copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailGroup:(CGPlacesDetailGroup*) other {
	return
	self.groupId == other.groupId &&
	[self isEqualWithNull:self.name other:other.name];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailGroup:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += self.groupId;
	h += [self.name hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailGroup groupId=%i,name=%@>", self.groupId, self.name];
}

@end
