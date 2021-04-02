//
//  BAPickerBasePopView.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import "BAPickerBasePopView.h"

@interface BAPickerBasePopView ()

@end

@implementation BAPickerBasePopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI__];
        [self initData__];
    }
    return self;
}

- (void)initUI__ {
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (void)initData__ {
    self.enableTouchDismiss = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

#pragma mark - custom method

- (void)show {
    if (self.superview) {
        return;
    }
    [self showOnView:kBAGetAlertWindow()];
}

- (void)showOnView:(UIView *)view {
    if (self.superview) {
        return;
    }
    
    [view addSubview:self];
    self.frame = view.bounds;
    self.backgroundColor = self.bgColor ? self.bgColor:[UIColor.blackColor colorWithAlphaComponent:0.3];
}

- (void)dismiss {
    self.onDismiss ? self.onDismiss():nil;
    kBARemoveAllSubviews(self);
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView *view = (UIView *)touches.anyObject;
    if (![view isKindOfClass:self.class]) {
        if (self.enableTouchDismiss) {
            [self dismiss];
        }
    }
}

#pragma mark - setter, getter

- (void)setBgColor:(UIColor *)bgColor {
    _bgColor = bgColor;
    
    if (bgColor) {
        self.backgroundColor = bgColor;        
    }
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = UIView.new;
    }
    return _contentView;
}

@end
