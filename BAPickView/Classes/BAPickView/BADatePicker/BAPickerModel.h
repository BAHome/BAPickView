//
//  BAPickerModel.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import <Foundation/Foundation.h>
#import "BAKit_PickerViewConfig.h"

NS_ASSUME_NONNULL_BEGIN

@class BADatePickerModel;
@class BAPickerToolBarModel;

@interface BAPickerModel : NSObject

@property(nonatomic, strong) BADatePickerModel *datePickerModel;
@property(nonatomic, strong) BAPickerToolBarModel *tooBarModel;

/**
 动画样式
 */
@property(nonatomic, assign) BAKit_PickerViewAnimationType animationType;

/**
 自定义 NSDateFormatter，返回的日期格式，注意：如果同时设置 BAKit_PickerViewDateType 和 customDateFormatter，以 customDateFormatter 为主
 */
@property(nonatomic, strong) NSDateFormatter *customDateFormatter;


@end

@interface BADatePickerModel : NSObject

@property(nonatomic, assign) BAKit_PickerViewDateType dateType;


@end

@interface BAPickerToolBarModel : NSObject

/**
 toolBar 背景颜色，默认：白色
 */
@property(nonatomic, strong) UIColor *ba_backgroundColor_toolBar;

/**
 pickView 背景颜色，默认：白色
 */
@property(nonatomic, strong) UIColor *ba_backgroundColor_pickView;

/**
 cancleButton title颜色，默认：黑色
 */
@property(nonatomic, strong) UIColor *ba_buttonTitleColor_cancle;

/**
 sureButton title颜色，默认：黑色
 */
@property(nonatomic, strong) UIColor *ba_buttonTitleColor_sure;

/**
 title 颜色，默认：黑色
 */
@property(nonatomic, strong) UIColor *ba_pickViewTitleColor;


@end

NS_ASSUME_NONNULL_END
