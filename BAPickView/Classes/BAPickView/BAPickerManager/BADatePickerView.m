//
//  BADatePickerView.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import "BADatePickerView.h"
#import "BAPickerToolBarView.h"

@interface BADatePickerView ()

@property(nonatomic, strong) UIView *bgView;
@property(nonatomic, strong) UIDatePicker *datePicker;
@property(nonatomic, strong) BADatePickerModel *datePickerModel;
@property(nonatomic, strong) NSDateFormatter *formatter;

@property(nonatomic, strong) BAPickerToolBarView *toolBarView;

@property(nonatomic, copy) NSString *resultString;
@property(nonatomic, strong) NSDate *resultDate;

@end

@implementation BADatePickerView

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
    
    [self.bgView addSubview:self.datePicker];
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    // 初始默认显示当前日期
    NSString *resultString = [self.formatter stringFromDate:NSDate.date];
    self.toolBarView.result = resultString;
    
    BAKit_WeakSelf;
    self.toolBarView.onCancleButton = ^{
        BAKit_StrongSelf;
        [self dismiss];
    };
    self.toolBarView.onSureButton = ^{
        BAKit_StrongSelf
        
        self.onSelectDatePicker ? self.onSelectDatePicker(self.resultString, self.resultDate):nil;
        [self dismiss];
    };
    
}

#pragma mark - custom method
#pragma mark 日期选择器数据更新
- (void)datePickValueChanged:(UIDatePicker *)sender {
    self.resultDate = sender.date;
}

#pragma mark - setter, getter

- (void)setResultDate:(NSDate *)resultDate {
    _resultDate = resultDate;
    
    NSString *resultString = [self.formatter stringFromDate:resultDate];
    self.resultString = resultString;
    self.toolBarView.result = resultString;
}

- (void)setConfigModel:(BADatePickerModel *)configModel {
    _configModel = configModel;
        
    // 公共配置：configModel
    {
        self.enableTouchDismiss = configModel.enableTouchDismiss;
        
        self.bgColor = configModel.maskViewBackgroundColor;
        self.datePicker.backgroundColor = configModel.pickerViewBackgroundColor;
                
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
        // 默认数据：
        self.resultDate = NSDate.date;
    }
}

- (void)setDatePickerModel:(BADatePickerModel *)datePickerModel {
    _datePickerModel = datePickerModel;
    
    if (datePickerModel.maximumDate) {
        self.datePicker.maximumDate = datePickerModel.maximumDate;
    }
    if (datePickerModel.minimumDate) {
        self.datePicker.minimumDate = datePickerModel.minimumDate;
    }
    if (datePickerModel.datePickerMode) {
        self.datePicker.datePickerMode = datePickerModel.datePickerMode;
    }
    if (datePickerModel.formatterString) {
        self.formatter.dateFormat = datePickerModel.formatterString;
    }
    

}

- (NSDateFormatter *)formatter {
    if (!_formatter) {
        _formatter = NSDateFormatter.new;
        //formatter.dateFormat = @"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
        _formatter.dateFormat = @"yyyy-MM-dd";
        _formatter.locale = [NSLocale localeWithLocaleIdentifier:@"China"];
        _formatter.timeZone = [NSTimeZone systemTimeZone];
    }
    return _formatter;
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

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = UIDatePicker.new;
        
        /*! 跟踪所有可用的地区，取出想要的地区 */
//        NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
        
        /*! 1、设置日期选择控件的地区 */
        _datePicker.locale = [NSLocale systemLocale];
        /*! 2、设置DatePicker的日历。默认为当天。 */
        [_datePicker setCalendar:[NSCalendar currentCalendar]];
        
        /*! 3、设置DatePicker的时区。*/
        [_datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
        
        /*! 8、当值发生改变的时候调用的方法 */
        [_datePicker addTarget:self action:@selector(datePickValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        /*! 9、用 runtime 和 KVC 改变字体颜色 */
        //        [self setTextColor];
        if (@available(iOS 13.4, *)) {
            _datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];//新发现这里不会根据系统的语言变了
            _datePicker.preferredDatePickerStyle = UIDatePickerStyleWheels;
        }
    }
    return _datePicker;
}

@end
