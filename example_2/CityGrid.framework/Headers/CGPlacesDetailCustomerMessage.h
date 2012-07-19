//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGPlacesDetailCustomerMessage : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* message;
@property (nonatomic, retain, readonly) NSString* attributionText;
@property (nonatomic, retain, readonly) NSURL* attributionLogo;
@property (nonatomic, assign, readonly) NSInteger attributionSource;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSString*) message attributionText:(NSString*) attributionText attributionLogo:(NSURL*) attributionLogo
   attributionSource:(NSInteger) attributionSource;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailCustomerMessage:(CGPlacesDetailCustomerMessage*) other;

@end
