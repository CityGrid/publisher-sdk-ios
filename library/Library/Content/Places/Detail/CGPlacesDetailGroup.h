//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGPlacesDetailGroup : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) NSInteger groupId;
@property (nonatomic, retain, readonly) NSString* name;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSInteger) groupId name:(NSString*) name;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailGroup:(CGPlacesDetailGroup*) other;

@end
