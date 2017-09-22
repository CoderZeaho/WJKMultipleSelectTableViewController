//
//  WJKMultipleSelectTableViewController.m
//  iOSwujike
//
//  Created by Zeaho on 2017/8/28.
//  Copyright © 2017年 xhb_iOS. All rights reserved.
//

#import "WJKMultipleSelectTableViewController.h"
#import "WJKMultipleSelectTableViewCell.h"

@implementation Item
@end

@interface WJKMultipleSelectTableViewController ()

@property (nonatomic, strong) UIButton *selectAllButton;

@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, strong) UIView *editOperationView;

@end

@implementation WJKMultipleSelectTableViewController {
    BOOL _recordAllCheckedStatus;
}

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
    
    self.tableView.allowsSelectionDuringEditing = YES;
    
    self.editOperationView = [[UIView alloc] initWithFrame:CGRectZero];
    self.editOperationView.frame = CGRectMake(0, SCREENHEIGHT - kBottomBarHeight, CGRectGetWidth(self.view.frame), kBottomBarHeight);
    self.editOperationView.hidden = YES;
    [[self view] addSubview:[self editOperationView]];
    
    [[self editOperationView] addSubview:[self selectAllButton]];
    [[self editOperationView] addSubview:[self deleteButton]];
    
    [[self tableView] reloadData];
}

#pragma mark - accessor
- (UIEdgeInsets)contentInset {
    return UIEdgeInsetsMake(0, 0, kTopBarHeight + kBottomBarHeight + kStatusBarHeight, 0);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - action
- (void)didClickedSelectAllButton:(UIButton *)sender {
    if (!_recordAllCheckedStatus && self.tableView.editing) {
        [[self selectAllButton] setTitle:@"取消全选" forState:UIControlStateNormal];
        _recordAllCheckedStatus = YES;
    } else
    if (_recordAllCheckedStatus && self.tableView.editing) {
        [[self selectAllButton] setTitle:@"全选" forState:UIControlStateNormal];
        _recordAllCheckedStatus = NO;
    }
}

- (void)didClickedDeleteButton:(UIButton *)sender {
}

- (void)setEditing:(BOOL)editting animated:(BOOL)animated {
    // 初始化状态
    [[self selectAllButton] setTitle:@"全选" forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.title = self.tableView.editing ? @"编辑" : @"取消";
    [[self tableView] setEditing:!self.tableView.editing animated:YES];
    [[self tableView] performSelector:@selector(reloadData) withObject:nil afterDelay:0.3];
    self.editOperationView.hidden = !self.tableView.editing;
    if(self.tableView.editing) {
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.bottom += kBottomBarHeight;
        self.tableView.contentInset = insets;
    } else {
        UIEdgeInsets insets = self.tableView.contentInset;
        insets.bottom -= kBottomBarHeight;
        self.tableView.contentInset = insets;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
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
    static NSString *CellIdentifier = @"Cell";
    WJKMultipleSelectTableViewCell *cell = (WJKMultipleSelectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[WJKMultipleSelectTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        cell.textLabel.font = [cell.textLabel.font fontWithSize:17];
    }
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.textColor = [UIColor blackColor];
    
    NSMutableArray *sectionArray = [NSMutableArray arrayWithArray:[[self dataSource] firstObject]];
    Item *item = [sectionArray objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    cell.isChecked = item.isChecked;
    return cell;;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *sectionArray = [NSMutableArray arrayWithArray:[[self dataSource] firstObject]];
    Item *item = [sectionArray objectAtIndex:indexPath.row];
    if (self.tableView.editing) {
        WJKMultipleSelectTableViewCell *cell = (WJKMultipleSelectTableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        item.isChecked = !item.isChecked;
        cell.isChecked = item.isChecked;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - accessor
- (UIButton *)selectAllButton {
    if (!_selectAllButton) {
        _selectAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectAllButton setTitle:@"全选" forState:UIControlStateNormal];
        [_selectAllButton setBackgroundColor:[UIColor whiteColor]];
        [_selectAllButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _selectAllButton.frame = CGRectMake(0, 0, SCREENWIDTH/2, kBottomBarHeight);
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
        _deleteButton.frame = CGRectMake(SCREENWIDTH/2, 0, SCREENWIDTH/2, kBottomBarHeight);
        [_deleteButton addTarget:self action:@selector(didClickedDeleteButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
