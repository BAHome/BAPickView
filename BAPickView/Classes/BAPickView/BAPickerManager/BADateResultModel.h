//
//  BADateResultModel.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BADateResultModel : NSObject

// 选中结果保存
@property(nonatomic, copy) NSString *resultString;
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
