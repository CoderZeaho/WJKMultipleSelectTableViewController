//
//  WJKMultipleSelectTableViewCell.h
//  iOSwujike
//
//  Created by Zeaho on 2017/8/28.
//  Copyright © 2017年 xhb_iOS. All rights reserved.
//

#import "WJKBaseTableViewCell.h"

@interface WJKMultipleSelectTableViewCell : WJKBaseTableViewCell
{
@private
    UIImageView*	m_checkImageView;
    BOOL			m_checked;
}

- (void)setChecked:(BOOL)checked;

- (void)setEditing:(BOOL)editting animated:(BOOL)animated;

@end
