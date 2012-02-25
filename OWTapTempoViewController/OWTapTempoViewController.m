//
//  OWTapTempoViewController.m
//
//  Created by Oded Welgreen on 10/02/12.
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

#import "OWTapTempoViewController.h"
#define MIN_BPM 20
@implementation OWTapTempoViewController
@synthesize currentBpm, currentTempoMarking;
@synthesize delegate;

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
    delegate = nil;
    [tapDates release];
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
    
    tapDates = [[NSMutableArray alloc] init ];
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

#pragma mark - Bpm Logic

-(void) tapped:(id)sender {
    [tapDates addObject:[NSDate date]];
    if (tapDates.count > 1)
        [self computeCurrentBpm];
    if (timer) {
        [timer invalidate];
        [timer release];
        timer = nil;
    }
    float interval = (60.0/(float)MIN_BPM);
    timer = [[NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timerElapsed:) userInfo:nil repeats:NO] retain];
}

- (void)timerElapsed:(NSTimer*)thisTimer {
    [tapDates removeAllObjects];
    lastAverage = 0;
    [timer invalidate];
    [timer release];
    timer = nil;
}

- (void)computeCurrentBpm {
    //compare this interval to the last average
    if (lastAverage > 0) {
        NSDate *lastDate = [tapDates objectAtIndex:tapDates.count-1];
        NSDate *oneBeforeLastDate = [tapDates objectAtIndex:tapDates.count-2];
        float interval = [lastDate timeIntervalSinceDate:oneBeforeLastDate];
        //if the difference between the last average and this interval is too big, chuck all the readings except for the last one
        if (MAX(interval, lastAverage) / MIN(interval, lastAverage) > 1.5) { 
            //remove all but the last two to start over
            [tapDates removeObjectsInRange:NSMakeRange(0, tapDates.count-2)];
        }
            
    }
    
    float total = 0;
    for (int i=0; i<tapDates.count-1; i++) {
        NSDate *date1 = [tapDates objectAtIndex:i];
        NSDate *date2 = [tapDates objectAtIndex:i+1];
        total += [date2 timeIntervalSinceDate:date1];
    }
    lastAverage = total / (float)(tapDates.count-1);
    currentBpm = round(60.0/lastAverage);
    [delegate controllerDidUpdateBpm:currentBpm];
}

#pragma mark - Tempo Marking
- (NSString*)currentTempoMarking {
    return [OWTapTempoViewController tempoMarkingForBpm:currentBpm];
}

+ (NSString*)tempoMarkingForBpm:(int)bpm {
    if (bpm <= 40)
        return @"Largamente";
    else if (bpm <= 45)
        return @"Grave";
    else if (bpm <= 51)
        return @"Largo";
    else if (bpm <= 55)
        return @"Lento";
    else if (bpm <= 59)
        return @"Adagio";
    else if (bpm <= 65)
        return @"Larghetto";
    else if (bpm <= 71)
        return @"Adagietto";
    else if (bpm <= 79)
        return @"Andante";
    else if (bpm <= 87)
        return @"Andantino";
    else if (bpm <= 95)
        return @"Maestoso";
    else if (bpm <= 107)
        return @"Moderato";
    else if (bpm <= 119)
        return @"Allegretto";
    else if (bpm <= 131)
        return @"Animato";
    else if (bpm <= 143)
        return @"Allegro";
    else if (bpm <= 159)
        return @"Vivace";
    else if (bpm <= 191)
        return @"Presto";
    else if (bpm <= 207)
        return @"Vivacissimo";
    else // > 207
        return @"Prestissimo";
    
}

@end
