//
//  CGEReviewsViewController.m
//  CityGridExample
//
//  Created by Christophe Vong on 8/24/11.
//  Copyright 2011 CityGrid Media. All rights reserved.
//

#import "CGEReviewsViewController.h"
#import <CityGrid/CityGrid.h>


@interface CGEReviewsViewController()

@property (nonatomic, retain) NSArray* reviews;
@property (nonatomic, retain) CGReviewsSearch* search;
@property (nonatomic, retain) NSString* where;
@property (nonatomic, retain) NSString* what;

@end


@implementation CGEReviewsViewController

@synthesize reviews = reviews_;
@synthesize reviewsTableView = reviewsTableView_;
@synthesize sortSwitch = sortSwitch_;
@synthesize search = search_;
@synthesize where = what_;
@synthesize what = where_;

- (CGEReviewsViewController*) initWithWhat:(NSString*) what andWithWhere:(NSString *) where{
    self = [super initWithNibName:@"CGEReviewsViewController" bundle:nil];
    
    if(self){
        self.where = where;
        self.what = what;
    }
    where = nil;
    what = nil;
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
    [search_ release];
    [reviews_ release];
    [sortSwitch_ release];
    [reviewsTableView_ release];
    [where_ release];
    [what_ release];
}

//Loading reviews
- (void) loadReviews {
    
    self.reviews = nil;
    self.search.where = self.where;
    self.search.what = self.what;
    self.search.radius = 20.0;
    self.search.resultsPerPage = 20;
    self.search.type = CGReviewTypeUserReview;
    
    NSArray* errors = nil;
    NSArray* tmpReviews = [self.search search:&errors].reviews;
    if ([errors count] > 0) {
        NSError* first = [errors objectAtIndex:0];
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            UIAlertView* alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:first.localizedDescription delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
            [alert show];
        }];
    } else {
        self.reviews = tmpReviews;
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.reviewsTableView reloadData];
            self.reviewsTableView.hidden = NO;
        }];
    }
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - TableView support

- (NSInteger) numberOfSectionsInTableView:(UITableView*) tableView {
	return 1;
}

- (NSInteger) tableView:(UITableView*) reviewTableView numberOfRowsInSection:(NSInteger) section {
	return [self.reviews count];
}

- (UITableViewCell*) tableView:(UITableView*) reviewTableView cellForRowAtIndexPath:(NSIndexPath*) indexPath {
    static NSString* CellIdentifier = @"PlaceCell";
    
    UITableViewCell* cell = [reviewTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
	if ([self.reviews count] > indexPath.row) {
		CGReviewsSearchReview* review = [self.reviews objectAtIndex:indexPath.row];
		cell.textLabel.text = review.title;
        NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
		cell.detailTextLabel.text = [formatter stringFromDate:review.date];
        
	} else {
		cell.textLabel.text = nil;
		cell.detailTextLabel.text = nil;
	}
	
    return cell;
}

- (void) tableView:(UITableView*) reviewTableView didSelectRowAtIndexPath:(NSIndexPath*) indexPath {
    //To complete for detailed review
}


//Sort choice
- (IBAction) switchChanged{
    if(self.sortSwitch.on){
        self.search.sort = CGReviewsSearchSortCreateDate;
        // By rating = CGReviewsSearchSortReviewRating
    }
    else
    {
        self.search.sort = CGReviewsSearchSortUnknown;
    }
    [self loadReviews]; 
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Reviews";
    self.search = [CityGrid reviewsSearch];
    [self loadReviews];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
