//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailOffer.h"

@interface CGPlacesDetailOffer ()

@property (nonatomic, retain, readwrite) NSString* name;
@property (nonatomic, retain, readwrite) NSString* text;
@property (nonatomic, retain, readwrite) NSString* offerDescription;
@property (nonatomic, retain, readwrite) NSURL* url;
@property (nonatomic, retain, readwrite) NSDate* expirationDate;

@end

@implementation CGPlacesDetailOffer

@synthesize name = name_;
@synthesize text = text_;
@synthesize offerDescription = offerDescription_;
@synthesize url = url_;
@synthesize expirationDate = expirationDate_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSString*) name text:(NSString*) text offerDescription:(NSString*) offerDescription
				 url:(NSURL*) url expirationDate:(NSDate*) expirationDate {
	self = [super init];
	
	if (self) {
		self.name = name;
		self.text = text;
		self.offerDescription = offerDescription;
		self.url = url;
		self.expirationDate = expirationDate;
	}
	
	return self;
}

- (void) dealloc {
	self.name = nil;
	self.text = nil;
	self.offerDescription = nil;
	self.url = nil;
	self.expirationDate = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.name = [decoder decodeObjectForKey:@"name"];
		self.text = [decoder decodeObjectForKey:@"text"];
		self.offerDescription = [decoder decodeObjectForKey:@"offerDescription"];
		self.url = [decoder decodeObjectForKey:@"url"];
		self.expirationDate = [decoder decodeObjectForKey:@"expirationDate"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.name forKey:@"name"];
	[encoder encodeObject:self.text forKey:@"text"];
	[encoder encodeObject:self.offerDescription forKey:@"offerDescription"];
	[encoder encodeObject:self.url forKey:@"url"];
	[encoder encodeObject:self.expirationDate forKey:@"expirationDate"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailOffer* copy = [super copyWithZone:zone];
	if (copy) {
		copy.name = [[self.name copyWithZone:zone] autorelease];
		copy.text = [[self.text copyWithZone:zone] autorelease];
		copy.offerDescription = [[self.offerDescription copyWithZone:zone] autorelease];
		copy.url = [[self.url copyWithZone:zone] autorelease];
		copy.expirationDate = [[self.expirationDate copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailOffer:(CGPlacesDetailOffer*) other {
	return
	[self isEqualWithNull:self.name other:other.name] &&
	[self isEqualWithNull:self.text other:other.text] &&
	[self isEqualWithNull:self.offerDescription other:other.offerDescription] &&
	[self isEqualWithNull:self.url other:other.url] &&
	[self isEqualWithNull:self.expirationDate other:other.expirationDate];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailOffer:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.name hash];
	h += [self.text hash];
	h += [self.offerDescription hash];
	h += [self.url hash];
	h += [self.expirationDate hash];
	return h;
}

- (NSString*) description {
	NSMutableString* description = [NSMutableString stringWithCapacity:64];
	[description appendString:@"<CGPlacesDetailOffer "];
	[description appendFormat:@"name=%@", self.name];
	[description appendFormat:@",text=%@", self.text];
	[description appendFormat:@",offerDescription=%@", self.offerDescription];
	[description appendFormat:@",url=%@", self.url];
	[description appendFormat:@",expirationDate=%@", self.expirationDate];
	[description appendString:@">"];
	return description;
}

@end
