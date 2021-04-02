//
//  BAPickerManger.m
//  BAPickView
//
//  Created by 博爱 on 2021/4/2.
//

#import "BAPickerManger.h"
#import "BAPickerView.h"
#import "BADatePickerView.h"

@implementation BAPickerManger

+ (void)initStringsPicker:(NSArray <NSString *>*)strings
                       cb:(onSelectPicker)cb {
    [self initStringsPicker:strings showResult:NO cb:cb];
}

+ (void)initStringsPicker:(NSArray <NSString *>*)strings
               showResult:(BOOL)showResult
                       cb:(onSelectPicker)cb {
    [self initStringsPicker:strings cancleTitle:nil sureTitle:nil showResult:showResult cb:cb];
}

+ (void)initStringsPicker:(NSArray <NSString *>*)strings
              cancleTitle:(nullable NSString *)cancleTitle
                sureTitle:(nullable NSString *)sureTitle
               showResult:(BOOL)showResult
                       cb:(onSelectPicker)cb {
    [self initStringsPicker:strings
                cancleTitle:cancleTitle
           cancleTitleColor:nil
                  sureTitle:sureTitle
             sureTitleColor:nil
                 showResult:showResult
                         cb:cb];
}

+ (void)initStringsPicker:(NSArray <NSString *>*)strings
              cancleTitle:(nullable NSString *)cancleTitle
         cancleTitleColor:(nullable UIColor *)cancleTitleColor
                sureTitle:(nullable NSString *)sureTitle
           sureTitleColor:(nullable UIColor *)sureTitleColor
               showResult:(BOOL)showResult
                       cb:(onSelectPicker)cb {
    [self initStringsPicker:strings
    maskViewBackgroundColor:nil
                cancleTitle:cancleTitle
           cancleTitleColor:cancleTitleColor
                  sureTitle:sureTitle
             sureTitleColor:sureTitleColor
                 titleColor:nil
                 showResult:showResult
                         cb:cb];
}

+ (void)initStringsPicker:(NSArray <NSString *>*)strings
  maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
              cancleTitle:(nullable NSString *)cancleTitle
         cancleTitleColor:(nullable UIColor *)cancleTitleColor
                sureTitle:(nullable NSString *)sureTitle
           sureTitleColor:(nullable UIColor *)sureTitleColor
               titleColor:(nullable UIColor *)titleColor
               showResult:(BOOL)showResult
                       cb:(onSelectPicker)cb {
    // 注意：如果项目中有统一 UI 规范的话，可以二次封装后使用，这样就不用每次都写 configModel 了！！！！
    BAPickerConfigModel *configModel = BAPickerConfigModel.new;
    configModel.maskViewBackgroundColor = maskViewBackgroundColor;
    
    BAPickerModel *pickerModel = BAPickerModel.new;
    pickerModel.stringsArray = strings;
    
    // ToolBar
    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
    //    toolBarModel.backgroundColor = BAKit_Color_RandomRGB_pod();
    toolBarModel.cancleTitleFont = [UIFont systemFontOfSize:14];
    toolBarModel.sureTitleFont = [UIFont systemFontOfSize:14];
    toolBarModel.titleFont = [UIFont boldSystemFontOfSize:16];
    toolBarModel.titleColor = titleColor;
    toolBarModel.cancleTitleColor = cancleTitleColor;
    toolBarModel.sureTitleColor = sureTitleColor;
    toolBarModel.cancleTitle = cancleTitle;
    toolBarModel.sureTitle = sureTitle;
    toolBarModel.showResult = showResult;
    
    configModel.pickerModel = pickerModel;
    configModel.toolBarModel = toolBarModel;
    
    BAPickerView *picker = BAPickerView.new;
    picker.configModel = configModel;
    picker.selectPicker = cb;
    
    [picker show];
}

@end

@implementation BAPickerManger (MultipleStrings)

+ (void)initMultipleStringsPicker:(NSArray <NSArray *>*)multipleStringsArray
                               cb:(onSelectPicker)cb {
    [self initMultipleStringsPicker:multipleStringsArray showResult:NO cb:cb];
}

+ (void)initMultipleStringsPicker:(NSArray <NSArray *>*)multipleStringsArray
                       showResult:(BOOL)showResult
                               cb:(onSelectPicker)cb {
    [self initMultipleStringsPicker:multipleStringsArray
                        cancleTitle:nil
                          sureTitle:nil
                         showResult:showResult
                                 cb:cb];
}

+ (void)initMultipleStringsPicker:(NSArray <NSArray *>*)multipleStringsArray
                      cancleTitle:(nullable NSString *)cancleTitle
                        sureTitle:(nullable NSString *)sureTitle
                       showResult:(BOOL)showResult
                               cb:(onSelectPicker)cb {
    [self initMultipleStringsPicker:multipleStringsArray
                        cancleTitle:cancleTitle
                   cancleTitleColor:nil
                          sureTitle:sureTitle
                     sureTitleColor:nil
                         titleColor:nil
                         showResult:showResult
                                 cb:cb];
}

+ (void)initMultipleStringsPicker:(NSArray <NSArray *>*)multipleStringsArray
                      cancleTitle:(nullable NSString *)cancleTitle
                 cancleTitleColor:(nullable UIColor *)cancleTitleColor
                        sureTitle:(nullable NSString *)sureTitle
                   sureTitleColor:(nullable UIColor *)sureTitleColor
                       titleColor:(nullable UIColor *)titleColor
                       showResult:(BOOL)showResult
                               cb:(onSelectPicker)cb {
    [self initMultipleStringsPicker:multipleStringsArray
                 multipleTitleArray:nil
            maskViewBackgroundColor:nil
                        cancleTitle:cancleTitle
                   cancleTitleColor:cancleTitleColor
                          sureTitle:sureTitle
                     sureTitleColor:sureTitleColor
                         titleColor:titleColor
                         showResult:showResult
                                 cb:cb];
}

+ (void)initMultipleStringsPicker:(NSArray <NSArray *>*)multipleStringsArray
               multipleTitleArray:(nullable NSArray <NSString *>*)multipleTitleArray
          maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                      cancleTitle:(nullable NSString *)cancleTitle
                 cancleTitleColor:(nullable UIColor *)cancleTitleColor
                        sureTitle:(nullable NSString *)sureTitle
                   sureTitleColor:(nullable UIColor *)sureTitleColor
                       titleColor:(nullable UIColor *)titleColor
                       showResult:(BOOL)showResult
                               cb:(onSelectPicker)cb {
    
    BAPickerConfigModel *configModel = BAPickerConfigModel.new;
    configModel.maskViewBackgroundColor = maskViewBackgroundColor;
    
    // Picker
    BAPickerModel *pickerModel = BAPickerModel.new;
    pickerModel.multipleTitleArray = multipleTitleArray;
    pickerModel.multipleStringsArray = multipleStringsArray;
    
    // ToolBar
    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
    //    toolBarModel.backgroundColor = BAKit_Color_RandomRGB_pod();
    toolBarModel.cancleTitleFont = [UIFont systemFontOfSize:14];
    toolBarModel.sureTitleFont = [UIFont systemFontOfSize:14];
    toolBarModel.titleFont = [UIFont boldSystemFontOfSize:16];
    toolBarModel.titleColor = titleColor;
    toolBarModel.cancleTitleColor = cancleTitleColor;
    toolBarModel.sureTitleColor = sureTitleColor;
    toolBarModel.cancleTitle = cancleTitle;
    toolBarModel.sureTitle = sureTitle;
    toolBarModel.showResult = showResult;
    
    configModel.pickerModel = pickerModel;
    configModel.toolBarModel = toolBarModel;
    
    BAPickerView *picker = BAPickerView.new;
    picker.configModel = configModel;
    picker.selectPicker = cb;
    
    [picker show];
}

@end

@implementation BAPickerManger (City)

+ (void)initCityPickerWithCallBack:(onSelectCityPicker)cb {
    
    BAPickerConfigModel *configModel = BAPickerConfigModel.new;
    
    // Picker
    BAPickerModel *pickerModel = BAPickerModel.new;
    NSArray *allProvinceCityArray = [[NSArray alloc] initWithContentsOfFile:[self getFilePath]];
    pickerModel.allProvinceCityArray = allProvinceCityArray;
    
    // ToolBar
    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
    //    toolBarModel.backgroundColor = BAKit_Color_RandomRGB_pod();
    toolBarModel.cancleTitleFont = [UIFont systemFontOfSize:14];
    toolBarModel.sureTitleFont = [UIFont systemFontOfSize:14];
    toolBarModel.titleFont = [UIFont boldSystemFontOfSize:16];
    //    toolBarModel.titleColor = titleColor;
    //    toolBarModel.cancleTitleColor = cancleTitleColor;
    //    toolBarModel.sureTitleColor = sureTitleColor;
    //    toolBarModel.cancleTitle = cancleTitle;
    //    toolBarModel.sureTitle = sureTitle;
    //    toolBarModel.showResult = showResult;
    
    configModel.pickerModel = pickerModel;
    configModel.toolBarModel = toolBarModel;
    
    BAPickerView *picker = BAPickerView.new;
    picker.configModel = configModel;
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

+ (void)initSystemDatePicker:(onSelectDatePicker)cb {
    [self initSystemDatePicker:UIDatePickerModeDate formatterString:nil showResult:NO cb:cb];
}

+ (void)initSystemDatePicker:(UIDatePickerMode)datePickerMode
             formatterString:(nullable NSString *)formatterString
                  showResult:(BOOL)showResult
                          cb:(onSelectDatePicker)cb {
    [self initSystemDatePicker:datePickerMode formatterString:formatterString cancleTitle:nil sureTitle:nil showResult:showResult cb:cb];
}

+ (void)initSystemDatePicker:(UIDatePickerMode)datePickerMode
             formatterString:(nullable NSString *)formatterString
                 cancleTitle:(nullable NSString *)cancleTitle
                   sureTitle:(nullable NSString *)sureTitle
                  showResult:(BOOL)showResult
                          cb:(onSelectDatePicker)cb {
    [self initSystemDatePicker:datePickerMode
               formatterString:formatterString
                   cancleTitle:cancleTitle
              cancleTitleColor:nil
                     sureTitle:sureTitle
                sureTitleColor:nil
                    titleColor:nil
                    showResult:showResult
                            cb:cb];
}

+ (void)initSystemDatePicker:(UIDatePickerMode)datePickerMode
             formatterString:(nullable NSString *)formatterString
                 cancleTitle:(nullable NSString *)cancleTitle
            cancleTitleColor:(nullable UIColor *)cancleTitleColor
                   sureTitle:(nullable NSString *)sureTitle
              sureTitleColor:(nullable UIColor *)sureTitleColor
                  titleColor:(nullable UIColor *)titleColor
                  showResult:(BOOL)showResult
                          cb:(onSelectDatePicker)cb {
    [self initSystemDatePicker:datePickerMode
               formatterString:formatterString
       maskViewBackgroundColor:nil
                   cancleTitle:cancleTitle
              cancleTitleColor:cancleTitleColor
                     sureTitle:sureTitle
                sureTitleColor:sureTitleColor
                    titleColor:titleColor
                    showResult:showResult
                            cb:cb];
}

+ (void)initSystemDatePicker:(UIDatePickerMode)datePickerMode
             formatterString:(nullable NSString *)formatterString
     maskViewBackgroundColor:(nullable UIColor *)maskViewBackgroundColor
                 cancleTitle:(nullable NSString *)cancleTitle
            cancleTitleColor:(nullable UIColor *)cancleTitleColor
                   sureTitle:(nullable NSString *)sureTitle
              sureTitleColor:(nullable UIColor *)sureTitleColor
                  titleColor:(nullable UIColor *)titleColor
                  showResult:(BOOL)showResult
                          cb:(onSelectDatePicker)cb {
    BAPickerConfigModel *configModel = BAPickerConfigModel.new;
    configModel.maskViewBackgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    
    // DatePicker
    BADatePickerModel *datePickerModel = BADatePickerModel.new;
    datePickerModel.datePickerMode = datePickerMode ? datePickerMode:UIDatePickerModeDate;
    datePickerModel.formatterString = formatterString.length ? formatterString :@"yyyy-MM-dd HH:mm:ss"; //@"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
    
    // ToolBar
    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
    //    toolBarModel.backgroundColor = BAKit_Color_RandomRGB_pod();
    toolBarModel.cancleTitleFont = [UIFont systemFontOfSize:14];
    toolBarModel.sureTitleFont = [UIFont systemFontOfSize:14];
    toolBarModel.titleFont = [UIFont boldSystemFontOfSize:16];
    toolBarModel.titleColor = titleColor;
    toolBarModel.cancleTitleColor = cancleTitleColor;
    toolBarModel.sureTitleColor = sureTitleColor;
    toolBarModel.cancleTitle = cancleTitle;
    toolBarModel.sureTitle = sureTitle;
    toolBarModel.showResult = showResult;
    
    configModel.datePickerModel = datePickerModel;
    configModel.toolBarModel = toolBarModel;
    
    BADatePickerView *picker = BADatePickerView.new;
    picker.configModel = configModel;
    
    picker.onSelectDatePicker = cb;
    [picker show];
}

@end
