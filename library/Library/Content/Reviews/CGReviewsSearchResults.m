//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGReviewsSearchResults.h"

@interface CGReviewsSearchResults ()

@property (nonatomic, assign, readwrite) NSInteger firstHit;
@property (nonatomic, assign, readwrite) NSInteger lastHit;
@property (nonatomic, assign, readwrite) NSInteger totalHits;
@property (nonatomic, assign, readwrite) NSInteger page;
@property (nonatomic, assign, readwrite) NSInteger resultsPerPage;
@property (nonatomic, retain, readwrite) NSURL* uri;
@property (nonatomic, retain, readwrite) NSString* didYouMean;
@property (nonatomic, retain, readwrite) NSArray* regions; // CGSearchRegion
@property (nonatomic, retain, readwrite) NSArray* reviews; // CGReviewsSearchReview
@property (nonatomic, retain, readwrite) NSArray* histograms; // CGSearchHistogram

@end

@implementation CGReviewsSearchResults

@synthesize firstHit = firstHit_;
@synthesize lastHit = lastHit_;
@synthesize totalHits = totalHits_;
@synthesize page = page_;
@synthesize resultsPerPage = resultsPerPage_;
@synthesize uri = uri_;
@synthesize didYouMean = didYouMean_;
@synthesize regions = regions_;
@synthesize reviews = reviews_;
@synthesize histograms = histograms_;

#pragma mark -
#pragma mark Lifecycle

- (id) initImmutable:(NSInteger) firstHit lastHit:(NSInteger) lastHit totalHits:(NSInteger) totalHits
				page:(NSInteger) page resultsPerPage:(NSInteger) resultsPerPage uri:(NSURL*) uri
		  didYouMean:(NSString*) didYouMean regions:(NSArray*) regions reviews:(NSArray*) reviews
		  histograms:(NSArray*) histograms {
	self = [super init];
	
	if (self) {
		self.firstHit = firstHit;
		self.lastHit = lastHit;
		self.totalHits = totalHits;
		self.page = page;
		self.resultsPerPage = resultsPerPage;
		self.uri = uri;
		self.didYouMean = didYouMean;
		self.regions = regions;
		self.reviews = reviews;
		self.histograms = histograms;
	}
	
	return self;
}

- (void) dealloc {
	self.uri = nil;
	self.didYouMean = nil;
	self.regions = nil;
	self.reviews = nil;
	self.histograms = nil;
	
	[super dealloc];
}

#pragma mark -
#pragma mark NSCoding

- (id) initWithCoder:(NSCoder*) decoder {
	self = [super initWithCoder:decoder];
	
	if (self) {
		self.firstHit = [decoder decodeIntegerForKey:@"firstHit"];
		self.lastHit = [decoder decodeIntegerForKey:@"lastHit"];
		self.totalHits = [decoder decodeIntegerForKey:@"totalHits"];
		self.page = [decoder decodeIntegerForKey:@"page"];
		self.resultsPerPage = [decoder decodeIntegerForKey:@"resultsPerPage"];
		self.uri = [decoder decodeObjectForKey:@"uri"];
		self.didYouMean = [decoder decodeObjectForKey:@"didYouMean"];
		self.regions = [decoder decodeObjectForKey:@"regions"];
		self.reviews = [decoder decodeObjectForKey:@"reviews"];
		self.histograms = [decoder decodeObjectForKey:@"histograms"];
	}
	
	return self;
}

- (void) encodeWithCoder:(NSCoder*) encoder {
	[super encodeWithCoder:encoder];
	[encoder encodeInteger:self.firstHit forKey:@"firstHit"];
	[encoder encodeInteger:self.lastHit forKey:@"lastHit"];
	[encoder encodeInteger:self.totalHits forKey:@"totalHits"];
	[encoder encodeInteger:self.page forKey:@"page"];
	[encoder encodeInteger:self.resultsPerPage forKey:@"resultsPerPage"];
	[encoder encodeObject:self.uri forKey:@"uri"];
	[encoder encodeObject:self.didYouMean forKey:@"didYouMean"];
	[encoder encodeObject:self.regions forKey:@"regions"];
	[encoder encodeObject:self.reviews forKey:@"reviews"];
	[encoder encodeObject:self.histograms forKey:@"histograms"];
}

#pragma mark -
#pragma mark NSCopying

- (id) copyWithZone:(NSZone*) zone {
	CGReviewsSearchResults* copy = [super copyWithZone:zone];
	if (copy) {
		copy.firstHit = self.firstHit;
		copy.lastHit = self.lastHit;
		copy.totalHits = self.totalHits;
		copy.page = self.page;
		copy.resultsPerPage = self.resultsPerPage;
		copy.uri = [[self.uri copyWithZone:zone] autorelease];
		copy.didYouMean = [[self.didYouMean copyWithZone:zone] autorelease];
		copy.regions = [[self.regions copyWithZone:zone] autorelease];
		copy.reviews = [[self.reviews copyWithZone:zone] autorelease];
		copy.histograms = [[self.histograms copyWithZone:zone] autorelease];
	}
	
	return copy;
}

#pragma mark -
#pragma mark NSObject

- (BOOL) isEqualToReviewsSearchResults:(CGReviewsSearchResults*) other {
	return
	self.firstHit == other.firstHit &&
	self.lastHit == other.lastHit &&
	self.totalHits == other.totalHits &&
	self.page == other.page &&
	self.resultsPerPage == other.resultsPerPage &&
	[self isEqualWithNull:self.uri other:other.uri] &&
	[self isEqualWithNull:self.didYouMean other:other.didYouMean] &&
	[self isEqualWithNull:self.regions other:other.regions] &&
	[self isEqualWithNull:self.reviews other:other.reviews] &&
	[self isEqualWithNull:self.histograms other:other.histograms];
}

- (BOOL) isEqual:(id) other {
	if (other == self) {
		return YES;
	}
	if (! other || ! [other isKindOfClass:[self class]]) {
		return NO;
	}
	
	return [self isEqualToReviewsSearchResults:other];
}

- (NSUInteger) hash {
	NSUInteger h = 0;
	h += self.firstHit;
	h += self.lastHit;
	h += self.totalHits;
	h += self.page;
	h += self.resultsPerPage;
	h += [self.uri hash];
	h += [self.didYouMean hash];
	h += [self.regions hash];
	h += [self.reviews hash];
	h += [self.histograms hash];
	return h;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGPlacesSearchResults firstHit=%i,lastHit=%i,totalHist=%i,pages=%i,resultsPerPage=%i,uri=%@,didYouMean=%@,regions=%@,reviews=%@,histograms=%@>",
			self.firstHit, self.lastHit, self.totalHits, self.page, self.resultsPerPage, self.uri, self.didYouMean, self.regions, self.reviews, self.histograms];
}

@end
