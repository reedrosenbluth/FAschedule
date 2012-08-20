//
//  CustomCell.h
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 4/24/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
// Custom Cell for table in daily schedules.

#import <UIKit/UIKit.h>


@interface CustomCell : UITableViewCell {
    UILabel *timeLabel;
    UILabel *subjectLabel;
    UILabel *roomLabel;
    UILabel *blockLabel;
}

@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UILabel *subjectLabel;
@property (nonatomic, strong) IBOutlet UILabel *roomLabel;
@property (nonatomic, strong) IBOutlet UILabel *roomHeading;
@property (nonatomic, strong) IBOutlet UILabel *blockLabel;
@property (strong, nonatomic) IBOutlet UILabel *blockLabel2;

@end
