//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import <SenTestingKit/SenTestingKit.h>

@class CGLocation;

@interface CGTBaseTests : SenTestCase

- (void) assertRegions:(NSArray*) regions parent:(NSString*) parent;
- (void) assertHistograms:(NSArray*) histograms parent:(NSString*) parent;
- (void) assertAddress:(id) address parent:(NSString*) parent;
- (void) assertLocation:(CGLocation*) location parent:(NSString*) parent assertAddress:(BOOL) assertAddress;

@end
