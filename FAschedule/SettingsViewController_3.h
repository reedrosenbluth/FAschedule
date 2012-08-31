//
//  SettingsViewController_3.h
//  FAschedule
//
//  Created by Reed Rosenbluth on 5/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SettingsViewController_3 : UITableViewController {
    NSArray *dataSource;
    NSString *blockCode;
    NSMutableArray *tempDays;
}

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) NSString *blockCode;
@property (nonatomic, strong) NSMutableArray *tempDays;

@end
