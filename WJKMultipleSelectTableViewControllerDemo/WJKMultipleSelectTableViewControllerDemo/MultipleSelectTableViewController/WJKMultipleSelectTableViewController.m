//
//  WJKMultipleSelectTableViewController.m
//  iOSwujike
//
//  Created by Zeaho on 2017/8/28.
//  Copyright © 2017年 xhb_iOS. All rights reserved.
//

#import "WJKMultipleSelectTableViewController.h"
#import "WJKMultipleSelectTableViewCell.h"

const CGFloat WJKEditOperationViewHeight = 49.0f;

@implementation Model
@end

@interface WJKMultipleSelectTableViewController ()

@property (nonatomic, strong) UIButton *selectAllButton;

@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UIView *editOperationView;

@property (nonatomic, assign) BOOL isAllChecked;

@end

@implementation WJKMultipleSelectTableViewController


- (instancetype)init
{
    self = [super init];
    if (self) {
        UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStylePlain target:self  action:@selector(setEditing:animated:)];
        self.navigationItem.rightBarButtonItem = right;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.editOperationView = [[UIView alloc] initWithFrame:CGRectZero];
    self.editOperationView.frame = CGRectMake(0, SCREENHEIGHT - WJKEditOperationViewHeight, CGRectGetWidth(self.view.frame), WJKEditOperationViewHeight);
    self.editOperationView.hidden = YES;
    [[self view] addSubview:[self editOperationView]];
    
    [[self editOperationView] addSubview:[self selectAllButton]];
    [[self editOperationView] addSubview:[self deleteButton]];
    
    self.tableView.allowsSelectionDuringEditing = YES;
    [[self tableView]registerClass:[WJKMultipleSelectTableViewCell class] forCellReuseIdentifier:NSStringFromClass([WJKMultipleSelectTableViewCell class])];
    [[self tableView] reloadData];
}

#pragma mark - action
- (void)didClickedSelectAllButton:(UIButton *)sender {
}

- (void)didClickedDeleteButton:(UIButton *)sender {
}

- (void)setEditing:(BOOL)editting animated:(BOOL)animated {
    // 初始化状态
    
    self.isAllChecked = NO;
    
    [[self selectAllButton] setTitle:@"全选" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.title = self.tableView.editing ? @"编辑" : @"取消";
    
    [[self tableView] setEditing:!self.tableView.editing animated:YES];
    
    self.editOperationView.hidden = !self.tableView.editing;
    
    [[self tableView] performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
    
    if(self.tableView.editing) {
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.bottom += WJKEditOperationViewHeight;
        self.tableView.contentInset = insets;
    } else {
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.bottom -= WJKEditOperationViewHeight;
        self.tableView.contentInset = insets;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self dataSource] count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *sectionDataSource = [NSMutableArray arrayWithArray:[[self dataSource] firstObject] ?: @[]];
    return [sectionDataSource ?: @[] count];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WJKMultipleSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([WJKMultipleSelectTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[WJKMultipleSelectTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([WJKMultipleSelectTableViewCell class])];
    }
    
    NSMutableArray *sectionArray = [NSMutableArray arrayWithArray:[[self dataSource] firstObject]];
    Model *model = sectionArray[[indexPath row]];
    cell.textLabel.text = model.title;
    cell.isChecked = model.isChecked;
    return cell;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSMutableArray *sectionArray = [NSMutableArray arrayWithArray:[[self dataSource] firstObject]];
    Model *model = [sectionArray objectAtIndex:indexPath.row];
    if (self.tableView.editing) {
        WJKMultipleSelectTableViewCell *cell = (WJKMultipleSelectTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        model.isChecked = !model.isChecked;
        cell.isChecked = model.isChecked;
    }
}

#pragma mark - accessor
- (UIButton *)selectAllButton {
    if (!_selectAllButton) {
        _selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
        [_selectAllButton setBackgroundColor:[UIColor whiteColor]];
        [_selectAllButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _selectAllButton.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame)*.5f, WJKEditOperationViewHeight);
        [_selectAllButton addTarget:self action:@selector(didClickedSelectAllButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAllButton;
}

- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setBackgroundColor:[UIColor whiteColor]];
        [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _deleteButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)*.5f, 0, CGRectGetWidth(self.view.frame)*.5f, WJKEditOperationViewHeight);
        [_deleteButton addTarget:self action:@selector(didClickedDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
