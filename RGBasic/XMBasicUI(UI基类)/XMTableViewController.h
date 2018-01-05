//
//  XMTableViewController.h
//  RGBasic
//
//  Created by robin on 2017/5/20.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMViewController.h"
#import "XMTableViewCellDelegate.h"
/**
 使用说明
 1.cell必须实现- (void)XM_setValue:(id)value;
 2.不可编辑列表传输的datas格式:
    @{ 
        key : @[],
         .......
        key : @[],
     }
 3.可编辑列表传输的datas格式:
    [NSMutableDictionary dictionaryWithObject:[NSMutableArray array] forKey:id]
 
 4.为支持多cell样式key值为该section的所使用的cell
 5.cell上的事件传递在willdisplay中实现
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

@property (nonatomic ,strong)NSMutableDictionary *datas;
@property (nonatomic ,strong)UITableView *tabelList;


- (id)modelOfIndexPath:(NSIndexPath *)indexPath;
- (void)updateCell:(NSIndexPath *)indexPath value:(id)value animation:(UITableViewRowAnimation)animation;
- (void)insertCell:(NSIndexPath *)indexPath value:(id)value animation:(UITableViewRowAnimation)animation;
- (void)removeCell:(NSIndexPath *)indexPath animation:(UITableViewRowAnimation)animation;
@end
