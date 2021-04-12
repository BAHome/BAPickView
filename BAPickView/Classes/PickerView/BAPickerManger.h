//
//  BAPickerManger.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/2.
//  此类是简单的二次封装，如有其他自定义选项可以自行单独二次封装

#import <Foundation/Foundation.h>
#import "BAPickerDefine.h"
#import "BAPickerConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BAPickerManger : NSObject

/// 快速创建 pickerView 单列
/// @param pickerModel 自定义 model
/// @param cb 返回
+ (void)initStringsPickerWithModel:(BAPickerModel *)pickerModel
                                cb:(BAPickerResultBlock)cb;

/// 快速创建 pickerView  单列
/// @param title 中间标题，例如：请选择日期
/// @param strings 数据源
/// @param showResult 是否显示选中结果
/// @param cb 返回
+ (void)initStringsPickerWithTitle:(nullable NSString *)title
                           strings:(NSArray <NSString *>*)strings
                        showResult:(BOOL)showResult
                                cb:(BAPickerResultBlock)cb ;

/// 快速创建 pickerView  单列
/// @param title 中间标题，例如：请选择日期
/// @param titleFont 中间标题文字字体
/// @param strings 数据源
/// @param maskViewBackgroundColor 遮罩背景颜色，默认：[UIColor.blackColor colorWithAlphaComponent:0.3]
/// @param cancleTitle 取消按钮文字
/// @param cancleTitleColor 取消按钮文字颜色
/// @param cancleTitleFont 取消按钮文字字体
/// @param sureTitle 确定按钮文字
/// @param sureTitleColor 确定按钮文字颜色
/// @param sureTitleFont 确定按钮文字字体
/// @param showResult 是否显示选中结果
/// @param cb 返回
+ (void)initStringsPickerWithTitle:(nullable NSString *)title
                         titleFont:(nullable UIFont *)titleFont
                           strings:(NSArray <NSString *>*)strings
           maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                       cancleTitle:(nullable NSString *)cancleTitle
                  cancleTitleColor:(nullable UIColor *)cancleTitleColor
                   cancleTitleFont:(nullable UIFont *)cancleTitleFont
                         sureTitle:(nullable NSString *)sureTitle
                    sureTitleColor:(nullable UIColor *)sureTitleColor
                     sureTitleFont:(nullable UIFont *)sureTitleFont
                        showResult:(BOOL)showResult
                                cb:(BAPickerResultBlock)cb;

@end

@interface BAPickerManger (MultipleStrings)

/// 快速创建 pickerView 多列
/// @param pickerModel 自定义 model
/// @param cb 返回
+ (void)initMultipleStringsPickerWithPickerModle:(BAPickerModel *)pickerModel
                                              cb:(BAPickerResultBlock)cb;

/// 快速创建 pickerView 多列
/// @param title 中间标题，例如：请选择日期 
/// @param multipleStringsArray 数据源
/// @param showResult 是否显示选中结果
/// @param cb 返回
+ (void)initMultipleStringsPickerWithTitle:(nullable NSString *)title
                      multipleStringsArray:(NSArray <NSArray *>*)multipleStringsArray
                                showResult:(BOOL)showResult
                                        cb:(BAPickerResultBlock)cb;

/// 快速创建 pickerView 多列
/// @param title 中间标题，例如：请选择日期
/// @param titleFont 中间标题文字字体
/// @param multipleStringsArray 数据源
/// @param multipleTitleArray 顶部标题注释，详见 demo
/// @param maskViewBackgroundColor 遮罩背景颜色，默认：[UIColor.blackColor colorWithAlphaComponent:0.3]
/// @param cancleTitle 取消按钮文字
/// @param cancleTitleColor 取消按钮文字颜色
/// @param cancleTitleFont 取消按钮文字字体
/// @param sureTitle 确定按钮文字
/// @param sureTitleColor 确定按钮文字颜色
/// @param sureTitleFont 确定按钮文字字体
/// @param showResult 是否显示选中结果
/// @param cb 返回
+ (void)initMultipleStringsPickerWithTitle:(nullable NSString *)title
                                 titleFont:(nullable UIFont *)titleFont
                      multipleStringsArray:(NSArray <NSArray *>*)multipleStringsArray
                        multipleTitleArray:(nullable NSArray <NSString *>*)multipleTitleArray
                   maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                               cancleTitle:(nullable NSString *)cancleTitle
                          cancleTitleColor:(nullable UIColor *)cancleTitleColor
                           cancleTitleFont:(nullable UIFont *)cancleTitleFont
                                 sureTitle:(nullable NSString *)sureTitle
                            sureTitleColor:(nullable UIColor *)sureTitleColor
                             sureTitleFont:(nullable UIFont *)sureTitleFont
                                showResult:(BOOL)showResult
                                        cb:(BAPickerResultBlock)cb;

@end

@interface BAPickerManger (City)

/// 快速创建 pickerView 城市选择
/// @param cb 返回
+ (void)initCityPickerWithCallBack:(BAPickerCityResultBlock)cb;

/// 快速创建 pickerView 城市选择
/// @param title 中间标题，例如：请选择日期
/// @param showResult 是否显示选中结果
/// @param cb 返回
+ (void)initCityPickerWithTitle:(nullable NSString *)title
                     showResult:(BOOL)showResult
                             cb:(BAPickerCityResultBlock)cb;

@end

@interface BAPickerManger (SystemDateDatePicker)

/// 快速创建 pickerView 日期选择器-系统样式
/// @param datePickerModel 自定义 model
/// @param cb 返回
+ (void)initSystemDatePickerWithModel:(BADatePickerModel *)datePickerModel
                                   cb:(BAPickerResultBlock)cb;

/// 快速创建 pickerView 日期选择器-系统样式
/// @param cb 返回
+ (void)initSystemDatePicker:(BAPickerResultBlock)cb;

/// 快速创建 pickerView 日期选择器-系统样式
/// @param title 中间标题，例如：请选择日期
/// @param datePickerMode datePickerMode description
/// @param showResult 是否显示选中结果
/// @param cb 返回
+ (void)initSystemDatePickerTitle:(nullable NSString *)title
                   datePickerMode:(UIDatePickerMode)datePickerMode
                       showResult:(BOOL)showResult
                               cb:(BAPickerResultBlock)cb;

/// 快速创建 pickerView 日期选择器-系统样式
/// @param title 中间标题，例如：请选择日期
/// @param titleFont 中间标题文字字体
/// @param datePickerMode datePickerMode description
/// @param formatterString formatterString description
/// @param maskViewBackgroundColor 遮罩背景颜色，默认：[UIColor.blackColor colorWithAlphaComponent:0.3]
/// @param cancleTitle 取消按钮文字
/// @param cancleTitleColor 取消按钮文字颜色
/// @param cancleTitleFont 取消按钮文字字体
/// @param sureTitle 确定按钮文字
/// @param sureTitleColor 确定按钮文字颜色
/// @param sureTitleFont 确定按钮文字字体
/// @param showResult 是否显示选中结果
/// @param cb 返回
+ (void)initSystemDatePickerTitle:(nullable NSString *)title
                        titleFont:(nullable UIFont *)titleFont
                   datePickerMode:(UIDatePickerMode)datePickerMode
                  formatterString:(nullable NSString *)formatterString
          maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                      cancleTitle:(nullable NSString *)cancleTitle
                 cancleTitleColor:(nullable UIColor *)cancleTitleColor
                  cancleTitleFont:(nullable UIFont *)cancleTitleFont
                        sureTitle:(nullable NSString *)sureTitle
                   sureTitleColor:(nullable UIColor *)sureTitleColor
                    sureTitleFont:(nullable UIFont *)sureTitleFont
                       showResult:(BOOL)showResult
                               cb:(BAPickerResultBlock)cb;

@end

@interface BAPickerManger (CustomDateDatePicker)

/// 快速创建 pickerView 日期选择器-自定义样式
/// @param datePickerModel 自定义 model
/// @param cb 返回
+ (void)initCustomDatePickerWithModel:(BADatePickerModel *)datePickerModel
                                   cb:(BAPickerResultBlock)cb;

/// 快速创建 pickerView 日期选择器-自定义样式
/// @param datePickerType datePickerType description
/// @param cb 返回
+ (void)initCustomDatePickerWithType:(BADatePickerType)datePickerType
                                  cb:(BAPickerResultBlock)cb;

/// 快速创建 pickerView 日期选择器-自定义样式
/// @param title 中间标题，例如：请选择日期
/// @param datePickerType datePickerType description
/// @param showResult 是否显示选中结果
/// @param cb 返回
+ (void)initCustomDatePickerWithTitle:(nullable NSString *)title
                       datePickerType:(BADatePickerType)datePickerType
                           showResult:(BOOL)showResult
                                   cb:(BAPickerResultBlock)cb;

/// 快速创建 pickerView 日期选择器-自定义样式
/// @param title 中间标题，例如：请选择日期
/// @param titleFont 中间标题文字字体
/// @param datePickerType datePickerType description
/// @param maskViewBackgroundColor 遮罩背景颜色，默认：[UIColor.blackColor colorWithAlphaComponent:0.3]
/// @param maximumDate 最大日期
/// @param minimumDate 最小日期
/// @param cancleTitle 取消按钮文字
/// @param cancleTitleColor 取消按钮文字颜色
/// @param cancleTitleFont 取消按钮文字字体
/// @param sureTitle 确定按钮文字
/// @param sureTitleColor 确定按钮文字颜色
/// @param sureTitleFont 确定按钮文字字体
/// @param showResult 是否显示选中结果
/// @param cb 返回
+ (void)initCustomDatePickerWithTitle:(nullable NSString *)title
                            titleFont:(nullable UIFont *)titleFont
                       datePickerType:(BADatePickerType)datePickerType
              maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                          maximumDate:(nullable NSDate *)maximumDate
                          minimumDate:(nullable NSDate *)minimumDate
                          cancleTitle:(nullable NSString *)cancleTitle
                     cancleTitleColor:(nullable UIColor *)cancleTitleColor
                      cancleTitleFont:(nullable UIFont *)cancleTitleFont
                            sureTitle:(nullable NSString *)sureTitle
                       sureTitleColor:(nullable UIColor *)sureTitleColor
                        sureTitleFont:(nullable UIFont *)sureTitleFont
                           showResult:(BOOL)showResult
                                   cb:(BAPickerResultBlock)cb;

@end

NS_ASSUME_NONNULL_END
