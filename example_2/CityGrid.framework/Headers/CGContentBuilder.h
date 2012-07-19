//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGBuilder.h"

@interface CGContentBuilder : CGBuilder

- (NSArray*) processRegions:(NSArray*) parsedRegions;
- (id) processLocationAddress:(NSDictionary*) parsedAddress useZip:(BOOL) useZip;
- (void) appendParameter:(NSMutableString*) urlString key:(NSString*) key value:(NSString*) value;
- (NSURL*) handleUrlFields:(NSURL*) original publisher:(NSString*) publisher impressionId:(NSString*) impressionId placement:(NSString*) placement;
- (NSArray*) processTags:(NSArray*) parsedTags;
- (NSArray*) processTagIds:(NSArray*) parsedTagIds;
- (NSArray*) processHistogramItems:(NSArray*) parsedItems;
- (NSArray*) processHistograms:(NSArray*) parsedHistograms;

@end
