//
//  ExtensionCell.h
//  FAschedule
//
//  Created by Reed Rosenbluth on 8/30/12.
//
//

#import <UIKit/UIKit.h>

@interface ExtensionCell : UITableViewCell {
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
