//
//  BAPickerToolBarView.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import "BAPickerToolBarView.h"
#import <Masonry/Masonry.h>

#define kMargin 12
#define kButton_w 40

@interface BAPickerToolBarView ()

@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *sureButton;

@property (nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) UIView *lineView;

@property(nonatomic, assign) BOOL isFirstLoad;

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
        make.left.offset(kMargin);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(kButton_w);
    }];
    
    [self addSubview:self.sureButton];
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-kMargin);
        make.centerY.offset(0);
        make.width.height.mas_equalTo(kButton_w);
    }];
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.left.mas_equalTo(self.cancleButton.mas_right).offset(10);
        make.right.mas_greaterThanOrEqualTo(self.sureButton.mas_left).offset(-10);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    self.titleLabel.hidden = NO;
}

- (void)initData {
    self.isFirstLoad = YES;
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
    
    if (self.toolBarModel.showResult) {
        self.titleLabel.text = result;
    } else if (self.toolBarModel.title.length > 0) {
        self.titleLabel.text = self.toolBarModel.title;
    } else {
        self.titleLabel.text = @"";
    }
}

- (void)setToolBarModel:(BAPickerToolBarModel *)toolBarModel {
    _toolBarModel = toolBarModel;
    
    if (toolBarModel.title.length > 0) {
        self.titleLabel.text = toolBarModel.title;
    }
    
    self.lineView.hidden = !toolBarModel.showBottomLine;
    
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
        if (toolBarModel.lineColor) {
            self.lineView.backgroundColor = toolBarModel.lineColor;
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
        CGFloat cancleTitle_w = kButton_w;
        CGFloat sureTitle_w = kButton_w;
        if (toolBarModel.cancleTitle.length) {
            cancleTitle_w = [toolBarModel.cancleTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, kButton_w) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:toolBarModel.cancleTitleFont ? toolBarModel.cancleTitleFont : self.cancleButton.titleLabel.font} context:nil].size.width;
            cancleTitle_w += 10;
            cancleTitle_w = MAX(cancleTitle_w, 40);
            [self.cancleButton setTitle:toolBarModel.cancleTitle forState:UIControlStateNormal];
            
            [self.cancleButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(cancleTitle_w);
            }];
            self.cancleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

        }
        if (toolBarModel.sureTitle.length) {
            sureTitle_w = [toolBarModel.sureTitle boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, kButton_w) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:toolBarModel.sureTitleFont ? toolBarModel.sureTitleFont : self.sureButton.titleLabel.font} context:nil].size.width;
            sureTitle_w += 10;
            sureTitle_w = MAX(sureTitle_w, kButton_w);
            [self.sureButton setTitle:toolBarModel.sureTitle forState:UIControlStateNormal];
            
            [self.sureButton mas_updateConstraints:^(MASConstraintMaker *make) {
                make.width.mas_equalTo(sureTitle_w);
            }];
            self.sureButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        }
        
        // 保证 title 居中显示
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (self.frame.size.width > 0) {
                CGFloat max_w = MAX(cancleTitle_w, sureTitle_w);
                CGFloat titleLabel_w = self.frame.size.width - kMargin*2 - max_w*2;
                [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.center.offset(0);
                    make.width.mas_equalTo(titleLabel_w);
                }];
            }
        });
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
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = UIColor.blackColor;
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
