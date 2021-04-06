//
//  BACustomDatePickerView.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/6.
//

#import "BACustomDatePickerView.h"
#import "BABasePickerView.h"

#import "BAPickerToolBarView.h"

@interface BACustomDatePickerView ()

@property(nonatomic, strong) UIView *bgView;

@property(nonatomic, strong) BABasePickerView *pickerView;
@property(nonatomic, strong) BADatePickerModel *datePickerModel;

@property(nonatomic, strong) BAPickerToolBarView *toolBarView;

@property(nonatomic, copy) NSString *resultString;
@property(nonatomic, assign) NSInteger resultRow;
@property(nonatomic, assign) NSInteger resultComponent;
@property(nonatomic, strong) NSArray *resultArray;
@property(nonatomic, strong) NSMutableArray *selectedArray;

@property(nonatomic, assign) BOOL isCityPicker;
// 省 数组
@property (nonatomic, copy) NSMutableArray *yearArray;
// 城市 数组
@property (nonatomic, copy) NSMutableArray *monthArray;
// 区县 数组
@property (nonatomic, copy) NSMutableArray *dayArray;

@end

@implementation BACustomDatePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initData];
    }
    return self;
}

- (void)initUI {
    [self.contentView addSubview:self.bgView];
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

    [self.bgView addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.toolBarView.mas_bottom);
        make.left.right.offset(0);
        if (@available(iOS 11.0, *)) {
            make.bottom.mas_equalTo(self.mas_safeAreaLayoutGuideBottom);
        } else {
            make.bottom.offset(0);
        }
    }];

}

- (void)initData {

    BAKit_WeakSelf;
    self.toolBarView.onCancleButton = ^{
        BAKit_StrongSelf;
        [self dismiss];
    };
    self.toolBarView.onSureButton = ^{
        BAKit_StrongSelf

        [self dismiss];
    };
}

#pragma mark - setter, getter

- (void)setResultString:(NSString *)resultString {
    _resultString = resultString;

    self.toolBarView.result = resultString;
}

- (void)setConfigModel:(BADatePickerModel *)configModel {
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
        self.datePickerModel = configModel;
        self.toolBarView.toolBarModel = configModel.toolBarModel;
    }
}

- (void)setDatePickerModel:(BADatePickerModel *)datePickerModel {
    _datePickerModel = datePickerModel;

   

}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = UIView.new;
        _bgView.backgroundColor = UIColor.whiteColor;
    }
    return _bgView;
}

- (BAPickerToolBarView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = BAPickerToolBarView.new;
        _toolBarView.backgroundColor = UIColor.whiteColor;
    }
    return _toolBarView;
}

- (BABasePickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = BABasePickerView.new;
        BAKit_WeakSelf
        // 返回需要展示的列（columns）的数目
        _pickerView.onNumberOfComponentsInPickerView = ^NSInteger(UIPickerView * _Nonnull pickerView) {
            BAKit_StrongSelf
            return 0;
        };

        // 返回每一列的行（rows）数
        _pickerView.onNumberOfRowsInComponent = ^NSInteger(NSInteger component, UIPickerView * _Nonnull pickerView) {
           BAKit_StrongSelf
            return 0;
        };

        // 返回每一行的标题
        _pickerView.onTitleForRowAndComponent = ^NSString * _Nonnull(NSInteger row, NSInteger component, UIPickerView * _Nonnull pickerView) {
            BAKit_StrongSelf
            return nil;
        };

        // 选中每一行的标题
        _pickerView.onDidSelectRowAndComponent = ^(NSInteger row, NSInteger component, UIPickerView * _Nonnull pickerView) {
            BAKit_StrongSelf

        };

    }
    return _pickerView;
}

- (NSMutableArray *)selectedArray {
    if (!_selectedArray) {
        _selectedArray = @[].mutableCopy;
    }
    return _selectedArray;
}

- (NSMutableArray *)yearArray {
    if (!_yearArray) {
        _yearArray = @[].mutableCopy;
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray {
    if (!_monthArray) {
        _monthArray = @[].mutableCopy;
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray {
    if (!_dayArray) {
        _dayArray = @[].mutableCopy;
    }
    return _dayArray;
}


@end
