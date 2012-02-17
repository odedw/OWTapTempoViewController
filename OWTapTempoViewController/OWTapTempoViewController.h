//
//  OWTapTempoViewController.h
//  OWTapTempoViewControllerDemo
//
//  Created by Oded Welgreen on 10/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OWTapTempoViewControllerDelegate <NSObject>
-(void)controllerDidUpdateBpm:(int)bpm;        
@end
@interface OWTapTempoViewController : UIViewController {
    
    UIButton *tapButton;
    UIImage *image;
    CGRect frame;
    NSTimer *timer;
    int currentBpm;
    NSMutableArray *tapDates;
    id<OWTapTempoViewControllerDelegate> delegate;
    
}
@property (readonly) int currentBpm;
@property (readonly) NSString* currentTempoMarking;
@property (nonatomic, assign) id<OWTapTempoViewControllerDelegate> delegate;
- (id)initWithFrame:(CGRect)frame andImage:(UIImage*)image;
- (id)initWithFrame:(CGRect)frame;
+ (NSString*) tempoMarkingForBpm:(int)bpm;

//internal use
- (void)computeCurrentBpm;

@end
