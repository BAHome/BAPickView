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
#import "NSDate+BAKit.h"
#import "NSDateFormatter+BAKit.h"
#import "NSBundle+BAPod.h"

// picker、datePicker 回调
typedef void (^BAPickerResultBlock)(BAPickerResultModel *resultModel);
// cityPicker 回调
typedef void (^BAPickerCityResultBlock)(BACityModel *model);

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
    // 15:33
    kBADatePickerType_HM,
    // 15:33:58
    kBADatePickerType_HMS,
    // 2021年，第21周
    kBADatePickerType_YearWeek,
};


// 获取当前最顶部的 window
CG_INLINE UIWindow *
kBAPickerGetAlertWindow() {
    UIWindow *alertWindow = [UIApplication sharedApplication].keyWindow;
    if (alertWindow.windowLevel != UIWindowLevelNormal) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"windowLevel == %ld AND hidden == 0 " , UIWindowLevelNormal];
        alertWindow = [[UIApplication sharedApplication].windows filteredArrayUsingPredicate:predicate].firstObject;
    }
    return alertWindow;
}

// 移除 view 所有 subviews
CG_INLINE void
kBAPickerRemoveAllSubviews(UIView *view) {
    while (view.subviews.count) {
        [view.subviews.lastObject removeFromSuperview];
    }
}

#endif /* BAPickerDefine_h */
