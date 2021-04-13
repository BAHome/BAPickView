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
                                cb:(BAPickerResultBlock)cb {
    BAPickerView *picker = BAPickerView.new;
    picker.configModel = pickerModel;
    picker.selectPicker = cb;
    
    [picker show];
}

+ (void)initStringsPickerWithTitle:(nullable NSString *)title
                           strings:(NSArray <NSString *>*)strings
                        showResult:(BOOL)showResult
                                cb:(BAPickerResultBlock)cb {
    [self initStringsPickerWithTitle:title
                           titleFont:nil
                             strings:strings
             maskViewBackgroundColor:nil
                         cancleTitle:nil
                    cancleTitleColor:nil
                     cancleTitleFont:nil
                           sureTitle:nil
                      sureTitleColor:nil
                       sureTitleFont:nil
                          showResult:showResult
                                  cb:cb];
}

+ (void)initStringsPickerWithTitle:(nullable NSString *)title
                         titleFont:(nullable UIFont *)titleFont
                           strings:(NSArray <NSString *>*)strings
           maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                       cancleTitle:(nullable NSString *)cancleTitle
                  cancleTitleColor:(nullable UIColor *)cancleTitleColor
                   cancleTitleFont:(nullable UIFont *)cancleTitleFont
                         sureTitle:(nullable NSString *)sureTitle
                    sureTitleColor:(nullable UIColor *)sureTitleColor
                     sureTitleFont:(nullable UIFont *)sureTitleFont
                        showResult:(BOOL)showResult
                                cb:(BAPickerResultBlock)cb {
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
    BAPickerToolBarModel *toolBarModel = [self initToolBarModelWithTitle:title
                                                               titleFont:titleFont
                                                             cancleTitle:cancleTitle
                                                        cancleTitleColor:cancleTitleColor
                                                         cancleTitleFont:cancleTitleFont
                                                               sureTitle:sureTitle
                                                          sureTitleColor:sureTitleColor
                                                           sureTitleFont:sureTitleFont
                                                              showResult:showResult];
    pickerModel.toolBarModel = toolBarModel;
    
    [self initStringsPickerWithModel:pickerModel cb:cb];
}

+ (BAPickerToolBarModel *)initToolBarModelWithTitle:(nullable NSString *)title
                                          titleFont:(nullable UIFont *)titleFont
                                        cancleTitle:(nullable NSString *)cancleTitle
                                   cancleTitleColor:(nullable UIColor *)cancleTitleColor
                                    cancleTitleFont:(nullable UIFont *)cancleTitleFont
                                          sureTitle:(nullable NSString *)sureTitle
                                     sureTitleColor:(nullable UIColor *)sureTitleColor
                                      sureTitleFont:(nullable UIFont *)sureTitleFont
                                         showResult:(BOOL)showResult {
    // ToolBar
    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
    if (title.length) {
        toolBarModel.title = title;
    }
    if (titleFont) {
        toolBarModel.titleFont = titleFont;
    }
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
    toolBarModel.showResult = showResult;
    return toolBarModel;
}

@end

@implementation BAPickerManger (MultipleStrings)

+ (void)initMultipleStringsPickerWithPickerModle:(BAPickerModel *)pickerModel
                                              cb:(BAPickerResultBlock)cb {
    BAPickerView *picker = BAPickerView.new;
    picker.configModel = pickerModel;
    picker.selectPicker = cb;
    
    [picker show];
}

+ (void)initMultipleStringsPickerWithTitle:(nullable NSString *)title
                      multipleStringsArray:(NSArray <NSArray *>*)multipleStringsArray
                                showResult:(BOOL)showResult
                                        cb:(BAPickerResultBlock)cb {
    [self initMultipleStringsPickerWithTitle:title
                                   titleFont:nil
                        multipleStringsArray:multipleStringsArray
                          multipleTitleArray:nil
                     maskViewBackgroundColor:nil
                                 cancleTitle:nil
                            cancleTitleColor:nil
                             cancleTitleFont:nil
                                   sureTitle:nil
                              sureTitleColor:nil
                               sureTitleFont:nil
                                  showResult:showResult
                                          cb:cb];
}

+ (void)initMultipleStringsPickerWithTitle:(nullable NSString *)title
                                 titleFont:(nullable UIFont *)titleFont
                      multipleStringsArray:(NSArray <NSArray *>*)multipleStringsArray
                        multipleTitleArray:(nullable NSArray <NSString *>*)multipleTitleArray
                   maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                               cancleTitle:(nullable NSString *)cancleTitle
                          cancleTitleColor:(nullable UIColor *)cancleTitleColor
                           cancleTitleFont:(nullable UIFont *)cancleTitleFont
                                 sureTitle:(nullable NSString *)sureTitle
                            sureTitleColor:(nullable UIColor *)sureTitleColor
                             sureTitleFont:(nullable UIFont *)sureTitleFont
                                showResult:(BOOL)showResult
                                        cb:(BAPickerResultBlock)cb {
    
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
    BAPickerToolBarModel *toolBarModel = [self initToolBarModelWithTitle:title
                                                               titleFont:titleFont
                                                             cancleTitle:cancleTitle
                                                        cancleTitleColor:cancleTitleColor
                                                         cancleTitleFont:cancleTitleFont
                                                               sureTitle:sureTitle
                                                          sureTitleColor:sureTitleColor
                                                           sureTitleFont:sureTitleFont
                                                              showResult:showResult];
    pickerModel.toolBarModel = toolBarModel;
    
    [self initMultipleStringsPickerWithPickerModle:pickerModel cb:cb];
}

@end

@implementation BAPickerManger (City)

+ (void)initCityPickerWithCallBack:(BAPickerCityResultBlock)cb {
    [self initCityPickerWithTitle:nil showResult:NO cb:cb];
}

+ (void)initCityPickerWithTitle:(nullable NSString *)title
                     showResult:(BOOL)showResult
                             cb:(BAPickerCityResultBlock)cb {
    // Picker
    BAPickerModel *pickerModel = BAPickerModel.new;
    NSArray *allProvinceCityArray = [[NSArray alloc] initWithContentsOfFile:[self getFilePath]];
    pickerModel.allProvinceCityArray = allProvinceCityArray;
    
    // ToolBar
    BAPickerToolBarModel *toolBarModel = [self initToolBarModelWithTitle:title
                                                               titleFont:nil
                                                             cancleTitle:nil
                                                        cancleTitleColor:nil
                                                         cancleTitleFont:nil
                                                               sureTitle:nil
                                                          sureTitleColor:nil
                                                           sureTitleFont:nil
                                                              showResult:showResult];
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
                                   cb:(BAPickerResultBlock)cb {
    BADatePickerView *picker = BADatePickerView.new;
    picker.configModel = datePickerModel;
    
    picker.selectDatePicker = cb;
    [picker show];
}

+ (void)initSystemDatePicker:(BAPickerResultBlock)cb {
    [self initSystemDatePickerTitle:nil datePickerMode:UIDatePickerModeDate showResult:NO cb:cb];
}

+ (void)initSystemDatePickerTitle:(nullable NSString *)title
                   datePickerMode:(UIDatePickerMode)datePickerMode
                       showResult:(BOOL)showResult
                               cb:(BAPickerResultBlock)cb {
    [self initSystemDatePickerTitle:title
                          titleFont:nil
                     datePickerMode:datePickerMode
                    formatterString:nil
            maskViewBackgroundColor:nil
                        cancleTitle:nil
                   cancleTitleColor:nil
                    cancleTitleFont:nil
                          sureTitle:nil
                     sureTitleColor:nil
                      sureTitleFont:nil
                         showResult:showResult
                                 cb:cb];
}

+ (void)initSystemDatePickerTitle:(nullable NSString *)title
                        titleFont:(nullable UIFont *)titleFont
                   datePickerMode:(UIDatePickerMode)datePickerMode
                  formatterString:(nullable NSString *)formatterString
          maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                      cancleTitle:(nullable NSString *)cancleTitle
                 cancleTitleColor:(nullable UIColor *)cancleTitleColor
                  cancleTitleFont:(nullable UIFont *)cancleTitleFont
                        sureTitle:(nullable NSString *)sureTitle
                   sureTitleColor:(nullable UIColor *)sureTitleColor
                    sureTitleFont:(nullable UIFont *)sureTitleFont
                       showResult:(BOOL)showResult
                               cb:(BAPickerResultBlock)cb {
    
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
    BAPickerToolBarModel *toolBarModel = [self initToolBarModelWithTitle:title
                                                               titleFont:titleFont
                                                             cancleTitle:cancleTitle
                                                        cancleTitleColor:cancleTitleColor
                                                         cancleTitleFont:cancleTitleFont
                                                               sureTitle:sureTitle
                                                          sureTitleColor:sureTitleColor
                                                           sureTitleFont:sureTitleFont
                                                              showResult:showResult];
    datePickerModel.toolBarModel = toolBarModel;
    
    [self initSystemDatePickerWithModel:datePickerModel cb:cb];
}

@end

@implementation BAPickerManger (CustomDateDatePicker)

+ (void)initCustomDatePickerWithModel:(BADatePickerModel *)datePickerModel
                                   cb:(BAPickerResultBlock)cb {
    
    BACustomDatePickerView *picker = BACustomDatePickerView.new;
    picker.configModel = datePickerModel;
    
    picker.selectDatePicker = cb;
    [picker show];
}

+ (void)initCustomDatePickerWithType:(BADatePickerType)datePickerType
                                  cb:(BAPickerResultBlock)cb {
    [self initCustomDatePickerWithTitle:nil datePickerType:datePickerType showResult:NO cb:cb];
}

+ (void)initCustomDatePickerWithTitle:(nullable NSString *)title
                       datePickerType:(BADatePickerType)datePickerType
                           showResult:(BOOL)showResult
                                   cb:(BAPickerResultBlock)cb {
    [self initCustomDatePickerWithTitle:title
                              titleFont:nil
                         datePickerType:datePickerType
                maskViewBackgroundColor:nil
                            maximumDate:nil
                            minimumDate:nil
                            cancleTitle:nil
                       cancleTitleColor:nil
                        cancleTitleFont:nil
                              sureTitle:nil
                         sureTitleColor:nil
                          sureTitleFont:nil
                             showResult:showResult
                                     cb:cb];
}

+ (void)initCustomDatePickerWithTitle:(nullable NSString *)title
                            titleFont:(nullable UIFont *)titleFont
                       datePickerType:(BADatePickerType)datePickerType
              maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                          maximumDate:(nullable NSDate *)maximumDate
                          minimumDate:(nullable NSDate *)minimumDate
                          cancleTitle:(nullable NSString *)cancleTitle
                     cancleTitleColor:(nullable UIColor *)cancleTitleColor
                      cancleTitleFont:(nullable UIFont *)cancleTitleFont
                            sureTitle:(nullable NSString *)sureTitle
                       sureTitleColor:(nullable UIColor *)sureTitleColor
                        sureTitleFont:(nullable UIFont *)sureTitleFont
                           showResult:(BOOL)showResult
                                   cb:(BAPickerResultBlock)cb {
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
    BAPickerToolBarModel *toolBarModel = [self initToolBarModelWithTitle:title
                                                               titleFont:titleFont
                                                             cancleTitle:cancleTitle
                                                        cancleTitleColor:cancleTitleColor
                                                         cancleTitleFont:cancleTitleFont
                                                               sureTitle:sureTitle
                                                          sureTitleColor:sureTitleColor
                                                           sureTitleFont:sureTitleFont
                                                              showResult:showResult];
    toolBarModel.backgroundColor = BAKit_Color_RandomRGB_pod();

    datePickerModel.toolBarModel = toolBarModel;
    
    [self initCustomDatePickerWithModel:datePickerModel cb:cb];
}

@end
