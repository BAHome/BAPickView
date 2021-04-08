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
                                cb:(BASelectPickerBlock)cb;

/// 快速创建 pickerView  单列
/// @param title 中间标题，例如：请选择日期
/// @param strings 数据源
/// @param showResult 是否显示选中结果
/// @param cb 返回
+ (void)initStringsPickerWithTitle:(nullable NSString *)title
                           strings:(NSArray <NSString *>*)strings
                        showResult:(BOOL)showResult
                                cb:(BASelectPickerBlock)cb ;

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
                                cb:(BASelectPickerBlock)cb;

@end

@interface BAPickerManger (MultipleStrings)

/// 快速创建 pickerView 多列
/// @param pickerModel 自定义 model
/// @param cb 返回
+ (void)initMultipleStringsPickerWithPickerModle:(BAPickerModel *)pickerModel
                                              cb:(BASelectPickerBlock)cb;

/// 快速创建 pickerView 多列
/// @param title 中间标题，例如：请选择日期 
/// @param multipleStringsArray 数据源
/// @param showResult 是否显示选中结果
/// @param cb 返回
+ (void)initMultipleStringsPickerWithTitle:(nullable NSString *)title
                      multipleStringsArray:(NSArray <NSArray *>*)multipleStringsArray
                                showResult:(BOOL)showResult
                                        cb:(BASelectPickerBlock)cb;

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
                                        cb:(BASelectPickerBlock)cb;

@end

@interface BAPickerManger (City)

+ (void)initCityPickerWithCallBack:(BASelectCityPickerBlock)cb;

@end

@interface BAPickerManger (SystemDateDatePicker)

+ (void)initSystemDatePickerWithModel:(BADatePickerModel *)datePickerModel
                                   cb:(BASelectDatePickerBlock)cb;

+ (void)initSystemDatePicker:(BASelectDatePickerBlock)cb;

+ (void)initSystemDatePickerTitle:(nullable NSString *)title
                   datePickerMode:(UIDatePickerMode)datePickerMode
                       showResult:(BOOL)showResult
                               cb:(BASelectDatePickerBlock)cb;

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
                               cb:(BASelectDatePickerBlock)cb;

@end

@interface BAPickerManger (CustomDateDatePicker)

+ (void)initCustomDatePickerWithModel:(BADatePickerModel *)datePickerModel
                                   cb:(BASelectDatePickerBlock)cb;

+ (void)initCustomDatePickerWithType:(BADatePickerType)datePickerType
                                  cb:(BASelectDatePickerBlock)cb;

+ (void)initCustomDatePickerWithTitle:(nullable NSString *)title
                       datePickerType:(BADatePickerType)datePickerType
                           showResult:(BOOL)showResult
                                   cb:(BASelectDatePickerBlock)cb;

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
                                   cb:(BASelectDatePickerBlock)cb;

@end

NS_ASSUME_NONNULL_END
