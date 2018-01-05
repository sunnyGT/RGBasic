//
//  XMTableViewController.m
//  RGBasic
//
//  Created by robin on 2017/5/20.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMTableViewController.h"
#import "UITableViewCell+Tool.h"

@interface XMTableViewController ()

@end

static NSString *cellIdentifer;
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

- (void)setDatas:(NSMutableDictionary *)datas{

    _datas = [NSMutableDictionary dictionaryWithDictionary:datas];
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
    
    return self.datas.allKeys.count?self.datas.allKeys.count:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSString *key = self.datas.allKeys[section];
    return ((NSMutableArray *)self.datas[key]).count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    id key = self.datas.allKeys[indexPath.section];
    NSMutableArray *valueArr = self.datas[key];
    id value = valueArr[indexPath.row];
    if ([cell respondsToSelector:NSSelectorFromString(@"XM_setValue:")]) {
       [cell performSelector:NSSelectorFromString(@"XM_setValue:") withObject:value];
    }
    return cell;
}

- (id)modelOfIndexPath:(NSIndexPath *)indexPath{
    id key = self.datas.allKeys[indexPath.section];
    NSMutableArray *valueArr = self.datas[key];
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
    
    id key = self.datas.allKeys[indexPath.section];
    NSMutableArray *tempArr = [[self.datas objectForKey:key] mutableCopy];
    [tempArr replaceObjectAtIndex:indexPath.row withObject:value];
    [self.datas setObject:tempArr forKey:key];
    [self.tabelList reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)insertCell:(NSIndexPath *)indexPath value:(id)value animation:(UITableViewRowAnimation)animation{
    
    id key = self.datas.allKeys[indexPath.section];
    NSMutableArray *tempArr = [[self.datas objectForKey:key] mutableCopy];
    [tempArr insertObject:value atIndex:indexPath.row];
    [self.datas setObject:tempArr forKey:key];
    [self.tabelList insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
}

- (void)removeCell:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation{
    id key = self.datas.allKeys[indexPath.section];
    NSMutableArray *tempArr = [[self.datas objectForKey:key] mutableCopy];
    [tempArr removeObjectAtIndex:indexPath.row];
    [self.datas setObject:tempArr forKey:key];
    [self.tabelList deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
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
