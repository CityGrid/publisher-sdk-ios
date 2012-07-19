//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGPlacesDetailUrls : CGObject

#pragma mark -
#pragma mark Properties

// All URL's have had the referenceId, publisher, placement and impressionId appended as parameters

@property (nonatomic, retain, readonly) NSURL* profile;
@property (nonatomic, retain, readonly) NSURL* reviews;
@property (nonatomic, retain, readonly) NSURL* video;
@property (nonatomic, retain, readonly) NSURL* website;
@property (nonatomic, retain, readonly) NSURL* menu;
@property (nonatomic, retain, readonly) NSURL* reservation;
@property (nonatomic, retain, readonly) NSURL* map;
@property (nonatomic, retain, readonly) NSURL* sendToFriend;
@property (nonatomic, retain, readonly) NSURL* email;
@property (nonatomic, retain, readonly) NSURL* custom1;
@property (nonatomic, retain, readonly) NSURL* custom2;
@property (nonatomic, retain, readonly) NSURL* orderUrl;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSURL*) profile reviews:(NSURL*) reviews video:(NSURL*) video
		  website:(NSURL*) website menu:(NSURL*) menu reservation:(NSURL*) reservation
			  map:(NSURL*) map sendToFriend:(NSURL*) sendToFriend email:(NSURL*) email
             custom1:(NSURL*) custom1 custom2:(NSURL*) custom2 orderUrl:(NSURL*) orderUrl;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailUrls:(CGPlacesDetailUrls*) other;

@end
