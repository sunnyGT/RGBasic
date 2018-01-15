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
@optional
- (void)didClickedVertifaButton:(UIButton *)button;
@end;

@protocol XMTextFieldTabelViewCellDelegate<NSObject>
@optional
- (BOOL)shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string textField:(UITextField *)textField;
@end

@interface XMFormViewController : XMViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong)UITableView *itemTable;
@property (nonatomic ,strong)NSMutableArray < NSMutableArray<XMForm *>* >*formItems;

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
  
}
@property (nonatomic ,assign)id <XMVertiCodeTabelViewCellDelegate>formDelegate;
@property (nonatomic ,strong)UIButton *vertiButton;
@end


@interface XMAccTabelViewCell : XMBasicTabelViewCell

@end
