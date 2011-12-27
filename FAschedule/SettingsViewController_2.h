//
//  SettingsViewController_2.h
//  FAschedule
//
//  Created by Jeffrey Rosenbluth on 5/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kEmptyString @""

@class SettingsViewController_3;

@interface SettingsViewController_2 : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> 
{
    UITextField *roomField;
    UITableView *subjectsTable;
    UILabel *subjectLabel;
    NSDictionary *subjects;
    NSArray *keys;
    SettingsViewController_3 *svc3;
    NSString *svc3Title;
    NSString *blockCode;
    NSString *subject;
    NSString *room;
    NSMutableArray *days;

}

@property (nonatomic, strong) IBOutlet UITextField *roomField;
@property (nonatomic, strong) IBOutlet UITableView *subjectsTable;
@property (nonatomic, strong) IBOutlet UILabel *subjectLabel;
@property (nonatomic, strong) IBOutlet NSDictionary *subjects;
@property (nonatomic, strong) IBOutlet NSArray *keys;
@property (nonatomic, copy) NSString *blockCode;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *room;
@property (nonatomic, strong) NSMutableArray *days;
@property (nonatomic, copy) NSString *svc3Title;



- (IBAction) textFieldDidEndEditing:(UITextField *)textField;
- (void)showBlock;

@end
