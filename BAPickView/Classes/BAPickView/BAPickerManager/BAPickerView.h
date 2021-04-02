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

@property(nonatomic, strong) BAPickerConfigModel *configModel;

@property(nonatomic, copy) onSelectPicker selectPicker;
@property(nonatomic, copy) onSelectCityPicker selectCityPicker;

@end

NS_ASSUME_NONNULL_END
