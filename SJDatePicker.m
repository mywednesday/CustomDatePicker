//
//  SJDatePicker.m
//  CustomDatePicker
//
//  Created by qnsoft on 15/11/26.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "SJDatePicker.h"



@interface SJDatePicker ()

@property (nonatomic, assign) CGFloat label_time_width;                         //容许包含startLabel、endLabel、startTime、endTime的矩形宽度
@property (nonatomic, assign) CGFloat label_time_height;                         //容许包含startLabel、endLabel、startTime、endTime的矩形高度

@property (nonatomic, assign) CGFloat start_end_label_left_space;               //startLabel到self左边界的距离,endLabel以中线为左边界
@property (nonatomic, assign) CGFloat start_end_time_left_space_to_label;       //startTime到startLabel的距离
@property (nonatomic, assign) CGFloat start_end_time_right_space_to_edge;       //endTime到self右边界的距离,startTime以中线为右边界
@property (nonatomic, assign) CGFloat start_end_time_top_space_to_edge;         //startTime和endTime到self上边界的距离
@property (nonatomic, assign) CGFloat start_end_time_bottom_space_to_edge;      //startTime和endTime到self下边界的距离


@property (nonatomic, assign) CGFloat start_end_label_width;            // //startLabel 和 endLabel的宽度
@property (nonatomic, assign) CGFloat start_end_label_height;            // //startLabel 和 endLabel的高度


@end





@implementation SJDatePicker

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
//        _label_time_width = self.frame.size.width;
//        _label_time_height = self.frame.size.height;
        
        _label_time_width = frame.size.width;
        _label_time_height = frame.size.height;
        _start_end_label_width = 20.0;
        _start_end_label_height = 20.0;
        _start_end_label_left_space = 10.0;
        _start_end_time_left_space_to_label = 0.0;
        _start_end_time_right_space_to_edge = 0.0;
        _start_end_time_top_space_to_edge = 0.0;
        _start_end_time_bottom_space_to_edge = 0.0;
        
        
        
        
        //标题Label
        if (!_titleLabel) {
            _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _label_time_width, 35)];
            _titleLabel.text = @"  营业时间";
            _titleLabel.textColor = [UIColor grayColor];
            _titleLabel.backgroundColor = [UIColor clearColor];
            _titleLabel.font = [UIFont systemFontOfSize:20.0];
            [self addSubview:_titleLabel];
        }
        
        //标题Label下方的分割线
        if (!_splitLineView) {
            _splitLineView = [[UIView alloc] initWithFrame:CGRectMake(frame.origin.x, _titleLabel.frame.origin.y + _titleLabel.frame.size.height,
                                                                      frame.size.width,
                                                                      1.0)];
            _splitLineView.backgroundColor = [UIColor grayColor];
            [self addSubview:_splitLineView];
        }
        
        
        //确定按钮
        if (!_okButton) {
            _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_okButton setBackgroundColor:[UIColor colorWithRed:(44)/255.0f green:(165)/255.0f blue:(89)/255.0f alpha:1]];
            [_okButton setTitle:@"确定" forState:UIControlStateNormal];
            [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            _okButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
            [_okButton addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            _okButton.frame = CGRectMake(10, _label_time_height - 42, _label_time_width - 20, 42);
            [self addSubview:_okButton];
        }
        
        
        
        
        
        
        _start_end_time_top_space_to_edge += (_splitLineView.frame.origin.y + _splitLineView.frame.size.height);
        _start_end_time_bottom_space_to_edge += _okButton.frame.size.height;
        
        
        //开始Label
        if (!_startLabel) {
            _startLabel = [[UILabel alloc] initWithFrame:CGRectMake(_start_end_label_left_space,
                                                                    (_label_time_height - _start_end_time_top_space_to_edge - _start_end_time_bottom_space_to_edge - _start_end_label_height) / 2 + _start_end_time_top_space_to_edge,
                                                                    _start_end_label_width,
                                                                    _start_end_label_height)];
            _startLabel.text = @"自";
            _startLabel.font = [UIFont systemFontOfSize:14.0];
            _startLabel.textColor = [UIColor colorWithRed:(44)/255.0f green:(165)/255.0f blue:(89)/255.0f alpha:1];
            [self addSubview:_startLabel];
        }
        
        
        
        //开始时间
        if(!_startTime) {
            _startTime = [[UIDatePicker alloc] initWithFrame:CGRectMake(_start_end_label_left_space + _start_end_label_width + _start_end_time_left_space_to_label,
                                                                        _start_end_time_top_space_to_edge,
                                                                        
                                                                        _label_time_width / 2 - (_start_end_label_left_space + _start_end_label_width + _start_end_time_left_space_to_label + _start_end_time_right_space_to_edge),
                                                                        
                                                                        _label_time_height - _start_end_time_top_space_to_edge - _start_end_time_bottom_space_to_edge)];
            _startTime.datePickerMode = UIDatePickerModeTime;
            [self addSubview:_startTime];
        }
        
        
        
        //结束Label
        if (!_endLabel) {
            _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(_label_time_width / 2 + _start_end_label_left_space,
                                                                  (_label_time_height - _start_end_time_top_space_to_edge - _start_end_time_bottom_space_to_edge - _start_end_label_height) / 2 + _start_end_time_top_space_to_edge,
                                                                    _start_end_label_width,
                                                                    _start_end_label_height)];
            _endLabel.text = @"至";
            _endLabel.font = [UIFont systemFontOfSize:14.0];
            _endLabel.textColor = [UIColor colorWithRed:(44)/255.0f green:(165)/255.0f blue:(89)/255.0f alpha:1];
            [self addSubview:_endLabel];
        }
        
        
        
        //结束时间
        if(!_endTime) {
            _endTime = [[UIDatePicker alloc] initWithFrame:CGRectMake(_label_time_width / 2 + _start_end_label_left_space + _start_end_label_width + _start_end_time_left_space_to_label,
                                                                      
                                                                      _start_end_time_top_space_to_edge,
                                                                      
                                                                      _label_time_width / 2 - (_start_end_label_left_space + _start_end_label_width + _start_end_time_left_space_to_label + _start_end_time_right_space_to_edge),
                                                                      
                                                                      _label_time_height - _start_end_time_top_space_to_edge - _start_end_time_bottom_space_to_edge)];
            _endTime.datePickerMode = UIDatePickerModeTime;
            [self addSubview:_endTime];
        }
        
        
        
        
        //确定按钮
        
        
        
    }
    return self;
}



- (void) drawRect:(CGRect)rect {
}



- (void) layoutSubviews {
    
}


/**
    确定按钮的点击事件
 */
- (void) okButtonClicked {
    
}









@end
