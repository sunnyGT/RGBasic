//
//  XMFormViewController.h
//  RGBasic
//
//  Created by robin on 2017/11/20.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMViewController.h"
#import "XMForm.h"
#import "UIButton+Tools.h"

@protocol XMVertiCodeTabelViewCellDelegate<NSObject>

- (void)didClickedVertifaButton:(UIButton *)button timer:(dispatch_source_t)timer;
@end;

@protocol XMTextFieldTabelViewCellDelegate<NSObject>

- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string textField:(UITextField *)textField;
@end

@interface XMFormViewController : XMViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *itemTable;
@property (nonatomic ,strong)NSMutableDictionary <id ,NSMutableArray<XMForm *>* >*data;

- (XMForm *)formInData:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface XMBasicTabelViewCell : UITableViewCell

@property (nonatomic ,strong)XMForm *form;
- (void)setupValueWithForm:(XMForm *)form;
- (void)configureFormAppearence;
@end

@interface XMTextFiledTabelViewCell : XMBasicTabelViewCell<UITextFieldDelegate>
@property (nonatomic ,weak) id <XMTextFieldTabelViewCellDelegate>formTextFieldDelegate;
@property (nonatomic ,strong) UITextField *textField;
@property (nonatomic ,strong) UILabel *titleLabel;
@end

@interface XMVertiCodeTabelViewCell:XMTextFiledTabelViewCell{
    dispatch_source_t _timer;
}
@property (nonatomic ,assign)id <XMVertiCodeTabelViewCellDelegate>formDelegate;
@property (nonatomic ,strong)UIButton *vertiButton;
@end


@interface XMAccTabelViewCell : XMBasicTabelViewCell

@end
