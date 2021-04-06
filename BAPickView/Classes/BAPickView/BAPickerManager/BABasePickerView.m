//
//  BABasePickerView.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/6.
//

#import "BABasePickerView.h"

@interface BABasePickerView () <UIPickerViewDataSource, UIPickerViewDelegate>

@property(nonatomic, strong) UIPickerView *pickerView;

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
    NSInteger num = self.onNumberOfRowsInComponent ? self.onNumberOfRowsInComponent(pickerView):0;
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
