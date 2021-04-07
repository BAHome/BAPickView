//
//  BAPickerDefine.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#ifndef BAPickerDefine_h
#define BAPickerDefine_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import <Masonry/Masonry.h>

#import "BACityModel.h"
#import "BAPickerResultModel.h"

#import "BAKit_ConfigurationDefine.h"
#import "NSDateFormatter+BAKit.h"
#import "NSBundle+BAPod.h"

// picker 回调
typedef void (^onSelectPicker)(NSInteger selectRow, NSInteger selectComponent, NSString *resultString, NSArray *resultArray);
// datePicker 回调
typedef void (^onSelectDatePicker)(BAPickerResultModel *dateResultModel);
typedef void (^onSelectDatePicker2)(NSString *resultString, NSDate *resultDate);
// cityPicker 回调
typedef void (^onSelectCityPicker)(BACityModel *model);

typedef NS_ENUM(NSUInteger, BADatePickerType) {
    // 2020-08-28
    kBADatePickerType_YMD = 0,
    // 2020
    kBADatePickerType_YY,
    // 2020-08
    kBADatePickerType_YM,
    // 08-28
    kBADatePickerType_MD,
    // 2020-08-28 15:33
    kBADatePickerType_YMDHM,
    // 2020-08-28 15:33:58
    kBADatePickerType_YMDHMS,
    // 2020-08-28，周二, 15:33:58
    kBADatePickerType_YMDEHMS,
    // 15:33
    kBADatePickerType_HM,
    // 15:33:58
    kBADatePickerType_HMS,
    // 2021年，第21周
    kBADatePickerType_YearWeek,
};


// 获取当前最顶部的 window
CG_INLINE UIWindow *
kBAGetAlertWindow() {
    UIWindow *alertWindow = [UIApplication sharedApplication].keyWindow;
    if (alertWindow.windowLevel != UIWindowLevelNormal) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"windowLevel == %ld AND hidden == 0 " , UIWindowLevelNormal];
        alertWindow = [[UIApplication sharedApplication].windows filteredArrayUsingPredicate:predicate].firstObject;
    }
    return alertWindow;
}

CG_INLINE void
kBARemoveAllSubviews(UIView *view) {
    while (view.subviews.count) {
        [view.subviews.lastObject removeFromSuperview];
    }
}



#endif /* BAPickerDefine_h */



