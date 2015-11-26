//
//  SJDatePicker.h
//  CustomDatePicker
//
//  Created by qnsoft on 15/11/26.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SJDatePicker : UIView

@property (nonatomic, strong) UILabel *titleLabel;          //标题Label
@property (nonatomic, strong) UIView *splitLineView;        //标题Label下方的分割线
@property (nonatomic, strong) UIButton *okButton;           //确定按钮
@property (nonatomic, strong) UILabel *startLabel;          //开始Label
@property (nonatomic, strong) UILabel *endLabel;            //结束Label
@property (nonatomic, strong) UIDatePicker *startTime;      //开始时间
@property (nonatomic, strong) UIDatePicker *endTime;        //结束时间

@end
