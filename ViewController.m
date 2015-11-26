//
//  ViewController.m
//  CustomDatePicker
//
//  Created by qnsoft on 15/11/26.
//  Copyright © 2015年 wzp. All rights reserved.
//

#import "ViewController.h"
#import "SJDatePicker.h"



@interface ViewController ()

@property (nonatomic, strong) SJDatePicker *myDatePicker;
@end





@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(!_myDatePicker) {
        _myDatePicker = [[SJDatePicker alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200)];
        _myDatePicker.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_myDatePicker];
        
    }
    
    
    
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
