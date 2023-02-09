# BAPickView

[![BAHome Team Name](https://img.shields.io/badge/Team-BAHome-brightgreen.svg?style=flat)](https://github.com/BAHome "BAHome Team")
[![CI Status](https://img.shields.io/travis/boai/BAPickView.svg?style=flat)](https://travis-ci.org/boai/BAPickView)
[![Version](https://img.shields.io/cocoapods/v/BAPickView.svg?style=flat)](https://cocoapods.org/pods/BAPickView)
[![License](https://img.shields.io/cocoapods/l/BAPickView.svg?style=flat)](https://cocoapods.org/pods/BAPickView)
[![Platform](https://img.shields.io/cocoapods/p/BAPickView.svg?style=flat)](https://cocoapods.org/pods/BAPickView)
[![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

BAPickView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BAPickView'
```

### `V1.2.1` 版本删除旧版本代码，注意：如需使用旧版本，请固定版本号为  `pod 'BAPickView', 1.2.0`

## Author

boai, sunboyan@outlook.com

## License

BAPickView is available under the MIT license. See the LICENSE file for more info.

## 1、功能及简介
* 1、城市选择器，三级联动，可返回省市县和精确的经纬度 <br>
* 2、可以自定义 array 显示，性别选择等【目前只支持单行数据】
* 3、日期选择器：年月日，可以完全自定义 NSDateFormatter
* 4、日期选择器：年月，可以完全自定义 NSDateFormatter
* 5、日期选择器：年周，如：2017年，第21周
* 6、横竖屏适配完美
* 7、可以自定义按钮颜色、背景颜色等
* 8、新增各种展示、消失动画，如：缩放、上下左右展示、消失动画等
* 9、可以自由设置 pickView 居中或者在底部显示，还可以自由定制 toolbar 居中或者在底部显示 <br>
* 10、可以自由设置 pickView 字体、字体颜色等内容，注意：日期选择器暂时不能修改字体，有可能被苹果审核不通过，如有特殊需求，可通过 runtime 修改 <br>
* 11、新增 各种自定义 datePicker：年、年月、年月日、时间等等，你能想到的效果都有 <br>
* 12、可以自定义 datePicker 的字体颜色、字体、字体大小、背景颜色等 <br>
* 13、可以自定义 datePicker 的最大、最小年限 <br>
* 14、可以自定义 datePicker 的 toolBar 位置、字体、背景颜色等
* 15、可以自定义显示隐藏 分割线和分割线颜色
* 16、日期选择器新增 最大月份限制(感谢简书网友 [@洁简](http://www.jianshu.com/u/62f0c72a2004) 同学提出的 需求！) <br>
* 17、日期选择器新增 优化了最大最小年份月份的写法，现在可以自由定义最大最小日期了，详见 demo<br>
* 18、新增 选中结果直接显示在 工具栏的中间，且可以自定义颜色、字体 <br>
* 19、日期选择器 新增背景年份水印显示 <br>
* 20、完美适配 iOS 11 和 iPhone X <br>
* 21、新增 自定义 `datePicker` 自定义字体颜色 <br>

## 2、图片示例
![BAPickView.gif](https://github.com/BAHome/BAPickView/blob/master/Images/BAPickView.gif)
![BAPickView1.png](https://github.com/BAHome/BAPickView/blob/master/Images/BAPickView1.png)

## 3、安装、导入示例和源码地址
* 1、pod 导入【最新版本：![](https://img.shields.io/cocoapods/v/BAPickView.svg?style=flat)】： <br>
 `pod 'BAPickView'`  <br>
如果发现 `pod search BAPickView` 搜索出来的不是最新版本，需要在终端执行 cd 转换文件路径命令退回到 desktop，然后执行 `pod setup` 命令更新本地spec缓存（可能需要几分钟），然后再搜索就可以了。<br>
具体步骤：
  - pod setup : 初始化
  - pod repo update : 更新仓库
  - pod search BAPickView
* 2、文件夹拖入：下载demo，把 BAPickView 文件夹拖入项目即可，<br>
* 3、导入头文件：<br>
`  #import "BAPickView_OC.h" `<br>
* 4、项目源码地址：<br>
 OC 版 ：[https://github.com/BAHome/BAPickView](https://github.com/BAHome/BAPickView)<br>

## 4、BAPickView 的类结构及 demo 示例
![BAPickView.png](https://github.com/BAHome/BAPickView/blob/master/Images/BAPickView.png)

### 简单封装效果 及 demo 示例
```
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

其他示例可下载demo查看源码！
```

## 5、更新记录：【倒叙】
 欢迎使用 [【BAHome】](https://github.com/BAHome) 系列开源代码 ！
 如有更多需求，请前往：[【https://github.com/BAHome】](https://github.com/BAHome) 
 
 最新更新时间：2023-02-9 【倒叙】 <br>
 最新Version：【Version：1.2.5】 <br>
 更新内容： <br>
 1.2.5.1、此版本删除旧版本代码，注意：如需使用旧版本，请固定版本号为 V1.2.0<br>
 1.2.5.2、修复一些已知问题<br>
 
 最新更新时间：2022-08-5 【倒叙】 <br>
 最新Version：【Version：1.2.4】 <br>
 更新内容： <br>
 1.2.4.1、此版本删除旧版本代码，注意：如需使用旧版本，请固定版本号为 V1.2.0<br>
 1.2.4.2、新增 `CustomDatePicker` 自定义字体颜色<br>
 1.2.4.2、修复一些已知问题<br>

 最新更新时间：2021-04-13 【倒叙】 <br>
 最新Version：【Version：1.2.3】 <br>
 更新内容： <br>
 1.2.3.1、此版本删除旧版本代码，注意：如需使用旧版本，请固定版本号为 V1.2.0<br>
 1.2.3.2、修复一些已知问题<br>

 最新更新时间：2021-04-09 【倒叙】 <br>
 最新Version：【Version：1.2.0】 <br>
 更新内容： <br>
 1.2.0.1、优化适配 iOS 14 及 修复 自定义日期选择器 已知问题 <br>
 1.2.0.2、`BAPickerManger`  全新封装组件开发完成，注意：如需使用旧版本，请固定版本号为 V1.2.0，<br>
 
 最新更新时间：2019-9-03 【倒叙】 <br>
 最新Version：【Version：1.1.9】 <br>
 更新内容： <br>
 1.1.9.1、优化适配异形屏，优化部分动画性能 <br>
 1.1.9.2、`BAKit_PickerView` 系统 `UIDatePicker` 新增 最大最小日期 设置<br>
 1.1.9.3、`BAKit_PickerView` 新增 toolBarView 底部线条，isShowTooBarBottomeLine ，可自定义线条颜色<br>
 
 最新更新时间：2019-8-30 【倒叙】 <br>
 最新Version：【Version：1.1.8】 <br>
 更新内容： <br>
 1.1.8.1、优化适配异形屏，优化部分动画性能，(感谢git网友 [@李智慧](https://github.com/luobojiangzi ) 同学提出的 bug！) <br>
 
 最新更新时间：2019-8-20 【倒叙】 <br>
 最新Version：【Version：1.1.7】 <br>
 更新内容： <br>
 1.1.7.1、修复部分自定义日期大小数值去错问题，(感谢git网友 [@李智慧](https://github.com/luobojiangzi ) 同学提出的 bug！) <br>
 
 最新更新时间：2019-2-27 【倒叙】 <br>
 最新Version：【Version：1.1.6】 <br>
 更新内容： <br>
 1.1.6.1、修复部分自定义数组取值不全的问题，(感谢简书网友 [@徐国伟](https://www.jianshu.com/u/cabe0049e1bc ) 同学提出的 bug！) <br>
  
 最新更新时间：2017-12-13 【倒叙】 <br>
 最新Version：【Version：1.1.4】 <br>
 更新内容： <br>
 1.1.4.1、修复 城市选择器 plist 文件读取失败后崩溃的 bug ，新增【城市数据读取失败】打印 log和弹框提示！(感谢简书网友 [@不会凉的黄花菜](http://www.jianshu.com/u/5b75c9f02124 ) 同学提出的 bug！) <br>
 
 最新更新时间：2017-11-02 【倒叙】 <br>
 最新Version：【Version：1.1.3】 <br>
 更新内容： <br>
 1.1.3.1、完美适配 iOS 11 和 iPhone X <br>
 
 最新更新时间：2017-10-08 【倒叙】 <br>
 最新Version：【Version：1.1.2】 <br>
 更新内容： <br>
 1.1.2.1、日期选择器 新增背景年份水印显示 <br>
 1.1.2.2、优化部分注释 <br>

 最新更新时间：2017-09-01 【倒叙】 <br>
 最新Version：【Version：1.1.1】 <br>
 更新内容： <br>
 1.1.1.1、日期选择器 修复顶部结果显示异常的问题，，详见 demo <br>
 
 最新更新时间：2017-08-05 【倒叙】 <br>
 最新Version：【Version：1.1.0】 <br>
 更新内容： <br>
 1.1.0.1、日期选择器新增 优化了最大最小年份月份的写法，现在可以自由定义最大最小日期了，详见 demo <br>
 1.1.0.2、新增 选中结果直接显示在 工具栏的中间，且可以自定义颜色、字体 <br>
 1.1.0.3、修复日期选择器横竖屏不适配的 bug <br>

 最新更新时间：2017-07-18 【倒叙】 <br>
 最新Version：【Version：1.0.9】 <br>
 更新内容： <br>
 1.0.9.1、日期选择器新增 最大月份限制(感谢简书网友 [@洁简](http://www.jianshu.com/u/62f0c72a2004) 同学提出的 需求！) <br>
 
 最新更新时间：2017-07-17 【倒叙】 <br>
 最新Version：【Version：1.0.8】 <br>
 更新内容： <br>
 1.0.8.1、新增分割线开关和分割线颜色自定义(感谢群里 [@杭州-可米](https://github.com/fan-xiang) 和 [@紫暄](https://github.com/rainy0426)同学提出的 需求！) <br>
 
 最新更新时间：2017-06-28 【倒叙】 <br>
 最新Version：【Version：1.0.7】 <br>
 更新内容： <br>
 1.0.7.1、修复 日期选择器 不同样式下错乱的 bug(感谢群里 [@西瓜Sama](https://github.com/lipengda) 同学提出的 bug！) <br>
 
 最新更新时间：2017-06-23 【倒叙】 <br>
 最新Version：【Version：1.0.6】 <br>
 更新内容： <br>
 1.0.6.1、优化部分宏定义 <br>
 
 最新更新时间：2017-06-22 【倒叙】 <br>
 最新Version：【Version：1.0.5】 <br>
 更新内容： <br>
 1.0.5.1、新增 多种动画样式 <br>
 
 最新更新时间：2017-06-19 【倒叙】 <br>
 最新Version：【Version：1.0.4】 <br>
 更新内容： <br>
 1.0.4.1、新增 各种自定义 datePicker：年、年月、年月日、时间等等，你能想到的效果都有 <br>
 1.0.4.2、可以自定义 datePicker 的字体颜色、字体、字体大小、背景颜色等 <br>
 1.0.4.3、可以自定义 datePicker 的最大、最小年限 <br>
 1.0.4.4、可以自定义 datePicker 的 toolBar 位置、字体、背景颜色等

 最新更新时间：2017-06-03 【倒叙】 <br>
 最新Version：【Version：1.0.3】 <br>
 更新内容： <br>
 1.0.3.1、可以自由设置 pickView 居中或者在底部显示，还可以自由定制 toolbar 居中或者在底部显示 <br>
 1.0.3.2、可以自由设置 pickView 字体、字体颜色等内容，注意：日期选择器暂时不能修改字体，有可能被苹果审核不通过，如有特殊需求，可通过 runtime 修改 <br>
 
 最新更新时间：2017-05-27 【倒叙】 <br>
 最新Version：【Version：1.0.2】 <br>
 更新内容： <br>
 1.0.2.1、新增进出场动画，缩放、上下左右展示、消失动画  <br>
 1.0.2.2、修复 isTouchEdgeHide 失效的 bug <br>
 
 最新更新时间：2017-05-22 【倒叙】 <br>
 最新Version：【Version：1.0.1】 <br>
 更新内容： <br>
 1.0.1.1、新增年周选择器，如：2017年，第21周  <br>

 最新更新时间：2017-05-16 【倒叙】 <br>
 最新Version：【Version：1.0.0】 <br>
 更新内容： <br>
 1.0.0.1、城市选择器，三级联动，可返回省市县和精确的经纬度  <br>
 1.0.0.2、可以自定义 array 显示，性别选择等【目前只支持单行数据】  <br>
 1.0.0.3、日期选择器：年月日，可以完全自定义 NSDateFormatter  <br>
 1.0.0.4、日期选择器：年月，可以完全自定义 NSDateFormatter  <br>
 1.0.0.5、横竖屏适配完美  <br>
 1.0.0.6、可以自定义按钮颜色、背景颜色等  <br>
 1.0.0.7、理论完全兼容现有所有 iOS 系统版本  <br>

## 6、bug 反馈
> 1、开发中遇到 bug，希望小伙伴儿们能够及时反馈与我们 [【BAHome】](https://github.com/BAHome) 团队，我们必定会认真对待每一个问题！ <br>

> 2、以后提需求和 bug 的同学，记得把 git 或者博客链接给我们，我直接超链到你们那里！希望大家积极参与测试！<br> 

## 7、BAHome 团队成员
> 1、QQ 群 
 479663605 <br> 
【注意：此群为 2 元 付费群，介意的小伙伴儿勿扰！】<br> 

> 孙博岩 <br> 
QQ：137361770 <br> 
git：[https://github.com/boai](https://github.com/boai) <br>
简书：[http://www.jianshu.com/u/95c9800fdf47](http://www.jianshu.com/u/95c9800fdf47) <br>
微博：[![](https://img.shields.io/badge/微博-博爱1616-red.svg)](http://weibo.com/538298123) <br>

> 马景丽 <br> 
QQ：1253540493 <br> 
git：[https://github.com/MaJingli](https://github.com/MaJingli) <br>

> 陆晓峰 <br> 
QQ：442171865 <br> 
git：[https://github.com/zeR0Lu](https://github.com/zeR0Lu) <br>

> 陈集 <br> 
QQ：3161182978 <br> 
git：[https://github.com/chenjipdc](https://github.com/chenjipdc) <br>
简书：[http://www.jianshu.com/u/90ae559fc21d](http://www.jianshu.com/u/90ae559fc21d)

> 任子丰 <br> 
QQ：459643690 <br> 
git：[https://github.com/renzifeng](https://github.com/renzifeng) <br>

> 吴丰收 <br> 
QQ：498121294 <br> 

> 石少庸 <br> 
QQ：363605775 <br> 
git：[https://github.com/CrazyCoderShi](https://github.com/CrazyCoderShi) <br>
简书：[http://www.jianshu.com/u/0726f4d689a3](http://www.jianshu.com/u/0726f4d689a3)

> 丁寅初 <br> 
QQ：1137155216 <br> 
git：[https://github.com/1137155216](https://github.com/1137155216) <br>
博客园：[http://www.cnblogs.com/ios-dyc1998](http://www.cnblogs.com/ios-dyc1998)

> 权军刚 <br> 
QQ：906910380 <br> 
git：[https://github.com/Gang679](https://github.com/Gang679) <br>
简书：[http://www.jianshu.com/u/ab83189244d9](http://www.jianshu.com/u/ab83189244d9)


## 8、开发环境 和 支持版本
> 开发使用 最新版本 Xcode，理论上支持 iOS 9 及以上版本，如有版本适配问题，请及时反馈！多谢合作！

## 9、感谢
> 感谢 [【BAHome】](https://github.com/BAHome)  团队成员倾力合作，后期会推出一系列 常用 UI 控件的封装，大家有需求得也可以在 issue 提出，如果合理，我们会尽快推出新版本！<br>

> [【BAHome】](https://github.com/BAHome)  的发展离不开小伙伴儿的信任与推广，再次感谢各位小伙伴儿的支持！


