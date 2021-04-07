//
//  BABasePickerView.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/6.
//

#import "BABasePickerView.h"

@interface BABasePickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation BABasePickerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
        [self initData];
    }
    return self;
}

- (void)initUI {
    [self addSubview:self.pickerView];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
}

- (void)initData {
    
}

#pragma mark - UIPickerViewDataSource
// 返回需要展示的列（columns）的数目
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    NSInteger num = self.onNumberOfComponentsInPickerView ? self.onNumberOfComponentsInPickerView(pickerView):0;
    return num;
}

// 返回每一列的行（rows）数
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    NSInteger num = self.onNumberOfRowsInComponent ? self.onNumberOfRowsInComponent(component, pickerView):0;
    return num;
}

#pragma mark - UIPickerViewDelegate
// 返回每一行的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title = self.onTitleForRowAndComponent ? self.onTitleForRowAndComponent(row, component, pickerView):nil;
    return title;
}

// 某一行被选择时调用
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.onDidSelectRowAndComponent ? self.onDidSelectRowAndComponent(row, component, pickerView):nil;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.backgroundColor = [UIColor clearColor];
        if (self.normalFont) {
            pickerLabel.font = self.normalFont;
        }
//        pickerLabel.textColor = self.ba_pickViewTextColor;
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
//    if (self.isShowLineView) {
//        for (UIView *lineView in pickerView.subviews) {
//            if (lineView.frame.size.height < 1) {
//                lineView.backgroundColor = self.ba_pickViewLineViewColor;
//            }
//        }
//    }
    
    return pickerLabel;
}

#pragma mark - setter, getter

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = UIPickerView.new;
        _pickerView.backgroundColor = UIColor.clearColor;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

@end
