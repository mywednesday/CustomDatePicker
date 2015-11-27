//
//  SJDatePicker.m
//  GGSJ
//
//  Created by qnsoft on 15/11/27.
//  Copyright © 2015年 com.channelsoft. All rights reserved.
//

#import "SJDatePicker.h"




#define UIColorRGBA_SJDatePicker(r,g,b,a) ([UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a])
#define UIColorRGB_SJDatePicker(r,g,b) UIColorRGBA_SJDatePicker(r,g,b,1)
#define SCREEN_WIDTH_SJDatePicker ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT_SJDatePicker ([UIScreen mainScreen].bounds.size.height)



@interface SJDatePicker ()

@property (nonatomic, strong) UIButton *coverBtn;           //灰色的背景图层按钮
@property (nonatomic, strong) UIView *backContainerView;     //白色的控件容器图层



@property (nonatomic, assign) BOOL showing;                                     //是否是可见的


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




- (id) initWithDatePickerFrame:(CGRect) frameRect {
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        _label_time_width = frameRect.size.width;
        _label_time_height = frameRect.size.height;
    }
    
    return self;
}




- (void) viewDidLoad {
    
    //灰色的背景图层按钮
    self.coverBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.coverBtn.backgroundColor = UIColorRGBA_SJDatePicker(0, 0, 0, 0.4);
    self.coverBtn.frame = CGRectMake(0, 0, SCREEN_WIDTH_SJDatePicker, SCREEN_HEIGHT_SJDatePicker);
    [self.coverBtn addTarget:self action:@selector(coverBtnTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.coverBtn];
    
    
    //白色的控件容器图层
    self.backContainerView = [[UIView alloc] init];
    self.backContainerView.backgroundColor = [UIColor whiteColor];
    self.backContainerView.frame = CGRectMake((self.coverBtn.bounds.size.width - _label_time_width)/2,
                                              SCREEN_HEIGHT_SJDatePicker - _label_time_height,
                                              _label_time_width,
                                              _label_time_height);
    [self.coverBtn addSubview:self.backContainerView];
    
    
    
    
    
    
    
    
//    _label_time_width = self.view.frame.size.width;
//    _label_time_height = self.view.frame.size.height;
    _start_end_label_width = 15.0;
    _start_end_label_height = 15.0;
    _start_end_label_left_space = 5.0;
    _start_end_time_left_space_to_label = 0.0;
    _start_end_time_right_space_to_edge = 0.0;
    _start_end_time_top_space_to_edge = 0.0;
    _start_end_time_bottom_space_to_edge = 0.0;
    
    
    
    
    //标题Label
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _label_time_width, 45)];
        _titleLabel.text = @"  营业时间";
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.backgroundColor = self.backContainerView.backgroundColor;
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        [self.backContainerView addSubview:_titleLabel];
    }
    
    //标题Label下方的分割线
    if (!_splitLineView_1) {
        _splitLineView_1 = [[UIView alloc] initWithFrame:CGRectMake(self.backContainerView.frame.origin.x,
                                                                  _titleLabel.frame.origin.y + _titleLabel.frame.size.height,
                                                                  self.backContainerView.frame.size.width,
                                                                  1.0)];
        _splitLineView_1.backgroundColor = UIColorRGB_SJDatePicker(228, 228, 228);
        [self.backContainerView addSubview:_splitLineView_1];
    }
    
    
    //确定按钮
    if (!_okButton) {
        _okButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_okButton setBackgroundColor:[UIColor colorWithRed:(44)/255.0f green:(165)/255.0f blue:(89)/255.0f alpha:1]];
        [_okButton setTitle:@"确定" forState:UIControlStateNormal];
        [_okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _okButton.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_okButton addTarget:self action:@selector(okButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        _okButton.frame = CGRectMake(10, _label_time_height - 42 - 8, _label_time_width - 20, 42);
        [self.backContainerView addSubview:_okButton];
    }
    
    
    
    
    //按钮上方的分割线
    if (!_splitLineView_2) {
        _splitLineView_2 = [[UIView alloc] initWithFrame:CGRectMake(self.backContainerView.frame.origin.x,
                                                                    _okButton.frame.origin.y - 5,
                                                                    self.backContainerView.frame.size.width,
                                                                    1.0)];
        _splitLineView_2.backgroundColor = UIColorRGB_SJDatePicker(228, 228, 228);
        [self.backContainerView addSubview:_splitLineView_2];
    }
    
    
    
    
    
    _start_end_time_top_space_to_edge += (_splitLineView_1.frame.origin.y + _splitLineView_1.frame.size.height);
    _start_end_time_bottom_space_to_edge += (self.backContainerView.frame.size.height - _splitLineView_2.frame.origin.y);
    
    
    //开始Label
    if (!_startLabel) {
        _startLabel = [[UILabel alloc] initWithFrame:CGRectMake(_start_end_label_left_space,
                                                                (_label_time_height - _start_end_time_top_space_to_edge - _start_end_time_bottom_space_to_edge - _start_end_label_height) / 2 + _start_end_time_top_space_to_edge,
                                                                _start_end_label_width,
                                                                _start_end_label_height)];
        _startLabel.text = @"从";
        _startLabel.font = [UIFont systemFontOfSize:14.0];
        _startLabel.textColor = [UIColor grayColor];
        _startLabel.backgroundColor = self.backContainerView.backgroundColor;
        [self.backContainerView addSubview:_startLabel];
    }
    
    
    
    //开始时间
    if(!_startTime) {
        _startTime = [[UIDatePicker alloc] initWithFrame:CGRectMake(_start_end_label_left_space + _start_end_label_width + _start_end_time_left_space_to_label,
                                                                    _start_end_time_top_space_to_edge,
                                                                    
                                                                    _label_time_width / 2 - (_start_end_label_left_space + _start_end_label_width + _start_end_time_left_space_to_label + _start_end_time_right_space_to_edge),
                                                                    
                                                                    _label_time_height - _start_end_time_top_space_to_edge - _start_end_time_bottom_space_to_edge)];
        _startTime.datePickerMode = UIDatePickerModeTime;
        _startTime.backgroundColor = self.backContainerView.backgroundColor;
        [self.backContainerView addSubview:_startTime];
    }
    
    
    
    //结束Label
    if (!_endLabel) {
        _endLabel = [[UILabel alloc] initWithFrame:CGRectMake(_label_time_width / 2 + _start_end_label_left_space,
                                                              (_label_time_height - _start_end_time_top_space_to_edge - _start_end_time_bottom_space_to_edge - _start_end_label_height) / 2 + _start_end_time_top_space_to_edge,
                                                              _start_end_label_width,
                                                              _start_end_label_height)];
        _endLabel.text = @"至";
        _endLabel.font = [UIFont systemFontOfSize:14.0];
        _endLabel.textColor = [UIColor grayColor];
        _endLabel.backgroundColor = self.backContainerView.backgroundColor;
        [self.backContainerView addSubview:_endLabel];
    }
    
    
    
    //结束时间
    if(!_endTime) {
        _endTime = [[UIDatePicker alloc] initWithFrame:CGRectMake(_label_time_width / 2 + _start_end_label_left_space + _start_end_label_width + _start_end_time_left_space_to_label,
                                                                  
                                                                  _start_end_time_top_space_to_edge,
                                                                  
                                                                  _label_time_width / 2 - (_start_end_label_left_space + _start_end_label_width + _start_end_time_left_space_to_label + _start_end_time_right_space_to_edge),
                                                                  
                                                                  _label_time_height - _start_end_time_top_space_to_edge - _start_end_time_bottom_space_to_edge)];
        _endTime.datePickerMode = UIDatePickerModeTime;
        _endTime.backgroundColor = self.backContainerView.backgroundColor;
        [self.backContainerView addSubview:_endTime];
    }
    
    
    
    if(self){
        self.showing = NO;
    }
    self.view.hidden = YES;
    
    
}




/**
    点击了背景图层按钮
 */
- (void)coverBtnTouched:(UIButton *)coverBtn{
    [self show];
}




- (void) show {
    __weak typeof(self) weakSelf = self;
    if(self.showing){
        CGFloat height = self.backContainerView.bounds.size.height;
        CGRect rect = self.backContainerView.frame;
        rect.origin.y += height;
        self.backContainerView.alpha = 1.0;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.backContainerView.frame = rect;
        } completion:^(BOOL finished) {
            CGRect rect = self.backContainerView.frame;
            rect.origin.y -= height;
            weakSelf.backContainerView.frame = rect;
            weakSelf.view.hidden = YES;
            weakSelf.showing = NO;
        }];
        
        
        
    }else{
        CGFloat height = self.backContainerView.bounds.size.height;
        CGRect rect = self.backContainerView.frame;
        rect.origin.y += height;
        self.backContainerView.frame = rect;
        rect.origin.y -= height;
        self.view.hidden = NO;
        self.backContainerView.alpha = 1.0;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.backContainerView.frame = rect;
        } completion:^(BOOL finished) {
            weakSelf.showing = YES;
            self.view.hidden = NO;
            weakSelf.backContainerView.alpha = 1.0;
        }];
    }
}



/**
    确定按钮的点击事件
 */
- (void) okButtonClicked {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didDateSlectedWithStartDate:EndDate:)]) {
        [self.delegate didDateSlectedWithStartDate:_startTime.date EndDate:_endTime.date];
    }
    [self show];
}








@end
