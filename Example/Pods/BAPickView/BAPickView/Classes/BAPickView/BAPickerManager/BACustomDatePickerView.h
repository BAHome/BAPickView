//
//  BACustomDatePickerView.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/6.
//

#import "BAPickerBasePopView.h"
#import "BAPickerDefine.h"
#import "BAPickerConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BACustomDatePickerView : BAPickerBasePopView

@property(nonatomic, strong) BADatePickerModel *configModel;

@property(nonatomic, copy) BAPickerResultBlock selectDatePicker;

@end

NS_ASSUME_NONNULL_END
