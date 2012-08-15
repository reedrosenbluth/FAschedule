//
//  RootViewController.m
//  FAschedule
//
//  Created by Reed Rosenbluth on 8/11/12.
//
//

#import "RootViewController.h"
#import "UIView+Screenshot.h"
#import "ScheduleViewController.h"

@interface RootViewController ()
@property (nonatomic, strong) ScheduleViewController *svc0;
@property (nonatomic) int currentDayNum;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _paperFoldView = [[PaperFoldView alloc] initWithFrame:CGRectMake(0,0,[self.view bounds].size.width,[self.view bounds].size.height)];
        [_paperFoldView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
        [self.view addSubview:_paperFoldView];
        
        CGRect centerRect = CGRectMake(0, 0, 320, 460);
        
        _svc0 = [[ScheduleViewController alloc] initWithStyle:UITableViewStylePlain];
        _currentDayNum = 0;
        _svc0.dayNum = _currentDayNum;
        _svc0.tableView.frame = centerRect;
        _centerViewNav = [[UINavigationController alloc] initWithRootViewController:_svc0];
        [self addChildViewController:_centerViewNav];
        [_paperFoldView setCenterContentView:[_centerViewNav view]];
        
        _leftViewController = [[LeftViewController alloc] initWithNibName:nil bundle:nil];
        [_leftViewController setDelegate:self];
        [self addChildViewController:_leftViewController];
        [_paperFoldView setLeftFoldContentView:[_leftViewController view]];
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(-1,0,1,[self.view bounds].size.height)];
        [_paperFoldView.contentView addSubview:line];
        [line setBackgroundColor:[UIColor darkGrayColor]];
        
        [_paperFoldView setDelegate:self];
    }
    return self;
}

- (void)switchToDay:(int)dayNum {
    if (dayNum != _currentDayNum) {
        ScheduleViewController *svc = [[ScheduleViewController alloc] initWithStyle:UITableViewStylePlain];
        CGRect centerRect = CGRectMake(0, 0, 320, 460);
        svc.dayNum = dayNum;
        svc.tableView.frame = centerRect;
        NSArray *viewController = [NSArray arrayWithObject:svc];
        [_centerViewNav setViewControllers:viewController animated:NO];
        _currentDayNum = dayNum;
    }
    [self.paperFoldView setPaperFoldState:PaperFoldStateDefault];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


#pragma mark paper fold delegate

- (void)paperFoldView:(id)paperFoldView didTransitionToState:(PaperFoldState)paperFoldState
{
    NSLog(@"did transition to state %i", paperFoldState);
}


@end

