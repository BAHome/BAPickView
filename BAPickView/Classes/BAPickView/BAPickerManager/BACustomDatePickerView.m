//
//  BACustomDatePickerView.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/6.
//

#import "BACustomDatePickerView.h"
#import "BABasePickerView.h"
#import "BAPickerToolBarView.h"

#import "NSDate+BAKit.h"

@interface BACustomDatePickerView ()

@property(nonatomic, strong) UIView *bgView;

@property(nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic, strong) BABasePickerView *basePickerView;
@property(nonatomic, strong) BADatePickerModel *datePickerModel;
@property(nonatomic, assign) BADatePickerType datePickerType;
@property(nonatomic, strong) NSDateFormatter *formatter;

@property(nonatomic, strong) BAPickerToolBarView *toolBarView;



@property(nonatomic, strong) NSMutableArray *yearArray;
@property(nonatomic, strong) NSMutableArray *mounthArray;
@property(nonatomic, strong) NSMutableArray *dayArray;
@property(nonatomic, strong) NSMutableArray *hoursArray;
@property(nonatomic, strong) NSMutableArray *minutesArray;
@property(nonatomic, strong) NSMutableArray *secondsArray;
@property(nonatomic, strong) NSMutableArray *weekArray;
// 选中结果保存
@property(nonatomic, copy) NSString *resultString;
@property(nonatomic, strong) BADateResultModel *resultModel;

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
    
    [self.bgView addSubview:self.basePickerView];
    [self.basePickerView mas_makeConstraints:^(MASConstraintMaker *make) {
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
        
        self.selectDatePicker ? self.selectDatePicker(self.resultModel):nil;
        [self dismiss];
    };
}

#pragma mark 默认配置：日期选择器-年月
- (void)initDateYM {
    NSDate *current_date = [NSDate date];
    NSInteger current_year = current_date.year;
    
    self.resultModel.selectedYear = [NSString stringWithFormat:@"%04li", current_year];
    if (self.datePickerType == kBADatePickerType_YearWeek) {
        self.resultModel.selectedWeek = [NSString stringWithFormat:@"%ld", (long)current_date.weekOfYear];
    } else {
        NSInteger current_mounth = current_date.month;
        self.resultModel.selectedMounth = [NSString stringWithFormat:@"%02li", current_mounth];
    }
    
    NSInteger index_year = [self.resultModel.selectedYear integerValue];
    NSInteger index_mounth = [self.resultModel.selectedMounth integerValue];
    NSInteger index_week = [self.resultModel.selectedWeek integerValue];

    [self.pickerView selectRow:(index_year - 1900) inComponent:0 animated:YES];

    // 设置年月、年周选择器的默认值
    if (self.datePickerType == kBADatePickerType_YearWeek) {
        [self refreshWeeksByYear:self.resultModel.selectedYear];
        [self.pickerView reloadComponent:1];
        [self.pickerView selectRow:(index_week - 1) inComponent:1 animated:YES];

        self.resultString = [NSString stringWithFormat:@"%@年，第 %@ 周", self.resultModel.selectedYear, self.resultModel.selectedWeek];
    } else {
        [self.pickerView selectRow:(index_mounth - 1) inComponent:1 animated:YES];

        self.resultString = [NSString stringWithFormat:@"%@-%@", self.resultModel.selectedYear, self.resultModel.selectedMounth];
        
//        if (self.customDateFormatter) {
//            self.resultString = [self.resultString stringByAppendingString:@"-10"];
//            NSDateFormatter *formatter = [NSDateFormatter ba_setupDateFormatterWithYMD];
//            NSDate *date = [formatter dateFromString:self.resultString];
//            self.resultString = [self.customDateFormatter stringFromDate:date];
//        }
    }
}

- (void)initPickerData {
//    [self initDateYM];

    BAKit_WeakSelf
    // 返回需要展示的列（columns）的数目
    self.basePickerView.onNumberOfComponentsInPickerView = ^NSInteger(UIPickerView * _Nonnull pickerView) {
        BAKit_StrongSelf
        
        NSInteger num = 0;
        switch (self.datePickerType) {
                // 2020-08-28
            case kBADatePickerType_YMD : {
                num = 3;
            } break;
                // 2020
            case kBADatePickerType_YY : {
                num = 1;
            } break;
                // 2020-08
            case kBADatePickerType_YM : {
                num = 2;
            } break;
                // 2020-08-28 15:33
            case kBADatePickerType_YMDHM : {
                num = 5;
            } break;
                // 2020-08-28 15:33:58
            case kBADatePickerType_YMDHMS : {
                num = 6;
            } break;
                // 2020-08-28，周二，15:33:58
            case kBADatePickerType_YMDEHMS : {
                num = 7;
            } break;
                // 15:33
            case kBADatePickerType_HM : {
                num = 2;
            } break;
                // 15:33:58
            case kBADatePickerType_HMS : {
                num = 3;
            } break;
                // 2021年，第21周
            case kBADatePickerType_YearWeek : {
                num = 2;
            } break;
                
            default:
                break;
        }
        return num;
    };
    
    // 返回每一列的行（rows）数
    self.basePickerView.onNumberOfRowsInComponent = ^NSInteger(NSInteger component, UIPickerView * _Nonnull pickerView) {
        BAKit_StrongSelf
        NSInteger num = 0;
        switch (self.datePickerType) {
                // 2020-08-28
            case kBADatePickerType_YMD : {
                num = 3;
            } break;
                // 2020
            case kBADatePickerType_YY : {
                num = 1;
            } break;
                // 2020-08
            case kBADatePickerType_YM : {
                num = (component == 0) ? self.yearArray.count : self.mounthArray.count;
            } break;
                // 2020-08-28 15:33
            case kBADatePickerType_YMDHM : {
                num = 5;
            } break;
                // 2020-08-28 15:33:58
            case kBADatePickerType_YMDHMS : {
                switch (component) {
                    case 0: {
                        num = self.yearArray.count;
                    } break;
                    case 1: {
                        num = self.mounthArray.count;
                    } break;
                    case 2: {
                        num = self.dayArray.count;
                    } break;
                    case 3: {
                        num = self.hoursArray.count;
                    } break;
                    case 4: {
                        num = self.minutesArray.count;
                    } break;
                    case 5: {
                        num = self.secondsArray.count;
                    } break;
                        
                    default:
                        break;
                }
            } break;
                // 2020-08-28，周二，15:33:58
            case kBADatePickerType_YMDEHMS : {
//                    num = 7;
            } break;
                // 15:33
            case kBADatePickerType_HM : {
//                    num = 2;
            } break;
                // 15:33:58
            case kBADatePickerType_HMS : {
//                    num = 3;
            } break;
                // 2021年，第21周
            case kBADatePickerType_YearWeek : {
                num = (component == 0) ? self.yearArray.count : self.weekArray.count;;
            } break;
                
            default:
                break;
        }
        return num;
    };
    
    // 返回每一行的标题
    self.basePickerView.onTitleForRowAndComponent = ^NSString * _Nonnull(NSInteger row, NSInteger component, UIPickerView * _Nonnull pickerView) {
        BAKit_StrongSelf
        
        NSString *title = @"";
        switch (self.datePickerType) {
                // 2020-08-28
            case kBADatePickerType_YMD : {
                title = nil;
            } break;
                // 2020
            case kBADatePickerType_YY : {
                title = nil;
            } break;
                // 2020-08
            case kBADatePickerType_YM : {
                title = (component == 0) ? self.yearArray[row] : self.mounthArray[row];;
            } break;
                // 2020-08-28 15:33
            case kBADatePickerType_YMDHM : {
                title = nil;
            } break;
                // 2020-08-28 15:33:58
            case kBADatePickerType_YMDHMS : {
                switch (component) {
                    case 0: {
                        title = self.yearArray[row];
                    } break;
                    case 1: {
                        title = self.mounthArray[row];
                    } break;
                    case 2: {
                        title = self.dayArray[row];
                    } break;
                    case 3: {
                        title = self.hoursArray[row];
                    } break;
                    case 4: {
                        title = self.minutesArray[row];
                    } break;
                    case 5: {
                        title = self.secondsArray[row];
                    } break;
                    default:
                        break;
                }
            } break;
                // 2020-08-28，周二，15:33:58
            case kBADatePickerType_YMDEHMS : {
//                    title = 7;
            } break;
                // 15:33
            case kBADatePickerType_HM : {
//                    title = 2;
            } break;
                // 15:33:58
            case kBADatePickerType_HMS : {
//                    title = 3;
            } break;
                // 2021年，第21周
            case kBADatePickerType_YearWeek : {
                title = (component == 0) ? [NSString stringWithFormat:@"%@年", self.yearArray[row]] : [NSString stringWithFormat:@"第 %@ 周", self.weekArray[row]];
            } break;
                
            default:
                break;
        }
        return title;
    };
    
    // 选中每一行的标题
    self.basePickerView.onDidSelectRowAndComponent = ^(NSInteger row, NSInteger component, UIPickerView * _Nonnull pickerView) {
        BAKit_StrongSelf
        row = row;
        
        switch (self.datePickerType) {
                // 2020-08-28
            case kBADatePickerType_YMD : {

            } break;
                // 2020
            case kBADatePickerType_YY : {

            } break;
                // 2020-08
            case kBADatePickerType_YM : {

            } break;
                // 2020-08-28 15:33
            case kBADatePickerType_YMDHM : {

            } break;
                // 2020-08-28 15:33:58
            case kBADatePickerType_YMDHMS : {
//                switch (component) {
//                    case 0: {
//                        title = self.yearArray[row];
//                    } break;
//                    case 1: {
//                        title = self.mounthArray[row];
//                    } break;
//                    case 2: {
//                        title = self.dayArray[row];
//                    } break;
//                    case 3: {
//                        title = self.hoursArray[row];
//                    } break;
//                    case 4: {
//                        title = self.minutesArray[row];
//                    } break;
//                    case 5: {
//                        title = self.secondsArray[row];
//                    } break;
//                    default:
//                        break;
//                }
            } break;
                // 2020-08-28，周二，15:33:58
            case kBADatePickerType_YMDEHMS : {

            } break;
                // 15:33
            case kBADatePickerType_HM : {

            } break;
                // 15:33:58
            case kBADatePickerType_HMS : {

            } break;
                // 2021年，第21周
            case kBADatePickerType_YearWeek : {
                NSString *year = self.resultModel.selectedYear;
                NSString *week = self.resultModel.selectedWeek;

                if (component == 0) {
                    [self refreshWeeksByYear:year];
                    [pickerView reloadComponent:1];
//                    [pickerView selectRow:0 inComponent:1 animated:YES];
                    year = self.yearArray[row];
                } else {
                    week = self.weekArray[row];
                }
                self.resultModel.selectedYear = year;
                self.resultModel.selectedWeek = week;
                
                self.resultString = [NSString stringWithFormat:@"%@-%@",year, week];
            } break;
                
            default:
                break;
        }
        
        
        
    };
}

#pragma mark 刷新年份的最大周数
- (void)refreshWeeksByYear:(NSString *)year {
    [self.weekArray removeAllObjects];
    
    for (NSInteger i = 1; i < [NSDate ba_dateGetWeekNumbersOfYear:[year integerValue]]+1; i++) {
        [self.weekArray addObject:[NSString stringWithFormat:@"%ld", i]];
    }
}

#pragma mark - setter, getter

- (void)setResultString:(NSString *)resultString {
    _resultString = resultString;

    self.resultModel.resultString = resultString;
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
    
    self.datePickerType = datePickerModel.datePickerType;
    
    [self initPickerData];
    [self initDateYM];
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

- (BABasePickerView *)basePickerView {
    if (!_basePickerView) {
        _basePickerView = BABasePickerView.new;
        self.pickerView = _basePickerView.pickerView;
    }
    return _basePickerView;
}

- (BADateResultModel *)resultModel {
    if (!_resultModel) {
        _resultModel = BADateResultModel.new;
    }
    return _resultModel;
}

- (NSMutableArray *)yearArray {
    if (!_yearArray) {
        _yearArray = @[].mutableCopy;
        for (int i = 1900; i < 2100; i++) {
            NSString *str = [NSString stringWithFormat:@"%04i",i];
            [self.yearArray addObject:str];
        }
    }
    return _yearArray;
}

- (NSMutableArray *)mounthArray {
    if (!_mounthArray) {
        _mounthArray = @[].mutableCopy;
        for (int i = 1; i < 13; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i%@",i,@"月"];
            [self.mounthArray addObject:str];
        }
    }
    return _mounthArray;
}

- (NSMutableArray *)dayArray {
    if (!_dayArray) {
        _dayArray = @[].mutableCopy;
    }
    return _dayArray;
}

- (NSMutableArray *)hoursArray {
    if (!_hoursArray) {
        _hoursArray = @[].mutableCopy;
        
        for (int i = 0; i < 24; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i时",i];
            [_hoursArray addObject:str];
        }
    }
    return _hoursArray;
}

- (NSMutableArray *)minutesArray {
    if (!_minutesArray) {
        _minutesArray = @[].mutableCopy;
        
        for (int i = 0; i < 60; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i分",i];
            [_minutesArray addObject:str];
        }
    }
    return _minutesArray;
}

- (NSMutableArray *)secondsArray {
    if (!_secondsArray) {
        _secondsArray = @[].mutableCopy;
        
        for (int i = 0; i < 60; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i秒",i];
            [_secondsArray addObject:str];
        }
    }
    return _secondsArray;
}

- (NSMutableArray *)weekArray {
    if (!_weekArray) {
        _weekArray = @[].mutableCopy;
    }
    return _weekArray;
}


@end
