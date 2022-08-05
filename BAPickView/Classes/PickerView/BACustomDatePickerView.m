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


// 是否显示后缀 年、月、日、时、分、秒
@property(nonatomic, assign) BOOL showSuffix;
// 是否显示 年、月、日、时、分、秒
@property(nonatomic, assign) BOOL showYear;
@property(nonatomic, assign) BOOL showMonth;
@property(nonatomic, assign) BOOL showDay;
@property(nonatomic, assign) BOOL showHours;
@property(nonatomic, assign) BOOL showMinutes;
@property(nonatomic, assign) BOOL showSeconds;
@property(nonatomic, assign) BOOL showWeek;

// 数据源
@property(nonatomic, strong) NSMutableArray *yearArray;
@property(nonatomic, strong) NSMutableArray *monthArray;
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
    
    self.showYear = NO;
    self.showMonth = NO;
    self.showDay = NO;
    self.showHours = NO;
    self.showMinutes = NO;
    self.showSeconds = NO;
    self.showWeek = NO;
    
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

- (void)initPickerData {
    
    BAKit_WeakSelf
    // 返回需要展示的列（columns）的数目
    self.basePickerView.onNumberOfComponentsInPickerView = ^NSInteger(UIPickerView * _Nonnull pickerView) {
        BAKit_StrongSelf
        
        NSInteger num = 0;
        switch (self.datePickerType) {
                // 2020-08-28
            case BADatePickerTypeYMD : {
                num = 3;
            } break;
                // 2020
            case BADatePickerTypeYY : {
                num = 1;
            } break;
                // 2020-08
            case BADatePickerTypeYM : {
                num = 2;
            } break;
                // 08-28
            case BADatePickerTypeMD : {
                num = 2;
            } break;
                // 2020-08-28 15:33
            case BADatePickerTypeYMDHM : {
                num = 5;
            } break;
                // 2020-08-28 15:33:58
            case BADatePickerTypeYMDHMS : {
                num = 6;
            } break;
                // 15:33
            case BADatePickerTypeHM : {
                num = 2;
            } break;
                // 15:33:58
            case BADatePickerTypeHMS : {
                num = 3;
            } break;
                // 2021年，第21周
            case BADatePickerTypeYearWeek : {
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
            case BADatePickerTypeYMD : {
                switch (component) {
                    case 0: {
                        num = self.yearArray.count;
                    } break;
                    case 1: {
                        num = self.monthArray.count;
                    } break;
                    case 2: {
                        num = self.dayArray.count;
                    } break;
                        
                    default:
                        break;
                }
            } break;
                // 2020
            case BADatePickerTypeYY : {
                num = self.yearArray.count;
            } break;
                // 2020-08
            case BADatePickerTypeYM : {
                num = (component == 0) ? self.yearArray.count : self.monthArray.count;
            } break;
                // 08-28
            case BADatePickerTypeMD : {
                num = (component == 0) ? self.monthArray.count : self.dayArray.count;
            } break;
                // 2020-08-28 15:33
            case BADatePickerTypeYMDHM :
                // 2020-08-28 15:33:58
            case BADatePickerTypeYMDHMS : {
                switch (component) {
                    case 0: {
                        num = self.yearArray.count;
                    } break;
                    case 1: {
                        num = self.monthArray.count;
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
                // 15:33
            case BADatePickerTypeHM :
                // 15:33:58
            case BADatePickerTypeHMS : {
                switch (component) {
                    case 0: {
                        num = self.hoursArray.count;
                    } break;
                    case 1: {
                        num = self.minutesArray.count;
                    } break;
                    case 2: {
                        num = self.secondsArray.count;
                    } break;
                        
                    default:
                        break;
                }
            } break;
                // 2021年，第21周
            case BADatePickerTypeYearWeek : {
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
            case BADatePickerTypeYMD : {
                switch (component) {
                    case 0: {
                        title = [self getTitleForYearWithRow:row];
                    } break;
                    case 1: {
                        title = [self getTitleForMonthWithRow:row];
                    } break;
                    case 2: {
                        title = [self getTitleForDayWithRow:row];
                    } break;
                    default:
                        break;
                }
            } break;
                // 2020
            case BADatePickerTypeYY : {
                title = [self getTitleForYearWithRow:row];
            } break;
                // 2020-08
            case BADatePickerTypeYM : {
                switch (component) {
                    case 0: {
                        title = [self getTitleForYearWithRow:row];
                    } break;
                    case 1: {
                        title = [self getTitleForMonthWithRow:row];
                    } break;
                    default:
                        break;
                }
            } break;
                // 08-28
            case BADatePickerTypeMD : {
                switch (component) {
                    case 0: {
                        title = [self getTitleForMonthWithRow:row];
                    } break;
                    case 1: {
                        title = [self getTitleForDayWithRow:row];
                    } break;
                    default:
                        break;
                }
            } break;
                // 2020-08-28 15:33
            case BADatePickerTypeYMDHM :
                // 2020-08-28 15:33:58
            case BADatePickerTypeYMDHMS : {
                switch (component) {
                    case 0: {
                        title = [self getTitleForYearWithRow:row];
                    } break;
                    case 1: {
                        title = [self getTitleForMonthWithRow:row];
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
                // 15:33
            case BADatePickerTypeHM : {
                switch (component) {
                    case 0: {
                        title = [self getTitleForHourWithRow:row];
                    } break;
                    case 1: {
                        title = [self getTitleForMinutesWithRow:row];
                    } break;
                    default:
                        break;
                }
            } break;
                // 15:33:58
            case BADatePickerTypeHMS : {
                switch (component) {
                    case 0: {
                        title = [self getTitleForHourWithRow:row];
                    } break;
                    case 1: {
                        title = [self getTitleForMinutesWithRow:row];
                    } break;
                    case 2: {
                        title = [self getTitleForSecondsWithRow:row];
                    } break;
                    default:
                        break;
                }
            } break;
                // 2021年，第21周
            case BADatePickerTypeYearWeek : {
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
        self.resultModel.selectRow = row;
        self.resultModel.selectComponent = component;
        
        switch (self.datePickerType) {
                // 2020-08-28
            case BADatePickerTypeYMD : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedYear = [self.yearArray[row] intValue];
                        [self refreshMonth];
                        [self.pickerView reloadComponent:1];
                    } break;
                    case 1: {
                        self.resultModel.selectedMonth = [self.monthArray[row] intValue];
                        [self refreshDay];
                        [self.pickerView reloadComponent:2];
                    } break;
                    case 2: {
                        self.resultModel.selectedDay = [self.dayArray[row] intValue];
                    } break;
                    default:
                        break;
                }
                self.resultString = [NSString stringWithFormat:@"%04ld-%02ld-%02ld", self.resultModel.selectedYear, self.resultModel.selectedMonth, self.resultModel.selectedDay];
            } break;
                // 2020
            case BADatePickerTypeYY : {
                self.resultModel.selectedYear = [self.yearArray[row] intValue];
                self.resultString = [NSString stringWithFormat:@"%04ld", self.resultModel.selectedYear];
            } break;
                // 2020-08
            case BADatePickerTypeYM : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedYear = [self.yearArray[row] intValue];
                        [self refreshMonth];
                    } break;
                    case 1: {
                        self.resultModel.selectedMonth = [self.monthArray[row] intValue];
                    } break;
                    default:
                        break;
                }
                self.resultString = [NSString stringWithFormat:@"%04ld-%02ld", self.resultModel.selectedYear, self.resultModel.selectedMonth];
            } break;
                // 08-28
            case BADatePickerTypeMD : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedMonth = [self.monthArray[row] intValue];
                        [self refreshMonth];
                    } break;
                    case 1: {
                        self.resultModel.selectedDay = [self.dayArray[row] intValue];
                    } break;
                    default:
                        break;
                }
                self.resultString = [NSString stringWithFormat:@"%02ld-%02ld", self.resultModel.selectedMonth, self.resultModel.selectedDay];
            } break;
                // 2020-08-28 15:33
            case BADatePickerTypeYMDHM :
                // 2020-08-28 15:33:58
            case BADatePickerTypeYMDHMS : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedYear = [self.yearArray[row] intValue];
                        [self refreshMonth];
                    } break;
                    case 1: {
                        self.resultModel.selectedMonth = [self.monthArray[row] intValue];
                        [self refreshDay];
                    } break;
                    case 2: {
                        self.resultModel.selectedDay = [self.dayArray[row] intValue];
                    } break;
                    case 3: {
                        self.resultModel.selectedHours = [self.hoursArray[row] intValue];
                    } break;
                    case 4: {
                        self.resultModel.selectedMinutes = [self.minutesArray[row] intValue];
                    } break;
                    case 5: {
                        self.resultModel.selectedSeconds = [self.secondsArray[row] intValue];
                    } break;
                    default:
                        break;
                }
                
                self.resultString = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld", self.resultModel.selectedYear, self.resultModel.selectedMonth, self.resultModel.selectedDay, self.resultModel.selectedHours, self.resultModel.selectedMinutes];
                if (self.datePickerType == BADatePickerTypeYMDHMS) {
                    self.resultString = [self.resultString stringByAppendingFormat:@":%02ld", self.resultModel.selectedSeconds];
                }
            } break;
                // 15:33
            case BADatePickerTypeHM : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedHours = [self.hoursArray[row] intValue];
                    } break;
                    case 1: {
                        self.resultModel.selectedMinutes = [self.minutesArray[row] intValue];
                    } break;
                    default:
                        break;
                }
                self.resultString = [NSString stringWithFormat:@"%02ld:%02ld", self.resultModel.selectedHours, self.resultModel.selectedMinutes];
            } break;
                // 15:33:58
            case BADatePickerTypeHMS : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedHours = [self.hoursArray[row] intValue];
                    } break;
                    case 1: {
                        self.resultModel.selectedMinutes = [self.minutesArray[row] intValue];
                    } break;
                    case 2: {
                        self.resultModel.selectedSeconds = [self.secondsArray[row] intValue];
                    } break;
                    default:
                        break;
                }
                self.resultString = [NSString stringWithFormat:@"%02ld:%02ld:%ld02ld", self.resultModel.selectedHours, self.resultModel.selectedMinutes, (long)self.resultModel.selectedSeconds];
            } break;
                // 2021年，第21周
            case BADatePickerTypeYearWeek : {
                NSInteger year = self.resultModel.selectedYear;
                NSInteger week = self.resultModel.selectedWeek;
                
                if (component == 0) {
                    [self refreshWeeksByYear:year];
                    [pickerView reloadComponent:1];
                    //                    [pickerView selectRow:0 inComponent:1 animated:YES];
                    year = [self.yearArray[row] intValue];
                    
                } else {
                    week = [self.weekArray[row] intValue];
                }
                self.resultModel.selectedYear = year;
                self.resultModel.selectedWeek = week;
                
                self.resultString = [NSString stringWithFormat:@"%04ld年第%02ld周",year, week];
            } break;
                
            default:
                break;
        }
    };
    self.basePickerView.onViewForRowAndComponent = ^(NSInteger row, NSInteger component, UIView * _Nonnull reusingView, UIPickerView * _Nonnull pickerView) {
        BAKit_StrongSelf
        UILabel *pickerLabel = (UILabel *)reusingView;
        if (!pickerLabel){
            pickerLabel = UILabel.new;
            pickerLabel.adjustsFontSizeToFitWidth = YES;
            pickerLabel.textAlignment = NSTextAlignmentCenter;
            pickerLabel.backgroundColor = [UIColor clearColor];
            pickerLabel.font = !self.datePickerModel.titleFont ? [UIFont boldSystemFontOfSize:15]:self.datePickerModel.titleFont;
            pickerLabel.textColor = !self.datePickerModel.titleColor ? UIColor.blackColor:self.datePickerModel.titleColor;
        }
        pickerLabel.text = self.basePickerView.onTitleForRowAndComponent(row, component, pickerView);
        
        return pickerLabel;
    };
}

#pragma mark 获取 title
- (NSString *)getTitleForYearWithRow:(NSInteger)row {
    if (row >= self.yearArray.count) {
        return nil;
    }
    NSString *title = [NSString stringWithFormat:@"%@", self.yearArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"年"];
    }
    return title;
}

- (NSString *)getTitleForMonthWithRow:(NSInteger)row {
    if (row >= self.monthArray.count) {
        return nil;
    }
    NSString *title = [NSString stringWithFormat:@"%@", self.monthArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"月"];
    }
    return title;
}

- (NSString *)getTitleForDayWithRow:(NSInteger)row {
    if (row >= self.dayArray.count) {
        return nil;
    }
    NSString *title = [NSString stringWithFormat:@"%@", self.dayArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"日"];
    }
    return title;
}

- (NSString *)getTitleForHourWithRow:(NSInteger)row {
    if (row >= self.hoursArray.count) {
        return nil;
    }
    NSString *title = [NSString stringWithFormat:@"%@", self.hoursArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"时"];
    }
    return title;
}

- (NSString *)getTitleForMinutesWithRow:(NSInteger)row {
    if (row >= self.minutesArray.count) {
        return nil;
    }
    NSString *title = [NSString stringWithFormat:@"%@", self.minutesArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"分"];
    }
    return title;
}

- (NSString *)getTitleForSecondsWithRow:(NSInteger)row {
    if (row >= self.secondsArray.count) {
        return nil;
    }
    NSString *title = [NSString stringWithFormat:@"%@", self.secondsArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"秒"];
    }
    return title;
}

- (NSString *)getTitleForWeekWithRow:(NSInteger)row {
    if (row >= self.weekArray.count) {
        return nil;
    }
    return [NSString stringWithFormat:@"第 %@ 周", self.weekArray[row]];
}

#pragma mark - refresh data

- (void)refreshMonth {
    if (self.resultModel.selectedMonth == 0) {
        self.resultModel.selectedMonth = [[NSString stringWithFormat:@"%04ld",(long)NSDate.date.month] intValue];
    }
    
    if (self.resultModel.selectedYear <= self.datePickerModel.maximumDate.year && self.resultModel.selectedMonth <= self.datePickerModel.minimumDate.month) {
        self.resultModel.selectedMonth = self.datePickerModel.minimumDate.month;
    } else if (self.resultModel.selectedYear >= self.datePickerModel.maximumDate.year && self.resultModel.selectedMonth >= self.datePickerModel.maximumDate.month) {
        self.resultModel.selectedMonth = self.datePickerModel.maximumDate.month;
    }
    
    [self.monthArray removeAllObjects];
    NSInteger minMonth = 1;
    NSInteger maxMonth = 12;
    if (self.datePickerModel.maximumDate.year == self.resultModel.selectedYear) {
        for (int i = 1; i <= self.datePickerModel.maximumDate.month; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i",i];
            [self.monthArray addObject:str];
        }
    } else {
        if (self.resultModel.selectedYear <= self.datePickerModel.minimumDate.year) {
            minMonth = self.datePickerModel.minimumDate.month;
            minMonth = MAX(1, minMonth);
        }
        if (self.resultModel.selectedYear == self.datePickerModel.maximumDate.year) {
            maxMonth = self.datePickerModel.maximumDate.month;
            maxMonth = MIN(12, minMonth);
        }
        
        for (int i = minMonth; i <= maxMonth; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i",i];
            [self.monthArray addObject:str];
        }
    }
    
    NSString *month = [NSString stringWithFormat:@"%02ld", self.resultModel.selectedMonth];
    NSInteger monthIndex = [self.monthArray indexOfObject:month];
    if (month.intValue <= minMonth) {
        monthIndex = 0;
    }
    
    NSInteger component = 1;
    if (monthIndex < self.monthArray.count) {
        if (self.datePickerType == BADatePickerTypeMD) {
            component = 0;
        }
    }
    [self.pickerView reloadComponent:component];
    [self.pickerView selectRow:monthIndex inComponent:component animated:NO];
    if (self.datePickerType != BADatePickerTypeYM) {
        [self refreshDay];
    }
}

- (void)refreshDay {
    if (self.resultModel.selectedYear == 0) {
        self.resultModel.selectedYear = [[NSString stringWithFormat:@"%04ld",(long)NSDate.date.year] intValue];
    }
    NSString *dayString = [NSString stringWithFormat:@"%02ld", self.resultModel.selectedDay];
    if (self.resultModel.selectedDay == 0) {
        self.resultModel.selectedDay = [[NSString stringWithFormat:@"%02ld",(long)NSDate.date.day] intValue];
        dayString = [NSString stringWithFormat:@"%02ld", self.resultModel.selectedDay];
    }
    NSInteger year = self.resultModel.selectedYear;
    NSInteger month = self.resultModel.selectedMonth;
    //    NSString *day = self.resultModel.selectedDay;
    NSInteger minDay = 1;
    
    NSString *dateStr = [NSString stringWithFormat:@"%04ld-%02ld-10", year, month];
    self.formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [self.formatter dateFromString:dateStr];
    NSInteger count =  [NSDate ba_dateTotaldaysInMonth:date];
    // 如果当月天数大于最大
    if (self.resultModel.selectedYear == self.datePickerModel.maximumDate.year &&  month == self.datePickerModel.maximumDate.month) {
        count = self.datePickerModel.maximumDate.day;
        self.resultModel.selectedDay = count;
    } else if (self.resultModel.selectedYear == self.datePickerModel.minimumDate.year &&  month == self.datePickerModel.minimumDate.month) {
        //        count = count - self.datePickerModel.minimumDate.day;
        if (self.resultModel.selectedDay <= self.datePickerModel.minimumDate.day) {
            self.resultModel.selectedDay = self.datePickerModel.minimumDate.day;
            minDay = self.resultModel.selectedDay;
        }
    }
    
    if (self.resultModel.selectedDay >= count) {
        self.resultModel.selectedDay = count;
    }
    dayString = [NSString stringWithFormat:@"%02ld", self.resultModel.selectedDay];
    
    [self.dayArray removeAllObjects];
    
    for (int i = minDay; i <= count; ++i) {
        NSString *str = [NSString stringWithFormat:@"%02i", i];
        [self.dayArray addObject:str];
    }
    
    NSInteger dayIndex = [self.dayArray indexOfObject:dayString];
    NSInteger component = 2;
    if (dayIndex < self.dayArray.count) {
        if (self.datePickerType == BADatePickerTypeMD) {
            component = 1;
        }
    }
    
    
    [self.pickerView reloadComponent:component];
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self.pickerView selectRow:dayIndex inComponent:component animated:NO];
    //        });
}

#pragma mark 刷新年份的最大周数
- (void)refreshWeeksByYear:(NSInteger)year {
    [self.weekArray removeAllObjects];
    
    for (NSInteger i = 1; i < [NSDate ba_dateGetWeekNumbersOfYear:year]+1; i++) {
        [self.weekArray addObject:[NSString stringWithFormat:@"%ld", i]];
    }
}

#pragma mark - setter, getter

- (void)setResultString:(NSString *)resultString {
    _resultString = resultString;
    
    // 等 configModel 有值有再赋值
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.02 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.resultModel.resultString = resultString;
        self.toolBarView.result = resultString;
    });
}

- (void)setConfigModel:(BADatePickerModel *)configModel {
    _configModel = configModel;
    
    // 公共配置：configModel
    {
        self.enableTouchDismiss = configModel.enableTouchDismiss;
        
        if (configModel.maskViewBackgroundColor) {
            self.maskViewBackgroundColor = configModel.maskViewBackgroundColor;
        }
        if (configModel.contentViewBackgroundColor) {
            self.bgView.backgroundColor = configModel.contentViewBackgroundColor;
        }
        if (configModel.pickerViewBackgroundColor) {
            self.basePickerView.backgroundColor = configModel.pickerViewBackgroundColor;
        }
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
    
    // 根据最大最小日期设置年
    NSInteger maxYear = datePickerModel.maximumDate.year;
    maxYear = maxYear > 0 ? maxYear:NSDate.date.year + 60;
    NSInteger minYear = datePickerModel.minimumDate.year;
    minYear = minYear > 0 ? minYear:NSDate.date.year - 60;
    
    if (maxYear > 0 && minYear > 0) {
        [self.yearArray removeAllObjects];
        for (NSInteger i = minYear; i <= maxYear; i++) {
            NSString *str = [NSString stringWithFormat:@"%04ld",(long)i];
            [self.yearArray addObject:str];
        }
    }
    
    self.datePickerType = datePickerModel.datePickerType;
    
    // BADatePickerTypeYMDHMS 样式需要特殊处理默认数据
    if (self.datePickerType == BADatePickerTypeYMDHMS) {
        self.datePickerModel.titleFont = [UIFont boldSystemFontOfSize:14];
        // BADatePickerTypeYMDHMS 样式内容过长显示不全，因此省去后缀
        self.showSuffix = NO;
    } else {
        self.showSuffix = YES;
    }
    
    
    // 默认数据，要在设置完数据后再初始化 picker
    [self initPickerData];
    
    NSString *resultString = @"";
    
    switch (self.datePickerType) {
            // 2020-08-28
        case BADatePickerTypeYMD : {
            self.showYear = YES;
            self.showMonth = YES;
            self.showDay = YES;
            resultString = [NSString stringWithFormat:@"%04ld年%02ld月%02ld日", self.resultModel.selectedYear, self.resultModel.selectedMonth, self.resultModel.selectedDay];
        } break;
            // 2020
        case BADatePickerTypeYY : {
            self.showYear = YES;
            resultString = [NSString stringWithFormat:@"%04ld年", self.resultModel.selectedYear];
        } break;
            // 2020-08
        case BADatePickerTypeYM : {
            self.showYear = YES;
            self.showMonth = YES;
            resultString = [NSString stringWithFormat:@"%04ld年%02ld月", self.resultModel.selectedYear, (long)self.resultModel.selectedMonth];
        } break;
            // 08-28
        case BADatePickerTypeMD : {
            self.showMonth = YES;
            self.showDay = YES;
            resultString = [NSString stringWithFormat:@"%02ld月%02ld日", (long)self.resultModel.selectedMonth, (long)self.resultModel.selectedDay];
        } break;
            // 2020-08-28 15:33
        case BADatePickerTypeYMDHM :
            // 2020-08-28 15:33:58
        case BADatePickerTypeYMDHMS : {
            self.showYear = YES;
            self.showMonth = YES;
            self.showDay = YES;
            self.showHours = YES;
            self.showMinutes = YES;
            
            resultString = [NSString stringWithFormat:@"%04ld-%02ld-%02ld %02ld:%02ld", self.resultModel.selectedYear, self.resultModel.selectedMonth, self.resultModel.selectedDay, self.resultModel.selectedHours, self.resultModel.selectedMinutes];
            // BADatePickerTypeYMDHMS 样式需要特殊处理默认数据
            if (self.datePickerType == BADatePickerTypeYMDHMS) {
                // BADatePickerTypeYMDHMS 样式内容过长显示不全，因此省去后缀
                self.showSeconds = YES;
                resultString = [self.resultModel.resultString stringByAppendingFormat:@":%02ld", self.resultModel.selectedSeconds];
            }
        } break;
            // 15:33
        case BADatePickerTypeHM : {
            self.showHours = YES;
            self.showMinutes = YES;
            resultString = [NSString stringWithFormat:@"%02ld:%02ld", self.resultModel.selectedHours, self.resultModel.selectedMinutes];
        } break;
            // 15:33:58
        case BADatePickerTypeHMS : {
            self.showHours = YES;
            self.showMinutes = YES;
            self.showSeconds = YES;
            resultString = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", self.resultModel.selectedHours, self.resultModel.selectedMinutes, self.resultModel.selectedSeconds];
        } break;
            // 2021年，第21周
        case BADatePickerTypeYearWeek : {
            self.showYear = YES;
            self.showWeek = YES;
            resultString = [NSString stringWithFormat:@"%04ld年第%02ld周", self.resultModel.selectedYear, self.resultModel.selectedWeek];
        } break;
            
        default:
            break;
    }
    [self.pickerView reloadAllComponents];
    
    // 是否显示默认选中结果
    BOOL isShowDefaultResult = datePickerModel.toolBarModel.temp_showDefaultResult;
    self.resultModel.resultString = resultString;
    if (isShowDefaultResult) {
        self.resultString = resultString;
    }
}

- (void)setShowYear:(BOOL)showYear {
    _showYear = showYear;
    
    if (showYear) {
        NSString *year = [NSString stringWithFormat:@"%04ld",(long)NSDate.date.year];
        self.resultModel.selectedYear = [year intValue];
        NSInteger yearIndex = [self.yearArray indexOfObject:year];
        if (yearIndex < self.yearArray.count) {
            [self.pickerView selectRow:yearIndex inComponent:0 animated:NO];
        }
    }
}

- (void)setShowMonth:(BOOL)showMonth {
    _showMonth = showMonth;
    
    if (showMonth) {
        [self refreshMonth];
        
        NSString *month = [NSString stringWithFormat:@"%02ld",(long)NSDate.date.month];
        self.resultModel.selectedMonth = [month intValue];
        NSInteger monthIndex = [self.monthArray indexOfObject:month];
        if (monthIndex < self.monthArray.count) {
            NSInteger component = 1;
            if (self.datePickerType == BADatePickerTypeMD) {
                component = 0;
            }
            [self.pickerView selectRow:monthIndex inComponent:component animated:NO];
            if (self.datePickerType != BADatePickerTypeYM) {
                [self refreshDay];
            }
        }
    }
}

- (void)setShowDay:(BOOL)showDay {
    _showDay = showDay;
    
    if (showDay) {
        NSString *day = [NSString stringWithFormat:@"%02ld",(long)NSDate.date.day];
        self.resultModel.selectedDay = [day intValue];
        NSInteger dayIndex = [self.dayArray indexOfObject:day];
        if (dayIndex < self.dayArray.count) {
            NSInteger component = 2;
            if (self.datePickerType == BADatePickerTypeMD) {
                component = 1;
            }
            [self.pickerView selectRow:dayIndex inComponent:component animated:NO];
        }
    }
}

- (void)setShowHours:(BOOL)showHours {
    _showHours = showHours;
    
    if (showHours) {
        NSString *hour = [NSString stringWithFormat:@"%02ld",(long)NSDate.date.hour];
        self.resultModel.selectedHours = [hour intValue];
        NSInteger hourIndex = [self.hoursArray indexOfObject:hour];
        if (hourIndex < self.hoursArray.count) {
            NSInteger component = 3;
            if (self.datePickerType == BADatePickerTypeHM || self.datePickerType == BADatePickerTypeHMS) {
                component = 0;
            }
            [self.pickerView selectRow:hourIndex inComponent:component animated:NO];
        }
    }
}

- (void)setShowMinutes:(BOOL)showMinutes {
    _showMinutes = showMinutes;
    
    if (showMinutes) {
        NSString *minute = [NSString stringWithFormat:@"%02ld",(long)NSDate.date.minute];
        self.resultModel.selectedMinutes = [minute intValue];
        NSInteger minutesIndex = [self.minutesArray indexOfObject:minute];
        if (minutesIndex < self.minutesArray.count) {
            NSInteger component = 4;
            if (self.datePickerType == BADatePickerTypeHM || self.datePickerType == BADatePickerTypeHMS) {
                component = 1;
            }
            [self.pickerView selectRow:minutesIndex inComponent:component animated:NO];
        }
    }
}

- (void)setShowSeconds:(BOOL)showSeconds {
    _showSeconds = showSeconds;
    
    if (showSeconds) {
        NSString *second = [NSString stringWithFormat:@"%02ld",(long)NSDate.date.second];
        self.resultModel.selectedSeconds = [second intValue];
        NSInteger secondsIndex = [self.secondsArray indexOfObject:second];
        if (secondsIndex < self.secondsArray.count) {
            NSInteger component = 5;
            if (self.datePickerType == BADatePickerTypeHMS) {
                component = 2;
            }
            [self.pickerView selectRow:secondsIndex inComponent:component animated:NO];
        }
    }
}

- (void)setShowWeek:(BOOL)showWeek {
    _showWeek = showWeek;
    
    if (showWeek) {
        NSString *weekOfYear = [NSString stringWithFormat:@"%02ld",(long)NSDate.date.weekOfYear];
        self.resultModel.selectedWeek = [weekOfYear intValue];
        [self refreshWeeksByYear:self.resultModel.selectedYear];
        [self.pickerView reloadAllComponents];
        
        NSInteger index_week = self.resultModel.selectedWeek;
        [self.pickerView selectRow:(index_week - 1) inComponent:1 animated:YES];
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

- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = NSDateFormatter.new;
        //formatter.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
        _formatter.dateFormat = @"yyyy-MM-dd";
        _formatter.locale = [NSLocale localeWithLocaleIdentifier:@"China"];
        _formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    }
    return _formatter;
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

- (NSMutableArray *)monthArray {
    if (!_monthArray) {
        _monthArray = @[].mutableCopy;
        for (int i = 1; i < 13; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i",i];
            [self.monthArray addObject:str];
        }
    }
    return _monthArray;
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
