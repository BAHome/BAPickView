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

@property(nonatomic, strong) UIColor *maskViewBackgroundColor;
@property(nonatomic, strong) UIColor *pickViewBackgroundColor;

@property(nonatomic, assign) CGFloat pickerHeight;
@property(nonatomic, assign) CGFloat toolBarHeight;

/**
 是否开启边缘触摸隐藏，默认：YES
 */
@property(nonatomic, assign) BOOL enableTouchDismiss;


@property(nonatomic, copy) void (^onResult)(id result);


@end

@interface BAPickerModel : NSObject



@end

@interface BADatePickerModel : NSObject

@property (nonatomic, strong) NSString *formatterString;

@property (nonatomic) UIDatePickerMode datePickerMode; // default is UIDatePickerModeDateAndTime

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

@end

NS_ASSUME_NONNULL_END
