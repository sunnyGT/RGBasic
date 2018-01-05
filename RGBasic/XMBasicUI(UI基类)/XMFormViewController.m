//
//  XMFormViewController.m
//  RGBasic
//
//  Created by robin on 2017/11/20.
//  Copyright © 2017年 robin. All rights reserved.
//

#import "XMFormViewController.h"
#import "UITextField+WordLimit.h"

@protocol XMFormCellDelegate<NSObject>

@end

static UIView *XMFormsFirstResponder(UIView *view)
{
    if ([view isFirstResponder])
    {
        return view;
    }
    for (UIView *subview in view.subviews)
    {
        UIView *responder = XMFormsFirstResponder(subview);
        if (responder)
        {
            return responder;
        }
    }
    return nil;
}


@implementation XMBasicTabelViewCell
- (void)setupValueWithForm:(XMForm *)form{
    if (isNUllOrNil(form)) return;
    self.form = form;
}
- (void)configureFormAppearence{
    
}

@end


@implementation XMTextFiledTabelViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setupValueWithForm:(XMForm *)form{
    [super setupValueWithForm:form];
    self.titleLabel.text = form.title;
    self.textField.placeholder = form.placeHolder;
    self.textField.text = form.content;
    
    if (self.form.appearence) {
        [self configureFormAppearence];
    }
    if ([form conformsToProtocol:@protocol(XMFormDelegate)]) {
        self.textField.keyboardType = [[form valueForKeyPath:@"keyboardType"] integerValue];
    }
    
}

- (void)configureFormAppearence{
    if (!self.form.appearence) {
        return;
    }
    self.titleLabel.textColor = self.form.appearence.titleColor? : self.titleLabel.textColor;
    self.titleLabel.font = self.form.appearence.titleFont? :self.titleLabel.font;
    self.textField.textColor = self.form.appearence.contentColor? :self.textField.textColor;
    self.textField.font = self.form.appearence.contentFont? :self.textField.font;
    self.textField.textAlignment = self.form.appearence.textAlignment?  :self.textField.textAlignment;
    self.textField.keyboardType = self.form.appearence.keyBoardType? :self.textField.keyboardType;
    self.textField.secureTextEntry = self.form.appearence.isSecure;
    
    if (self.form.appearence.minLength && self.form.appearence.maxLength) {
         [self.textField configureMaxLength:self.form.appearence.maxLength minLength:self.form.appearence.minLength];
    }else if (self.form.appearence.minLength) {
        [self.textField configureMaxLength:NSIntegerMax minLength:self.form.appearence.minLength];
    }else if (self.form.appearence.maxLength) {
        [self.textField configureMaxLength:self.form.appearence.maxLength minLength:0];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.leading.mas_equalTo(15.f);
        make.trailing.mas_equalTo(_textField.mas_leading).offset(-5);
    }];
    
    [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.trailing.mas_equalTo(-35.f);
        make.height.mas_offset(44.f);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)setup{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    [[NSNotificationCenter defaultCenter] postNotificationName:UITextFieldTextDidBeginEditingNotification object:self.textField];
    self.textField.returnKeyType = UIReturnKeyDone;
    [self.titleLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.textAlignment = NSTextAlignmentRight;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeyDone;
    }
    return _textField;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([self.formTextFieldDelegate respondsToSelector:@selector(shouldChangeCharactersInRange:replacementString:textField:)]) {
      return [self.formTextFieldDelegate shouldChangeCharactersInRange:range replacementString:string textField:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    self.form.content = textField.text;
    return YES;
}

@end



@implementation XMVertiCodeTabelViewCell
- (void)setupValueWithForm:(XMForm *)form{
    [super setupValueWithForm:form];
    self.textField.keyboardType = UIKeyboardTypeNumberPad;
}

- (void)setup{
    [super setup];
    [self.contentView addSubview:self.vertiButton];
    self.textField.textAlignment = NSTextAlignmentCenter;
    
}



- (void)layoutSubviews{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(0);
        make.leading.mas_equalTo(15.f);
        make.trailing.mas_equalTo(self.textField.mas_leading).offset(-5);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.trailing.mas_equalTo(self.vertiButton.mas_leading).offset(-15);
        make.height.mas_offset(44.f);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.vertiButton mas_makeConstraints:^(MASConstraintMaker *make) {

        make.trailing.mas_equalTo(-15.f);
        make.height.mas_equalTo(27.f);
        make.width.mas_equalTo(80.f);
        make.centerY.mas_equalTo(self);

    }];
}

- (UIButton *)vertiButton{
    if (!_vertiButton) {
        _vertiButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_vertiButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_vertiButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _vertiButton.backgroundColor = ThemeTintColor;
        _vertiButton.layer.cornerRadius = 27/2.f;
        _vertiButton.layer.masksToBounds = YES;
        _vertiButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_vertiButton addTarget:self action:@selector(getVertiCode:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _vertiButton;
}

- (void)getVertiCode:(UIButton *)sender{
    
    if ([self.formDelegate respondsToSelector:@selector(didClickedVertifaButton: timer:)]) {
        [self.formDelegate didClickedVertifaButton:sender timer:_timer];
    }
}
@end



@implementation XMAccTabelViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
    }
    return self;
}

- (void)setupValueWithForm:(XMForm *)form{
    [super setupValueWithForm:form];
    if (form.appearence) {
        [self configureFormAppearence];
    }
    self.textLabel.text = form.title;
    [self setDetailTextLabelText:form];
}

- (void)configureFormAppearence{
    if (!self.form.appearence) {
        return;
    }
    self.textLabel.textColor = self.form.appearence.titleColor? : self.textLabel.textColor;
    self.textLabel.font = self.form.appearence.titleFont? :self.textLabel.font;
    self.detailTextLabel.textColor = self.form.appearence.contentColor? :self.detailTextLabel.textColor;
    self.detailTextLabel.font = self.form.appearence.contentFont? :self.detailTextLabel.font;
    self.detailTextLabel.textAlignment = self.form.appearence.textAlignment?  :self.detailTextLabel.textAlignment;
}

- (void)setDetailTextLabelText:(XMForm *)form{
    if (form.content) {
        self.detailTextLabel.text = form.content;
        self.detailTextLabel.textColor = [UIColor blackColor];
        self.detailTextLabel.textColor = self.form.appearence.contentColor? :self.detailTextLabel.textColor;
    }else{
        self.detailTextLabel.text = form.placeHolder;
        self.detailTextLabel.textColor = LightTextGrayColor;
    }
}

@end


@interface XMFormViewController (){
    UITapGestureRecognizer *tap;
}

@end

@implementation XMFormViewController

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self.itemTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(NavigationBarBottomY);
        make.leading.trailing.bottom.mas_equalTo(0);
    }];
}

- (void)setData:(NSMutableDictionary *)data{
    _data = [NSMutableDictionary dictionaryWithDictionary:data];
    [self.itemTable reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.itemTable];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}


- (UITapGestureRecognizer *)tap{
    if (!tap) {
        tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignResponder:)];
        [self.view addGestureRecognizer:tap];
    }
    tap.enabled = YES;
    return tap;
}

- (void)resignResponder:(UITapGestureRecognizer *)sender{
    [self.view endEditing:YES];
}

- (void)showKeyboard:(NSNotification *)sender{
    
    UIView * selectView = XMFormsFirstResponder(self.itemTable);
    NSDictionary *userInfo = sender.userInfo;
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGRect viewRect = selectView.frame;
    CGRect overRect = [self.view convertRect:viewRect fromView:selectView.superview];
    if (CGRectIntersectsRect(keyboardRect, overRect)) {
        CGPoint tempOffset = CGPointMake(self.itemTable.contentOffset.x,self.itemTable.contentOffset.y + fabs( CGRectGetMaxY(overRect) - CGRectGetMinY(keyboardRect)));
        [self.itemTable setContentOffset:tempOffset];
    }
    [self tap];
}

- (void)hideKeyboard:(NSNotification *)sender{
    tap.enabled = NO;
}

- (UITableView *)itemTable{
    if (!_itemTable) {
        _itemTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _itemTable.delegate = self;
        _itemTable.dataSource = self;
        _itemTable.estimatedRowHeight = 10.f;
        _itemTable.estimatedSectionFooterHeight = 0.f;
        _itemTable.estimatedSectionHeaderHeight = 0.f;
        _itemTable.rowHeight = UITableViewAutomaticDimension;
        _itemTable.tableFooterView = [UIView new];
        _itemTable.backgroundColor = VCBackgroudColor;
        [_itemTable registerClass:[XMAccTabelViewCell class] forCellReuseIdentifier:NSStringFromClass([XMAccTabelViewCell class])];
        
        [_itemTable registerClass:[XMTextFiledTabelViewCell class] forCellReuseIdentifier:NSStringFromClass([XMTextFiledTabelViewCell class])];
        
        
        [_itemTable registerClass:[XMVertiCodeTabelViewCell class] forCellReuseIdentifier:NSStringFromClass([XMVertiCodeTabelViewCell class])];

    }
    return _itemTable;
}


- (XMForm *)formInData:(NSIndexPath *)indexPath{

    id temp = self.data[@(indexPath.section)][indexPath.row];
    XMForm *form = (XMForm *)temp;
    return form;
}


- (NSString *)cellIdentifier:(FormType)type{
    switch (type) {
        case Form_TextField:
            return NSStringFromClass([XMTextFiledTabelViewCell class]);
            break;
        case Form_Accessory:
            return NSStringFromClass([XMAccTabelViewCell class]);
            break;
        case Form_Vertica:
            return NSStringFromClass([XMVertiCodeTabelViewCell class]);
            break;
        default:
            break;
    }
    return @"";
}
#pragma mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.data.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  [self.data[@(section)] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XMForm *form = [self formInData:indexPath];
    XMBasicTabelViewCell *cell = (XMBasicTabelViewCell *)[tableView dequeueReusableCellWithIdentifier:[self cellIdentifier:form.formType]];
    [cell setupValueWithForm:form];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.view endEditing:YES];
    XMForm *form = [self formInData:indexPath];
    if (form.formType != Form_Accessory) return;
    [self didSelectRowAtIndexPath:indexPath];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
