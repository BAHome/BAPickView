//
//  BAPickView_Version.h
//  BAPickView
//
//  Created by boai on 2017/10/8.
//  Copyright © 2017年 boai. All rights reserved.
//

#ifndef BAPickView_Version_h
#define BAPickView_Version_h

/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 欢迎使用 BAHome 系列开源代码 ！
 如有更多需求，请前往：https://github.com/BAHome
 
 项目源码地址：
 OC 版 ：https://github.com/BAHome/BAPickView
 
 最新更新时间：2021-04-12 【倒叙】 <br>
 最新Version：【Version：1.2.1】 <br>
 更新内容： <br>
 1.2.1.1、此版本删除旧版本代码，注意：如需使用旧版本，请固定版本号为 V1.2.0<br>
 
 最新更新时间：2021-04-09 【倒叙】 <br>
 最新Version：【Version：1.2.0】 <br>
 更新内容： <br>
 1.2.0.1、优化适配 iOS 14 及 修复 自定义日期选择器 已知问题 <br>
 1.2.0.2、`BAPickerManger`  全新封装组件开发完成，注意：如需使用旧版本，请固定版本号为 V1.2.0，<br>
 
 最新更新时间：2019-9-06 【倒叙】 <br>
 最新Version：【Version：1.1.9】 <br>
 更新内容： <br>
 1.1.9.1、优化适配异形屏，优化部分动画性能 <br>
 1.1.9.2、`BAKit_PickerView` 系统 `UIDatePicker` 新增 最大最小日期 设置<br>
 1.1.9.3、`BAKit_PickerView`、`BAKit_DatePicker` 新增 toolBarView 底部线条，isShowTooBarBottomeLine ，可自定义线条颜色<br>
 
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
 
 最新更新时间：2018-12-28 【倒叙】 <br>
 最新Version：【Version：1.1.5】 <br>
 更新内容： <br>
 1.1.5.1、修复部分日期选择最大最小值问题，优化最新代码 <br>
 
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
 1.1.1.1、日期选择器 修复顶部结果显示异常的问题，，详见 demo (感谢简书网友 [@洁简](https://github.com/Jayxiang ) 同学提出的 需求！) <br>
 
 最新更新时间：2017-08-05 【倒叙】 <br>
 最新Version：【Version：1.1.0】 <br>
 更新内容： <br>
 1.1.0.1、日期选择器新增 优化了最大最小年份月份的写法，现在可以自由定义最大最小日期了，详见 demo (感谢简书网友 [@洁简](https://github.com/Jayxiang ) 同学提出的 需求！) <br>
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
 
 最新更新时间：2017-06-23 【倒叙】
 最新Version：【Version：1.0.6】
 更新内容：
 1.0.6.1、优化部分宏定义
 
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
 
 */

#endif /* BAPickView_Version_h */
