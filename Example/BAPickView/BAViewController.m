//
//  BAViewController.m
//  BAPickView
//
//  Created by boai on 11/27/2018.
//  Copyright (c) 2018 boai. All rights reserved.
//

#import "BAViewController.h"

#import "BAPickView_OC.h"
#import "BAKit_DatePicker.h"

@interface BAViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property(nonatomic, strong) UITableView *tableView;
@property(strong, nonatomic) NSArray *dataArray;

@property(nonatomic, strong) BAKit_PickerView *pickView;

@end

@implementation BAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}

- (void)setupUI {
    self.title = @"BAPickView-OC";
    self.tableView.hidden = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
   
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    
    CGFloat min_view_w = CGRectGetWidth(self.view.frame);
    CGFloat min_view_h = CGRectGetHeight(self.view.frame);
    
    min_x = BAKit_ViewSafeAreaInsets(self.view).left;
    min_h = min_view_h - min_y;
    min_w = min_view_w - BAKit_ViewSafeAreaInsets(self.view).left - BAKit_ViewSafeAreaInsets(self.view).right;
    
    self.tableView.frame = CGRectMake(min_x, min_y, min_w, min_h);

}

#pragma mark - UITableViewDataSource / UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if ( !cell ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
        cell.accessoryType = (indexPath.section == 0) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    }
    NSArray *tempArray = self.dataArray[indexPath.section];
    cell.textLabel.text = tempArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( 0 == indexPath.section ) {
        switch ( indexPath.row ) {
                case 0: {
                [self pickView1];
            }
                break;
                case 1: {
                [self pickView2];
            }
                break;
                case 2: {
                [self pickView3];
            }
                break;
                case 3: {
                [self pickView4];
            }
                break;
                case 4: {
                [self pickView5];
            }
                break;
                case 5: {
                [self pickView6];
            }
                break;
                
            default:
                break;
        }
    } else if (1 == indexPath.section) {
        NSInteger type = 0;
        switch (indexPath.row) {
                case 0: {
                type = BAKit_CustomDatePickerDateTypeYMDHMS;
            }
                break;
                case 1: {
                type = BAKit_CustomDatePickerDateTypeYMDHM;
            }
                break;
                case 2: {
                type = BAKit_CustomDatePickerDateTypeYMD;
            }
                break;
                
                case 3: {
                type = BAKit_CustomDatePickerDateTypeHMS;
            }
                break;
                
                case 4: {
                type = BAKit_CustomDatePickerDateTypeYM;
            }
                break;
                
                case 5: {
                type = BAKit_CustomDatePickerDateTypeMD;
            }
                break;
                case 6: {
                type = BAKit_CustomDatePickerDateTypeHM;
            }
                break;
                case 7: {
                type = BAKit_CustomDatePickerDateTypeYY;
            }
                break;
                
            default:
                break;
        }
        
        [self ba_creatDatePickerWithType:type];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [UIView new];
    
    UILabel *headerTitle = [UILabel new];
    headerTitle.font = [UIFont systemFontOfSize:14];
    headerTitle.textColor = [UIColor redColor];
    headerTitle.numberOfLines = 0;
    [headerView addSubview:headerTitle];
    
    headerTitle.frame = CGRectMake(20, 0, BAKit_SCREEN_WIDTH - 40, 40);
    switch (section) {
            case 0: {
            headerTitle.text = @"BAPickView 的几种日常用法！";
        }
            break;
            case 1: {
            headerTitle.text = @"自定义 DatePicker";
        }
            break;
            case 2: {
            headerTitle.text = @"BAPickView 的特点！";
        }
            break;
            
        default:
            break;
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return FLT_MIN;
}

#pragma mark - custom method

- (void)pickView1 {
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatCityPickerViewWithConfiguration:^(BAKit_PickerView *tempView) {
        BAKit_StrongSelf
        // 设置“取消“和”确定“ button 在 pickerView 的底部
        tempView.buttonPositionType = BAKit_PickerViewButtonPositionTypeBottom;
        // 设置 pickerView 在屏幕中的位置
        tempView.pickerViewPositionType = BAKit_PickerViewPositionTypeCenter;
        // 是否开启边缘触摸隐藏 默认：YES
        tempView.isTouchEdgeHide = NO;
        // 动画样式
        tempView.animationType = BAKit_PickerViewAnimationTypeBottom;
        /**
         pickView 字体，默认：[UIFont boldSystemFontOfSize:17]
         */
        tempView.ba_pickViewFont = [UIFont systemFontOfSize:17];
        /**
         pickView 字体颜色，默认：[UIColor blackColor]
         */
        tempView.ba_pickViewTextColor = [UIColor orangeColor];
        
        /**
         是否显示分割线，默认：NO，不显示，注意：iOS 10 开始，pickerView 默认没有分割线，这里是自己添加的分割线
         */
        tempView.isShowLineView = YES;
        /**
         pickView 分割线颜色，注意：请务必 打开 isShowLineView 开关！
         */
        tempView.ba_pickViewLineViewColor = BAKit_Color_Red_pod;
        
        self.pickView = tempView;
    } block:^(BAKit_CityModel *model) {
        BAKit_StrongSelf
        // 返回 BAKit_CityModel，包含省市县 和 详细的经纬度
        NSString *msg = [NSString stringWithFormat:@"%@%@%@\n纬度：%f\n经度：%f", model.province, model.city, model.area, model.coordie.latitude, model.coordie.longitude];
        NSLog(@"%@", msg);
        BAKit_ShowAlertWithMsg_ios8(msg);
    }];
}

- (void)pickView2 {
    NSArray *array = @[@"男", @"女",@"我们的"];
    
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatCustomPickerViewWithDataArray:array configuration:^(BAKit_PickerView *tempView) {
        BAKit_StrongSelf
        // 可以自由定制 toolBar 和 pickView 的背景颜色
        //        tempView.ba_backgroundColor_toolBar = [UIColor cyanColor];
        //        tempView.ba_backgroundColor_pickView = [UIColor greenColor];
        tempView.animationType = BAKit_PickerViewAnimationTypeBottom;
        tempView.pickerViewPositionType = BAKit_PickerViewPositionTypeNormal;
        self.pickView = tempView;
    } block:^(NSString *resultString, NSInteger index) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

- (void)pickView3 {
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatPickerViewWithType:BAKit_PickerViewTypeDate configuration:^(BAKit_PickerView *tempView) {
        BAKit_StrongSelf
        
        tempView.defaultTitle = @"请选择日期";
        // 可以自由定制 NSDateFormatter
        tempView.dateMode = BAKit_PickerViewDateModeDate;
        tempView.dateType = BAKit_PickerViewDateTypeYMD;
        
        NSDateFormatter *format = [NSDateFormatter ba_setupDateFormatterWithYMD];
        [format setDateFormat:@"yyyy年MM月dd日"];

        // 最小时间，当前时间
        NSDate *minDate = [format dateFromString:@"1900年01月01日"];
        tempView.ba_maxDate = BAKit_Current_Date();
        tempView.ba_minDate = minDate;
        //        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //        formatter.dateFormat = @"yyyy年MM月dd日";
        //        tempView.customDateFormatter = formatter;
        // 可以自由定制按钮颜色
        tempView.ba_buttonTitleColor_sure = [UIColor redColor];
        tempView.ba_buttonTitleColor_cancle = [UIColor greenColor];
        tempView.animationType = BAKit_PickerViewAnimationTypeLeft;
        
        self.pickView = tempView;
        
    } block:^(NSString *resultString, NSInteger index) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

- (void)pickView4 {
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatPickerViewWithType:BAKit_PickerViewTypeDateYM configuration:^(BAKit_PickerView *tempView) {
        BAKit_StrongSelf
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM";
        tempView.customDateFormatter = formatter;
        tempView.animationType = BAKit_PickerViewAnimationTypeRight;
        self.pickView = tempView;
    } block:^(NSString *resultString, NSInteger index) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

- (void)pickView5 {
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatPickerViewWithType:BAKit_PickerViewTypeDateWeek configuration:^(BAKit_PickerView *tempView) {
        
        BAKit_StrongSelf
        self.pickView = tempView;
    } block:^(NSString *resultString, NSInteger index) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

- (void)pickView6 {
    NSArray *array = @[
                       @[@"男", @"女"],
                       @[@"18", @"22"],
                       @[@"163", @"168"]
                       ];
    NSArray *titleArray = @[@"性别", @"年龄", @"身高"];
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatCustomMultiplePickerViewWithDataArray:array configuration:^(BAKit_PickerView *tempView) {
        
        BAKit_StrongSelf
        tempView.multipleTitleArray = titleArray;
        // 是否显示 pickview title
        //        tempView.isShowTitle = NO;
        // 自定义 pickview title 的字体颜色
        tempView.ba_pickViewTitleColor = BAKit_Color_Red_pod;
        // 自定义 pickview title 的字体
        tempView.ba_pickViewTitleFont = [UIFont boldSystemFontOfSize:15];
        // 可以自由定制 toolBar 和 pickView 的背景颜色
        tempView.ba_backgroundColor_toolBar = [UIColor cyanColor];
        tempView.ba_backgroundColor_pickView = [UIColor greenColor];
        tempView.animationType = BAKit_PickerViewAnimationTypeTop;
        tempView.pickerViewPositionType = BAKit_PickerViewPositionTypeCenter;
        self.pickView = tempView;
    } block:^(NSString *resultString, NSInteger index) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
        NSLog(@"%@", resultString);
    }];
}

#pragma mark 自定义日期选择器
- (void)ba_creatDatePickerWithType:(BAKit_CustomDatePickerDateType)type {
    [BAKit_DatePicker ba_creatPickerViewWithType:type configuration:^(BAKit_DatePicker *tempView) {
        
        if (type != BAKit_CustomDatePickerDateTypeHMS) {
            tempView.defaultTitle = @"请选择日期";
        }

        NSDate *maxDate;
        NSDate *minDate;
        // 自定义：最大最小日期格式
        if (type == BAKit_CustomDatePickerDateTypeYMD) {
            //            NSDateFormatter *format = [NSDateFormatter ba_setupDateFormatterWithYMD];
            //            maxDate = [format dateFromString:@"2018-08-09"];
            //            minDate = [format dateFromString:@"2016-07-20"];
            NSDateFormatter *format = [NSDateFormatter ba_setupDateFormatterWithYMD];
            NSDate *today = [[NSDate alloc]init];
            [format setDateFormat:@"yyyy-MM-dd"];
            
            // 最小时间，当前时间
            minDate = [format dateFromString:[format stringFromDate:today]];
            
            //            NSTimeInterval oneDay = 24 * 60 * 60;
            //            // 最大时间，当前时间+180天
            //            NSDate *theDay = [today initWithTimeIntervalSinceNow:oneDay * 180];
            //            maxDate = [format dateFromString:[format stringFromDate:theDay]];
            
            maxDate = [format dateFromString:@"2019-01-07"];
            
        }
        else if (type == BAKit_CustomDatePickerDateTypeYM) {
            NSDateFormatter *format = [NSDateFormatter ba_setupDateFormatterWithYM];
            maxDate = [format dateFromString:@"2018-08"];
            minDate = [format dateFromString:@"2016-07"];
        }
        
        if (maxDate) {
            // 自定义：最大日期
            tempView.ba_maxDate = maxDate;
        }
        if (minDate) {
            // 自定义：最小日期
            tempView.ba_minDate = minDate;
        }
        
        /**
         是否显示背景年份水印，默认：NO
         */
        tempView.isShowBackgroundYearLabel = YES;
        
        // 是否显示 pickview title
        //        tempView.isShowTitle = NO;
        // 自定义 pickview title 的字体颜色
        tempView.ba_pickViewTitleColor = BAKit_Color_Red_pod;
        // 自定义 pickview title 的字体
        tempView.ba_pickViewTitleFont = [UIFont boldSystemFontOfSize:15];
        // 自定义 pickview背景 title 的字体颜色
        //        tempView.ba_bgYearTitleColor = [UIColor orangeColor];
        //        // 自定义 pickview背景 title 的字体
        //        tempView.ba_bgYearTitleFont = [UIFont systemFontOfSize:50];
        // 自定义：动画样式
        tempView.animationType = BAKit_PickerViewAnimationTypeBottom;
        // 自定义：pickView 位置
//                    tempView.pickerViewPositionType = BAKit_PickerViewPositionTypeCenter;
        // 自定义：toolBar 位置
                    tempView.buttonPositionType = BAKit_PickerViewButtonPositionTypeBottom;
        // 自定义：pickView 文字颜色
        tempView.ba_pickViewTextColor = [UIColor redColor];
        // 自定义：pickView 文字字体
        tempView.ba_pickViewFont = [UIFont systemFontOfSize:13];
        
        // 可以自由定制按钮颜色
        tempView.ba_buttonTitleColor_sure = [UIColor redColor];
        tempView.ba_buttonTitleColor_cancle = [UIColor greenColor];
        
        // 可以自由定制 toolBar 和 pickView 的背景颜色
        //            tempView.ba_backgroundColor_toolBar = [UIColor cyanColor];
        //            tempView.ba_backgroundColor_pickView = [UIColor greenColor];
        
    } block:^(NSString *resultString, NSInteger index) {

        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

#pragma mark - setter / getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        self.tableView.delegate = self;
        self.tableView.dataSource =  self;
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.tableView.backgroundColor = BAKit_Color_Gray_11_pod;
        
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (NSArray *)dataArray {
    if ( !_dataArray ) {
        _dataArray = [NSArray arrayWithObjects:@[@"1、城市选择器，返回省市县和经纬度",
                                                 @"2、普通数组自定义数据",
                                                 @"3、日期选择器：年月日，可以完全自定义 NSDateFormatter",
                                                 @"4、日期选择器：年月，可以完全自定义 NSDateFormatter",
                                                 @"5、日期选择器：年周，如：2017年，第21周",
                                                 @"5、多数组自定义数据",
                                                 ],
                      @[@"1、YYYY-MM-DD HH:mm:ss",@"2、YYYY-MM-DD HH:mm",@"3、YYYY-MM-DD",@"4、HH:mm:ss",@"5、YYYY-MM",@"6、MM-DD",@"7、HH:mm",@"8、YYYY"],
                      @[@"1、城市选择器，三级联动，可返回省市县和精确的经纬度\n2、可以自定义 array 显示，性别选择等【目前只支持单行数据】\n3、日期选择器：年月日，可以完全自定义 NSDateFormatter\n4、日期选择器：年月，可以完全自定义 NSDateFormatter\n5、横竖屏适配完美\n6、可以自定义按钮颜色、背景颜色等\n7、可以自由设置 pickView 居中或者在底部显示，还可以自由定制 toolbar 居中或者在底部显示\n8、可以自由设置 pickView 字体、字体颜色等内容，注意：日期选择器暂时不能修改字体，有可能被苹果审核不通过，如有特殊需求，可通过 runtime 修改\n9、理论完全兼容现有所有 iOS 系统版本"
                        ], nil];
    }
    return _dataArray;
}


@end

