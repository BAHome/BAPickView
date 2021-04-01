//
//  BAPickerDefine.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#ifndef BAPickerDefine_h
#define BAPickerDefine_h

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#import "BAKit_ConfigurationDefine.h"
#import "NSDateFormatter+BAKit.h"



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

#endif /* BAPickerDefine_h */



