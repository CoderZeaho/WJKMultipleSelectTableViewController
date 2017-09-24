//
//  WJKMultipleSelectTableViewController.h
//  iOSwujike
//
//  Created by Zeaho on 2017/8/28.
//  Copyright © 2017年 xhb_iOS. All rights reserved.
//

#import "ZHBaseTableViewController.h"

@interface Model : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isChecked;
@end

@interface WJKMultipleSelectTableViewController : ZHBaseTableViewController

@end
