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
@property(nonatomic, strong) NSDate *resultDate;

@property(nonatomic, copy) NSString *selectedYear;
@property(nonatomic, copy) NSString *selectedMounth;
@property(nonatomic, copy) NSString *selectedDay;
@property(nonatomic, copy) NSString *selectedHours;
@property(nonatomic, copy) NSString *selectedMinutes;
@property(nonatomic, copy) NSString *selectedSeconds;
@property(nonatomic, copy) NSString *selectedWeek;

@end

NS_ASSUME_NONNULL_END
