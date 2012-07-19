//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGPlacesDetailAttribute : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, assign, readonly) NSInteger attributeId;
@property (nonatomic, retain, readonly) NSString* name;
@property (nonatomic, retain, readonly) NSString* value;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSInteger) attributeId name:(NSString*) name value:(NSString*) value;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailAttribute:(CGPlacesDetailAttribute*) other;

@end
