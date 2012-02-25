//
//  ModalViewController.m
//  OWTapTempoViewControllerDemo
//
//  Created by Oded Welgreen on 12/02/12.
//  Copyright (c) 2012 Oded Welgreen. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

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
    [tfBpm release];
    [lblTempoMarking release];
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
    tapTempoViewController.delegate = self;
    [self.view addSubview:tapTempoViewController.view];
    tapTempoViewController.view.center = self.view.center;
}

- (void)viewDidUnload
{
    [tfBpm release];
    tfBpm = nil;
    [lblTempoMarking release];
    lblTempoMarking = nil;
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
    [delegate didSelectBpm:tapTempoViewController.currentBpm];
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - OWTapTempoViewControllerDelegate methods

- (void)controllerDidUpdateBpm:(int)bpm {
    tfBpm.text = [NSString stringWithFormat:@"%d",bpm];
    lblTempoMarking.text = tapTempoViewController.currentTempoMarking;
}


@end
