//
//  OWTapTempoViewController.h
//  OWTapTempoViewControllerDemo
//
//  Created by Oded Welgreen on 10/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWTapTempoViewController : UIViewController {
    UIButton *tapButton;
    CGRect frame;
    UIImage *image;
    int currentBPM;
}
@property (readonly) int currentBPM;
- (id)initWithFrame:(CGRect)frame andImage:(UIImage*)image;
- (id)initWithFrame:(CGRect)frame;
@end
