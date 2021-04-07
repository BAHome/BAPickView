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

+ (void)initStringsPickerWithModel:(BAPickerModel *)pickerModel
                                cb:(onSelectPicker)cb;

/// 快速创建 pickerView  单列：不显示中间选中结果
/// @param strings 数据源
/// @param cb 返回
+ (void)initStringsPicker:(NSArray <NSString *>*)strings
                       cb:(onSelectPicker)cb;

/// 快速创建 pickerView  单列
/// @param strings 数据源
/// @param maskViewBackgroundColor 遮罩背景颜色，默认：[UIColor.blackColor colorWithAlphaComponent:0.3]
/// @param cancleTitle 取消按钮文字
/// @param cancleTitleColor 取消按钮文字颜色
/// @param sureTitle 确定按钮文字
/// @param sureTitleColor 确定按钮颜色
/// @param cb 返回
+ (void)initStringsPicker:(NSArray <NSString *>*)strings
  maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
              cancleTitle:(nullable NSString *)cancleTitle
         cancleTitleColor:(nullable UIColor *)cancleTitleColor
         cancleTitleFont:(nullable UIFont *)cancleTitleFont
                sureTitle:(nullable NSString *)sureTitle
           sureTitleColor:(nullable UIColor *)sureTitleColor
            sureTitleFont:(nullable UIFont *)sureTitleFont
                       cb:(onSelectPicker)cb;

@end

@interface BAPickerManger (MultipleStrings)

+ (void)initMultipleStringsPickerWithPickerModle:(BAPickerModel *)pickerModel
                                              cb:(onSelectPicker)cb;

/// 快速创建 pickerView 多列：不显示中间选中结果
/// @param multipleStringsArray 数据源
/// @param cb 返回
+ (void)initMultipleStringsPicker:(NSArray <NSArray *>*)multipleStringsArray
                               cb:(onSelectPicker)cb;

/// 快速创建 pickerView 多列
/// @param multipleStringsArray 数据源
/// @param multipleTitleArray 顶部标题注释，详见 demo
/// @param maskViewBackgroundColor 遮罩背景颜色，默认：[UIColor.blackColor colorWithAlphaComponent:0.3]
/// @param cancleTitle 取消按钮文字
/// @param cancleTitleColor 取消按钮文字颜色
/// @param sureTitle 确定按钮文字
/// @param sureTitleColor 确定按钮颜色
/// @param cb 返回
+ (void)initMultipleStringsPicker:(NSArray <NSArray *>*)multipleStringsArray
               multipleTitleArray:(nullable NSArray <NSString *>*)multipleTitleArray
          maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                      cancleTitle:(nullable NSString *)cancleTitle
                 cancleTitleColor:(nullable UIColor *)cancleTitleColor
                 cancleTitleFont:(nullable UIFont *)cancleTitleFont
                        sureTitle:(nullable NSString *)sureTitle
                   sureTitleColor:(nullable UIColor *)sureTitleColor
                    sureTitleFont:(nullable UIFont *)sureTitleFont
                               cb:(onSelectPicker)cb;



@end

@interface BAPickerManger (City)

+ (void)initCityPickerWithCallBack:(onSelectCityPicker)cb;

@end

@interface BAPickerManger (SystemDateDatePicker)

+ (void)initSystemDatePickerWithModel:(BADatePickerModel *)datePickerModel
                                   cb:(onSelectDatePicker2)cb;

+ (void)initSystemDatePicker:(onSelectDatePicker2)cb;

+ (void)initSystemDatePicker:(UIDatePickerMode)datePickerMode
             formatterString:(nullable NSString *)formatterString
                          cb:(onSelectDatePicker2)cb;

+ (void)initSystemDatePicker:(UIDatePickerMode)datePickerMode
             formatterString:(nullable NSString *)formatterString
     maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                 cancleTitle:(nullable NSString *)cancleTitle
            cancleTitleColor:(nullable UIColor *)cancleTitleColor
            cancleTitleFont:(nullable UIFont *)cancleTitleFont
                   sureTitle:(nullable NSString *)sureTitle
              sureTitleColor:(nullable UIColor *)sureTitleColor
               sureTitleFont:(nullable UIFont *)sureTitleFont
                          cb:(onSelectDatePicker2)cb;


@end

@interface BAPickerManger (CustomDateDatePicker)

+ (void)initCustomDatePickerWithModel:(BADatePickerModel *)datePickerModel
                                   cb:(onSelectDatePicker)cb;

+ (void)initCustomDatePickerWithType:(BADatePickerType)datePickerType
                                  cb:(onSelectDatePicker)cb;

+ (void)initCustomDatePickerWithType:(BADatePickerType)datePickerType
                          showResult:(BOOL)showResult
                                  cb:(onSelectDatePicker)cb;

+ (void)initCustomDatePickerWithType:(BADatePickerType)datePickerType
             maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                         maximumDate:(nullable NSDate *)maximumDate
                         minimumDate:(nullable NSDate *)minimumDate
                          showResult:(BOOL)showResult
                                  cb:(onSelectDatePicker)cb;

@end

NS_ASSUME_NONNULL_END
