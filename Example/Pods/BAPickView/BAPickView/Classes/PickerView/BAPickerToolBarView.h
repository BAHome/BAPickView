//
//  BAPickerToolBarView.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import <UIKit/UIKit.h>
#import "BAPickerConfigModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BAPickerToolBarView : UIView

@property(nonatomic, strong) BAPickerToolBarModel *toolBarModel;

@property(nonatomic, copy) NSString *result;

@property(nonatomic, copy) void (^onCancleButton)(void);
@property(nonatomic, copy) void (^onSureButton)(void);

@end

NS_ASSUME_NONNULL_END
