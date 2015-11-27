//
//  SJDatePicker.h
//  GGSJ
//
//  Created by qnsoft on 15/11/27.
//  Copyright © 2015年 com.channelsoft. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SJDatePickerDelegate <NSObject>
@optional
- (void) didDateSlectedWithStartDate:(NSDate *)startDate EndDate:(NSDate *) endDate;
@end









@interface SJDatePicker : UIViewController


@property (nonatomic, strong) UILabel *titleLabel;          //标题Label
@property (nonatomic, strong) UIView *splitLineView_1;        //标题Label下方的分割线
@property (nonatomic, strong) UIView *splitLineView_2;        //按钮上方的分割线
@property (nonatomic, strong) UIButton *okButton;           //确定按钮
@property (nonatomic, strong) UILabel *startLabel;          //开始Label
@property (nonatomic, strong) UILabel *endLabel;            //结束Label
@property (nonatomic, strong) UIDatePicker *startTime;      //开始时间
@property (nonatomic, strong) UIDatePicker *endTime;        //结束时间

- (id) initWithDatePickerFrame:(CGRect) frameRect;
- (void) show;

@property (nonatomic, weak) id<SJDatePickerDelegate> delegate;

@end
