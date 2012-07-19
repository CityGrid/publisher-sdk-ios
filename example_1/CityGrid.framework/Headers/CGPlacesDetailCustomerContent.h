//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@class CGPlacesDetailCustomerMessage;

@interface CGPlacesDetailCustomerContent : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) CGPlacesDetailCustomerMessage* message;
@property (nonatomic, retain, readonly) NSArray* bullets; // NSString*
@property (nonatomic, retain, readonly) NSURL* url;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(CGPlacesDetailCustomerMessage*) message bullets:(NSArray*) bullets
  url:(NSURL*) url;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailCustomerContent:(CGPlacesDetailCustomerContent*) other;

@end
