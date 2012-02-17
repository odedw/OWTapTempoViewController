//
//  ModalViewController.h
//  OWTapTempoViewControllerDemo
//
//  Created by Oded Welgreen on 12/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OWTapTempoViewController.h"
@protocol ModalViewControllerDelegate <NSObject>
- (void)didSelectBpm:(int)bpm;
@end

@interface ModalViewController : UIViewController <OWTapTempoViewControllerDelegate>{
    id<ModalViewControllerDelegate> delegate;
    OWTapTempoViewController *tapTempoViewController;
    IBOutlet UITextField *tfBpm;
    IBOutlet UILabel *lblTempoMarking;
}
@property (nonatomic, assign) id<ModalViewControllerDelegate> delegate;
@end
