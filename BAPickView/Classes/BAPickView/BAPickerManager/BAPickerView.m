//
//  BAPickerView.m
//  BApickerView
//
//  Created by 博爱 on 2021/4/1.
//

#import "BAPickerView.h"
#import "BAPickerToolBarView.h"
#import "BABasePickerView.h"

@interface BAPickerView ()
{
   NSString *m_local2DString;
}

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIView *titleBgView;
@property(nonatomic, strong) NSMutableArray <UILabel *>*titleLabelArray;

@property(nonatomic, strong) BABasePickerView *pickerView;
@property(nonatomic, strong) BAPickerModel *pickerModel;

@property(nonatomic, strong) BAPickerToolBarView *toolBarView;

@property(nonatomic, copy) NSString *resultString;
@property(nonatomic, assign) NSInteger resultRow;
@property(nonatomic, assign) NSInteger resultComponent;
@property(nonatomic, strong) NSArray *resultArray;
@property(nonatomic, strong) NSMutableArray *selectedArray;

@property(nonatomic, assign) BOOL isCityPicker;
// 省 数组
@property (nonatomic, copy) NSMutableArray *provinceArray;
// 城市 数组
@property (nonatomic, copy) NSMutableArray *cityArray;
// 区县 数组
@property (nonatomic, copy) NSMutableArray *areaArray;
/**
 省，用于保存选择后的数据
 */
@property (nonatomic, copy) NSString *selectedProvince;

/**
 市，用于保存选择后的数据
 */
@property (nonatomic, copy) NSString *selectedCity;

/**
 区，用于保存选择后的数据
 */
@property (nonatomic, copy) NSString *selectedArea;

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
        
        if (self.isCityPicker) {
            
            if (self.selectedProvince.length > 0) {
                BACityModel *model = BACityModel.new;
                model.province = self.selectedProvince;
                model.city = self.selectedCity;
                model.area = self.selectedArea;
                
                CLLocationCoordinate2D coordie;
                coordie.latitude = 0;
                coordie.longitude = 0;
                
                if (self->m_local2DString.length > 0) {
                    NSArray *arr = [self->m_local2DString componentsSeparatedByString:NSLocalizedString(@",", nil)];
                    if([arr count] > 1) {
                        coordie.latitude = [arr[0] floatValue];
                        coordie.longitude = [arr[1] floatValue];
                    }
                }
                model.coordie = coordie;
                self.selectCityPicker ? self.selectCityPicker(model):nil;
            }
        } else {
            self.selectPicker ? self.selectPicker(self.resultRow, self.resultComponent, self.resultString, self.resultArray):nil;
        }
        [self dismiss];
    };
}

- (NSString *)cutLocalStringForShow:(NSString *)iStr {
    // 对显示坐标进行去重
    NSArray *arr = [iStr componentsSeparatedByString:NSLocalizedString(@"|", nil)];
    if([arr count] < 2) return iStr;
    return arr[0];
}

- (NSString *)cutLocalString:(NSString *)iStr {
    // 对显示坐标进行去重
    NSArray * arr = [iStr componentsSeparatedByString:NSLocalizedString(@"|", nil)];
    if([arr count] < 2) return iStr;
    m_local2DString = arr[1];
    return arr[0];
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

- (void)setConfigModel:(BAPickerModel *)configModel {
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
    
    // 内容配置：pickerModel、toolBarModel
    {
        self.pickerModel = configModel;
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
    } else if (pickerModel.allProvinceCityArray.count > 0) {
        self.isCityPicker = YES;
        
        NSArray *allProvinceCityArray = pickerModel.allProvinceCityArray;

        if (allProvinceCityArray.count > 0) {
            [self.provinceArray removeAllObjects];
            [self.cityArray removeAllObjects];
            [self.areaArray removeAllObjects];

            [allProvinceCityArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.provinceArray addObject:obj[@"state"]];
            }];
            
            NSMutableArray *citys = allProvinceCityArray[0][@"cities"];
            [citys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.cityArray addObject:obj[@"city"]];
            }];
            
            self.areaArray = citys[0][@"areas"];
            
            // 设置城市选择器的默认值
            self.selectedProvince = [self cutLocalString:self.provinceArray[0]];
            self.selectedCity = [self cutLocalString:self.cityArray[0]];
            self.selectedArea = 0 == self.areaArray.count ? @"" : [self cutLocalString:self.areaArray[0]];
        }
        
        [self.pickerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.toolBarView.mas_bottom);
        }];
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

- (BABasePickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = BABasePickerView.new;
      
        BAKit_WeakSelf
        // 返回需要展示的列（columns）的数目
        _pickerView.onNumberOfComponentsInPickerView = ^NSInteger(UIPickerView * _Nonnull pickerView) {
            BAKit_StrongSelf
            NSInteger num = 0;
            if (self.isCityPicker) {
                num = 3;
            } else if (self.pickerModel.multipleStringsArray.count > 0) {
                num = self.pickerModel.multipleStringsArray.count;
            } else {
                num = 1;
            }
            return num;
        };
        
        // 返回每一列的行（rows）数
        _pickerView.onNumberOfRowsInComponent = ^NSInteger(NSInteger component, UIPickerView * _Nonnull pickerView) {
            BAKit_StrongSelf
            NSInteger num = 0;
            if (self.isCityPicker) {
                num = 0 == component ? self.provinceArray.count : 1 == component ? self.cityArray.count : self.areaArray.count;
            } else if (self.pickerModel.multipleStringsArray.count > 0) {
                num = [self.pickerModel.multipleStringsArray[component] count];
            } else {
                num = self.pickerModel.stringsArray.count;
            }
            return num;
        };
        
        // 返回每一行的标题
        _pickerView.onTitleForRowAndComponent = ^NSString * _Nonnull(NSInteger row, NSInteger component, UIPickerView * _Nonnull pickerView) {
            BAKit_StrongSelf
            if (self.isCityPicker) {
                return 0 == component ? [self cutLocalStringForShow:self.provinceArray[row]] : 1 == component ? [self cutLocalStringForShow:self.cityArray[row]] : 0 == self.areaArray.count ? nil : [self cutLocalStringForShow:self.areaArray[row]];
            } else {
                return self.pickerModel.multipleStringsArray.count > 0 ? self.pickerModel.multipleStringsArray[component][row] : self.pickerModel.stringsArray[row];
            }
        };
        
        // 选中每一行的标题
        _pickerView.onDidSelectRowAndComponent = ^(NSInteger row, NSInteger component, UIPickerView * _Nonnull pickerView) {
            BAKit_StrongSelf
            if (self.isCityPicker) {
               
                NSArray *allProvinceCityArray = self.pickerModel.allProvinceCityArray;
                
                if (0 == component) {
                    self.selectedArray = allProvinceCityArray[row][@"cities"];
                    [self.cityArray removeAllObjects];
                    
                    [self.selectedArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        [self.cityArray addObject:obj[@"city"]];
                    }];
                    
                    self.areaArray = [NSMutableArray arrayWithArray:self.selectedArray[0][@"areas"]];
                    [pickerView reloadComponent:1];
                    [pickerView selectRow:0 inComponent:1 animated:YES];
                    
                    [pickerView reloadComponent:2];
                    [pickerView selectRow:0 inComponent:2 animated:YES];
                } else if (1 == component) {
                    if (0 == self.selectedArray.count) {
                        self.selectedArray = allProvinceCityArray[0][@"cities"];
                    }
                    
                    self.areaArray = self.selectedArray[row][@"areas"];
                    [pickerView reloadComponent:2];
                    [pickerView selectRow:0 inComponent:2 animated:YES];
                }
                
                NSInteger provinces = [pickerView selectedRowInComponent:0];
                NSInteger city = [pickerView selectedRowInComponent:1];
                NSInteger area = [pickerView selectedRowInComponent:2];
                
                self.selectedProvince = [self cutLocalString:self.provinceArray[provinces]];
                self.selectedCity = [self cutLocalString:self.cityArray[city]];
                self.selectedArea = 0 == self.areaArray.count ? @"" : [self cutLocalString:self.areaArray[area]];
                
                if (self.selectedArea.length) {
                    self.resultString = [NSString stringWithFormat:@"%@,%@,%@", self.selectedProvince, self.selectedCity, self.selectedArea];
                } else {
                    self.resultString = [NSString stringWithFormat:@"%@,%@", self.selectedProvince, self.selectedCity];
                }
            } else if (self.pickerModel.multipleStringsArray.count > 0) {
                [self.selectedArray replaceObjectAtIndex:component withObject:self.pickerModel.multipleStringsArray[component][row]];
                self.resultArray = self.selectedArray;
            } else {
                NSString *resultString = self.pickerModel.stringsArray[row];
                self.resultString = resultString;
            }
            self.resultRow = row;
            self.resultComponent = component;
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

- (NSMutableArray<UILabel *> *)titleLabelArray {
    if (!_titleLabelArray) {
        _titleLabelArray = @[].mutableCopy;
    }
    return _titleLabelArray;
}

- (NSMutableArray *)provinceArray {
    if (!_provinceArray) {
        _provinceArray = @[].mutableCopy;
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        _cityArray = @[].mutableCopy;
    }
    return _cityArray;
}

- (NSMutableArray *)areaArray {
    if (!_areaArray) {
        _areaArray = @[].mutableCopy;
    }
    return _areaArray;
}

@end
