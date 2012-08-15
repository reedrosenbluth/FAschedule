//
//  LeftViewController.h
//  FAschedule
//
//  Created by Reed Rosenbluth on 8/11/12.
//
//

#import <UIKit/UIKit.h>

#define kClassDefault @"  ----  "
#define kRoomDefault  @"  ----  "
#define kEmptyString @""

@class Time;
@class RootViewController;

@interface LeftViewController : UIViewController {
    NSString *currentSubject;
    NSString *currentRoom;
    NSString *nextSubject;
    NSString *nextRoom;
    Time *startSec;
    Time *endSec;

}

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *dayButtons;
@property (strong, nonatomic) RootViewController *delegate;
@property (nonatomic, strong) IBOutlet UILabel *nowDynamicLabel;
@property (nonatomic, strong) IBOutlet UILabel *nextDynamicLabel;
@property (nonatomic, strong) IBOutlet UILabel *nowDynamicRoom;
@property (nonatomic, strong) IBOutlet UILabel *nextDynamicRoom;
@property (strong, nonatomic) IBOutlet UIProgressView *classProgress;
@property (nonatomic, assign) int dayNum;

- (IBAction)switchDay:(UIButton *)sender;
- (void) currentClass;

@end


@protocol LeftViewControllerDelegate <NSObject>

@required

- (IBAction)switchToDay:(int)dayNum;

@end