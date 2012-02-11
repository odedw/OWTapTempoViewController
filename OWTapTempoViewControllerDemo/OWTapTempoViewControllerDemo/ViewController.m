//
//  ViewController.m
//  OWTapTempoViewControllerDemo
//
//  Created by Oded Welgreen on 10/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#define MAX_BPM 200
#define MIN_BPM 30

@implementation ViewController

@synthesize switchEnableFlash;
@synthesize flashView;
@synthesize tfBPM;
@synthesize btnStartStop;
@synthesize maskView;
@synthesize slider;

-(float)duration {
    return 60.0 / (float)bpm;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //init slider
    slider.minimumValue = MIN_BPM;
    slider.maximumValue = MAX_BPM;
    slider.value = 60.0;//(MIN_BPM + MAX_BPM) / 2;
    [self setTextFieldValueFromSlider];
    
    //init tick sound
    NSURL* url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"CB" ofType:@"caf"]];
    AudioServicesCreateSystemSoundID((CFURLRef)url, &tickSound);
    
    //flash view
    //flashView.layer.cornerRadius = 100.0;
    
}

- (void)viewDidUnload
{
    [self setTfBPM:nil];
    [self setSlider:nil];
    [self setBtnStartStop:nil];
    [self setMaskView:nil];
    [self setFlashView:nil];
    [self setSwitchEnableFlash:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return UIInterfaceOrientationIsPortrait(interfaceOrientation);
}

- (void)dealloc {
    [tfBPM release];
    [slider release];
    [btnStartStop release];
    [maskView release];
    AudioServicesDisposeSystemSoundID(tickSound);
    [flashView release];
    [switchEnableFlash release];
    [super dealloc];
}
- (IBAction)showTapTempo:(id)sender {
    
}
- (IBAction)sliderValueChanged:(id)sender {
    [self setTextFieldValueFromSlider];
}

- (void) setTextFieldValueFromSlider {
    bpm = round(slider.value);
    tfBPM.text = [NSString stringWithFormat:@"%d",bpm];
    
}

- (IBAction)startStopTapped:(id)sender {
    isPlaying = !isPlaying;
    [btnStartStop setTitle: (isPlaying ? @"Stop" : @"Start") forState: UIControlStateNormal];
    if (isPlaying)
        [self performSelectorInBackground:@selector(startMetronome) withObject:nil];
    StartAnimationBlock(0.2);
    maskView.alpha = isPlaying ? 0.9 : 0;
    btnStartStop.frame = CGRectMake(btnStartStop.frame.origin.x, btnStartStop.frame.origin.y, btnStartStop.bounds.size.width, isPlaying ? 120.0 : 37.0 );
    EndAnimationBlock();
    
}

- (void)startMetronome {    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];       
    
    // Give the sound thread high priority to keep the timing steady.    
    [NSThread setThreadPriority:1.0];    
    count = 1;
    NSDate *startTime = [NSDate date];
    while (isPlaying) {  // Loop until cancelled.   
        // An autorelease pool to prevent the build-up of temporary objects.    
        NSAutoreleasePool *loopPool = [[NSAutoreleasePool alloc] init];     

        NSDate *curtainTime = [startTime dateByAddingTimeInterval:self.duration * count];    
        NSDate *currentTime = [[NSDate alloc] init];
        while (isPlaying &&  [currentTime compare:curtainTime] == NSOrderedAscending) {     
            [NSThread sleepForTimeInterval:0.001];    
            [currentTime release];    
            currentTime = [[NSDate alloc] init];    
        }
        if (isPlaying) {
            AudioServicesPlaySystemSound(tickSound);
            [self performSelectorOnMainThread:@selector(flash) withObject:nil waitUntilDone:NO];
        }
        [currentTime release];     
        [loopPool drain];   
        count++;
    }    
    [pool drain];    
}

- (void)flash {
    if (switchEnableFlash.isOn) {
        StartAnimationBlock((self.duration / 10.0));
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
        flashView.alpha = 1;
        EndAnimationBlock();
    }
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)c {
    StartAnimationBlock((self.duration * 9.0 / 10.0));
    flashView.alpha = 0;
    EndAnimationBlock();
}




@end
