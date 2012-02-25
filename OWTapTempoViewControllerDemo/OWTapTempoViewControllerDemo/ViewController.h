//
//  ViewController.h
//  OWTapTempoViewControllerDemo
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

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ModalViewController.h"
@interface ViewController : UIViewController <ModalViewControllerDelegate> {
    BOOL isPlaying;
    SystemSoundID tickSound;
    int bpm;
    int count;
    
}
@property (retain, nonatomic) IBOutlet UILabel *lblTempoMarking;
@property (retain, nonatomic) IBOutlet UISwitch *switchEnableFlash;
@property (retain, nonatomic) IBOutlet UIView *flashView;
@property (retain, nonatomic) IBOutlet UITextField *tfBPM;
@property (retain, nonatomic) IBOutlet UIButton *btnStartStop;
@property (retain, nonatomic) IBOutlet UIView *maskView;
@property (retain, nonatomic) IBOutlet UISlider *slider;
@property (readonly) float duration;
- (IBAction)showTapTempo:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;
- (IBAction)startStopTapped:(id)sender;
- (void)setTextFieldValueFromSlider;
- (void)startMetronome;
- (void)flash;

@end
