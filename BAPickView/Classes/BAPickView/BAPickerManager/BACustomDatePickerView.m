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


// 数据源
// 是否显示后缀 年、月、日、时、分、秒
@property(nonatomic, assign) BOOL showSuffix;
@property(nonatomic, strong) NSMutableArray *yearArray;
@property(nonatomic, strong) NSMutableArray *mounthArray;
@property(nonatomic, strong) NSMutableArray *dayArray;
@property(nonatomic, strong) NSMutableArray *hoursArray;
@property(nonatomic, strong) NSMutableArray *minutesArray;
@property(nonatomic, strong) NSMutableArray *secondsArray;
@property(nonatomic, strong) NSMutableArray *weekArray;

// 选中结果保存
@property(nonatomic, copy) NSString *resultString;
@property(nonatomic, strong) BAPickerResultModel *resultModel;

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
    self.showSuffix = YES;
    
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
                // 08-28
            case kBADatePickerType_MD : {
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
                // 08-28
            case kBADatePickerType_MD : {
                
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
                title = (component == 0) ? [self getTitleForYearWithRow:row] : [self getTitleForMounthWithRow:row];
            } break;
                // 08-28
            case kBADatePickerType_MD : {
                
            } break;
                // 2020-08-28 15:33
            case kBADatePickerType_YMDHM : {
                title = nil;
            } break;
                // 2020-08-28 15:33:58
            case kBADatePickerType_YMDHMS : {
                switch (component) {
                    case 0: {
                        title = [self getTitleForYearWithRow:row];
                    } break;
                    case 1: {
                        title = [self getTitleForMounthWithRow:row];
                    } break;
                    case 2: {
                        title = [self getTitleForDayWithRow:row];
                    } break;
                    case 3: {
                        title = [self getTitleForHourWithRow:row];
                    } break;
                    case 4: {
                        title = [self getTitleForMinutesWithRow:row];
                    } break;
                    case 5: {
                        title = [self getTitleForSecondsWithRow:row];
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
                title = (component == 0) ? [self getTitleForYearWithRow:row] : [self getTitleForWeekWithRow:row];
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
                switch (component) {
                    case 0: {
                        self.resultModel.selectedYear = self.yearArray[row];
                        [self refreshDay];
                    } break;
                    case 1: {
                        self.resultModel.selectedMounth = self.mounthArray[row];
                        [self refreshDay];
                    } break;
                    case 2: {
                        self.resultModel.selectedDay = self.dayArray[row];
                    } break;
                    case 3: {
                        self.resultModel.selectedHours = self.hoursArray[row];
                    } break;
                    case 4: {
                        self.resultModel.selectedMinutes = self.minutesArray[row];
                    } break;
                    case 5: {
                        self.resultModel.selectedSeconds = self.secondsArray[row];
                    } break;
                    default:
                        break;
                }
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

#pragma mark 获取 title
- (NSString *)getTitleForYearWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.yearArray[row]];
    if (self.showSuffix) {
        [title stringByAppendingString:@"年"];
    }
    return title;
}

- (NSString *)getTitleForMounthWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.mounthArray[row]];
    if (self.showSuffix) {
        [title stringByAppendingString:@"月"];
    }
    return title;
}

- (NSString *)getTitleForDayWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.dayArray[row]];
    if (self.showSuffix) {
        [title stringByAppendingString:@"日"];
    }
    return title;
}

- (NSString *)getTitleForHourWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.hoursArray[row]];
    if (self.showSuffix) {
        [title stringByAppendingString:@"时"];
    }
    return title;
}

- (NSString *)getTitleForMinutesWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.minutesArray[row]];
    if (self.showSuffix) {
        [title stringByAppendingString:@"分"];
    }
    return title;
}

- (NSString *)getTitleForSecondsWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.secondsArray[row]];
    if (self.showSuffix) {
        [title stringByAppendingString:@"秒"];
    }
    return title;
}

- (NSString *)getTitleForWeekWithRow:(NSInteger)row {
    return [NSString stringWithFormat:@"第 %@ 周", self.weekArray[row]];
}

- (void)refreshDay {
    [self.dayArray removeAllObjects];
    NSString *year = self.resultModel.selectedYear;
    NSString *mounth = self.resultModel.selectedMounth;
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@",year,mounth];
    NSDateFormatter *formatter = [NSDateFormatter ba_setupDateFormatterWithYM];
    NSDate *date = [formatter dateFromString:dateStr];
    NSInteger count =  [NSDate ba_dateTotaldaysInMonth:date];
    for (int i = 1; i < count + 1; i++) {
        NSString *str = [NSString stringWithFormat:@"%02i",i];
        [_dayArray addObject:str];
    }
    [self.pickerView reloadComponent:2];
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
    // 默认数据
    [self initPickerData];
    [self initDateYM];
    
    // kBADatePickerType_YMDHMS 样式需要特殊处理默认数据
    if (self.datePickerType == kBADatePickerType_YMDHMS) {
        // kBADatePickerType_YMDHMS 样式内容过长显示不全，因此省去后缀
        self.showSuffix = NO;
        self.basePickerView.normalFont = [UIFont systemFontOfSize:14];
        NSDate *nowDate = [NSDate date];
        
        self.resultModel.selectedYear = [NSString stringWithFormat:@"%04li",(long)nowDate.year];
        NSInteger yearIndex = [self.yearArray indexOfObject:self.resultModel.selectedYear];
        if (yearIndex <self.yearArray.count) {
            [self.pickerView selectRow:[self.yearArray indexOfObject:self.resultModel.selectedYear] inComponent:0 animated:NO];
        }
        
        self.resultModel.selectedMounth = [NSString stringWithFormat:@"%02li",(long)nowDate.month];
        NSInteger mounthIndex = [self.mounthArray indexOfObject:self.resultModel.selectedMounth];
        if (mounthIndex < self.mounthArray.count) {
            [self.pickerView selectRow:[self.mounthArray indexOfObject:self.resultModel.selectedMounth] inComponent:1 animated:NO];
        }
        
        self.resultModel.selectedDay = [NSString stringWithFormat:@"%02li",(long)nowDate.day];
        NSInteger dayIndex = [self.dayArray indexOfObject:self.resultModel.selectedDay];
        if (dayIndex < self.dayArray.count) {
            [self.pickerView selectRow:[self.dayArray indexOfObject:self.resultModel.selectedDay] inComponent:2 animated:NO];
        }
        
        self.resultModel.selectedHours = [NSString stringWithFormat:@"%02li",(long)nowDate.hour];
        NSInteger hourIndex = [self.hoursArray indexOfObject:self.resultModel.selectedHours];
        if (hourIndex < self.hoursArray.count) {
            [self.pickerView selectRow:[self.hoursArray indexOfObject:self.resultModel.selectedHours] inComponent:3 animated:NO];
        }
        
        self.resultModel.selectedMinutes = [NSString stringWithFormat:@"%02li",(long)nowDate.minute];
        NSInteger minutesIndex = [self.minutesArray indexOfObject:self.resultModel.selectedMinutes];
        if (minutesIndex < self.minutesArray.count) {
            [self.pickerView selectRow:[self.minutesArray indexOfObject:self.resultModel.selectedMinutes] inComponent:4 animated:NO];
        }
        
        self.resultModel.selectedSeconds = [NSString stringWithFormat:@"%02li",(long)nowDate.second];
        NSInteger secondsIndex = [self.secondsArray indexOfObject:self.resultModel.selectedSeconds];
        if (secondsIndex < self.secondsArray.count) {
            [self.pickerView selectRow:[self.secondsArray indexOfObject:self.resultModel.selectedSeconds] inComponent:5 animated:NO];
        }
    }
    
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

- (BAPickerResultModel *)resultModel {
    if (!_resultModel) {
        _resultModel = BAPickerResultModel.new;
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
            NSString *str = [NSString stringWithFormat:@"%02i",i];
            [self.mounthArray addObject:str];
        }
    }
    return _mounthArray;
}

- (NSMutableArray *)dayArray {
    if (!_dayArray) {
        _dayArray = @[].mutableCopy;
        [self refreshDay];
    }
    return _dayArray;
}

- (NSMutableArray *)hoursArray {
    if (!_hoursArray) {
        _hoursArray = @[].mutableCopy;
        
        for (int i = 0; i < 24; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i",i];
            [_hoursArray addObject:str];
        }
    }
    return _hoursArray;
}

- (NSMutableArray *)minutesArray {
    if (!_minutesArray) {
        _minutesArray = @[].mutableCopy;
        
        for (int i = 0; i < 60; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i",i];
            [_minutesArray addObject:str];
        }
    }
    return _minutesArray;
}

- (NSMutableArray *)secondsArray {
    if (!_secondsArray) {
        _secondsArray = @[].mutableCopy;
        
        for (int i = 0; i < 60; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i",i];
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
