//
//  BAPickerConfigModel.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/1.
//

#import "BAPickerConfigModel.h"

@implementation BAPickerConfigModel

@end

@implementation BAPickerConfigBaseModel

- (instancetype)init {
    self = [super init];
    if (self) {
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
        self.showBottomLine = YES;
        
        self.cancleTitleFont = [UIFont systemFontOfSize:14];
        self.sureTitleFont = [UIFont systemFontOfSize:14];
        self.titleFont = [UIFont boldSystemFontOfSize:16];
        
        self.lineColor = BAKit_Color_RGB_pod(204, 204, 204);
    }
    return self;
}

- (BOOL)temp_showDefaultResult {
    BOOL isShowDefaultResult = self.title.length <= 0 && self.showResult;
    return isShowDefaultResult;
}

@end
