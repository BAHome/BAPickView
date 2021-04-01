//
//  BADatePickerView.h
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BADatePickerView : UIView

@property(nonatomic, strong) NSDateFormatter *formatter;

@property(nonatomic, copy) void (^onSelectDatePicker)(NSString *resultString, NSDate *resultDate);



@end

NS_ASSUME_NONNULL_END
