//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGObject.h"

@interface CGPlacesDetailTip : CGObject

#pragma mark -
#pragma mark Properties

@property (nonatomic, retain, readonly) NSString* name;
@property (nonatomic, retain, readonly) NSString* text;

#pragma mark -
#pragma mark Initialization

- (id) initImmutable:(NSString*) name text:(NSString*) text;

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToPlacesDetailTip:(CGPlacesDetailTip*) other;

@end
