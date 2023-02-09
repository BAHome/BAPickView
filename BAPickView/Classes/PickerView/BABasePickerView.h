//
//  BABasePickerView.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/6.
//

#import <UIKit/UIKit.h>
#import "BAPickerDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface BABasePickerView : UIView

@property(nonatomic, strong) UIPickerView *pickerView;

// 返回需要展示的列（columns）的数目
@property(nonatomic, copy) NSInteger (^onNumberOfComponentsInPickerView)(UIPickerView *pickerView);
// 返回每一列的行（rows）数
@property(nonatomic, copy) NSInteger (^onNumberOfRowsInComponent)(NSInteger component, UIPickerView *pickerView);
// 返回每一行的标题
@property(nonatomic, copy) NSString *(^onTitleForRowAndComponent)(NSInteger row, NSInteger component, UIPickerView *pickerView);
// 选中每一行的标题
@property(nonatomic, copy) void (^onDidSelectRowAndComponent)(NSInteger row, NSInteger component, UIPickerView *pickerView);
// 每一行的高度
@property(nonatomic, copy) CGFloat (^onRowHeightForComponent)(NSInteger component, UIPickerView *pickerView);
// 自定义文本
@property(nonatomic, copy) UIView *(^onViewForRowAndComponent)(NSInteger row, NSInteger component, UIView *reusingView, UIPickerView *pickerView);

@end

NS_ASSUME_NONNULL_END
