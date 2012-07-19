//
//
//  Copyright 2011 CityGrid Media LLC All rights reserved.
//
#import "CGEPlaceViewController.h"
#import <CityGrid/CityGrid.h>
#import "CGEAppDelegate.h"

@interface CGEPlaceViewController ()

@property (nonatomic, assign) NSInteger locationId;
@property (nonatomic, retain) NSOperationQueue* queue;
@property (nonatomic, retain) CGPlacesDetailLocation* place;
@property (nonatomic, retain) CGAdsMobileAd* ad;
@property (nonatomic, retain) NSString* clientIp;
@property (nonatomic, retain) NSString* publicId;
@property (nonatomic, retain) NSString* rawWhat;

@end

@implementation CGEPlaceViewController

@synthesize imageView = imageView_;
@synthesize adButton = adButton_;
@synthesize streetLabel = streetLabel_;
@synthesize cityLabel = cityLabel_;
@synthesize stateLabel = stateLabel_;
@synthesize zipLabel = zipLabel_;
@synthesize publicIdLabel = publicIdLabel_;

@synthesize locationId = locationId_;
@synthesize queue = queue_;
@synthesize place = place_;
@synthesize ad = ad_;
@synthesize clientIp = clientIp_;
@synthesize publicId = publicId_;
@synthesize rawWhat= rawWhat_;


- (id) initWithLocationId:(NSInteger) locationId andWithPublicId:(NSString*) publicId andWithIp:(NSString*) clientIp andWithRawWhat:(NSString*) rawWhat{
    self = [super initWithNibName:@"CGEPlace" bundle:nil];
	
	if (self) {
        if(publicId > 0){
            self.publicId = publicId;
        }
		else{
            self.locationId = locationId;
        }
        self.clientIp = clientIp;
        self.rawWhat = rawWhat;
	}
    [publicId release];
    [clientIp release];
    [rawWhat release];
    
    return self;
}

#pragma mark - View lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
    
	self.title = @"Loading...";
	self.streetLabel.text = @"Loading...";
	self.cityLabel.text = @"Loading...";
	self.stateLabel.text = @"Loading...";
	self.zipLabel.text = @"Loading...";
    self.publicIdLabel.text = @"Loading...";
    self.adButton.titleLabel.text = @"Loading...";
	
	self.queue = [[[NSOperationQueue alloc] init] autorelease];
	[[CGEAppDelegate sharedAppDelegate] showActivity:self];
	[self.queue addOperationWithBlock:^{
		
		CGPlacesDetail* detail = [CityGrid placesDetail];
		if(self.publicId != nil)
        {
            //Deprecated
            //detail.publicId = self.publicId;
            detail.placeId = self.publicId;
            //Notify that the type of the id
            detail.idType = @"cg";
        }
        else{
            //Deprecated
            //detail.locationId = self.locationId;
            detail.placeId = [NSString stringWithFormat:@"%i", self.locationId];
            //Notify that the type of the id
            detail.idType = @"cs";
        }
        
		NSArray* errors = nil;
        
		self.place = [detail detail:&errors].location;
        
		if ([errors count] > 0) {
			NSError* first = [errors objectAtIndex:0];
			UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:first.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
			[alert show];
		}
		
        //Place detail loading
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			self.title = self.place.name;
			CGAddress* address = self.place.address;
			self.streetLabel.text = address.street;
			self.cityLabel.text = address.city;
			self.stateLabel.text = address.state;
			self.zipLabel.text = address.zip;
            self.publicIdLabel.text = self.place.publicId;
            
			[self.queue addOperationWithBlock:^{
				NSArray* errors = [self.place track:CGAdsTrackerActionTargetListingProfile];
				
				if ([errors count] > 0) {
					NSError* first = [errors objectAtIndex:0];
					UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:first.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
					[alert show];
				}
			}];
		}];
		
        //Ads Custom loading
        [self.queue addOperationWithBlock:^{
            CGAdsMobile* mobile = [CityGrid adsMobile];
            
            mobile.where = ((CGAddress*)self.place.address).zip;
            mobile.what = self.rawWhat;
            //mobile.rawWhat = self.rawWhat;
            mobile.collection = CGAdsMobileCollection320x50cat;
            mobile.size = CGSizeMake(320.0, 50.0);
            mobile.max = 1;
            self.adButton.titleLabel.text = @"";
            
            NSArray* errors = nil;
            
            self.ad = [[mobile banner:&errors] ad];
            
            //Ad Image loading
            if (self.ad.image) {
                [self.queue addOperationWithBlock:^{
                    [[CGEAppDelegate sharedAppDelegate] showActivity:self];
                    
                    UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.ad.image]];
                    
                    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                        [self.adButton setImage:image forState:UIControlStateNormal];
                    }];
                    [[CGEAppDelegate sharedAppDelegate] hideActivity:self];
                }];
            }
            
            
        }];   
        
        //Image loading
		if (self.place.image) {
			[self.queue addOperationWithBlock:^{
				[[CGEAppDelegate sharedAppDelegate] showActivity:self];
				UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.place.image]];
				
				[[NSOperationQueue mainQueue] addOperationWithBlock:^{
					self.imageView.image = image;
				}];
				[[CGEAppDelegate sharedAppDelegate] hideActivity:self];
			}];
		}
		
		[[CGEAppDelegate sharedAppDelegate] hideActivity:self];
	}];
}

//Hyperlien
- (IBAction)goToLink{
    if(self.ad.image){
        [[UIApplication sharedApplication] openURL:self.ad.destinationUrl];
    }    
}

- (void) viewDidUnload {
    [super viewDidUnload];
}

- (void) dealloc {
    [super dealloc];
    [self.queue cancelAllOperations];
	self.queue = nil;
    [place_ release];
    [ad_ release];
    [imageView_ release];
    [adButton_ release];
    [streetLabel_ release];
    [cityLabel_ release];
    [stateLabel_ release];
    [zipLabel_ release];
    [publicIdLabel_ release];
}

@end
