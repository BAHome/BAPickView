//
//  BAPickerView.m
//  BApickerView
//
//  Created by 博爱 on 2021/4/1.
//

#import "BAPickerView.h"
#import "BAPickerToolBarView.h"

@interface BAPickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *titleBgView;
@property(nonatomic, strong) NSMutableArray <UILabel *>*titleLabelArray;

@property(nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic, strong) BAPickerModel *pickerModel;

@property(nonatomic, strong) BAPickerToolBarView *toolBarView;

@property(nonatomic, copy) NSString *resultString;
@property(nonatomic, strong) NSArray *resultArray;
@property(nonatomic, strong) NSMutableArray *selectedArray;

@end

@implementation BAPickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initData];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.bottom.offset(0);
        if (@available(iOS 11.0, *)) {
            make.height.mas_equalTo(self.safeAreaInsets.bottom+240);
        } else {
            make.height.mas_equalTo(240);
        }
    }];
    
    [self.bgView addSubview:self.toolBarView];
    [self.toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.offset(0);
        make.height.mas_equalTo(44);
    }];
    
    [self.bgView addSubview:self.titleBgView];
    [self.titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.toolBarView.mas_bottom);
        make.left.right.offset(0);
        make.height.mas_equalTo(30);
    }];
    
    [self.bgView addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleBgView.mas_bottom);
        make.left.right.offset(0);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.offset(0);
        }
    }];
    
    self.titleBgView.hidden = YES;
}

- (void)initData {
    
    BAKit_WeakSelf;
    self.toolBarView.onCancleButton = ^{
        BAKit_StrongSelf;
        [self dismiss];
    };
    self.toolBarView.onSureButton = ^{
        BAKit_StrongSelf
        
        self.onSelectPicker ? self.onSelectPicker(self.resultString, self.resultArray):nil;
        [self dismiss];
    };
}

#pragma mark - UIPickerViewDataSource
// 返回需要展示的列（columns）的数目
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.pickerModel.multipleStringsArray.count > 0 ? self.pickerModel.multipleStringsArray.count:1;
}

// 返回每一列的行（rows）数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerModel.multipleStringsArray.count > 0 ? [self.pickerModel.multipleStringsArray[component] count] : self.pickerModel.stringsArray.count;
}

#pragma mark - UIPickerViewDelegate
// 返回每一行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.pickerModel.multipleStringsArray.count > 0 ? self.pickerModel.multipleStringsArray[component][row] : self.pickerModel.stringsArray[row];
}

// 某一行被选择时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (self.pickerModel.multipleStringsArray.count > 0) {
        [self.selectedArray replaceObjectAtIndex:component withObject:self.pickerModel.multipleStringsArray[component][row]];
        self.resultArray = self.selectedArray;
    } else {
        NSString *resultString = self.pickerModel.stringsArray[row];
        self.resultString = resultString;
    }
}

#pragma mark - setter, getter

- (void)setResultString:(NSString *)resultString {
    _resultString = resultString;
    
    self.toolBarView.result = resultString;
}

- (void)setResultArray:(NSArray *)resultArray {
    _resultArray = resultArray;
    
    self.resultString = [self.selectedArray componentsJoinedByString:@","];
}

- (void)setConfigModel:(BAPickerConfigModel *)configModel {
    _configModel = configModel;
        
    // 公共配置：configModel
    {
        self.enableTouchDismiss = configModel.enableTouchDismiss;
        
        self.bgColor = configModel.maskViewBackgroundColor;
        self.pickerView.backgroundColor = configModel.pickerViewBackgroundColor;
                
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            if (@available(iOS 11.0, *)) {
                make.height.mas_equalTo(self.safeAreaInsets.bottom + configModel.pickerHeight);
            } else {
                make.height.mas_equalTo(configModel.pickerHeight);
            }
        }];
        
        [self.toolBarView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(configModel.toolBarHeight);
        }];
    }
    
    // 内容配置：datePickerModel、toolBarModel
    {
        self.pickerModel = configModel.pickerModel;
        self.toolBarView.toolBarModel = configModel.toolBarModel;
    }
}

- (void)setPickerModel:(BAPickerModel *)pickerModel {
    _pickerModel = pickerModel;
    
    if (pickerModel.multipleStringsArray.count > 0) {
        [self.selectedArray removeAllObjects];

        for (NSArray *arry in pickerModel.multipleStringsArray) {
            [self.selectedArray addObject:arry[0]];
        }
        self.resultArray = self.selectedArray;
        
        if (pickerModel.multipleTitleArray.count == pickerModel.multipleStringsArray.count) {
            self.titleBgView.hidden = NO;
            kBARemoveAllSubviews(self.titleBgView);
            [self.titleLabelArray removeAllObjects];
            
            BAKit_WeakSelf
            [pickerModel.multipleTitleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                BAKit_StrongSelf
                
                UILabel *titleLabel = UILabel.new;
                titleLabel.text = obj;
                titleLabel.textAlignment = NSTextAlignmentCenter;
                titleLabel.textColor = [UIColor blackColor];
                titleLabel.font = [UIFont systemFontOfSize:14];
                
                [self.titleBgView addSubview:titleLabel];
                [self.titleLabelArray addObject:titleLabel];
                
                [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {

                    //按钮从左到右总宽度
                    make.centerY.offset(0);
                    make.width.mas_equalTo(self.titleBgView.mas_width).multipliedBy(1.0/pickerModel.multipleTitleArray.count);
                    
                    if (idx == 0) {
                        make.left.offset(0);
                    } else {
                        make.left.mas_equalTo(self.titleLabelArray[idx-1].mas_right).offset(0);
                    }
                }];
            }];
            
        } else {
            [self.pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.toolBarView.mas_bottom);
            }];
        }
        
    } else {
        // 初始默认显示第一个数据
        self.resultString = self.pickerModel.stringsArray.firstObject;
        [self.pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.toolBarView.mas_bottom);
        }];
    }
    
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.backgroundColor = UIColor.whiteColor;
    }
    return _bgView;
}

- (UIView *)titleBgView {
    if (!_titleBgView) {
        _titleBgView = UIView.new;
        _titleBgView.backgroundColor = UIColor.clearColor;
    }
    return _titleBgView;
}

- (BAPickerToolBarView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = BAPickerToolBarView.new;
        _toolBarView.backgroundColor = UIColor.whiteColor;
    }
    return _toolBarView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = UIPickerView.new;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = @[].mutableCopy;
    }
    return _selectedArray;
}

- (NSMutableArray<UILabel *> *)titleLabelArray {
    if (!_titleLabelArray) {
        _titleLabelArray = @[].mutableCopy;
    }
    return _titleLabelArray;
}

@end
