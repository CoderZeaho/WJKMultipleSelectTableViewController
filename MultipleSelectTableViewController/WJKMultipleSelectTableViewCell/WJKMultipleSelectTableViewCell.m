//
//  WJKMultipleSelectTableViewCell.m
//  iOSwujike
//
//  Created by Zeaho on 2017/8/28.
//  Copyright © 2017年 xhb_iOS. All rights reserved.
//

#import "WJKMultipleSelectTableViewCell.h"

@interface WJKMultipleSelectTableViewCell ()

@end

@implementation WJKMultipleSelectTableViewCell

- (void)dealloc
{
    m_checkImageView = nil;
}

- (void)setCheckImageViewCenter:(CGPoint)pt alpha:(CGFloat)alpha animated:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        m_checkImageView.center = pt;
        m_checkImageView.alpha = alpha;
        
        [UIView commitAnimations];
    } else {
        m_checkImageView.center = pt;
        m_checkImageView.alpha = alpha;
    }
}


- (void)setEditing:(BOOL)editting animated:(BOOL)animated {
    if (self.editing == editting) {
        return;
    }
    
    [super setEditing:editting animated:animated];
    
    if (editting) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (m_checkImageView == nil) {
            m_checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"对勾"]];
            [self addSubview:m_checkImageView];
        }
        
        [self setChecked:m_checked];
        m_checkImageView.center = CGPointMake(-CGRectGetWidth(m_checkImageView.frame) * 0.5,
                                              CGRectGetHeight(self.bounds) * 0.5);
        m_checkImageView.alpha = 0.0;
        [self setCheckImageViewCenter:CGPointMake(20.5, CGRectGetHeight(self.bounds) * 0.5)
                                alpha:1.0 animated:animated];
    } else {
        m_checked = NO;
        self.backgroundView = nil;
        if (m_checkImageView) {
            [self setCheckImageViewCenter:CGPointMake(-CGRectGetWidth(m_checkImageView.frame) * 0.5,
                                                      CGRectGetHeight(self.bounds) * 0.5)
                                    alpha:0.0
                                 animated:animated];
        }
    }
}

- (void)setChecked:(BOOL)checked {
    if (checked) {
        m_checkImageView.image = [UIImage imageNamed:@"对勾选中"];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
    } else {
        m_checkImageView.image = [UIImage imageNamed:@"对勾"];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    m_checked = checked;
}

@end
