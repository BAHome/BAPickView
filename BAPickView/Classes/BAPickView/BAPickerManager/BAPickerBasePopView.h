//
//  BAPickerBasePopView.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import <UIKit/UIKit.h>
#import "BAPickerDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface BAPickerBasePopView : UIView

/**
 BAPickerBasePopView：父类 view，可以在上面加载任意 view
 */
@property(nonatomic, strong) UIView *contentView;
/// 默认：[UIColor.blackColor colorWithAlphaComponent:0.3]
@property(nonatomic, strong) UIColor *bgColor;

/// 默认 yes
@property(nonatomic, assign) BOOL enableTouchDismiss;

@property(nonatomic, copy) void (^onDismiss)(void);

- (void)show;
- (void)showOnView:(UIView *)view;

- (void)dismiss;

@end

NS_ASSUME_NONNULL_END
