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
    self.animationStyle = BAPickerBasePopViewAnimationStyle_None;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.needContentViewTopCorner) {
        [self setCornerWithView:self.contentView corners :UIRectCornerTopLeft|UIRectCornerTopRight cornerRadius:self.contentViewCorners];
    } else {
        self.contentView.layer.cornerRadius = self.contentViewCorners;
    }
}

- (void)handleLayout {
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self setNeedsLayout];
//        [self layoutIfNeeded];
//    });
}

- (void)setCornerWithView:(UIView *)view
                  corners:(UIRectCorner)corners
             cornerRadius:(CGFloat)cornerRadius {
    
    if (CGRectEqualToRect(view.bounds, CGRectZero)) {
        NSLog(@"******** %s view frame 错误！", __func__);
        return;
    }
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds
                                                     byRoundingCorners:corners
                                                           cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.frame = view.bounds;
    
    view.layer.mask = shapeLayer;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.path = bezierPath.CGPath;
    borderLayer.fillColor = [UIColor clearColor].CGColor;
    //        borderLayer.strokeColor = self.ba_viewBorderColor.CGColor;
    //        borderLayer.lineWidth = self.ba_viewBorderWidth;
    borderLayer.frame = view.bounds;
    [view.layer addSublayer:borderLayer];
}

#pragma mark - custom method

- (void)show {
    if (self.superview) {
        return;
    }
    [self showOnView:kBAPickerGetAlertWindow()];
}

- (void)showOnView:(UIView *)view {
    if (self.superview) {
        return;
    }
    
    [view addSubview:self];
    self.backgroundColor = self.maskViewBackgroundColor ? self.maskViewBackgroundColor:[UIColor.blackColor colorWithAlphaComponent:0.3];
    switch (self.animationStyle) {
        case BAPickerBasePopViewAnimationStyle_None: {
            self.frame = view.bounds;
        } break;
        case BAPickerBasePopViewAnimationStyle_Bottom: {
            self.frame = view.bounds;

            CGRect frame = CGRectMake(0, BAKit_SCREEN_HEIGHT, BAKit_SCREEN_WIDTH, self.contentViewHeight);
            self.contentView.frame = frame;
            
            // TO POS
            frame.origin.y = [UIScreen mainScreen].bounds.size.height - self.contentViewHeight;
            
            [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.contentView.frame = frame;
                [self handleLayout];
            } completion:^(BOOL finished) {
            }];
        } break;
            
        default:
            break;
    }
}

- (void)dismiss {
    @BAKit_Weakify(self);
    switch (self.animationStyle) {
        case BAPickerBasePopViewAnimationStyle_None: {
            [self removeAll];
        } break;
        case BAPickerBasePopViewAnimationStyle_Bottom: {
            [UIView animateWithDuration:0.5 animations:^{
                @BAKit_Strongify(self)
                self.contentView.transform = CGAffineTransformMakeTranslation(0, self.contentView.bounds.size.height);
            } completion:^(BOOL finished) {
                @BAKit_Strongify(self)
                [self removeAll];
            }];
        } break;
            
        default:
            break;
    }
}

- (void)removeAll {
    self.onDismiss ? self.onDismiss():nil;
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIView *view = (UIView *)touches.anyObject;
    if (![view.class isKindOfClass:self.contentView.class]) {
        if (self.enableTouchDismiss) {
            [self dismiss];
        }
    }
}

#pragma mark - setter, getter

- (void)setContentViewHeight:(CGFloat)contentViewHeight {
    _contentViewHeight = contentViewHeight;
    
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(contentViewHeight);
    }];
}

- (void)setMaskViewBackgroundColor:(UIColor *)maskViewBackgroundColor {
    _maskViewBackgroundColor = maskViewBackgroundColor;
    
    if (maskViewBackgroundColor) {
        self.backgroundColor = maskViewBackgroundColor;
    }
}

- (void)setNeedContentViewTopCorner:(BOOL)needContentViewTopCorner {
    _needContentViewTopCorner = needContentViewTopCorner;
    
    [self handleLayout];
}

- (void)setContentViewCorners:(CGFloat)contentViewCorners {
    _contentViewCorners = contentViewCorners;
    
    [self handleLayout];
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = UIView.new;
        _contentView.backgroundColor = UIColor.whiteColor;
        _contentView.clipsToBounds = YES;
    }
    return _contentView;
}

@end
