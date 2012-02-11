//
//  ViewController.h
//  OWTapTempoViewControllerDemo
//
//  Created by Oded Welgreen on 10/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
@interface ViewController : UIViewController {
    BOOL isPlaying;
    SystemSoundID tickSound;
    int bpm;
    int count;
    
}
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
