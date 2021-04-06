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

#import "BAKit_ConfigurationDefine.h"
#import "NSDateFormatter+BAKit.h"
#import "NSBundle+BAPod.h"

// picker 回调
typedef void (^onSelectPicker)(NSInteger selectRow, NSInteger selectComponent, NSString *resultString, NSArray *resultArray, UIPickerView *pickerView);
// datePicker 回调
typedef void (^onSelectDatePicker)(NSString *resultString, NSDate *resultDate);
// cityPicker 回调
typedef void (^onSelectCityPicker)(BACityModel *model);

typedef NS_ENUM(NSUInteger, BADatePickerType) {
    kBADatePickerType_YMD = 0,
    kBADatePickerType_Y,
    kBADatePickerType_YM,
    kBADatePickerType_YMDHM,
    kBADatePickerType_YMDHMS,
    // 系统样式：需要设置 UIDatePickerMode，默认为：UIDatePickerModeDate
    kBADatePickerType_System,
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



