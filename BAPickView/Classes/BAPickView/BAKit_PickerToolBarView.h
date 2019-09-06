//
//  BAKit_PickerToolBarView.h
//  BAPickView
//
//  Created by boai on 2019/9/4.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BAKit_PickerToolBarView : UIView

@property(nonatomic, strong) UIView *bgView;

/**
 取消按钮
 */
@property (nonatomic, strong) UIButton *cancleButton;

/**
 确定按钮
 */
@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) UILabel *contentTitleLabel;


@property(nonatomic, strong) UIView *lineView;

@property(nonatomic, copy) void (^onSureButton)(void);
@property(nonatomic, copy) void (^onCancleButton)(void);

@end

NS_ASSUME_NONNULL_END
