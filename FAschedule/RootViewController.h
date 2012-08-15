//
//  RootViewController.h
//  FAschedule
//
//  Created by Reed Rosenbluth on 8/11/12.
//
//

#import <UIKit/UIKit.h>
#import "PaperFoldView.h"
#import "LeftViewController.h"

@interface RootViewController : UIViewController <PaperFoldViewDelegate, LeftViewControllerDelegate>

@property (nonatomic, strong) PaperFoldView *paperFoldView;
@property (nonatomic, strong) UINavigationController *centerViewNav;
@property (nonatomic, strong) LeftViewController *leftViewController;

@end