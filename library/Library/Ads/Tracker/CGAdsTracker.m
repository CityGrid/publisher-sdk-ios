//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import <UIKit/UIKit.h>
#import "CGAdsTracker.h"
#import "CGShared.h"
#import "CGConstants.h"

#define CGAdsTrackerUri @"ads/tracker/imp"

@implementation CGAdsTracker

@synthesize publisher = publisher_;
@synthesize actionTarget = actionTarget_;
@synthesize locationId = locationId_;
@synthesize referenceId = referenceId_;
@synthesize impressionId = impressionId_;
@synthesize placement = placement_;
@synthesize sourcePhone = sourcePhone_;
@synthesize dialPhone = dialPhone_;
@synthesize timeout = timeout_;

#pragma mark -
#pragma mark Lifecycle

- (id) init:(NSString*) publisher {
	self = [super init];
	
	if (self) {
		self.publisher = publisher;
		self.actionTarget = CGAdsTrackerActionTargetUnknown;
		self.locationId = CG_NSINTEGER_UNKNOWN;
		self.referenceId = CG_NSINTEGER_UNKNOWN;
		self.impressionId = nil;
		self.placement = nil;
		self.sourcePhone = nil;
		self.dialPhone = nil;
		self.timeout = [CGShared sharedInstance].timeout;
	}
	
	return self;
}

+ (id) adsTracker {
	return [[self class] adsTrackerWithPublisher:nil placement:nil];
}

+ (id) adsTrackerWithPublisher:(NSString*) publisher {
	return [[self class] adsTrackerWithPublisher:publisher placement:nil];
}

+ (id) adsTrackerWithPlacement:(NSString*) placement {
	return [[self class] adsTrackerWithPublisher:nil placement:placement];
}

+ (id) adsTrackerWithPublisher:(NSString*) publisher placement:(NSString*) placement {
	NSString* resolvedPublisher = publisher ? publisher : [CGShared sharedInstance].publisher;
	NSString* resolvedPlacement = placement ? placement : [CGShared sharedInstance].placement;
	
	CGAdsTracker* builder = [[[[self class] alloc] init:resolvedPublisher] autorelease];
	builder.placement = resolvedPlacement;
	return builder;
}

- (void) dealloc {
	self.publisher = nil;
	self.impressionId = nil;
	self.placement = nil;
	self.sourcePhone = nil;
	self.dialPhone = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.publisher = [decoder decodeObjectForKey:@"publisher"];
		self.actionTarget = [decoder decodeIntegerForKey:@"actionTarget"];
		self.locationId = [decoder decodeIntegerForKey:@"locationId"];
		self.referenceId = [decoder decodeIntegerForKey:@"referenceId"];
		self.impressionId = [decoder decodeObjectForKey:@"impressionId"];
		self.placement = [decoder decodeObjectForKey:@"placement"];
		self.sourcePhone = [decoder decodeObjectForKey:@"sourcePhone"];
		self.dialPhone = [decoder decodeObjectForKey:@"dialPhone"];
		self.timeout = [decoder decodeDoubleForKey:@"timeout"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeObject:self.publisher forKey:@"publisher"];
	[encoder encodeInteger:self.actionTarget forKey:@"actionTarget"];
	[encoder encodeInteger:self.locationId forKey:@"locationId"];
	[encoder encodeInteger:self.referenceId forKey:@"referenceId"];
	[encoder encodeObject:self.impressionId forKey:@"impressionId"];
	[encoder encodeObject:self.placement forKey:@"placement"];
	[encoder encodeObject:self.sourcePhone forKey:@"sourcePhone"];
	[encoder encodeObject:self.dialPhone forKey:@"dialPhone"];
	[encoder encodeDouble:self.timeout forKey:@"timeout"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGAdsTracker* copy = [super copyWithZone:zone];
	if (copy) {
		copy.publisher = [[self.publisher copyWithZone:zone] autorelease];
		copy.actionTarget = self.actionTarget;
		copy.locationId = self.locationId;
		copy.referenceId = self.referenceId;
		copy.impressionId = [[self.impressionId copyWithZone:zone] autorelease];
		copy.placement = [[self.placement copyWithZone:zone] autorelease];
		copy.sourcePhone = [[self.sourcePhone copyWithZone:zone] autorelease];
		copy.dialPhone = [[self.dialPhone copyWithZone:zone] autorelease];
		copy.timeout = self.timeout;
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToAdsTracker:(CGAdsTracker*) other {
	return
	[self isEqualWithNull:self.publisher other:other.publisher] &&
	self.locationId == other.locationId &&
	self.referenceId == other.referenceId &&
	[self isEqualWithNull:self.impressionId other:other.impressionId] &&
	[self isEqualWithNull:self.placement other:other.placement] &&
	[self isEqualWithNull:self.sourcePhone other:other.sourcePhone] &&
	[self isEqualWithNull:self.dialPhone other:other.dialPhone] &&
	self.timeout == other.timeout;
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToAdsTracker:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += [self.publisher hash];
	h += self.locationId;
	h += self.referenceId;
	h += [self.impressionId hash];
	h += [self.placement hash];
	h += [self.sourcePhone hash];
	h += [self.dialPhone hash];
	h += (NSUInteger) self.timeout;
	return h;
}

- (NSString*) description {
	NSMutableString* description = [[NSMutableString alloc] initWithCapacity:64];
	[description appendString:@"<CGAdsTracker "];
	[description appendFormat:@"actionTarget=%i", self.actionTarget];
	[description appendFormat:@"publisher=%@", self.publisher];
	[description appendFormat:@"locationId=%i", self.locationId];
	[description appendFormat:@"referenceId=%i", self.referenceId];
	[description appendFormat:@",impressionId=%@", self.impressionId];
	[description appendFormat:@",placement=%@", self.placement];
	[description appendFormat:@",sourcePhone=%@", self.sourcePhone];
	[description appendFormat:@",dialPhone=%@", self.dialPhone];
	[description appendFormat:@",timeout=%f", self.timeout];
	[description appendString:@">"];
	return [description autorelease];
}

#pragma mark -
#pragma mark Actions

- (NSArray*) validate {
	NSMutableArray* errors = [[NSMutableArray alloc] initWithCapacity:0];
	
	if ([self.publisher length] == 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumPublisherRequired]];
	}
	if (self.actionTarget == CGAdsTrackerActionTargetUnknown) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumActionTargetRequired]];
	}
	if (self.locationId == CG_NSINTEGER_UNKNOWN) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumLocationIdRequired]];
	}
	if (self.referenceId == CG_NSINTEGER_UNKNOWN) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumReferenceIdRequired]];
	}
	if (self.actionTarget == CGAdsTrackerActionTargetClickToCall && [self.dialPhone length] == 0) {
		[errors addObject:[[CGShared sharedInstance] errorWithErrorNum:CGErrorNumDialPhoneRequired]];
	}
	
	[errors autorelease];
	return [errors count] == 0 ? nil : errors;
}

- (NSString*) parameterForActionTarget:(CGAdsTrackerActionTarget) actionTarget {
	NSString* parameter = nil;
	switch (actionTarget) {
		case CGAdsTrackerActionTargetListingProfile:
			parameter = @"listing_profile";
			break;
		case CGAdsTrackerActionTargetClickToCall:
			parameter = @"click_to_call";
			break;
		case CGAdsTrackerActionTargetListingProfilePrint:
			parameter = @"listing_profile_print";
			break;
		case CGAdsTrackerActionTargetListingWebsite:
			parameter = @"listing_website";
			break;
		case CGAdsTrackerActionTargetListingReview:
			parameter = @"listing_review";
			break;
		case CGAdsTrackerActionTargetWriteReview:
			parameter = @"write_review";
			break;
		case CGAdsTrackerActionTargetListingMap:
			parameter = @"listing_map";
			break;
		case CGAdsTrackerActionTargetListingDrivingDirection:
			parameter = @"listing_driving_direction";
			break;
		case CGAdsTrackerActionTargetListingMapPrint:
			parameter = @"listing_map_print";
			break;
		case CGAdsTrackerActionTargetSendListingEmail:
			parameter = @"send_listing_email";
			break;
		case CGAdsTrackerActionTargetSendListingPhone:
			parameter = @"send_listing_phone";
			break;
		case CGAdsTrackerActionTargetSendListingGps:
			parameter = @"send_listing_gps";
			break;
		case CGAdsTrackerActionTargetOffer:
			parameter = @"offer";
			break;
		case CGAdsTrackerActionTargetOfferPrint:
			parameter = @"offer_print";
			break;
		case CGAdsTrackerActionTargetListingRequestOffer:
			parameter = @"listing_request_offer";
			break;
		case CGAdsTrackerActionTargetPartnerMenu:
			parameter = @"partner_menu";
			break;
		case CGAdsTrackerActionTargetPartnerReservation:
			parameter = @"partner_reservation";
			break;
		case CGAdsTrackerActionTargetListingPhoto:
			parameter = @"listing_photo";
			break;
		case CGAdsTrackerActionTargetUploadListingPhoto:
			parameter = @"upload_listing_photo";
			break;
		case CGAdsTrackerActionTargetListingBlog:
			parameter = @"listing_blog";
			break;
		case CGAdsTrackerActionTargetListingForums:
			parameter = @"listing_forums";
			break;
		case CGAdsTrackerActionTargetListingNewsletters:
			parameter = @"listing_newsletters";
			break;
		case CGAdsTrackerActionTargetListingVote:
			parameter = @"listing_vote";
			break;
		case CGAdsTrackerActionTargetListingCorrection:
			parameter = @"listing_correction";
			break;
		case CGAdsTrackerActionTargetListingBookmark:
			parameter = @"listing_bookmark";
			break;
		default:
			break;
	}
	return parameter;
}

- (NSDictionary*) build {
	NSMutableDictionary* parameters = [[NSMutableDictionary alloc] initWithCapacity:10];
	if ([self.publisher length] > 0) {
		[parameters setObject:self.publisher forKey:@"publisher"];
	}
	if (self.actionTarget != CGAdsTrackerActionTargetUnknown) {
		[parameters setObject:[self parameterForActionTarget:self.actionTarget] forKey:@"action_target"];
	}
	if (self.locationId != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.locationId] forKey:@"listing_id"];
	}
	if (self.referenceId != CG_NSINTEGER_UNKNOWN) {
		[parameters setObject:[NSString stringWithFormat:@"%i", self.referenceId] forKey:@"reference_id"];
	}
	if ([self.placement length] > 0) {
		[parameters setObject:self.placement forKey:@"placement"];
	}
	if ([self.impressionId length] > 0) {
		[parameters setObject:self.impressionId forKey:@"i"];
	}
	if ([self.sourcePhone length] > 0) {
		[parameters setObject:self.sourcePhone forKey:@"sourcePhone"];
	}
	if ([self.dialPhone length] > 0) {
		[parameters setObject:self.dialPhone forKey:@"dialPhone"];
	}
	[parameters setObject:[[UIDevice currentDevice] model] forKey:@"mobile_type"];
	[parameters setObject:[[UIDevice currentDevice] uniqueIdentifier] forKey:@"muid"];
	[parameters setObject:@"json" forKey:@"format"];
	
	return [parameters autorelease];
}

- (NSArray*) track {
	NSArray* errors = [self validate];
	if (errors) {
		return errors;
	}
	
	NSURL* url = [[CGShared sharedInstance].url URLByAppendingPathComponent:CGAdsTrackerUri];
	NSDictionary* parameters = [self build];
	
	NSDictionary* parsed = [[CGShared sharedInstance] sendSynchronousRequest:url parameters:parameters timeout:self.timeout errors:&errors];
	if (errors) {
		return errors;
	}
	
	return nil;
}

@end
