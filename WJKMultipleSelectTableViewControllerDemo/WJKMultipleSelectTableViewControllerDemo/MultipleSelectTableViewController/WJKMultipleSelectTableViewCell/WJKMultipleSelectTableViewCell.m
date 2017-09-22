//
//  WJKMultipleSelectTableViewCell.m
//  iOSwujike
//
//  Created by Zeaho on 2017/8/28.
//  Copyright © 2017年 xhb_iOS. All rights reserved.
//

#import "WJKMultipleSelectTableViewCell.h"

@interface WJKMultipleSelectTableViewCell ()

@property (nonatomic, strong) UIImageView *checkImageView;

@end

@implementation WJKMultipleSelectTableViewCell

- (void)dealloc
{
    self.checkImageView = nil;
}

- (void)setCheckImageViewCenter:(CGPoint)pt alpha:(CGFloat)alpha animated:(BOOL)animated {
    if (animated) {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        
        self.checkImageView.center = pt;
        self.checkImageView.alpha = alpha;
        
        [UIView commitAnimations];
    } else {
        self.checkImageView.center = pt;
        self.checkImageView.alpha = alpha;
    }
}


- (void)setEditing:(BOOL)editting animated:(BOOL)animated {
    if (self.editing == editting) {
        return;
    }
    
    [super setEditing:editting animated:animated];
    
    if (editting) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        if (self.checkImageView == nil) {
            self.checkImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"对勾"]];
            [self addSubview:[self checkImageView]];
        }
        
        [self setIsChecked:[self isChecked]];
        self.checkImageView.center = CGPointMake(-CGRectGetWidth(self.checkImageView.frame) * 0.5,
                                              CGRectGetHeight(self.bounds) * 0.5);
        self.checkImageView.alpha = 0.0;
        [self setCheckImageViewCenter:CGPointMake(20.5, CGRectGetHeight(self.bounds) * 0.5)
                                alpha:1.0 animated:animated];
    } else {
        self.isChecked = NO;
        self.backgroundView = nil;
        if (self.checkImageView) {
            [self setCheckImageViewCenter:CGPointMake(-CGRectGetWidth(self.checkImageView.frame) * 0.5,
                                                      CGRectGetHeight(self.bounds) * 0.5)
                                    alpha:0.0
                                 animated:animated];
        }
    }
}

- (void)setIsChecked:(BOOL)isChecked {
    if (isChecked) {
        self.checkImageView.image = [UIImage imageNamed:@"对勾选中"];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
    } else {
        self.checkImageView.image = [UIImage imageNamed:@"对勾"];
        self.backgroundView.backgroundColor = [UIColor whiteColor];
    }
    _isChecked = isChecked;
}

@end
