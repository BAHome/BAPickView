//
//  BADatePickerView.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import "BAPickerBasePopView.h"

#import "BAPickerConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BADatePickerView : BAPickerBasePopView

@property(nonatomic, strong) BADatePickerModel *configModel;

@property(nonatomic, copy) onSelectDatePicker2 selectDatePicker2;

@end

NS_ASSUME_NONNULL_END
