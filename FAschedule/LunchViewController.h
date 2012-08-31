//
//  LunchViewController.h
//  FAschedule
//
//  Created by Reed Rosenbluth on 8/20/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LunchViewController : UIViewController
{
    
    UISegmentedControl *aM;
    UISegmentedControl *aT;
    UISegmentedControl *aW;
    UISegmentedControl *aTh;
    UISegmentedControl *aF;
    UISegmentedControl *bM;
    UISegmentedControl *bT;
    UISegmentedControl *bW;
    UISegmentedControl *bTh;
    UISegmentedControl *bF;
    NSMutableArray *segmentedControls;
}

@property (nonatomic, strong) IBOutlet UISegmentedControl *aM;
@property (nonatomic, strong) IBOutlet UISegmentedControl *aT;
@property (nonatomic, strong) IBOutlet UISegmentedControl *aW;
@property (nonatomic, strong) IBOutlet UISegmentedControl *aTh;
@property (nonatomic, strong) IBOutlet UISegmentedControl *aF;
@property (nonatomic, strong) IBOutlet UISegmentedControl *bM;
@property (nonatomic, strong) IBOutlet UISegmentedControl *bT;
@property (nonatomic, strong) IBOutlet UISegmentedControl *bW;
@property (nonatomic, strong) IBOutlet UISegmentedControl *bTh;
@property (nonatomic, strong) IBOutlet UISegmentedControl *bF;

@end
