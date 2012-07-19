//
//  CGEParametersViewControllers.m
//  CityGridExample
//
//  Created by Christophe Vong on 8/22/11.
//  Copyright 2011 CityGrid MEdia. All rights reserved.
//

#import "CGEParametersViewController.h"
#import <CityGrid/CityGrid.h>

@interface CGEParametersViewController ()

@property (nonatomic, assign) CGSearchType searchType;

@end

@implementation CGEParametersViewController

@synthesize whereTextField = whereTextField_;
@synthesize whatTextField = whatTextField_;
@synthesize searchType = searchType_;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andSearchType:(CGSearchType) searchType
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.searchType = searchType;
    }
    return self;
}

- (void)dealloc
{
    [whereTextField_ release];
    [whatTextField_ release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

//Lauching search
- (IBAction) validate{
   
    if(searchType_ == CGSearchTypePlace)
    {
        CGEPlacesViewController* placesView = [[CGEPlacesViewController alloc] initWithWhere:self.whereTextField.text andWithWhat:self.whatTextField.text];
        [self.navigationController pushViewController:placesView animated:YES];
        [placesView release];
    }
    else if(searchType_ == CGSearchTypeReview)
    {
        CGEReviewsViewController* reviewsView = [[CGEReviewsViewController alloc] initWithWhat:self.whatTextField.text andWithWhere:self.whereTextField.text];
        [self.navigationController pushViewController:reviewsView animated:YES];
        [reviewsView release];
    }
    
}


//Event leaving keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textfield {
	// the user pressed the "Done" button, so dismiss the keyboard
	[textfield resignFirstResponder];
	return YES;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Search parameters";
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
