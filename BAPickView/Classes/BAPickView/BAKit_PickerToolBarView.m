//
//  BAKit_PickerToolBarView.m
//  BAPickView
//
//  Created by boai on 2019/9/4.
//

#import "BAKit_PickerToolBarView.h"

@implementation BAKit_PickerToolBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.cancleButton];
    [self.bgView addSubview:self.sureButton];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.contentTitleLabel];

    [self initData];
}

- (void)initData {
    self.lineView.backgroundColor = UIColor.lightGrayColor;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.bgView.frame = self.bounds;
    
    float min_x = 0;
    float min_y = 0;
    float min_w = 0;
    float min_h = 0;
    float min_margin = 10;
    float max_margin = 20;

    min_x = max_margin;
    min_w = 40;
    min_h = CGRectGetHeight(self.bgView.frame);
    self.cancleButton.frame = CGRectMake(min_x, min_y, min_w, min_h);

    min_x = CGRectGetWidth(self.bgView.frame) - min_w - max_margin;
    self.sureButton.frame = CGRectMake(min_x, min_y, min_w, min_h);

    min_x = CGRectGetMaxX(self.cancleButton.frame) + min_margin;
    min_w = CGRectGetMaxX(self.sureButton.frame) - CGRectGetMaxX(self.cancleButton.frame) - self.cancleButton.frame.size.width - max_margin;
    self.contentTitleLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 0;
    min_h = 0.5;
    min_y = CGRectGetMaxY(self.bgView.frame) - min_h;
    min_w = self.bgView.frame.size.width;
    self.lineView.frame = CGRectMake(min_x, min_y, min_w, min_h);
}

#pragma mark - custom method

- (void)handleButtonAction:(UIButton *)sender {
    if (sender.tag == 1000) {
        self.onCancleButton ? self.onCancleButton():nil;
    } else if (sender.tag == 1001) {
        self.onSureButton ? self.onSureButton():nil;
    }
}

#pragma mark - setter, getter

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = UIView.new;
    }
    return _bgView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = UIView.new;
    }
    return _lineView;
}

- (UILabel *)contentTitleLabel {
    if (!_contentTitleLabel) {
        _contentTitleLabel = [[UILabel alloc] init];
        _contentTitleLabel.font = [UIFont systemFontOfSize:15];
        _contentTitleLabel.textAlignment = NSTextAlignmentCenter;
        _contentTitleLabel.textColor = [UIColor blackColor];
    }
    return _contentTitleLabel;
}

- (UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancleButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.cancleButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.cancleButton.tag = 1000;
    }
    return _cancleButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.sureButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.sureButton.tag = 1001;
    }
    return _sureButton;
}


@end
