//
//  ModalViewController.m
//  OWTapTempoViewControllerDemo
//
//  Created by Oded Welgreen on 12/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ModalViewController.h"

@implementation ModalViewController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setModalPresentationStyle:UIModalPresentationFullScreen];
        [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    }
    return self;
}

- (void)dealloc {
    delegate = nil;
    [tapTempoViewController release];
    [super dealloc];
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    //init bar buttons
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
    self.navigationItem.rightBarButtonItem = done;
    [done release];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    self.navigationItem.leftBarButtonItem = cancel;
    [cancel release];
    
    //init OWTapTempoViewController
    tapTempoViewController = [[OWTapTempoViewController alloc] initWithFrame:CGRectMake(0, 0, 150, 150) andImage:[UIImage imageNamed:@"RoundBlueButton"]];
    [self.view addSubview:tapTempoViewController.view];
    tapTempoViewController.view.center = self.view.center;
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

- (void)cancel:(id)sender {
    [self dismissModalViewControllerAnimated:YES];
}

- (void)done:(id)sender {
    [delegate didSelectBpm:150];
    [self dismissModalViewControllerAnimated:YES];
    
}

@end
