//
//  BAPickerConfigModel.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import "BAPickerConfigModel.h"

@implementation BAPickerConfigModel

- (instancetype)init {
    self = [super init];
    if (self) {
        if (!self.datePickerModel) {
            self.datePickerModel = BADatePickerModel.new;
        }
        if (!self.pickerModel) {
            self.pickerModel = BAPickerModel.new;
        }
        if (!self.toolBarModel) {
            self.toolBarModel = BAPickerToolBarModel.new;
        }
        
        self.maskViewBackgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.3];
        
        self.pickerHeight = 240;
        self.toolBarHeight = 44;
        
        self.enableTouchDismiss = YES;
    }
    return self;
}

@end

@implementation BAPickerModel

@end

@implementation BADatePickerModel

- (instancetype)init {
    self = [super init];
    if (self) {
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        NSDate *currentDate = [NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        comps.year = 60;
        NSDate *maxDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        comps.year = -60;
        NSDate *minDate = [calendar dateByAddingComponents:comps toDate:currentDate options:0];
        
        self.minimumDate = minDate;
        self.maximumDate = maxDate;
        
        self.formatterString = @"yyyy-MM-dd";
    }
    return self;
}

@end

@implementation BAPickerToolBarModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.showResult = YES;
    }
    return self;
}

@end
