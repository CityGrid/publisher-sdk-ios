//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGPlacesDetailUrls.h"

@interface CGPlacesDetailUrls ()

@property (nonatomic, retain, readwrite) NSURL* profile;
@property (nonatomic, retain, readwrite) NSURL* reviews;
@property (nonatomic, retain, readwrite) NSURL* video;
@property (nonatomic, retain, readwrite) NSURL* website;
@property (nonatomic, retain, readwrite) NSURL* menu;
@property (nonatomic, retain, readwrite) NSURL* reservation;
@property (nonatomic, retain, readwrite) NSURL* map;
@property (nonatomic, retain, readwrite) NSURL* sendToFriend;
@property (nonatomic, retain, readwrite) NSURL* email;
@property (nonatomic, retain, readwrite) NSURL* custom1;
@property (nonatomic, retain, readwrite) NSURL* custom2;
@property (nonatomic, retain, readwrite) NSURL* orderUrl;

@end

@implementation CGPlacesDetailUrls

@synthesize profile = profile_;
@synthesize reviews = reviews_;
@synthesize video = video_;
@synthesize website = website_;
@synthesize menu = menu_;
@synthesize reservation = reservation_;
@synthesize map = map_;
@synthesize sendToFriend = sendToFriend_;
@synthesize email = email_;
@synthesize custom1 = custom1_;
@synthesize custom2 = custom2_;
@synthesize orderUrl = orderUrl_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSURL*) profile reviews:(NSURL*) reviews video:(NSURL*) video
			 website:(NSURL*) website menu:(NSURL*) menu reservation:(NSURL*) reservation
				 map:(NSURL*) map sendToFriend:(NSURL*) sendToFriend email:(NSURL*) email
			 custom1:(NSURL*) custom1 custom2:(NSURL*) custom2 orderUrl:(NSURL *)orderUrl{
	self = [super init];
	
	if (self) {
		self.profile = profile;
		self.reviews = reviews;
		self.video = video;
		self.website = website;
		self.menu = menu;
		self.reservation = reservation;
		self.map = map;
		self.sendToFriend = sendToFriend;
		self.email = email;
		self.custom1 = custom1;
		self.custom2 = custom2;
        self.orderUrl = orderUrl;
	}
	
	return self;
}

- (void) dealloc {
	self.profile = nil;
	self.reviews = nil;
	self.video = nil;
	self.website = nil;
	self.menu = nil;
	self.reservation = nil;
	self.map = nil;
	self.sendToFriend = nil;
	self.email = nil;
	self.custom1 = nil;
	self.custom2 = nil;
    self.orderUrl = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.profile = [decoder decodeObjectForKey:@"profile"];
		self.reviews = [decoder decodeObjectForKey:@"reviews"];
		self.video = [decoder decodeObjectForKey:@"video"];
		self.website = [decoder decodeObjectForKey:@"website"];
		self.menu = [decoder decodeObjectForKey:@"menu"];
		self.reservation = [decoder decodeObjectForKey:@"reservation"];
		self.map = [decoder decodeObjectForKey:@"map"];
		self.sendToFriend = [decoder decodeObjectForKey:@"sendToFriend"];
		self.email = [decoder decodeObjectForKey:@"email"];
		self.custom1 = [decoder decodeObjectForKey:@"custom1"];
		self.custom2 = [decoder decodeObjectForKey:@"custom2"];
        self.orderUrl = [decoder decodeObjectForKey:@"orderUrl"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.profile forKey:@"profile"];
	[encoder encodeObject:self.reviews forKey:@"reviews"];
	[encoder encodeObject:self.video forKey:@"video"];
	[encoder encodeObject:self.website forKey:@"website"];
	[encoder encodeObject:self.menu forKey:@"menu"];
	[encoder encodeObject:self.reservation forKey:@"reservation"];
	[encoder encodeObject:self.map forKey:@"map"];
	[encoder encodeObject:self.sendToFriend forKey:@"sendToFriend"];
	[encoder encodeObject:self.email forKey:@"email"];
	[encoder encodeObject:self.custom1 forKey:@"custom1"];
	[encoder encodeObject:self.custom2 forKey:@"custom2"];
    [encoder encodeObject:self.orderUrl forKey:@"orderUrl"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGPlacesDetailUrls* copy = [super copyWithZone:zone];
	if (copy) {
		copy.profile = [[self.profile copyWithZone:zone] autorelease];
		copy.reviews = [[self.reviews copyWithZone:zone] autorelease];
		copy.video = [[self.video copyWithZone:zone] autorelease];
		copy.website = [[self.website copyWithZone:zone] autorelease];
		copy.menu = [[self.menu copyWithZone:zone] autorelease];
		copy.reservation = [[self.reservation copyWithZone:zone] autorelease];
		copy.map = [[self.map copyWithZone:zone] autorelease];
		copy.sendToFriend = [[self.sendToFriend copyWithZone:zone] autorelease];
		copy.email = [[self.email copyWithZone:zone] autorelease];
		copy.custom1 = [[self.custom1 copyWithZone:zone] autorelease];
		copy.custom2 = [[self.custom2 copyWithZone:zone] autorelease];
        copy.orderUrl = [[self.orderUrl copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailUrls:(CGPlacesDetailUrls*) other {
	return
	[self isEqualWithNull:self.profile other:other.profile] &&
	[self isEqualWithNull:self.reviews other:other.reviews] &&
	[self isEqualWithNull:self.video other:other.video] &&
	[self isEqualWithNull:self.website other:other.website] &&
	[self isEqualWithNull:self.menu other:other.menu] &&
	[self isEqualWithNull:self.reservation other:other.reservation] &&
	[self isEqualWithNull:self.map other:other.map] &&
	[self isEqualWithNull:self.sendToFriend other:other.sendToFriend] &&
	[self isEqualWithNull:self.email other:other.email] &&
	[self isEqualWithNull:self.custom1 other:other.custom1] &&
	[self isEqualWithNull:self.custom2 other:other.custom2] &&
    [self isEqualWithNull:self.orderUrl other:other.orderUrl];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToPlacesDetailUrls:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.profile hash];
	h += [self.reviews hash];
	h += [self.video hash];
	h += [self.website hash];
	h += [self.menu hash];
	h += [self.reservation hash];
	h += [self.map hash];
	h += [self.sendToFriend hash];
	h += [self.email hash];
	h += [self.custom1 hash];
	h += [self.custom2 hash];
    h += [self.orderUrl hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesDetailUrls profile=%@,reviews=%@,video=%@,website=%@,menu=%@,reservation=%@,map=%@,sendToFriend=%@,email=%@,custom1=%@,custom2=%@>, orderUrl=%@",
			self.profile, self.reviews, self.video, self.website, self.menu, self.reservation, self.map, self.sendToFriend, self.email, self.custom1, self.custom2, self.orderUrl];
}

@end
