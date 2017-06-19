//
//  ViewController.m
//  BAPickView
//
//  Created by boai on 2017/5/16.
//  Copyright © 2017年 boai. All rights reserved.
//

#import "ViewController.h"
#import "BAPickView_OC.h"
#import "BAKit_DatePicker.h"

/*! VC 用 BAKit_ShowAlertWithMsg */
#define BAKit_ShowAlertWithMsg_ios8(msg) UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:msg preferredStyle:UIAlertControllerStyleAlert];\
UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确 定" style:UIAlertActionStyleDefault handler:nil];\
[alert addAction:sureAction];\
[self presentViewController:alert animated:YES completion:nil];

@interface ViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource
>

@property(nonatomic, strong) UITableView *tableView;
@property(strong, nonatomic) NSArray *dataArray;

@property(nonatomic, strong) BAKit_PickerView *pickView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setupUI];
}

- (void)setupUI
{
    self.title = @"BAPickView-OC";
    self.tableView.hidden = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
    
}


#pragma mark - UITableViewDataSource / UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if ( !cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
        cell.accessoryType = (indexPath.section == 0) ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;
    }
    NSArray *tempArray = self.dataArray[indexPath.section];
    cell.textLabel.text = tempArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ( 0 == indexPath.section )
    {
        switch ( indexPath.row ) {
            case 0:
            {
                [self pickView1];
            }
                break;
            case 1:
            {
                [self pickView2];
            }
                break;
            case 2:
            {
                [self pickView3];
            }
                break;
            case 3:
            {
                [self pickView4];
            }
                break;
            case 4:
            {
                [self pickView5];
            }
                break;
                
            default:
                break;
        }
    }
    else if (1 == indexPath.section)
    {
        NSInteger type = 0;
        switch (indexPath.row) {
            case 0:
            {
                type = BAKit_CustomDatePickerDateTypeYMDHMS;
            }
                break;
            case 1:
            {
                type = BAKit_CustomDatePickerDateTypeYMDHM;
            }
                break;
            case 2:
            {
                type = BAKit_CustomDatePickerDateTypeYMD ;
            }
                break;

            case 3:
            {
                type = BAKit_CustomDatePickerDateTypeHMS;
            }
                break;

            case 4:
            {
                type = BAKit_CustomDatePickerDateTypeYM;
            }
                break;

            case 5:
            {
                type = BAKit_CustomDatePickerDateTypeMD;
            }
                break;
            case 6:
            {
                type = BAKit_CustomDatePickerDateTypeHM;
            }
                break;
            case 7:
            {
                type = BAKit_CustomDatePickerDateTypeYY;
            }
                break;
 
            default:
                break;
        }
        
        [BAKit_DatePicker ba_creatPickerViewWithType:type configuration:^(BAKit_DatePicker *tempView) {
            // 自定义：最小年份
            tempView.ba_minYear = BAKit_Current_Date.year;
            // 自定义：最大年份
            tempView.ba_maxYear = tempView.ba_minYear + 5;
            // 自定义：动画样式
            tempView.animationType = BAKit_PickerViewAnimationTypeScale;
            // 自定义：pickView 位置
            tempView.pickerViewPositionType = BAKit_PickerViewPositionTypeCenter;
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
            tempView.ba_backgroundColor_toolBar = [UIColor cyanColor];
            tempView.ba_backgroundColor_pickView = [UIColor greenColor];
            
        } block:^(NSString *resultString) {
            
            BAKit_ShowAlertWithMsg_ios8(resultString);
        }];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    
    UILabel *headerTitle = [UILabel new];
    headerTitle.font = [UIFont systemFontOfSize:14];
    headerTitle.textColor = [UIColor redColor];
    headerTitle.numberOfLines = 0;
    [headerView addSubview:headerTitle];
    
    headerTitle.frame = CGRectMake(20, 0, BAKit_SCREEN_WIDTH - 40, 40);
    switch (section) {
        case 0:
        {
             headerTitle.text = @"BAPickView 的几种日常用法！";
        }
            break;
        case 1:
        {
            headerTitle.text = @"自定义 DatePicker";
        }
            break;
        case 2:
        {
            headerTitle.text = @"BAPickView 的特点！";
        }
            break;
 
        default:
            break;
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}

#pragma mark - custom method

- (void)pickView1
{
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
        
        self.pickView = tempView;
    } block:^(BAKit_CityModel *model) {
        BAKit_StrongSelf
        // 返回 BAKit_CityModel，包含省市县 和 详细的经纬度
        NSString *msg = [NSString stringWithFormat:@"%@%@%@\n纬度：%f\n经度：%f", model.province, model.city, model.area, model.coordie.latitude, model.coordie.longitude];
        NSLog(@"%@", msg);
        BAKit_ShowAlertWithMsg_ios8(msg);
    }];
}

- (void)pickView2
{
    NSArray *array = @[@"男", @"女"];
    
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatCustomPickerViewWithDataArray:array configuration:^(BAKit_PickerView *tempView) {
        BAKit_StrongSelf
        // 可以自由定制 toolBar 和 pickView 的背景颜色
        tempView.ba_backgroundColor_toolBar = [UIColor cyanColor];
        tempView.ba_backgroundColor_pickView = [UIColor greenColor];
        tempView.animationType = BAKit_PickerViewAnimationTypeTop;
        tempView.pickerViewPositionType = BAKit_PickerViewPositionTypeCenter;
        self.pickView = tempView;
    } block:^(NSString *resultString) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

- (void)pickView3
{
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatPickerViewWithType:BAKit_PickerViewTypeDate configuration:^(BAKit_PickerView *tempView) {
        BAKit_StrongSelf
        
        // 可以自由定制 NSDateFormatter
        tempView.dateMode = BAKit_PickerViewDateModeDate;
        tempView.dateType = BAKit_PickerViewDateTypeYMDHMS;
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        formatter.dateFormat = @"yyyy年MM月dd日";
//        tempView.customDateFormatter = formatter;
        // 可以自由定制按钮颜色
        tempView.ba_buttonTitleColor_sure = [UIColor redColor];
        tempView.ba_buttonTitleColor_cancle = [UIColor greenColor];
        tempView.animationType = BAKit_PickerViewAnimationTypeLeft;

        self.pickView = tempView;
        
    } block:^(NSString *resultString) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

- (void)pickView4
{
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatPickerViewWithType:BAKit_PickerViewTypeDateYM configuration:^(BAKit_PickerView *tempView) {
        BAKit_StrongSelf
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM";
        tempView.customDateFormatter = formatter;
        tempView.animationType = BAKit_PickerViewAnimationTypeRight;
        self.pickView = tempView;
    } block:^(NSString *resultString) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

- (void)pickView5
{
    BAKit_WeakSelf
    [BAKit_PickerView ba_creatPickerViewWithType:BAKit_PickerViewTypeDateWeek configuration:^(BAKit_PickerView *tempView) {
        
        BAKit_StrongSelf
        self.pickView = tempView;
    } block:^(NSString *resultString) {
        BAKit_StrongSelf
        BAKit_ShowAlertWithMsg_ios8(resultString);
    }];
}

#pragma mark - setter / getter

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [UITableView new];
        self.tableView.delegate = self;
        self.tableView.dataSource =  self;
        self.tableView.estimatedRowHeight = 44;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.backgroundColor = BAKit_Color_Gray_11;
        
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (NSArray *)dataArray
{
    if ( !_dataArray )
    {
        _dataArray = [NSArray arrayWithObjects:@[@"1、城市选择器，返回省市县和经纬度",
                                                 @"2、普通数组自定义数据",
                                                 @"3、日期选择器：年月日，可以完全自定义 NSDateFormatter",
                                                 @"4、日期选择器：年月，可以完全自定义 NSDateFormatter",
                                                 @"5、日期选择器：年周，如：2017年，第21周",
                                                 ],
                     @[@"1、YYYY-MM-DD HH:mm:ss",@"2、YYYY-MM-DD HH:mm",@"3、YYYY-MM-DD",@"4、HH:mm:ss",@"5、YYYY-MM",@"6、MM-DD",@"7、HH:mm",@"8、YYYY"],
                      @[@"1、城市选择器，三级联动，可返回省市县和精确的经纬度\n2、可以自定义 array 显示，性别选择等【目前只支持单行数据】\n3、日期选择器：年月日，可以完全自定义 NSDateFormatter\n4、日期选择器：年月，可以完全自定义 NSDateFormatter\n5、横竖屏适配完美\n6、可以自定义按钮颜色、背景颜色等\n7、可以自由设置 pickView 居中或者在底部显示，还可以自由定制 toolbar 居中或者在底部显示\n8、10、可以自由设置 pickView 字体、字体颜色等内容，注意：日期选择器暂时不能修改字体，有可能被苹果审核不通过，如有特殊需求，可通过 runtime 修改\n9、理论完全兼容现有所有 iOS 系统版本"
                        ], nil];
    }
    return _dataArray;
}


@end
