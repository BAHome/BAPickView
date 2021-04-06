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
@property(nonatomic, strong) UIView *titleBgView;
@property(nonatomic, strong) NSMutableArray <UILabel *>*titleLabelArray;

@property(nonatomic, strong) BABasePickerView *pickerView;
@property(nonatomic, strong) BAPickerModel *pickerModel;

@property(nonatomic, strong) BAPickerToolBarView *toolBarView;

//@property(nonatomic, copy) NSString *resultString;
//@property(nonatomic, assign) NSInteger resultRow;
//@property(nonatomic, assign) NSInteger resultComponent;
//@property(nonatomic, strong) NSArray *resultArray;
//@property(nonatomic, strong) NSMutableArray *selectedArray;
//
//@property(nonatomic, assign) BOOL isCityPicker;
//// 省 数组
//@property (nonatomic, copy) NSMutableArray *yearArray;
//// 城市 数组
//@property (nonatomic, copy) NSMutableArray *monthArray;
//// 区县 数组
//@property (nonatomic, copy) NSMutableArray *dayArray;

@end

@implementation BACustomDatePickerView

//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self initUI];
//        [self initData];
//    }
//    return self;
//}
//
//- (void)initUI {
//    [self.contentView addSubview:self.bgView];
//    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.offset(0);
//        make.bottom.offset(0);
//        if (@available(iOS 11.0, *)) {
//            make.height.mas_equalTo(self.safeAreaInsets.bottom+240);
//        } else {
//            make.height.mas_equalTo(240);
//        }
//    }];
//
//    [self.bgView addSubview:self.toolBarView];
//    [self.toolBarView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.offset(0);
//        make.height.mas_equalTo(44);
//    }];
//
//    [self.bgView addSubview:self.titleBgView];
//    [self.titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.toolBarView.mas_bottom);
//        make.left.right.offset(0);
//        make.height.mas_equalTo(30);
//    }];
//
//    [self.bgView addSubview:self.pickerView];
//    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.titleBgView.mas_bottom);
//        make.left.right.offset(0);
//        if (@available(iOS 11.0, *)) {
//            make.bottom.mas_equalTo(self.mas_safeAreaLayoutGuideBottom);
//        } else {
//            make.bottom.offset(0);
//        }
//    }];
//
//    self.titleBgView.hidden = YES;
//}
//
//- (void)initData {
//
//    BAKit_WeakSelf;
//    self.toolBarView.onCancleButton = ^{
//        BAKit_StrongSelf;
//        [self dismiss];
//    };
//    self.toolBarView.onSureButton = ^{
//        BAKit_StrongSelf
//
//        [self dismiss];
//    };
//}
//
//#pragma mark - setter, getter
//
//- (void)setResultString:(NSString *)resultString {
//    _resultString = resultString;
//
//    self.toolBarView.result = resultString;
//}
//
//- (void)setConfigModel:(BAPickerConfigModel *)configModel {
//    _configModel = configModel;
//
//    // 公共配置：configModel
//    {
//        self.enableTouchDismiss = configModel.enableTouchDismiss;
//
//        self.bgColor = configModel.maskViewBackgroundColor;
//        self.pickerView.backgroundColor = configModel.pickerViewBackgroundColor;
//
//        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
//            if (@available(iOS 11.0, *)) {
//                make.height.mas_equalTo(self.safeAreaInsets.bottom + configModel.pickerHeight);
//            } else {
//                make.height.mas_equalTo(configModel.pickerHeight);
//            }
//        }];
//
//        [self.toolBarView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.height.mas_equalTo(configModel.toolBarHeight);
//        }];
//    }
//
//    // 内容配置：datePickerModel、toolBarModel
//    {
//        self.pickerModel = configModel.pickerModel;
//        self.toolBarView.toolBarModel = configModel.toolBarModel;
//    }
//}
//
//- (void)setPickerModel:(BAPickerModel *)pickerModel {
//    _pickerModel = pickerModel;
//
//    if (pickerModel.multipleStringsArray.count > 0) {
//        [self.selectedArray removeAllObjects];
//
//
//        [self.pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.toolBarView.mas_bottom);
//        }];
//
//    } else if (pickerModel.allProvinceCityArray.count > 0) {
//        self.isCityPicker = YES;
//
//        NSArray *allProvinceCityArray = pickerModel.allProvinceCityArray;
//
//        if (allProvinceCityArray.count > 0) {
//            [self.provinceArray removeAllObjects];
//            [self.cityArray removeAllObjects];
//            [self.areaArray removeAllObjects];
//
//            [allProvinceCityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [self.provinceArray addObject:obj[@"state"]];
//            }];
//
//            NSMutableArray *citys = allProvinceCityArray[0][@"cities"];
//            [citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                [self.cityArray addObject:obj[@"city"]];
//            }];
//
//            self.areaArray = citys[0][@"areas"];
//
//            // 设置城市选择器的默认值
//            self.selectedProvince = [self cutLocalString:self.provinceArray[0]];
//            self.selectedCity = [self cutLocalString:self.cityArray[0]];
//            self.selectedArea = 0 == self.areaArray.count ? @"" : [self cutLocalString:self.areaArray[0]];
//        }
//
//        [self.pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.toolBarView.mas_bottom);
//        }];
//    } else {
//        // 初始默认显示第一个数据
//        self.resultString = self.pickerModel.stringsArray.firstObject;
//        [self.pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(self.toolBarView.mas_bottom);
//        }];
//    }
//
//}
//
//- (UIView *)bgView {
//    if (!_bgView) {
//        _bgView = UIView.new;
//        _bgView.backgroundColor = UIColor.whiteColor;
//    }
//    return _bgView;
//}
//
//- (UIView *)titleBgView {
//    if (!_titleBgView) {
//        _titleBgView = UIView.new;
//        _titleBgView.backgroundColor = UIColor.clearColor;
//    }
//    return _titleBgView;
//}
//
//- (BAPickerToolBarView *)toolBarView {
//    if (!_toolBarView) {
//        _toolBarView = BAPickerToolBarView.new;
//        _toolBarView.backgroundColor = UIColor.whiteColor;
//    }
//    return _toolBarView;
//}
//
//- (BABasePickerView *)pickerView {
//    if (!_pickerView) {
//        _pickerView = BABasePickerView.new;
//        BAKit_WeakSelf
//        // 返回需要展示的列（columns）的数目
//        _pickerView.onNumberOfComponentsInPickerView = ^NSInteger(UIPickerView * _Nonnull pickerView) {
//            BAKit_StrongSelf
//
//        };
//
//        // 返回每一列的行（rows）数
//        _pickerView.onNumberOfRowsInComponent = ^NSInteger(UIPickerView * _Nonnull pickerView) {
//            BAKit_StrongSelf
//
//        };
//
//        // 返回每一行的标题
//        _pickerView.onTitleForRowAndComponent = ^NSString * _Nonnull(NSInteger row, NSInteger component, UIPickerView * _Nonnull pickerView) {
//            BAKit_StrongSelf
//
//        };
//
//        // 选中每一行的标题
//        _pickerView.onDidSelectRowAndComponent = ^(NSInteger row, NSInteger component, UIPickerView * _Nonnull pickerView) {
//            @strongify(self)
//            BAKit_StrongSelf
//
//        };
//
//    }
//    return _pickerView;
//}
//
//- (NSMutableArray *)selectedArray {
//    if (!_selectedArray) {
//        _selectedArray = @[].mutableCopy;
//    }
//    return _selectedArray;
//}
//
//- (NSMutableArray<UILabel *> *)titleLabelArray {
//    if (!_titleLabelArray) {
//        _titleLabelArray = @[].mutableCopy;
//    }
//    return _titleLabelArray;
//}
//
//- (NSMutableArray *)provinceArray {
//    if (!_provinceArray) {
//        _provinceArray = @[].mutableCopy;
//    }
//    return _provinceArray;
//}
//
//- (NSMutableArray *)cityArray {
//    if (!_cityArray) {
//        _cityArray = @[].mutableCopy;
//    }
//    return _cityArray;
//}
//
//- (NSMutableArray *)areaArray {
//    if (!_areaArray) {
//        _areaArray = @[].mutableCopy;
//    }
//    return _areaArray;
//}


@end
