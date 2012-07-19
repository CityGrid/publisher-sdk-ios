//
//
//  Copyright 2011 CityGrid Media, LLC All rights reserved.
//
#import "CGShared.h"
#import "CGConstants.h"
#import "CGJSON.h"

@implementation CGShared

@synthesize publisher = publisher_;
@synthesize placement = placement_;
@synthesize timeout = timeout_;
@synthesize url = url_;
@synthesize debug = debug_;
@synthesize simulation = simulation_;

- (NSError*) errorWithCode:(CGErrorNum) code description:(NSString*) description recoverySuggestion:(NSString*) recoverySuggestion {
	return [self errorWithCode:code description:description recoverySuggestion:recoverySuggestion error:nil];
}

- (NSError*) errorWithCode:(CGErrorNum) code description:(NSString*) description recoverySuggestion:(NSString*) recoverySuggestion error:(NSError*) error {
	NSMutableDictionary* userInfo = [NSMutableDictionary dictionaryWithCapacity:3];
	if (description) {
		[userInfo setObject:description forKey:NSLocalizedDescriptionKey];
	}
	if (recoverySuggestion) {
		[userInfo setObject:recoverySuggestion forKey:NSLocalizedRecoverySuggestionErrorKey];
	}
	if (error) {
		[userInfo setObject:error forKey:NSUnderlyingErrorKey];
	}
	
	return [NSError errorWithDomain:CG_ERROR_DOMAIN code:code userInfo:userInfo];
}

- (NSString*) dictAsUrlEncodedParameters:(NSDictionary*) dict {
	if (dict == nil || [dict count] == 0) {
		return nil;
	}
	
	NSMutableString* params = [NSMutableString stringWithCapacity:64];
	
	[dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
        //If it is a NSArray (here is used for multiple terms for what
        if ([obj isKindOfClass:[NSArray class]]){
            for (id term in obj){
		        [params appendFormat:@"&%@=%@", key, [term stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            }
        }
        //else if it a simple object
        else{
            if ([params length] > 0) {
                [params appendString:@"&"];
            }
            [params appendFormat:@"%@=%@", key, [obj stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        }
	}];
	
	if ([params length] > 0) {
		return params;
	} else {
		return nil;
	}
}

- (NSError*) errorWithErrorNum:(CGErrorNum) errorNum {
	NSError* error = nil;
	
	switch (errorNum) {
		case CGErrorNumUnderspecified:
			error = [self errorWithCode:errorNum description:@"Neither type, what, tag, nor chain was specified" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumQueryTypeUnknown:
			error = [self errorWithCode:errorNum description:@"The query type parameter is not supported" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumQueryOverspecified:
			error = [self errorWithCode:errorNum description:@"The parameter type was specified in addition to tag or chain" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumGeographyUnderspecified:
			error = [self errorWithCode:errorNum description:@"Neither where or latitude/longitude/radius were given" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumGeographyOverspecified:
			error = [self errorWithCode:errorNum description:@"Both where and one of latitude or longitude were given" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumRadiusRequired:
			error = [self errorWithCode:errorNum description:@"Both latitude and longitude were given, but radius was missing" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumDatePast:
			error = [self errorWithCode:errorNum description:@"" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumDateRangeIncomplete:
			error = [self errorWithCode:errorNum description:@"" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumDateRangeTooLong:
			error = [self errorWithCode:errorNum description:@"" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumGeocodeFailure:
			error = [self errorWithCode:errorNum description:@"The geocoder could not find a match for the given where parameter" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumTagIllegal:
			error = [self errorWithCode:errorNum description:@"The parameter tag was not an integer" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumChainIllegal:
			error = [self errorWithCode:errorNum description:@"The parameter chain was not an integer" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumFirstIllegal:
			error = [self errorWithCode:errorNum description:@"The parameter first was not a character" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumLatitudeIllegal:
			error = [self errorWithCode:errorNum description:@"The parameter latitude was not a valid number" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumLongitudeIllegal:
			error = [self errorWithCode:errorNum description:@"The parameter longitude was not a valid number" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumRadiusIllegal:
			error = [self errorWithCode:errorNum description:@"The parameter radius was not a valid number" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumPageIllegal:
			error = [self errorWithCode:errorNum description:@"The parameter page was not an integer" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumResultsPerPageIllegal:
			error = [self errorWithCode:errorNum description:@"The parameter resultsPerPage was not an integer" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumFromIllegal:
			error = [self errorWithCode:errorNum description:@"" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumToIllegal:
			error = [self errorWithCode:errorNum description:@"" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumSortIllegal:
			error = [self errorWithCode:errorNum description:@"The parameter sort contained an unknown value" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumRadiusOutOfRange:
			error = [self errorWithCode:errorNum description:@"The parameter radius was below 1" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumPageOutOfRange:
			error = [self errorWithCode:errorNum description:@"The parameter page was less than 1" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumResultsPerPageOutOfRange:
			error = [self errorWithCode:errorNum description:@"The parameter resultsPerPage was not in the range 1..50" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumPublisherRequired:
			error = [self errorWithCode:errorNum description:@"The publisher parameter is missing" recoverySuggestion:@"Please, provide the publisher"];
			break;
		case CGErrorNumInternal:
			error = [self errorWithCode:errorNum description:@"An internal problem with the service occurred" recoverySuggestion:@"Please, report this to CityGrid support"];
			break;
		case CGErrorNumListingNotFound:
			error = [self errorWithCode:errorNum description:@"" recoverySuggestion:@"Please, enter a valid listing"];
			break;
		case CGErrorNumNetworkError:
			error = [self errorWithCode:errorNum description:@"A problem with the network occurred" recoverySuggestion:@"Please, check your settings"];
			break;
		case CGErrorNumParseError:
			error = [self errorWithCode:errorNum description:@"A problem with the network payload occurred" recoverySuggestion:@"Please, report this to CityGrid support"];
			break;
		case CGErrorNumPhoneIllegal:
			error = [self errorWithCode:errorNum description:@"The parameter phone was illegal and was not 10 digits" recoverySuggestion:@"Please, review and correct the phone number"];
			break;
		case CGErrorNumLocationIdOutOfRange:
			error = [self errorWithCode:errorNum description:@"The parameter locationId was illegal and not a positive integer" recoverySuggestion:@"Please, review and correct the listing id"];
			break;
		case CGErrorNumInfoUsaIdOutOfRange:
			error = [self errorWithCode:errorNum description:@"The parameter infoUsaId was illegal and not a positive integer" recoverySuggestion:@"Please, review and correct the info USA id"];
			break;
		case CGErrorNumReviewCountOutOfRange:
			error = [self errorWithCode:errorNum description:@"The parameter reviewCount was illegal and not between 0 and 20" recoverySuggestion:@"Please, review and correct the review count"];
			break;
		case CGErrorNumReviewRatingOutOfRange:
			error = [self errorWithCode:errorNum description:@"The parameter ratomg was illegal and not a positive integer" recoverySuggestion:@"Please, review and correct the review count"];
			break;
		case CGErrorNumReviewDaysOutOfRange:
			error = [self errorWithCode:errorNum description:@"The parameter reviewCount was illegal and not a positive integer" recoverySuggestion:@"Please, review and correct the review count"];
			break;
		case CGErrorNumOfferIdRequired:
			error = [self errorWithCode:errorNum description:@"The parameter offerId is required" recoverySuggestion:@"Please, review and correct the review count"];
			break;
		case CGErrorNumMaxOutOfRange:
			error = [self errorWithCode:errorNum description:@"The parameter max was not in the range 1..10" recoverySuggestion:@"Please, review and correct the error"];
			break;
		case CGErrorNumCollectionRequired:
			error = [self errorWithCode:errorNum description:@"The collection parameter is missing" recoverySuggestion:@"Please, provide the collection"];
			break;
		case CGErrorNumSizeRequired:
			error = [self errorWithCode:errorNum description:@"The size parameter is missing" recoverySuggestion:@"Please, provide the size"];
			break;
		case CGErrorNumActionTargetRequired:
			error = [self errorWithCode:errorNum description:@"The actionTarget parameter is missing" recoverySuggestion:@"Please, provide the actionTarget"];
			break;
		case CGErrorNumLocationIdRequired:
			error = [self errorWithCode:errorNum description:@"The listingId parameter is missing" recoverySuggestion:@"Please, provide the listingId"];
			break;
		case CGErrorNumReferenceIdRequired:
			error = [self errorWithCode:errorNum description:@"The referenceId parameter is missing" recoverySuggestion:@"Please, provide the referenceId"];
			break;
		case CGErrorNumDialPhoneRequired:
			error = [self errorWithCode:errorNum description:@"The dialPhone parameter is missing when the actionTarget is click to call" recoverySuggestion:@"Please, provide the dialPhone"];
			break;
        case CGErrorNumIdTypeNotFound:
			error = [self errorWithCode:errorNum description:@"The idType parameter is missing" recoverySuggestion:@"Please, provide the idType"];
			break;
        case CGErrorNumPublicIdNotFound:
			error = [self errorWithCode:errorNum description:@"The publicId parameter is missing" recoverySuggestion:@"Please, provide the publicId"];
			break;
        case CGErrorNumMaxWhatOutOfRange:
			error = [self errorWithCode:errorNum description:@"The number of what terms cannot be > to 3" recoverySuggestion:@"Please, remove provide 3 terms maximum"];
			break;
		default:
			error = [self errorWithCode:errorNum description:@"An unknown error number was specified" recoverySuggestion:@"Please, report this to CityGrid support"];
			break;
	}
	
	return error;
}

- (NSError*) serverErrorToError:(NSString*) serverError {
	NSError* error = nil;
	
	if ([serverError isEqualToString:@"query.underspecified"]) {
		error = [self errorWithErrorNum:CGErrorNumUnderspecified];
	} else if ([serverError isEqualToString:@"query.type.unknown"]) {
		error = [self errorWithErrorNum:CGErrorNumQueryTypeUnknown];
	} else if ([serverError isEqualToString:@"query.overspecified"]) {
		error = [self errorWithErrorNum:CGErrorNumQueryOverspecified];
	} else if ([serverError isEqualToString:@"geography.underspecified"]) {
		error = [self errorWithErrorNum:CGErrorNumGeographyUnderspecified];
	} else if ([serverError isEqualToString:@"geography.overspecified"]) {
		error = [self errorWithErrorNum:CGErrorNumGeographyOverspecified];
	} else if ([serverError isEqualToString:@"radius.required"]) {
		error = [self errorWithErrorNum:CGErrorNumRadiusRequired];
	} else if ([serverError isEqualToString:@"geocode.failure"]) {
		error = [self errorWithErrorNum:CGErrorNumGeocodeFailure];
	} else if ([serverError isEqualToString:@"tag.illegal"]) {
		error = [self errorWithErrorNum:CGErrorNumTagIllegal];
	} else if ([serverError isEqualToString:@"chain.illegal"]) {
		error = [self errorWithErrorNum:CGErrorNumChainIllegal];
	} else if ([serverError isEqualToString:@"first.illegal"]) {
		error = [self errorWithErrorNum:CGErrorNumFirstIllegal];
	} else if ([serverError isEqualToString:@"latitude.illegal"]) {
		error = [self errorWithErrorNum:CGErrorNumLatitudeIllegal];
	} else if ([serverError isEqualToString:@"longitude.illegal"]) {
		error = [self errorWithErrorNum:CGErrorNumLongitudeIllegal];
	} else if ([serverError isEqualToString:@"radius.illegal"]) {
		error = [self errorWithErrorNum:CGErrorNumRadiusIllegal];
	} else if ([serverError isEqualToString:@"page.illegal"]) {
		error = [self errorWithErrorNum:CGErrorNumPageIllegal];
	} else if ([serverError isEqualToString:@"rpp.illegal"]) {
		error = [self errorWithErrorNum:CGErrorNumResultsPerPageIllegal];
	} else if ([serverError isEqualToString:@"sort.illegal"]) {
		error = [self errorWithErrorNum:CGErrorNumSortIllegal];
	} else if ([serverError isEqualToString:@"radius.out.of.range"]) {
		error = [self errorWithErrorNum:CGErrorNumRadiusOutOfRange];
	} else if ([serverError isEqualToString:@"page.out.of.range"]) {
		error = [self errorWithErrorNum:CGErrorNumPageOutOfRange];
	} else if ([serverError isEqualToString:@"rpp.out.of.range"]) {
		error = [self errorWithErrorNum:CGErrorNumResultsPerPageOutOfRange];
	} else if ([serverError isEqualToString:@"publisher.required"]) {
		error = [self errorWithErrorNum:CGErrorNumPublisherRequired];
	} else if ([serverError isEqualToString:@"internal.error"]) {
		error = [self errorWithErrorNum:CGErrorNumInternal];
	} else {
		error = [self errorWithCode:CGErrorNumUnknown description:[NSString stringWithFormat:@"An unknown server error occurred %@", serverError] recoverySuggestion:@"Please, report this to CityGrid support"];
	}
	
	return error;
}

- (NSDictionary*) sendSynchronousRequest:(NSURL*) url parameters:(NSDictionary*) parameters timeout:(NSTimeInterval) timeout errors:(NSArray**) errors {
	NSString* fullUrlString = [NSString stringWithFormat:@"%@?%@", url, [self dictAsUrlEncodedParameters:parameters]];
	NSURL* fullUrl = [NSURL URLWithString:fullUrlString];
	NSString* responseString = nil;
	
	if (self.simulation) {
		if (self.debug) {
			NSLog(@"CityGrid: *SIMULATED* sent %@", fullUrl);
		}

		NSString* partialPath = [[[url absoluteString] componentsSeparatedByString:[NSString stringWithFormat:@"%@/", [self.url absoluteString]]] lastObject];
		NSString* fileName = [partialPath stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
		
		NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:@"json"];
		
		NSError* error = nil;
		responseString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
		if (error) {
			if (errors != NULL) {
				NSMutableDictionary* userInfo = [NSMutableDictionary dictionaryWithCapacity:2];
				[userInfo setObject:@"Could not find simulation for url." forKey:NSLocalizedDescriptionKey];
				[userInfo setObject:error forKey:NSUnderlyingErrorKey];
				*errors = [NSArray arrayWithObject:[NSError errorWithDomain:CG_ERROR_DOMAIN code:CGErrorNumSimulationNotFound userInfo:userInfo]];
			}
			return nil;
		}
		
		if (self.debug) {
			NSLog(@"CityGrid: *SIMULATED* received %@\ndata: %@", fullUrl, responseString);
		}
		if ([fullUrlString rangeOfString:@"/ads/tracker/imp"].location != NSNotFound) {
			return nil;
		}
		
	} else {
		NSURLRequest* request = [NSURLRequest requestWithURL:fullUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:timeout];
		
		NSError* networkError = nil;
		NSHTTPURLResponse* response = nil;
		if (self.debug) {
			NSLog(@"CityGrid: sent %@", fullUrl);
		}
		
		NSData* responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&networkError];
		responseString = [[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding] autorelease];
		
		if (self.debug) {
			NSLog(@"CityGrid: received %@\nstatus:%i\nmime-type:%@\ndata:\n%@", fullUrl, [response statusCode], [response MIMEType], responseString);
		}
		
		if (networkError) {
			if (errors != NULL) {
				*errors = [NSArray arrayWithObject:[[CGShared sharedInstance] errorWithCode:CGErrorNumNetworkError description:[NSString stringWithFormat:@"A network error occurred while invoking %@", fullUrl] recoverySuggestion:@"Please, review and correct the error" error:networkError]];
			}
			return nil;
		}
		
		if ([response statusCode] != 200) {
			if (errors != NULL) {
				*errors = [NSArray arrayWithObject:[[CGShared sharedInstance] errorWithCode:CGErrorNumNetworkError description:[NSString stringWithFormat:@"Received a %i status code while invoking %@\n%@", [response statusCode], fullUrl, responseString] recoverySuggestion:@"Please, review and correct the request to achieve a 200 status code"]];
			}
			return nil;
		}
		
		if (! ([[response MIMEType] isEqualToString:@"application/json"] || [[response MIMEType] isEqualToString:@"text/plain"] || [[response MIMEType] isEqualToString:@"image/gif"])) {
			if (errors != NULL) {
				*errors = [NSArray arrayWithObject:[[CGShared sharedInstance] errorWithCode:CGErrorNumNetworkError description:[NSString stringWithFormat:@"Received a %@ mime type while invoking %@", [response MIMEType], fullUrl] recoverySuggestion:@"Please, review and correct the request to achieve an application/xml mime type"]];
			}
			return nil;
		}
		
		if (responseData == nil) {
			if (errors != NULL) {
				*errors = [NSArray arrayWithObject:[[CGShared sharedInstance] errorWithCode:CGErrorNumNetworkError description:[NSString stringWithFormat:@"Received empty data while invoking %@", fullUrl] recoverySuggestion:@"Please, review and correct the request to return a result"]];
			}
			return nil;
		}
		
		if ([fullUrlString rangeOfString:@"/ads/tracker/imp"].location != NSNotFound) {
			return nil;
		}
	}
	
	CGJsonParser* parser = [[[CGJsonParser alloc] init] autorelease];
	NSError* parseError = nil;
	
	NSDictionary* parsed = [parser objectWithString:responseString error:&parseError];
	
	if (parseError) {
		if (errors != NULL) {
			*errors = [NSArray arrayWithObject:[[CGShared sharedInstance] errorWithCode:CGErrorNumParseError description:[NSString stringWithFormat:@"Could not parse the JSON for %@", fullUrl] recoverySuggestion:@"Please, review and correct the parse error" error:parseError]];
		}
		return nil;
	}
	
	NSArray* parsedServerErrors = [parsed objectForKey:@"errors"];
	NSMutableArray* serverErrors = [NSMutableArray arrayWithCapacity:[parsedServerErrors count]];
	for (NSDictionary* errorDictionary in parsedServerErrors) {
		[serverErrors addObject:[self serverErrorToError:[errorDictionary objectForKey:@"error"]]];
	}
	
	if ([serverErrors count] > 0) {
		if (errors != NULL) {
			*errors = serverErrors;
		}
		return nil;
	}
	
	return parsed;
}

#pragma mark -
#pragma mark Singleton Methods

static CGShared* instance;

- (id) init {
	self = [super init];
	
	if (self) {
		self.publisher = nil;
		self.timeout = CG_DEFAULT_TIMEOUT;
		self.url = [NSURL URLWithString:CG_BASE_URL];
#ifndef __OPTIMIZE__
		self.debug = YES;
#else
		self.debug = NO;
#endif
		self.simulation = CG_DEFAULT_SIMULATION;
	}
	
	return self;
}

+ (CGShared*) sharedInstance {
	if (instance == nil) {
		instance = [[super allocWithZone:NULL] init];
	}
	return instance;
}

+ (id) allocWithZone:(NSZone*) zone {
    return [[self sharedInstance] retain];
}

- (id) copyWithZone:(NSZone*) zone {
    return self;
}

- (id) retain {
    return self;
}

- (NSUInteger) retainCount {
    return NSUIntegerMax;  // denotes an object that cannot be released
}

- (oneway void) release {
    //do nothing
}

- (id) autorelease {
    return self;
}

- (NSString*) description {
	return [NSString stringWithFormat:@"<CGShared publisher=%@,timeout=%f,url=%@,debug=%i,simulation=%i>",
			self.publisher, self.timeout, self.url, self.debug, self.simulation];
}

@end
