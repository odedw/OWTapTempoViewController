//
//  OWTapTempoViewController.m
//  OWTapTempoViewControllerDemo
//
//  Created by Oded Welgreen on 10/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OWTapTempoViewController.h"

@implementation OWTapTempoViewController
@synthesize currentBPM;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFrame:(CGRect)rect  andImage:(UIImage*)img{
    self = [super init];
    if (self) {
        frame = rect;
        image = img;
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)rect {
    self = [super init];
    if (self) {
        frame = rect;
    }
    return self;
}

- (void)dealloc {
    [image release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:frame ];
    UIButton *btn = nil;
    if (image) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = view.bounds;    
        [btn setImage:image forState:UIControlStateNormal];
        
    }
    else {
        btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btn.frame = CGRectMake(0, 0, view.bounds.size.width, 37);    
        btn.center = view.center;
        [btn setTitle:@"Tap" forState:UIControlStateNormal];
    }
    
    [btn addTarget:self action:@selector(tapped:) forControlEvents:UIControlEventTouchDown];
    [view addSubview:btn];
    self.view = view;
    [view release];
}


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

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

-(void) tapped:(id)sender {
    NSLog(@"tapped");
}

@end
