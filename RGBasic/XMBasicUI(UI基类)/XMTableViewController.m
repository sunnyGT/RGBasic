//
//  XMTableViewController.m
//  RGBasic
//
//  Created by robin on 2017/5/20.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMTableViewController.h"
#import "UITableViewCell+Tool.h"
#import "Masonry.h"
#import "XMMacro.h"

@interface XMTableViewController (){
    
    NSString *cellIdentifer;
}

@end


@implementation XMTableViewController

- (void)viewWillLayoutSubviews{
    
    [super viewWillLayoutSubviews];
    [_tabelList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(NavigationBarBottomY);
        make.leading.trailing.bottom.mas_equalTo(0);
    }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tabelList];
}

- (void)setDatas:(NSMutableArray *)datas{

    _datas = [NSMutableArray arrayWithArray:datas];
    [_tabelList reloadData];
}

- (UITableView *)tabelList{
    
    if (!_tabelList) {
        _tabelList = [[UITableView alloc] initWithFrame:CGRectZero style:[self tableViewStyle]];
        _tabelList.delegate = self;
        _tabelList.dataSource = self;
        _tabelList.estimatedRowHeight = 44.f;
        _tabelList.estimatedSectionFooterHeight = 0;
        _tabelList.estimatedSectionHeaderHeight = 0;
        _tabelList.tableFooterView = [UIView new];
        if ([self respondsToSelector:@selector(cellClass)]) {
            cellIdentifer = NSStringFromClass([self cellClass]);
           [_tabelList registerClass:[self cellClass] forCellReuseIdentifier:cellIdentifer];
        }
        if ([self respondsToSelector:@selector(nibCellClass)]) {
            cellIdentifer = NSStringFromClass([self cellClass]);
            [_tabelList registerNib:[UINib nibWithNibName:NSStringFromClass([self nibCellClass]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellIdentifer];
        }
    }
    return _tabelList;
}

#pragma mark - tableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.datas.count?self.datas.count:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.datas[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    NSMutableArray *valueArr = self.datas[indexPath.section];
    id value = valueArr[indexPath.row];
    if ([cell respondsToSelector:NSSelectorFromString(@"XM_setValue:")]) {
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
       [cell performSelector:NSSelectorFromString(@"XM_setValue:") withObject:value];
#pragma clang diagnostic pop

    }
    return cell;
}

- (id)modelOfIndexPath:(NSIndexPath *)indexPath{
    
    NSMutableArray *valueArr = self.datas[indexPath.section];
    id value = valueArr[indexPath.row];
    return value;
}

#pragma mark - XMDelegate

- (UITableViewStyle)tableViewStyle{
    
    return UITableViewStylePlain;
}

- (Class)cellClass{
    
    return [UITableViewCell class];
}

- (BOOL)canbeDelete{
    
    return NO;
}

#pragma mark Tool

- (void)updateCell:(NSIndexPath *)indexPath value:(id)value animation:(UITableViewRowAnimation)animation{

    NSMutableArray *tempArr = self.datas[indexPath.section];
    [tempArr replaceObjectAtIndex:indexPath.row withObject:value];
    [self.tabelList reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)updateSection:(NSUInteger)section value:(NSMutableArray *)values animation:(UITableViewRowAnimation)animation{
    
    [self.datas replaceObjectAtIndex:section withObject:values];
    [self.tabelList reloadRowsAtIndexPaths:@[[NSIndexSet indexSetWithIndex:section]] withRowAnimation:animation];
    
}

- (void)insertCell:(NSIndexPath *)indexPath value:(id)value animation:(UITableViewRowAnimation)animation{
    
    NSMutableArray *tempArr = self.datas[indexPath.section];
    [tempArr insertObject:value atIndex:indexPath.row];
    [self.tabelList insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)insertSection:(NSUInteger)section value:(NSMutableArray *)value animation:(UITableViewRowAnimation)animation{

    [self.datas insertObject:value atIndex:section];
    [self.tabelList insertRowsAtIndexPaths:@[[NSIndexSet indexSetWithIndex:section]] withRowAnimation:animation];
}

- (void)removeCell:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation{

    NSMutableArray *tempArr = self.datas[indexPath.section];
    [tempArr removeObjectAtIndex:indexPath.row];
    [self.tabelList deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)removeSection:(NSUInteger)section animation:(UITableViewRowAnimation)animation{
    
    [self.datas removeObjectAtIndex:section];
    [self.tabelList deleteRowsAtIndexPaths:@[[NSIndexSet indexSetWithIndex:section]] withRowAnimation:animation];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return [self canbeDelete];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self removeCell:indexPath animation:0];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
