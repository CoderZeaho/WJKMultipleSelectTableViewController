//
//  TableViewCell.m
//  WJKMultipleSelectTableViewControllerDemo
//
//  Created by Zeaho on 2017/9/24.
//  Copyright © 2017年 Zeaho. All rights reserved.
//

#import "TableViewCell.h"

@interface TableViewCell ()

@property (nonatomic, strong) UIImageView *coverImageView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _createSubviews];
        [self _configurateSubviewsDefault];
        [self _installConstraints];
    }
    return self;
}


- (void)_createSubviews {
    
    self.coverImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.coverImageView.backgroundColor = [UIColor greenColor];
    [[self contentView] addSubview:[self coverImageView]];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = @"哈哈哈";
    [[self contentView] addSubview:[self titleLabel]];
}

- (void)_configurateSubviewsDefault {
    
}

- (void)_installConstraints {
    
    self.coverImageView.frame = CGRectMake(15, 15, 30, 30);
    
    self.titleLabel.frame = CGRectMake(self.coverImageView.frame.origin.x + self.coverImageView.frame.size.width + 8, 15, CGRectGetWidth(self.contentView.frame) - 15 - 30 - 8, 20);
}

@end
