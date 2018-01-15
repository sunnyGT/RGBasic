//
//  XMTableViewController.h
//  RGBasic
//
//  Created by robin on 2017/5/20.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMViewController.h"

@protocol XMTableViewCellDelegate;
/**
 使用说明
   目前只之前一个页面只有一种cell的情况,多种cell未完成
 
 1.cell必须实现- (void)XM_setValue:(id)value;
 2.列表传输的datas格式:
 内部一个数组即表示一个section
    @[
        @[],
        @[]
     ];

 3.cell上的事件传递在willdisplay中实现
 */
@protocol XMTableViewControllerDelegate <NSObject>

@optional
- (Class<XMTableViewCellDelegate>)cellClass;
- (Class<XMTableViewCellDelegate>)nibCellClass;
- (BOOL)canbeDelete;
- (UITableViewStyle)tableViewStyle;
@end

@interface XMTableViewController : XMViewController<XMTableViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,weak)id<XMTableViewControllerDelegate>delegate;

@property (nonatomic ,strong)NSMutableArray *datas;
@property (nonatomic ,strong)UITableView *tabelList;


- (id)modelOfIndexPath:(NSIndexPath *)indexPath;

//更新cell数据
- (void)updateCell:(NSIndexPath *)indexPath value:(id)value animation:(UITableViewRowAnimation)animation;
- (void)insertCell:(NSIndexPath *)indexPath value:(id)value animation:(UITableViewRowAnimation)animation;
- (void)removeCell:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation;

//更新sectoin数据
- (void)updateSection:(NSUInteger)section value:(NSMutableArray *)values animation:(UITableViewRowAnimation)animation;

- (void)insertSection:(NSUInteger)section value:(NSMutableArray *)value animation:(UITableViewRowAnimation)animation;

- (void)removeSection:(NSUInteger)section animation:(UITableViewRowAnimation)animation;

@end
