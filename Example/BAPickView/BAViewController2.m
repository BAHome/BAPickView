//
//  BAViewController2.m
//  BAPickView_Example
//
//  Created by 博爱 on 2021/4/1.
//  Copyright © 2021 boai. All rights reserved.
//

#import "BAViewController2.h"

#import "BAPickerView.h"

#import "BADatePickerView.h"
#import "BAKit_ConfigurationDefine.h"

#import "BAPickerManger.h"

@interface BAViewController2 ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property(nonatomic, strong) UITableView *tableView;
@property(strong, nonatomic) NSArray *dataArray;


@end

@implementation BAViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUI];
}

- (void)initUI {
    self.title = @"BAPickView-新版";
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
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
            } break;
            case 1: {
                [self pickView2];
            } break;
            case 2: {
                [self pickView3];
            } break;
            case 3: {
                //                [self pickView4];
            } break;
            case 4: {
                //                [self pickView5];
            } break;
            case 5: {
                //                [self pickView6];
            } break;
                
            default:
                break;
        }
    } else if (1 == indexPath.section) {
        //        NSInteger type = 0;
        switch (indexPath.row) {
            case 0: {
                //                type = BAKit_CustomDatePickerDateTypeYMDHMS;
            } break;
                
            default:
                break;
        }
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
        } break;
        case 1: {
            headerTitle.text = @"自定义 DatePicker";
        } break;
        case 2: {
            headerTitle.text = @"BAPickView 的特点！";
        } break;
            
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
    [BAPickerManger initCityPickerWithCallBack:^(BACityModel *model) {
        BAKit_StrongSelf
        // 返回 BAKit_CityModel，包含省市县 和 详细的经纬度
        NSString *msg = [NSString stringWithFormat:@"%@%@%@\n纬度：%f\n经度：%f", model.province, model.city, model.area, model.coordie.latitude, model.coordie.longitude];
        BAKit_ShowAlertWithMsg_ios8(msg);
    }];
    
    return;
    
    BAPickerConfigModel *configModel = BAPickerConfigModel.new;
    configModel.maskViewBackgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
    
    // DatePicker
    BADatePickerModel *datePickerModel = BADatePickerModel.new;
    datePickerModel.datePickerMode = UIDatePickerModeDateAndTime;
    datePickerModel.formatterString = @"yyyy-MM-dd KK:mm:ss"; //@"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";

    // ToolBar
    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
    toolBarModel.backgroundColor = BAKit_Color_RandomRGB_pod();
    toolBarModel.cancleTitleFont = [UIFont systemFontOfSize:14];
    toolBarModel.sureTitleFont = [UIFont systemFontOfSize:14];
    toolBarModel.titleColor = BAKit_Color_RandomRGB_pod();
    toolBarModel.titleFont = [UIFont boldSystemFontOfSize:16];
    
    
    configModel.datePickerModel = datePickerModel;
    configModel.toolBarModel = toolBarModel;
    
    BADatePickerView *picker = BADatePickerView.new;
    picker.configModel = configModel;
    
//    BAKit_WeakSelf
    picker.onSelectDatePicker = ^(NSString * _Nonnull resultString, NSDate * _Nonnull resultDate) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    };
    [picker show];
}

- (void)pickView2 {
    BAKit_WeakSelf
    [BAPickerManger initStringsPicker:@[@"性别", @"年龄", @"身高"] showResult:YES cb:^(NSInteger selectRow, NSInteger selectComponent, NSString *resultString, NSArray *resultArray, UIPickerView *pickerView) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

- (void)pickView3 {
    
    NSArray *multipleTitleArray = @[@"性别", @"年龄", @"身高"];
    NSArray *multipleStringsArray =  @[
        @[@"男", @"女"],
        @[@"18", @"22", @"25", @"30", @"36", @"42"],
        @[@"145", @"150", @"160", @"168", @"175"]
    ];
    BAKit_WeakSelf
//    [BAPickerManger initMultipleStringsPicker:multipleStringsArray cb:^(NSInteger selectRow, NSInteger selectComponent, NSString *resultString, NSArray *resultArray) {
//        BAKit_StrongSelf
//        BAKit_ShowAlertWithMsg_ios8(resultString);
//    }];
    [BAPickerManger initMultipleStringsPicker:multipleStringsArray multipleTitleArray:multipleTitleArray maskViewBackgroundColor:[UIColor.blackColor colorWithAlphaComponent:0.6] cancleTitle:@"cancle1111" cancleTitleColor:UIColor.lightGrayColor sureTitle:@"sure" sureTitleColor:UIColor.redColor titleColor:UIColor.greenColor showResult:YES cb:^(NSInteger selectRow, NSInteger selectComponent, NSString *resultString, NSArray *resultArray, UIPickerView *pickerView) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
    
    
//    BAPickerConfigModel *configModel = BAPickerConfigModel.new;
//    configModel.maskViewBackgroundColor = [UIColor.blackColor colorWithAlphaComponent:0.6];
//    
//    BAPickerModel *pickerModel = BAPickerModel.new;
//    pickerModel.multipleTitleArray = @[@"性别", @"年龄", @"身高"];
//    pickerModel.multipleStringsArray =  @[
//        @[@"男", @"女"],
//        @[@"18", @"22", @"25", @"30", @"36", @"42"],
//        @[@"145", @"150", @"160", @"168", @"175"]
//    ];
//
//    // DatePicker
////    BADatePickerModel *datePickerModel = BADatePickerModel.new;
////    datePickerModel.datePickerMode = UIDatePickerModeDateAndTime;
////    datePickerModel.formatterString = @"yyyy-MM-dd KK:mm:ss"; //@"EEE',' dd MMM yyyy HH':'mm':'ss 'GMT'";
//    
//    // ToolBar
//    BAPickerToolBarModel *toolBarModel = BAPickerToolBarModel.new;
//    toolBarModel.backgroundColor = BAKit_Color_RandomRGB_pod();
//    toolBarModel.cancleTitleFont = [UIFont systemFontOfSize:14];
//    toolBarModel.sureTitleFont = [UIFont systemFontOfSize:14];
//    toolBarModel.titleColor = BAKit_Color_RandomRGB_pod();
//    toolBarModel.titleFont = [UIFont boldSystemFontOfSize:16];
//    
//    
//    configModel.pickerModel = pickerModel;
//    configModel.toolBarModel = toolBarModel;
//    
//    BAPickerView *picker = BAPickerView.new;
//    picker.configModel = configModel;
//    
////    BAKit_WeakSelf
//    picker.onSelectPicker = ^(NSInteger resultRow, NSInteger resultComponent, NSString * _Nonnull resultString, NSArray * _Nonnull resultArray) {
//        BAKit_StrongSelf
//        BAKit_ShowAlertWithMsg_ios8(resultString);
//    };
//    
//    [picker show];
}

#pragma mark - setter / getter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [UITableView new];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        
        self.tableView.backgroundColor = BAKit_Color_Gray_11_pod;
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
