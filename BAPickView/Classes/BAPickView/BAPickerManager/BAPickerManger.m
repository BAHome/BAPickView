//
//  BAPickerManger.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/2.
//

#import "BAPickerManger.h"
#import "BAPickerView.h"
#import "BADatePickerView.h"
#import "BACustomDatePickerView.h"
#import "NSDate+BAKit.h"

@implementation BAPickerManger

+ (void)initStringsPickerWithModel:(BAPickerModel *)pickerModel
                                cb:(BASelectPickerBlock)cb {
    BAPickerView *picker = BAPickerView.new;
    picker.configModel = pickerModel;
    picker.selectPicker = cb;
    
    [picker show];
}

+ (void)initStringsPicker:(NSArray <NSString *>*)strings
                       cb:(BASelectPickerBlock)cb {
    [self initStringsPicker:strings
    maskViewBackgroundColor:nil
                cancleTitle:nil
           cancleTitleColor:nil
            cancleTitleFont:nil
                  sureTitle:nil
             sureTitleColor:nil
              sureTitleFont:nil
                         cb:cb];
}

+ (void)initStringsPicker:(NSArray <NSString *>*)strings
  maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
              cancleTitle:(nullable NSString *)cancleTitle
         cancleTitleColor:(nullable UIColor *)cancleTitleColor
         cancleTitleFont:(nullable UIFont *)cancleTitleFont
                sureTitle:(nullable NSString *)sureTitle
           sureTitleColor:(nullable UIColor *)sureTitleColor
            sureTitleFont:(nullable UIFont *)sureTitleFont
                       cb:(BASelectPickerBlock)cb {
    // 注意：如果项目中有统一 UI 规范的话，可以二次封装后使用，这样就不用每次都写 configModel 了！！！！
    // Picker
    BAPickerModel *pickerModel = BAPickerModel.new;
    if (strings) {
        pickerModel.stringsArray = strings;
    }
    if (maskViewBackgroundColor) {
        pickerModel.maskViewBackgroundColor = maskViewBackgroundColor;
    }
    
    // ToolBar
    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
    if (cancleTitle) {
        toolBarModel.cancleTitle = cancleTitle;
    }
    if (cancleTitleFont) {
        toolBarModel.cancleTitleFont = cancleTitleFont;
    }
    if (cancleTitleColor) {
        toolBarModel.cancleTitleColor = cancleTitleColor;
    }
    
    if (sureTitle) {
        toolBarModel.sureTitle = sureTitle;
    }
    if (sureTitleFont) {
        toolBarModel.sureTitleFont = sureTitleFont;
    }
    if (sureTitleColor) {
        toolBarModel.sureTitleColor = sureTitleColor;
    }
    
    pickerModel.toolBarModel = toolBarModel;
    
    [self initStringsPickerWithModel:pickerModel cb:cb];
}

@end

@implementation BAPickerManger (MultipleStrings)

+ (void)initMultipleStringsPickerWithPickerModle:(BAPickerModel *)pickerModel
                                              cb:(BASelectPickerBlock)cb {
    BAPickerView *picker = BAPickerView.new;
    picker.configModel = pickerModel;
    picker.selectPicker = cb;
    
    [picker show];
}

+ (void)initMultipleStringsPicker:(NSArray <NSArray *>*)multipleStringsArray
                               cb:(BASelectPickerBlock)cb {
    [self initMultipleStringsPicker:multipleStringsArray
                 multipleTitleArray:nil
            maskViewBackgroundColor:nil
                        cancleTitle:nil
                   cancleTitleColor:nil
                    cancleTitleFont:nil
                          sureTitle:nil
                     sureTitleColor:nil
                      sureTitleFont:nil
                                 cb:cb];
}

+ (void)initMultipleStringsPicker:(NSArray <NSArray *>*)multipleStringsArray
               multipleTitleArray:(nullable NSArray <NSString *>*)multipleTitleArray
          maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                      cancleTitle:(nullable NSString *)cancleTitle
                 cancleTitleColor:(nullable UIColor *)cancleTitleColor
                 cancleTitleFont:(nullable UIFont *)cancleTitleFont
                        sureTitle:(nullable NSString *)sureTitle
                   sureTitleColor:(nullable UIColor *)sureTitleColor
                    sureTitleFont:(nullable UIFont *)sureTitleFont
                               cb:(BASelectPickerBlock)cb {
    
    // Picker
    BAPickerModel *pickerModel = BAPickerModel.new;
    if (multipleTitleArray) {
        pickerModel.multipleTitleArray = multipleTitleArray;
    }
    if (multipleStringsArray) {
        pickerModel.multipleStringsArray = multipleStringsArray;
    }
    if (maskViewBackgroundColor) {
        pickerModel.maskViewBackgroundColor = maskViewBackgroundColor;
    }
    
    // ToolBar
    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
    if (cancleTitle) {
        toolBarModel.cancleTitle = cancleTitle;
    }
    if (cancleTitleFont) {
        toolBarModel.cancleTitleFont = cancleTitleFont;
    }
    if (cancleTitleColor) {
        toolBarModel.cancleTitleColor = cancleTitleColor;
    }
    
    if (sureTitle) {
        toolBarModel.sureTitle = sureTitle;
    }
    if (sureTitleFont) {
        toolBarModel.sureTitleFont = sureTitleFont;
    }
    if (sureTitleColor) {
        toolBarModel.sureTitleColor = sureTitleColor;
    }
    
    pickerModel.toolBarModel = toolBarModel;
    
    [self initMultipleStringsPickerWithPickerModle:pickerModel cb:cb];
}

@end

@implementation BAPickerManger (City)

+ (void)initCityPickerWithCallBack:(BASelectCityPickerBlock)cb {
    // Picker
    BAPickerModel *pickerModel = BAPickerModel.new;
    NSArray *allProvinceCityArray = [[NSArray alloc] initWithContentsOfFile:[self getFilePath]];
    pickerModel.allProvinceCityArray = allProvinceCityArray;
    
    // ToolBar
    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
    pickerModel.toolBarModel = toolBarModel;
    
    BAPickerView *picker = BAPickerView.new;
    picker.configModel = pickerModel;
    picker.selectCityPicker = cb;
    
    [picker show];
}

+ (NSString *)getFilePath {
    NSBundle *bundle = [NSBundle ba_bundleWithBundleName:@"BAPickView" podName:@"BAPickView"];
    NSString *fileBundlePath = [bundle pathForResource:@"BAPickView" ofType:@"bundle"];
    NSBundle *fileBundle = [NSBundle bundleWithPath:fileBundlePath];
    
    NSAssert(bundle, @"bundle 资源加载失败！");
    
    NSString *path = [fileBundle pathForResource:@"BACity" ofType:@"plist"];
    return path;
}

@end

@implementation BAPickerManger (SystemDateDatePicker)

+ (void)initSystemDatePickerWithModel:(BADatePickerModel *)datePickerModel
                                   cb:(BASelectDatePickerBlock)cb {
    BADatePickerView *picker = BADatePickerView.new;
    picker.configModel = datePickerModel;
    
    picker.selectDatePicker = cb;
    [picker show];
}

+ (void)initSystemDatePicker:(BASelectDatePickerBlock)cb {
    [self initSystemDatePicker:UIDatePickerModeDate formatterString:nil cb:cb];
}

+ (void)initSystemDatePicker:(UIDatePickerMode)datePickerMode
             formatterString:(nullable NSString *)formatterString
                          cb:(BASelectDatePickerBlock)cb {
    [self initSystemDatePicker:datePickerMode
               formatterString:formatterString
       maskViewBackgroundColor:nil
                   cancleTitle:nil
              cancleTitleColor:nil
               cancleTitleFont:nil
                     sureTitle:nil
                sureTitleColor:nil
                 sureTitleFont:nil
                            cb:cb];
}

+ (void)initSystemDatePicker:(UIDatePickerMode)datePickerMode
             formatterString:(nullable NSString *)formatterString
     maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                 cancleTitle:(nullable NSString *)cancleTitle
            cancleTitleColor:(nullable UIColor *)cancleTitleColor
            cancleTitleFont:(nullable UIFont *)cancleTitleFont
                   sureTitle:(nullable NSString *)sureTitle
              sureTitleColor:(nullable UIColor *)sureTitleColor
               sureTitleFont:(nullable UIFont *)sureTitleFont
                          cb:(BASelectDatePickerBlock)cb {
    
    // DatePicker
    BADatePickerModel *datePickerModel = BADatePickerModel.new;
    if (datePickerMode) {
        datePickerModel.datePickerMode = datePickerMode;
    }
    if (formatterString.length > 0) {
        datePickerModel.formatterString = formatterString; //@"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
    }
    if (maskViewBackgroundColor) {
        datePickerModel.maskViewBackgroundColor = maskViewBackgroundColor;
    }
    
    // ToolBar
    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
    if (cancleTitle) {
        toolBarModel.cancleTitle = cancleTitle;
    }
    if (cancleTitleFont) {
        toolBarModel.cancleTitleFont = cancleTitleFont;
    }
    if (cancleTitleColor) {
        toolBarModel.cancleTitleColor = cancleTitleColor;
    }
    
    if (sureTitle) {
        toolBarModel.sureTitle = sureTitle;
    }
    if (sureTitleFont) {
        toolBarModel.sureTitleFont = sureTitleFont;
    }
    if (sureTitleColor) {
        toolBarModel.sureTitleColor = sureTitleColor;
    }
    
    datePickerModel.toolBarModel = toolBarModel;
    
    [self initSystemDatePickerWithModel:datePickerModel cb:cb];
}

@end

@implementation BAPickerManger (CustomDateDatePicker)

+ (void)initCustomDatePickerWithModel:(BADatePickerModel *)datePickerModel
                                   cb:(BASelectDatePickerBlock)cb {
    
    BACustomDatePickerView *picker = BACustomDatePickerView.new;
    picker.configModel = datePickerModel;
    
    picker.selectDatePicker = cb;
    [picker show];
}

+ (void)initCustomDatePickerWithType:(BADatePickerType)datePickerType
                                  cb:(BASelectDatePickerBlock)cb {
    [self initCustomDatePickerWithType:datePickerType showResult:NO cb:cb];
}

+ (void)initCustomDatePickerWithType:(BADatePickerType)datePickerType
                          showResult:(BOOL)showResult
                                  cb:(BASelectDatePickerBlock)cb {
    [self initCustomDatePickerWithType:datePickerType maskViewBackgroundColor:nil maximumDate:nil minimumDate:nil showResult:showResult cb:cb];
}

+ (void)initCustomDatePickerWithType:(BADatePickerType)datePickerType
             maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                         maximumDate:(nullable NSDate *)maximumDate
                         minimumDate:(nullable NSDate *)minimumDate
                          showResult:(BOOL)showResult
                                  cb:(BASelectDatePickerBlock)cb {
    
    // DatePicker
    BADatePickerModel *datePickerModel = BADatePickerModel.new;
    datePickerModel.datePickerType = datePickerType;
    if (maskViewBackgroundColor) {
        datePickerModel.maskViewBackgroundColor = maskViewBackgroundColor;
    }
    if (maximumDate) {
        datePickerModel.maximumDate = maximumDate;// [NSDate ba_dateAfterYears:1]
    }
    if (minimumDate) {
        datePickerModel.minimumDate = minimumDate;
    }
    
    // ToolBar
    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
    toolBarModel.showResult = showResult;
    
    datePickerModel.toolBarModel = toolBarModel;
    
    [self initCustomDatePickerWithModel:datePickerModel cb:cb];
}

@end
