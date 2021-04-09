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
@property(nonatomic, assign) BOOL showMounth;
@property(nonatomic, assign) BOOL showDay;
@property(nonatomic, assign) BOOL showHours;
@property(nonatomic, assign) BOOL showMinutes;
@property(nonatomic, assign) BOOL showSeconds;
@property(nonatomic, assign) BOOL showWeek;

// 数据源
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
    
    self.showYear = NO;
    self.showMounth = NO;
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
                        num = self.mounthArray.count;
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
                num = (component == 0) ? self.yearArray.count : self.mounthArray.count;
            } break;
                // 08-28
            case BADatePickerTypeMD : {
                num = (component == 0) ? self.mounthArray.count : self.dayArray.count;
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
                        title = [self getTitleForMounthWithRow:row];
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
                        title = [self getTitleForMounthWithRow:row];
                    } break;
                    default:
                        break;
                }
            } break;
                // 08-28
            case BADatePickerTypeMD : {
                switch (component) {
                    case 0: {
                        title = [self getTitleForMounthWithRow:row];
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
        switch (self.datePickerType) {
                // 2020-08-28
            case BADatePickerTypeYMD : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedYear = self.yearArray[row];
                    } break;
                    case 1: {
                        self.resultModel.selectedMounth = self.mounthArray[row];
                        [self refreshDay];
                    } break;
                    case 2: {
                        self.resultModel.selectedDay = self.dayArray[row];
                    } break;
                    default:
                        break;
                }
                self.resultString = [NSString stringWithFormat:@"%@年-%@月-%@日", self.resultModel.selectedYear, self.resultModel.selectedMounth, self.resultModel.selectedDay];
            } break;
                // 2020
            case BADatePickerTypeYY : {
                self.resultModel.selectedYear = self.yearArray[row];
                self.resultString = [NSString stringWithFormat:@"%@年", self.resultModel.selectedYear];
            } break;
                // 2020-08
            case BADatePickerTypeYM : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedYear = self.yearArray[row];
                    } break;
                    case 1: {
                        self.resultModel.selectedMounth = self.mounthArray[row];
                    } break;
                    default:
                        break;
                }
                self.resultString = [NSString stringWithFormat:@"%@年-%@月", self.resultModel.selectedYear, self.resultModel.selectedMounth];
            } break;
                // 08-28
            case BADatePickerTypeMD : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedMounth = self.mounthArray[row];
                        [self refreshDay];
                    } break;
                    case 1: {
                        self.resultModel.selectedDay = self.dayArray[row];
                    } break;
                    default:
                        break;
                }
                self.resultString = [NSString stringWithFormat:@"%@月-%@日", self.resultModel.selectedMounth, self.resultModel.selectedDay];
            } break;
                // 2020-08-28 15:33
            case BADatePickerTypeYMDHM :
                // 2020-08-28 15:33:58
            case BADatePickerTypeYMDHMS : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedYear = self.yearArray[row];
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
                
                self.resultString = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", self.resultModel.selectedYear, self.resultModel.selectedMounth, self.resultModel.selectedDay, self.resultModel.selectedHours, self.resultModel.selectedMinutes];
                if (self.datePickerType == BADatePickerTypeYMDHMS) {
                    self.resultString = [self.resultString stringByAppendingFormat:@":%@", self.resultModel.selectedSeconds];
                }
            } break;
                // 15:33
            case BADatePickerTypeHM : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedHours = self.hoursArray[row];
                    } break;
                    case 1: {
                        self.resultModel.selectedMinutes = self.minutesArray[row];
                    } break;
                    default:
                        break;
                }
                self.resultString = [NSString stringWithFormat:@"%@:%@", self.resultModel.selectedHours, self.resultModel.selectedMinutes];
            } break;
                // 15:33:58
            case BADatePickerTypeHMS : {
                switch (component) {
                    case 0: {
                        self.resultModel.selectedHours = self.hoursArray[row];
                    } break;
                    case 1: {
                        self.resultModel.selectedMinutes = self.minutesArray[row];
                    } break;
                    case 2: {
                        self.resultModel.selectedSeconds = self.secondsArray[row];
                        [self refreshDay];
                    } break;
                    default:
                        break;
                }
                self.resultString = [NSString stringWithFormat:@"%@:%@:%@", self.resultModel.selectedHours, self.resultModel.selectedMinutes, self.resultModel.selectedSeconds];
            } break;
                // 2021年，第21周
            case BADatePickerTypeYearWeek : {
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
                
                self.resultString = [NSString stringWithFormat:@"%@年-第%@周",year, week];
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
            UIFont *font = [UIFont boldSystemFontOfSize:15];
            if (self.datePickerModel.titleFont) {
                font = self.datePickerModel.titleFont;
            }
            pickerLabel.font = font;
        }
        pickerLabel.text = self.basePickerView.onTitleForRowAndComponent(row, component, pickerView);
        
        return pickerLabel;
    };
}

#pragma mark 获取 title
- (NSString *)getTitleForYearWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.yearArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"年"];
    }
    return title;
}

- (NSString *)getTitleForMounthWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.mounthArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"月"];
    }
    return title;
}

- (NSString *)getTitleForDayWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.dayArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"日"];
    }
    return title;
}

- (NSString *)getTitleForHourWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.hoursArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"时"];
    }
    return title;
}

- (NSString *)getTitleForMinutesWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.minutesArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"分"];
    }
    return title;
}

- (NSString *)getTitleForSecondsWithRow:(NSInteger)row {
    NSString *title = [NSString stringWithFormat:@"%@", self.secondsArray[row]];
    if (self.showSuffix) {
        title = [title stringByAppendingString:@"秒"];
    }
    return title;
}

- (NSString *)getTitleForWeekWithRow:(NSInteger)row {
    return [NSString stringWithFormat:@"第 %@ 周", self.weekArray[row]];
}

- (void)refreshDay {
    [self.dayArray removeAllObjects];
    
    if (self.resultModel.selectedYear.length == 0) {
        self.resultModel.selectedYear = [NSString stringWithFormat:@"%04li",(long)NSDate.date.year];
    }
    if (self.resultModel.selectedDay.length == 0) {
        self.resultModel.selectedDay = [NSString stringWithFormat:@"%02li",(long)NSDate.date.day];
    }
    NSString *year = self.resultModel.selectedYear;
    NSString *mounth = self.resultModel.selectedMounth;
    NSString *day = self.resultModel.selectedDay;
    
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@-%@", year, mounth, day];
    self.formatter.dateFormat = @"yyyy-MM-dd";
    NSDate *date = [self.formatter dateFromString:dateStr];
    NSInteger count =  [NSDate ba_dateTotaldaysInMonth:date];
    for (int i = 1; i < count + 1; ++i) {
        NSString *str = [NSString stringWithFormat:@"%02i",i];
        [self.dayArray addObject:str];
    }
    
    NSInteger dayIndex = [self.dayArray indexOfObject:self.resultModel.selectedDay];
    if (dayIndex < self.dayArray.count) {
        NSInteger component = 2;
        if (self.datePickerType == BADatePickerTypeMD) {
            component = 1;
        }
        //        [self.pickerView reloadComponent:component];
        [self.pickerView reloadAllComponents];
    }
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
    
    // 等 configModel 有值有再赋值
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
    
    // 根据最大最小日期设置日期
    NSInteger maxYear = datePickerModel.maximumDate.year;
    maxYear = maxYear > 0 ? maxYear:NSDate.date.year + 60;
    NSInteger minYear = datePickerModel.minimumDate.year;
    minYear = minYear > 0 ? minYear:NSDate.date.year - 60;
    
    if (maxYear > 0 && minYear > 0) {
        [self.yearArray removeAllObjects];
        for (NSInteger i = minYear; i <= maxYear; i++) {
            NSString *str = [NSString stringWithFormat:@"%04li",(long)i];
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
            self.showMounth = YES;
            self.showDay = YES;
            resultString = [NSString stringWithFormat:@"%@年-%@月-%@日", self.resultModel.selectedYear, self.resultModel.selectedMounth, self.resultModel.selectedDay];
        } break;
            // 2020
        case BADatePickerTypeYY : {
            self.showYear = YES;
            resultString = [NSString stringWithFormat:@"%@年", self.resultModel.selectedYear];
        } break;
            // 2020-08
        case BADatePickerTypeYM : {
            self.showYear = YES;
            self.showMounth = YES;
            resultString = [NSString stringWithFormat:@"%@年-%@月", self.resultModel.selectedYear, self.resultModel.selectedMounth];
        } break;
            // 08-28
        case BADatePickerTypeMD : {
            self.showMounth = YES;
            self.showDay = YES;
            resultString = [NSString stringWithFormat:@"%@月-%@日", self.resultModel.selectedMounth, self.resultModel.selectedDay];
        } break;
            // 2020-08-28 15:33
        case BADatePickerTypeYMDHM :
            // 2020-08-28 15:33:58
        case BADatePickerTypeYMDHMS : {
            self.showYear = YES;
            self.showMounth = YES;
            self.showDay = YES;
            self.showHours = YES;
            self.showMinutes = YES;
            
            resultString = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", self.resultModel.selectedYear, self.resultModel.selectedMounth, self.resultModel.selectedDay, self.resultModel.selectedHours, self.resultModel.selectedMinutes];
            // BADatePickerTypeYMDHMS 样式需要特殊处理默认数据
            if (self.datePickerType == BADatePickerTypeYMDHMS) {
                // BADatePickerTypeYMDHMS 样式内容过长显示不全，因此省去后缀
                self.showSeconds = YES;
                resultString = [self.resultModel.resultString stringByAppendingFormat:@":%@", self.resultModel.selectedSeconds];
            }
        } break;
            // 15:33
        case BADatePickerTypeHM : {
            self.showHours = YES;
            self.showMinutes = YES;
            resultString = [NSString stringWithFormat:@"%@:%@", self.resultModel.selectedHours, self.resultModel.selectedMinutes];
        } break;
            // 15:33:58
        case BADatePickerTypeHMS : {
            self.showHours = YES;
            self.showMinutes = YES;
            self.showSeconds = YES;
            resultString = [NSString stringWithFormat:@"%@:%@:%@", self.resultModel.selectedHours, self.resultModel.selectedMinutes, self.resultModel.selectedSeconds];
        } break;
            // 2021年，第21周
        case BADatePickerTypeYearWeek : {
            self.showYear = YES;
            self.showWeek = YES;
            resultString = [NSString stringWithFormat:@"%@年-第%@周", self.resultModel.selectedYear, self.resultModel.selectedWeek];
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
        self.resultModel.selectedYear = [NSString stringWithFormat:@"%04li",(long)NSDate.date.year];
        NSInteger yearIndex = [self.yearArray indexOfObject:self.resultModel.selectedYear];
        if (yearIndex <self.yearArray.count) {
            [self.pickerView selectRow:[self.yearArray indexOfObject:self.resultModel.selectedYear] inComponent:0 animated:NO];
        }
    }
}

- (void)setShowMounth:(BOOL)showMounth {
    _showMounth = showMounth;
    
    if (showMounth) {
        self.resultModel.selectedMounth = [NSString stringWithFormat:@"%02li",(long)NSDate.date.month];
        NSInteger mounthIndex = [self.mounthArray indexOfObject:self.resultModel.selectedMounth];
        if (mounthIndex < self.mounthArray.count) {
            NSInteger component = 1;
            if (self.datePickerType == BADatePickerTypeMD) {
                component = 0;
            }
            [self.pickerView selectRow:[self.mounthArray indexOfObject:self.resultModel.selectedMounth] inComponent:component animated:NO];
            if (self.datePickerType != BADatePickerTypeYM) {
                [self refreshDay];
            }
        }
    }
}

- (void)setShowDay:(BOOL)showDay {
    _showDay = showDay;
    
    if (showDay) {
        self.resultModel.selectedDay = [NSString stringWithFormat:@"%02li",(long)NSDate.date.day];
        NSInteger dayIndex = [self.dayArray indexOfObject:self.resultModel.selectedDay];
        if (dayIndex < self.dayArray.count) {
            NSInteger component = 2;
            if (self.datePickerType == BADatePickerTypeMD) {
                component = 1;
            }
            [self.pickerView selectRow:[self.dayArray indexOfObject:self.resultModel.selectedDay] inComponent:component animated:NO];
        }
    }
}

- (void)setShowHours:(BOOL)showHours {
    _showHours = showHours;
    
    if (showHours) {
        self.resultModel.selectedHours = [NSString stringWithFormat:@"%02li",(long)NSDate.date.hour];
        NSInteger hourIndex = [self.hoursArray indexOfObject:self.resultModel.selectedHours];
        if (hourIndex < self.hoursArray.count) {
            NSInteger component = 3;
            if (self.datePickerType == BADatePickerTypeHM || self.datePickerType == BADatePickerTypeHMS) {
                component = 0;
            }
            [self.pickerView selectRow:[self.hoursArray indexOfObject:self.resultModel.selectedHours] inComponent:component animated:NO];
        }
    }
}

- (void)setShowMinutes:(BOOL)showMinutes {
    _showMinutes = showMinutes;
    
    if (showMinutes) {
        self.resultModel.selectedMinutes = [NSString stringWithFormat:@"%02li",(long)NSDate.date.minute];
        NSInteger minutesIndex = [self.minutesArray indexOfObject:self.resultModel.selectedMinutes];
        if (minutesIndex < self.minutesArray.count) {
            NSInteger component = 4;
            if (self.datePickerType == BADatePickerTypeHM || self.datePickerType == BADatePickerTypeHMS) {
                component = 1;
            }
            [self.pickerView selectRow:[self.minutesArray indexOfObject:self.resultModel.selectedMinutes] inComponent:component animated:NO];
        }
    }
}

- (void)setShowSeconds:(BOOL)showSeconds {
    _showSeconds = showSeconds;
    
    if (showSeconds) {
        self.resultModel.selectedSeconds = [NSString stringWithFormat:@"%02li",(long)NSDate.date.second];
        NSInteger secondsIndex = [self.secondsArray indexOfObject:self.resultModel.selectedSeconds];
        if (secondsIndex < self.secondsArray.count) {
            NSInteger component = 5;
            if (self.datePickerType == BADatePickerTypeHMS) {
                component = 2;
            }
            [self.pickerView selectRow:[self.secondsArray indexOfObject:self.resultModel.selectedSeconds] inComponent:component animated:NO];
        }
    }
}

- (void)setShowWeek:(BOOL)showWeek {
    _showWeek = showWeek;
    
    if (showWeek) {
        self.resultModel.selectedWeek = [NSString stringWithFormat:@"%ld", (long)NSDate.date.weekOfYear];
        [self refreshWeeksByYear:self.resultModel.selectedYear];
        [self.pickerView reloadAllComponents];
        
        NSInteger index_week = [self.resultModel.selectedWeek integerValue];
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
