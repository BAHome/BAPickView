//
//  BAPickerView.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import "BAPickerBasePopView.h"
#import "BAPickerDefine.h"
#import "BAPickerConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BAPickerView : BAPickerBasePopView

@property(nonatomic, strong) BAPickerModel *configModel;

@property(nonatomic, copy) BAPickerResultBlock selectPicker;
@property(nonatomic, copy) BAPickerCityResultBlock selectCityPicker;

@end

NS_ASSUME_NONNULL_END
