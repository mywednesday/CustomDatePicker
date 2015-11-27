//
//  ViewController.m
//  CustomDatePicker
//
//  Created by qnsoft on 15/11/26.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "ViewController.h"
#import "SJDatePicker.h"



@interface ViewController ()<SJDatePickerDelegate>

@property (nonatomic, strong) SJDatePicker *myDatePicker;
@property (weak, nonatomic) IBOutlet UILabel *timeScopeLabel;
- (IBAction)showDatePicker:(id)sender;
@end





@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!_myDatePicker) {
        _myDatePicker = [[SJDatePicker alloc] initWithDatePickerFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
        _myDatePicker.delegate = self;
        [self.view addSubview:_myDatePicker.view];
        
    }
    
    
    
    
    
}



#pragma mark --- SJDatePickerDelegate ---
- (void) didDateSlectedWithStartDate:(NSDate *)startDate EndDate:(NSDate *)endDate {
    
    NSTimeZone* localzone = [NSTimeZone localTimeZone];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    [dateFormatter setTimeZone:localzone];
    NSString *startTime = [dateFormatter stringFromDate:startDate];
    NSString *endTime = [dateFormatter stringFromDate:endDate];
    
    
    self.timeScopeLabel.text = [NSString stringWithFormat:@"选择的时间范围是:%@-%@",startTime,endTime];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)showDatePicker:(id)sender {
    if (_myDatePicker) {
        [_myDatePicker show];
    }
}
@end
