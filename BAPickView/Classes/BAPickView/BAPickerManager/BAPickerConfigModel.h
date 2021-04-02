//
//  BAPickerConfigModel.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import <Foundation/Foundation.h>
#import "BAKit_PickerViewConfig.h"

NS_ASSUME_NONNULL_BEGIN

@class BAPickerModel;
@class BADatePickerModel;
@class BAPickerToolBarModel;

@interface BAPickerConfigModel : NSObject

@property(nonatomic, strong) BAPickerModel *pickerModel;
@property(nonatomic, strong) BADatePickerModel *datePickerModel;
@property(nonatomic, strong) BAPickerToolBarModel *toolBarModel;


#pragma mark - common
/**
 动画样式
 */
@property(nonatomic, assign) BAKit_PickerViewAnimationType animationType;

/// 默认：[UIColor.blackColor colorWithAlphaComponent:0.3]
@property(nonatomic, strong) UIColor *maskViewBackgroundColor;
@property(nonatomic, strong) UIColor *pickerViewBackgroundColor;

@property(nonatomic, assign) CGFloat pickerHeight;
@property(nonatomic, assign) CGFloat toolBarHeight;

/**
 是否开启边缘触摸隐藏，默认：YES
 */
@property(nonatomic, assign) BOOL enableTouchDismiss;

@end

@interface BAPickerModel : NSObject

// 单列
@property(nonatomic, strong) NSArray <NSString *>*stringsArray;

// 多列
@property(nonatomic, strong) NSArray *multipleTitleArray;
@property(nonatomic, strong) NSArray *multipleStringsArray;

// city
@property(nonatomic, strong) NSArray *allProvinceCityArray;

@end

@interface BADatePickerModel : NSObject

@property (nonatomic, strong) NSString *formatterString;

@property (nonatomic) UIDatePickerMode datePickerMode; // default is UIDatePickerModeDate

/**
 日期选择器的最大日期，默认为：当前时间 +60年
 */
@property(nonatomic, strong) NSDate *maximumDate;

/**
 日期选择器的最小日期，默认为：当前时间 -60年
 */
@property(nonatomic, strong) NSDate *minimumDate;



@end

@interface BAPickerToolBarModel : NSObject

#pragma mark - title
@property(nonatomic, copy) NSString *cancleTitle;
@property(nonatomic, copy) NSString *sureTitle;

#pragma mark - color
@property(nonatomic, strong) UIColor *backgroundColor;
@property(nonatomic, strong) UIColor *titleColor;
@property(nonatomic, strong) UIColor *cancleTitleColor;
@property(nonatomic, strong) UIColor *sureTitleColor;

#pragma mark - font
@property(nonatomic, strong) UIFont *titleFont;
@property(nonatomic, strong) UIFont *cancleTitleFont;
@property(nonatomic, strong) UIFont *sureTitleFont;

@property(nonatomic, assign) BOOL showBottomeLine;
@property(nonatomic, strong) UIColor *bottomeLineColor;

/// toolBar 是否显示选中结果，默认：YES
@property(nonatomic, assign) BOOL showResult;

@end

NS_ASSUME_NONNULL_END
