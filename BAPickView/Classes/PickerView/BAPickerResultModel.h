//
//  BAPickerResultModel.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BAPickerResultModel : NSObject

// 选中结果保存

#pragma mark - common
@property(nonatomic, copy) NSString *resultString;

@property(nonatomic, assign) NSInteger selectRow;
@property(nonatomic, assign) NSInteger selectComponent;

#pragma mark - picker
@property(nonatomic, strong) NSArray *resultArray;

#pragma mark - 日期选择器
/// 只有系统日期选择器才会返回
@property(nonatomic, strong) NSDate *resultDate;

@property(nonatomic, assign) NSInteger selectedYear;
@property(nonatomic, assign) NSInteger selectedMonth;
@property(nonatomic, assign) NSInteger selectedDay;
@property(nonatomic, assign) NSInteger selectedHours;
@property(nonatomic, assign) NSInteger selectedMinutes;
@property(nonatomic, assign) NSInteger selectedSeconds;
@property(nonatomic, assign) NSInteger selectedWeek;

@end

NS_ASSUME_NONNULL_END
