//
//  BAPickerBasePopView.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import <UIKit/UIKit.h>
#import "BAPickerDefine.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BAPickerBasePopViewAnimationStyle) {
    BAPickerBasePopViewAnimationStyle_None,
    BAPickerBasePopViewAnimationStyle_Bottom,
};

@interface BAPickerBasePopView : UIView

/**
 LYBasePopView：父类 view，可以在上面加载任意 view
 */
@property(nonatomic, strong) UIView *contentView;
/// 默认：[UIColor.blackColor colorWithAlphaComponent:0.3]
@property(nonatomic, strong) UIColor *maskViewBackgroundColor;

@property(nonatomic, assign) CGFloat contentViewHeight;

/// 是否支持触摸边缘地区隐藏 popView，默认 NO
@property(nonatomic, assign) BOOL enableTouchDismiss;

@property(nonatomic, assign) CGFloat contentViewCorners;
@property(nonatomic, assign) BOOL needContentViewTopCorner;
// 动画样式
@property(nonatomic, assign) BAPickerBasePopViewAnimationStyle animationStyle;

@property(nonatomic, copy) void (^onDismiss)(void);

- (void)show;
- (void)showOnView:(UIView *)view;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
