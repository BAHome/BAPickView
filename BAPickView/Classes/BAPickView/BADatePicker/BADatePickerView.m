//
//  BADatePickerView.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import "BADatePickerView.h"

@interface BADatePickerView ()

@property(nonatomic, strong) UIDatePicker *datePicker;

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
    
}

- (void)initData {
    
}

#pragma mark - custom method

#pragma mark 日期选择器数据更新
- (void)datePickValueChanged:(UIDatePicker *)sender {
    NSString *resultString = [self.formatter stringFromDate:sender.date];
    self.onSelectDatePicker ? self.onSelectDatePicker(resultString, sender.date):nil;
}

#pragma mark - setter, getter

- (UIDatePicker *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        
        /*! 跟踪所有可用的地区，取出想要的地区 */
//        NSLog(@"%@", [NSLocale availableLocaleIdentifiers]);
        
        /*! 1、设置日期选择控件的地区 */
        [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
        /*! 英文 */
//            [_datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"en_SC"]];
         //[_datePicker setLocale:[NSLocale systemLocale]];
        /*! 2、设置DatePicker的日历。默认为当天。 */
        [_datePicker setCalendar:[NSCalendar currentCalendar]];
        
        /*! 3、设置DatePicker的时区。*/
        [_datePicker setTimeZone:[NSTimeZone defaultTimeZone]];
        
        /*! 4、设置DatePicker的日期。 */
        //[_datePicker setDate:BAKit_Current_Date];
        
        /*! 5、设置DatePicker的允许的最小日期。 */
        //        NSDate *minDate = [[NSDate alloc]initWithTimeIntervalSince1970:NSTimeIntervalSince1970];
        //        _datePicker.minimumDate = minDate;
        
        /*! 6、设置DatePicker的允许的最大日期。 */
        NSDateComponents *dc = [[NSDateComponents alloc] init];
        dc.year = 2099;
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _datePicker.maximumDate = [gregorian dateFromComponents:dc];
        
        /*! 6.1 限定UIDatePicker的时间范围 */
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        comps.year = 30;
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        comps.year = -30;
        
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        
        NSString *selfStr = [formatter stringFromDate:minDate];
        NSString *maxStr = [formatter stringFromDate:maxDate];
       
        _datePicker.minimumDate = [formatter dateFromString:selfStr];
        _datePicker.maximumDate = [formatter dateFromString:maxStr];
        
//        /*! 7、显示年月日，名称根据本地设置，显示小时，分钟和AM/PM,这个的名称是根据本地设置的 */
//        [_datePicker setDatePickerMode:UIDatePickerModeDate];
//
        /*! 8、当值发生改变的时候调用的方法 */
        [_datePicker addTarget:self action:@selector(datePickValueChanged:) forControlEvents:UIControlEventValueChanged];
        
        /*! 9、用 runtime 和 KVC 改变字体颜色 */
//        [self setTextColor];
    }
    return _datePicker;
}

@end
