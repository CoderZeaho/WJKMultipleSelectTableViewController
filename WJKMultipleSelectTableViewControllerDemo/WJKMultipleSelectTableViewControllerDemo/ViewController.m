//
//  ViewController.m
//  WJKMultipleSelectTableViewControllerDemo
//
//  Created by Zeaho on 2017/9/22.
//  Copyright © 2017年 Zeaho. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"

@interface WJKMultipleSelectTableViewController ()

- (void)didClickedDeleteButton:(UIButton *)sender;

- (void)didClickedSelectAllButton:(UIButton *)sender;

- (void)setEditing:(BOOL)editting animated:(BOOL)animated;

@property (nonatomic, assign) BOOL isAllChecked;

@property (nonatomic, strong) UIButton *selectAllButton;

@end

@interface ViewController ()
@end

@implementation ViewController

- (instancetype)init{
    if (self = [super init]) {
        self.title = @"离线缓存";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 50;
    [[self tableView] registerClass:[TableViewCell class] forCellReuseIdentifier:NSStringFromClass([TableViewCell class])];
    
    NSMutableArray *sectionDataSource = [NSMutableArray array];
    for (NSInteger i = 0; i < 20; i++) {
        Model *model = [[Model alloc] init];
        model.title = [NSString stringWithFormat:@"%ld",i];
        model.isChecked = NO;
        [sectionDataSource addObject:model];
    }
    self.dataSource = @[sectionDataSource];
}

#pragma mark - action
- (void)didClickedDeleteButton:(UIButton *)sender {
    
    [super didClickedDeleteButton:sender];
    
    NSMutableArray *copyDataSource = [NSMutableArray arrayWithArray:[self dataSource]];
    for (NSMutableArray *sectionArray in copyDataSource) {
        
        NSMutableArray *copySectionArray = [NSMutableArray arrayWithArray:sectionArray];
        [copySectionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([(Model *)obj isChecked] == YES) {

                [sectionArray removeObject:(Model *)obj];
            }
        }];
    }
    
    [[self tableView] reloadData];
}

- (void)didClickedSelectAllButton:(UIButton *)sender {
    
    [super didClickedSelectAllButton:sender];
    
    if (!self.isAllChecked && self.tableView.editing) {
        
        self.isAllChecked = !self.isAllChecked;
        //点击全选
        for (NSMutableArray *sectionArray in [self dataSource]) {
            [sectionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [(Model *)obj setIsChecked:YES];
            }];
        }

        [[self selectAllButton] setTitle:@"取消全选" forState:UIControlStateNormal];
        [[self selectAllButton] setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    } else
    if (self.isAllChecked && self.tableView.editing) {
        
        self.isAllChecked = !self.isAllChecked;
        //取消全选
        for (NSMutableArray *sectionArray in [self dataSource]) {
            [sectionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [(Model *)obj setIsChecked:NO];
            }];
        }
        
        [[self selectAllButton] setTitle:@"全选" forState:UIControlStateNormal];
        
        [[self selectAllButton] setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
        
    [[self tableView] reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    for (NSMutableArray *sectionArray in [self dataSource]) {
        [sectionArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [(Model *)obj setIsChecked:NO];
        }];
    }
}


#pragma mark - tableView delegate && dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *sectionDataSource = [NSMutableArray arrayWithArray:[[self dataSource] objectAtIndex:section] ?: @[]];
    return [sectionDataSource ?: @[] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *sectionDataSource = [NSMutableArray arrayWithArray:[[self dataSource] objectAtIndex:[indexPath section]] ?: @[]];
    Model *model = sectionDataSource[[indexPath row]];
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([TableViewCell class])];
    }
    cell.isChecked = model.isChecked;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *sectionDataSource = [NSMutableArray arrayWithArray:[[self dataSource] objectAtIndex:[indexPath section]] ?: @[]];
    Model *model = sectionDataSource[[indexPath row]];
    if (self.tableView.editing) {
        TableViewCell *cell = (TableViewCell*)[tableView cellForRowAtIndexPath:indexPath];
        model.isChecked = !model.isChecked;
        cell.isChecked = model.isChecked;
        NSLog(@"选择");
    } else {
        
        NSLog(@"跳转");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
