//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailCategory.h"
#import "CGPlacesDetailGroup.h"

@interface CGPlacesDetailCategory ()

@property (nonatomic, assign, readwrite) NSInteger categoryId;
@property (nonatomic, retain, readwrite) NSString* name;
@property (nonatomic, assign, readwrite) NSInteger parentId;
@property (nonatomic, retain, readwrite) NSString* parent;
@property (nonatomic, retain, readwrite) NSArray* groups;

@end

@implementation CGPlacesDetailCategory

@synthesize categoryId = categoryId_;
@synthesize name = name_;
@synthesize parentId = parentId_;
@synthesize parent = parent_;
@synthesize groups = groups_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSInteger) categoryId name:(NSString*) name parentId:(NSInteger) parentId
			  parent:(NSString*) parent groups:(NSArray*) groups {
	self = [super init];
	
	if (self) {
		self.categoryId = categoryId;
		self.name = name;
		self.parentId = parentId;
		self.parent = parent;
		self.groups = groups;
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;
	self.parent = nil;
	self.groups = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.categoryId = [decoder decodeIntegerForKey:@"categoryId"];
		self.name = [decoder decodeObjectForKey:@"name"];
		self.parentId = [decoder decodeIntegerForKey:@"parentId"];
		self.parent = [decoder decodeObjectForKey:@"parent"];
		self.groups = [decoder decodeObjectForKey:@"groups"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeInteger:self.categoryId forKey:@"categoryId"];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeInteger:self.parentId forKey:@"parentId"];
	[encoder encodeObject:self.parent forKey:@"parent"];
	[encoder encodeObject:self.groups forKey:@"groups"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailCategory* copy = [super copyWithZone:zone];
	if (copy) {
		copy.categoryId = self.categoryId;
		copy.name = [[self.name copyWithZone:zone] autorelease];
		copy.parentId = self.parentId;
		copy.parent = [[self.parent copyWithZone:zone] autorelease];
		copy.groups = [[self.groups copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailCategory:(CGPlacesDetailCategory*) other {
	return
	self.categoryId == other.categoryId &&
	[self isEqualWithNull:self.name other:other.name] &&
	self.parentId == other.parentId &&
	[self isEqualWithNull:self.parent other:other.parent] &&
	[self isEqualWithNull:self.groups other:other.groups];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailCategory:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += self.categoryId;
	h += [self.name hash];
	h += self.parentId;
	h += [self.parent hash];
	h += [self.groups hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailCategory categoryId=%i,name=%@,parentId=%i,parent=%@,groups=%@>",
			self.categoryId, self.name, self.parentId, self.parent, self.groups];
}

@end
