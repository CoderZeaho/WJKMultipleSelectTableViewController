//
//  WJKMultipleSelectTableViewCell.h
//  iOSwujike
//
//  Created by Zeaho on 2017/8/28.
//  Copyright © 2017年 xhb_iOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WJKMultipleSelectTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UIImageView *checkImageView;

@property (nonatomic, assign) BOOL isChecked;

- (void)setEditing:(BOOL)editting animated:(BOOL)animated;

@end
