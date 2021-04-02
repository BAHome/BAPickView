//
//  BAPickerToolBarView.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import "BAPickerToolBarView.h"
#import <Masonry/Masonry.h>

@interface BAPickerToolBarView ()

@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIView *lineView;

@end

@implementation BAPickerToolBarView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initData];
    }
    return self;
}

- (void)initUI {
    
    [self addSubview:self.cancleButton];
    [self.cancleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(40);
    }];
    
    [self addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-12);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(40);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.left.mas_greaterThanOrEqualTo(self.cancleButton.mas_right).offset(10);
        make.right.mas_lessThanOrEqualTo(self.sureButton.mas_left).offset(-10);
    }];
    
}

- (void)initData {
    
}

- (void)clickCancleButton {
    self.onCancleButton ? self.onCancleButton():nil;
}

- (void)clickSureButton {
    self.onSureButton ? self.onSureButton():nil;
}

#pragma mark - setter, getter

- (void)setResult:(NSString *)result {
    _result = result;
    
    self.titleLabel.hidden = !self.toolBarModel.showResult;

    if (self.toolBarModel.showResult) {
        self.titleLabel.text = result;
    }
}

- (void)setToolBarModel:(BAPickerToolBarModel *)toolBarModel {
    _toolBarModel = toolBarModel;
    
#pragma mark - color
    {
        if (toolBarModel.backgroundColor) {
            self.backgroundColor = toolBarModel.backgroundColor;
        }
        if (toolBarModel.titleColor) {
            self.titleLabel.textColor = toolBarModel.titleColor;
        }
        if (toolBarModel.cancleTitleColor) {
            [self.cancleButton setTitleColor:toolBarModel.cancleTitleColor forState:UIControlStateNormal];
        }
        if (toolBarModel.sureTitleColor) {
            [self.sureButton setTitleColor:toolBarModel.sureTitleColor forState:UIControlStateNormal];
        }
    }
#pragma mark - font
    {
        if (toolBarModel.titleFont) {
            self.titleLabel.font = toolBarModel.titleFont;
        }
        if (toolBarModel.cancleTitleFont) {
            self.cancleButton.titleLabel.font = toolBarModel.cancleTitleFont;
        }
        if (toolBarModel.sureTitleFont) {
            self.sureButton.titleLabel.font = toolBarModel.sureTitleFont;
        }
    }
    
#pragma mark - title
    {
        if (toolBarModel.cancleTitle.length) {
            CGFloat name_w = [toolBarModel.cancleTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:toolBarModel.cancleTitleFont ? toolBarModel.cancleTitleFont : self.cancleButton.titleLabel.font} context:nil].size.width;
            name_w += 10;
            [self.cancleButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(name_w);
            }];
            [self.cancleButton setTitle:toolBarModel.cancleTitle forState:UIControlStateNormal];
        }
        if (toolBarModel.sureTitle.length) {
            CGFloat name_w = [toolBarModel.sureTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 40) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:toolBarModel.sureTitleFont ? toolBarModel.sureTitleFont : self.sureButton.titleLabel.font} context:nil].size.width;
            name_w += 10;
            [self.sureButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(name_w);
            }];
            [self.sureButton setTitle:toolBarModel.sureTitle forState:UIControlStateNormal];
        }
    }
  
    
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = UIView.new;
    }
    return _lineView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor blackColor];
    }
    return _titleLabel;
}

- (UIButton *)cancleButton {
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancleButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.cancleButton addTarget:self action:@selector(clickCancleButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

- (UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.sureButton addTarget:self action:@selector(clickSureButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureButton;
}

@end
