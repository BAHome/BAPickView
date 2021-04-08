//
//  BAPickerConfigModel.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import <Foundation/Foundation.h>
#import "BAKit_PickerViewConfig.h"
#import "BAPickerDefine.h"

NS_ASSUME_NONNULL_BEGIN

@class BAPickerModel;
@class BADatePickerModel;
@class BAPickerToolBarModel;

@interface BAPickerConfigModel : NSObject

@end

@interface BAPickerConfigBaseModel : NSObject

#pragma mark - common
/// 背景遮罩颜色，默认：[UIColor.blackColor colorWithAlphaComponent:0.3]
@property(nonatomic, strong) UIColor *maskViewBackgroundColor;
/// contentView 的背景颜色
@property(nonatomic, strong) UIColor *contentViewBackgroundColor;
/// picker 的背景颜色
@property(nonatomic, strong) UIColor *pickerViewBackgroundColor;
/// picker 的高度
@property(nonatomic, assign) CGFloat pickerHeight;
/// toolBar 的高度
@property(nonatomic, assign) CGFloat toolBarHeight;
/// toolBar 配置 model
@property(nonatomic, strong) BAPickerToolBarModel *toolBarModel;
/// 是否开启边缘触摸隐藏，默认：YES
@property(nonatomic, assign) BOOL enableTouchDismiss;
/// picker 文本字体
@property(nonatomic, strong) UIFont *titleFont;

@end

@interface BAPickerModel : BAPickerConfigBaseModel

/// 单列
@property(nonatomic, strong) NSArray <NSString *>*stringsArray;

/// 多列-标题
@property(nonatomic, strong) NSArray *multipleTitleArray;
/// 多列-数据
@property(nonatomic, strong) NSArray *multipleStringsArray;

/// city
@property(nonatomic, strong) NSArray *allProvinceCityArray;

@end

@interface BADatePickerModel : BAPickerConfigBaseModel

#pragma mark - common
/// 日期选择器的最大日期，默认为：当前时间 +60年
@property(nonatomic, strong) NSDate *maximumDate;
/// 日期选择器的最小日期，默认为：当前时间 -60年
@property(nonatomic, strong) NSDate *minimumDate;

#pragma mark - system
@property (nonatomic, strong) NSString *formatterString;

// default is UIDatePickerModeDate
@property (nonatomic) UIDatePickerMode datePickerMode;

#pragma mark - custom
@property(nonatomic, assign) BADatePickerType datePickerType;

@end

@interface BAPickerToolBarModel : NSObject

#pragma mark - common
/// ToolBar：是否显示选中结果，默认：YES
@property(nonatomic, assign) BOOL showResult;

@property(nonatomic, assign) BOOL showBottomeLine;
@property(nonatomic, strong) UIColor *bottomeLineColor;

#pragma mark - title
/// ToolBar：默认标题，例如：请选择出生日期
@property(nonatomic, copy) NSString *title;
/// ToolBar：左边按钮 title
@property(nonatomic, copy) NSString *cancleTitle;
/// ToolBar：右边按钮 title
@property(nonatomic, copy) NSString *sureTitle;

#pragma mark - color
/// ToolBar：背景颜色
@property(nonatomic, strong) UIColor *backgroundColor;
/// ToolBar：中间标题文字颜色
@property(nonatomic, strong) UIColor *titleColor;
/// ToolBar：左边按钮文字颜色
@property(nonatomic, strong) UIColor *cancleTitleColor;
/// ToolBar：右边按钮文字颜色
@property(nonatomic, strong) UIColor *sureTitleColor;

#pragma mark - font
/// ToolBar：中间标题文字字体
@property(nonatomic, strong) UIFont *titleFont;
/// ToolBar：左边按钮文字字体
@property(nonatomic, strong) UIFont *cancleTitleFont;
/// ToolBar：右边按钮文字字体
@property(nonatomic, strong) UIFont *sureTitleFont;

@end

NS_ASSUME_NONNULL_END
