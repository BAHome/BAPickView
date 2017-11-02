//
//  BAKit_DatePicker.m
//  BAKit
//
//  Created by boai on 2017/6/6.
//  Copyright © 2017年 BAHome. All rights reserved.
//

#import "BAKit_DatePicker.h"
#import "NSDate+BAKit.h"
#import "UIView+BAAnimation.h"
#import "BAKit_ConfigurationDefine.h"
#import "UIView+BARectCorner_pick.h"
#import "NSDateFormatter+BAKit.h"

static NSString *const BAKit_DatePickerCellID = @"cell";

#define BAKit_Default_Height    240

@interface BACustomTabelViewCell : UITableViewCell

@property(strong, nonatomic)NSIndexPath *indexPath;

@end

@interface BAKit_DatePicker()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) UITableView *yearTableView;
@property(strong, nonatomic) UITableView *monthTableView;
@property(strong, nonatomic) UITableView *dayTableView;
@property(strong, nonatomic) UITableView *hourTableView;
@property(strong, nonatomic) UITableView *minuteTableView;
@property(strong, nonatomic) UITableView *secondTableView;

@property(strong, nonatomic) NSMutableArray *yearArray;
@property(strong, nonatomic) NSMutableArray *monthArray;
@property(strong, nonatomic) NSMutableArray *dayArray;
@property(strong, nonatomic) NSMutableArray *hourArray;
@property(strong, nonatomic) NSMutableArray *minuteArray;
@property(strong, nonatomic) NSMutableArray *secondArray;

@property(strong, nonatomic) NSMutableDictionary *resoultDictionary;

@property(strong, nonatomic) NSDate * maxDate;
@property(strong, nonatomic) NSDate * minDate;
@property(strong, nonatomic) NSDate * defautDate;

@property (assign, nonatomic) CGFloat cellHight;
@property (nonatomic, strong) UIWindow *alertWindow;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *toolBarView;

@property (nonatomic, strong) UIView *topLine;
@property (nonatomic, strong) UIView *bottomLine;

/**
 年份背景
 */
@property (nonatomic, strong) UILabel *bgShowYearLabel;

@property (nonatomic, assign) BAKit_CustomDatePickerDateType pickerViewType;
@property (nonatomic, copy) BAKit_PickerViewResultBlock resultBlock;

/**
 取消按钮
 */
@property (nonatomic, strong) UIButton *cancleButton;

/**
 确定按钮
 */
@property (nonatomic, strong) UIButton *sureButton;

@property(nonatomic, assign) BOOL isAnimating;

@property (nonatomic, strong) UILabel * contentTitleLabel;


@end

@implementation BAKit_DatePicker

+ (void)ba_creatPickerViewWithType:(BAKit_CustomDatePickerDateType)pickerViewType
                     configuration:(void (^)(BAKit_DatePicker *tempView))configuration
                             block:(BAKit_PickerViewResultBlock)block
{
    BAKit_DatePicker *pickerView = [[BAKit_DatePicker alloc] init];
    pickerView.pickerViewType = pickerViewType;
    if (configuration)
    {
        configuration(pickerView);
    }
    
    pickerView.resultBlock = block;
    [pickerView ba_pickViewShow];
}

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    // 默认配置
    self.isTouchEdgeHide = YES;
    self.isShowBackgroundYearLabel = NO;
    self.ba_backgroundColor_pickView = BAKit_Color_White_pod;
    self.ba_backgroundColor_toolBar = BAKit_Color_White_pod;
    self.animationType = BAKit_PickerViewAnimationTypeScale;
    self.ba_pickViewFont = [UIFont systemFontOfSize:10];
    self.ba_pickViewTextColor = BAKit_Color_Black_pod;
    self.bgShowYearLabel.textColor = [UIColor colorWithRed:237.0/255.0 green:240.0/255.0 blue:244.0/255.0 alpha:1];
    self.buttonPositionType = BAKit_PickerViewButtonPositionTypeNormal;
    self.pickerViewPositionType = BAKit_PickerViewPositionTypeNormal;
    
    [self registCell];

    [BAKit_NotiCenter addObserver:self selector:@selector(handleDeviceOrientationRotateAction:) name:UIDeviceOrientationDidChangeNotification object:nil];

}

- (void)registCell
{
    [self.yearTableView registerClass:[BACustomTabelViewCell class] forCellReuseIdentifier:BAKit_DatePickerCellID];
    [self.monthTableView registerClass:[BACustomTabelViewCell class] forCellReuseIdentifier:BAKit_DatePickerCellID];
    [self.dayTableView registerClass:[BACustomTabelViewCell class] forCellReuseIdentifier:BAKit_DatePickerCellID];
    [self.hourTableView registerClass:[BACustomTabelViewCell class] forCellReuseIdentifier:BAKit_DatePickerCellID];
    [self.minuteTableView registerClass:[BACustomTabelViewCell class] forCellReuseIdentifier:BAKit_DatePickerCellID];
    [self.secondTableView registerClass:[BACustomTabelViewCell class] forCellReuseIdentifier:BAKit_DatePickerCellID];
}

#pragma mark - 通知处理
- (void)handleDeviceOrientationRotateAction:(NSNotification *)notification
{
    [self ba_layoutSubViews];
    
}

- (void)ba_pickViewShow
{
    [self.alertWindow addSubview:self];
    [self ba_layoutSubViews];
    
    if (self.animationType != 0)
    {
        [self ba_pickViewShowAnimation];
    }
}

- (void)ba_pickViewHidden
{
    [self ba_pickViewHiddenAnimation];
}

#pragma mark 进场动画
- (void)ba_pickViewShowAnimation
{
    self.isAnimating = YES;
    BAKit_WeakSelf
    switch (self.animationType) {
        case BAKit_PickerViewAnimationTypeScale:
        {
            [self.backView ba_animation_scaleShowWithDuration:0.6f ratio:1.0f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeTop:
        {
            [self.backView ba_animation_showFromPositionType:BAKit_ViewAnimationEnterDirectionTypeTop duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeBottom:
        {
            [self.backView ba_animation_showFromPositionType:BAKit_ViewAnimationEnterDirectionTypeBottom duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeLeft:
        {
            [self.backView ba_animation_showFromPositionType:BAKit_ViewAnimationEnterDirectionTypeLeft duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeRight:
        {
            [self.backView ba_animation_showFromPositionType:BAKit_ViewAnimationEnterDirectionTypeRitht duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark 出场动画
- (void)ba_pickViewHiddenAnimation
{
    self.isAnimating = YES;
    self.backView.alpha = 1.0f;
    BAKit_WeakSelf
    switch (self.animationType) {
        case BAKit_PickerViewAnimationTypeScale:
        {
            [self.backView ba_animation_scaleDismissWithDuration:0.6f ratio:1.0f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
                self.backView.alpha = 0.1f;
                [self ba_removeSelf];
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeTop:
        {
            [self.backView ba_animation_dismissFromPositionType:BAKit_ViewAnimationEnterDirectionTypeTop duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
                self.backView.alpha = 0.1f;
                [self ba_removeSelf];
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeBottom:
        {
            [self.backView ba_animation_dismissFromPositionType:BAKit_ViewAnimationEnterDirectionTypeBottom duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
                self.backView.alpha = 0.1f;
                [self ba_removeSelf];
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeLeft:
        {
            [self.backView ba_animation_dismissFromPositionType:BAKit_ViewAnimationEnterDirectionTypeLeft duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
                self.backView.alpha = 0.1f;
                [self ba_removeSelf];
            }];
        }
            break;
        case BAKit_PickerViewAnimationTypeRight:
        {
            [self.backView ba_animation_dismissFromPositionType:BAKit_ViewAnimationEnterDirectionTypeRitht duration:0.6f finishBlock:^{
                BAKit_StrongSelf
                self.isAnimating = NO;
                self.backView.alpha = 0.1f;
                [self ba_removeSelf];
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)ba_removeSelf
{
    if (self.toolBarView)
    {
        [self.toolBarView removeFromSuperview];
        self.toolBarView = nil;
    }
    
    if (self.backView)
    {
        [self.backView removeFromSuperview];
        self.backView = nil;
    }
    
    self.alertWindow = nil;
    [BAKit_NotiCenter removeObserver:self];
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self removeFromSuperview];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"触摸了边缘隐藏View！");
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    
    if (self.isAnimating)
    {
        NSLog(@"请在动画结束时点击！");
        return;
    }
    if (!self.isTouchEdgeHide)
    {
        NSLog(@"触摸了View边缘，但您未开启触摸边缘隐藏方法，请设置 isTouchEdgeHide 属性为 YES 后再使用！");
        return;
    }
    
    if ([view isKindOfClass:[self class]])
    {
        [self ba_pickViewHidden];
    }
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (tableView.tag)
    {
        case 0:
            return self.yearArray.count  + 4;
            break;
        case 1:
            return self.monthArray.count  + 4;
            break;
        case 2:
            return self.dayArray.count  + 4;
            break;
        case 3:
            return self.hourArray.count  + 4;
            break;
        case 4:
            return self.minuteArray.count  + 4;
            break;
        case 5:
            return self.secondArray.count  + 4;
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _cellHight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BACustomTabelViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BAKit_DatePickerCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [cell.contentView viewWithTag:100];
    if (!titleLabel)
    {
        titleLabel = [[UILabel alloc] initWithFrame:cell.bounds];
        titleLabel.tag = 100;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [cell.contentView addSubview:titleLabel];
    }
    
    titleLabel.frame = cell.contentView.bounds;
    titleLabel.textColor = self.ba_pickViewTextColor;
    
    NSArray * dataArray;
    NSString *defaultDateStr;
    switch (tableView.tag)
    {
        case 0:
        {
            dataArray = self.yearArray;
            defaultDateStr = [self.resoultDictionary objectForKey:@"year"];
        }
            break;
        case 1:
        {
            dataArray = self.monthArray;
            defaultDateStr = [self.resoultDictionary objectForKey:@"month"];
        }
            break;
        case 2:
        {
            dataArray = self.dayArray;
            defaultDateStr = [self.resoultDictionary objectForKey:@"day"];
        }
            break;
        case 3:
        {
            dataArray = self.hourArray;
            defaultDateStr = [self.resoultDictionary objectForKey:@"hour"];
        }
            break;
        case 4:
        {
            dataArray = self.minuteArray;
            defaultDateStr = [self.resoultDictionary objectForKey:@"minute"];
        }
            break;
        case 5:
        {
            dataArray = self.secondArray;
            defaultDateStr = [self.resoultDictionary objectForKey:@"seconds"];
        }
            break;
        default:
        {
            defaultDateStr = @"";
            dataArray = [NSMutableArray array];
        }
            break;
    }
    
    if (indexPath.row <2 || indexPath.row > dataArray.count + 1)
    {
        titleLabel.text = @"";
    }
    else
    {
        titleLabel.text = dataArray[indexPath.row - 2];
    }
    
    cell.indexPath = indexPath;
    [self changeLabelWithTabelView:tableView cell:cell];
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UITableView *table = (UITableView *)scrollView;
    NSArray *cells = table.visibleCells;
    [cells enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        BACustomTabelViewCell *cell = (BACustomTabelViewCell *)obj;
        [self changeLabelWithTabelView:table cell:cell];
    }];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self refreshSelectDateWith:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self refreshSelectDateWith:scrollView];
}

- (void)refreshSelectDateWith:(UIScrollView *)scrollView
{
    UITableView *table = (UITableView *)scrollView;
    NSArray * cells =   table.visibleCells;
    for (BACustomTabelViewCell *cell in cells) {
        UILabel *titleLabel = [cell.contentView viewWithTag:100];
        if (titleLabel.alpha == 1.0)
        {
            [table scrollToRowAtIndexPath:cell.indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            
            NSString *key = @"";
            switch (scrollView.tag) {
                case 0:
                    key = @"year";
                    break;
                case 1:
                    key = @"mounth";
                    break;
                case 2:
                    key = @"day";
                    break;
                case 3:
                    key = @"hour";
                    break;
                case 4:
                    key = @"minute";
                    break;
                case 5:
                    key = @"seconds";
                    break;
                default:
                    break;
            }
            
            if (!BAKit_stringIsBlank_pod(titleLabel.text))
            {
                [self.resoultDictionary setObject:titleLabel.text forKey:key];
                
                NSString *year = self.resoultDictionary[@"year"];
                NSString *mounth = self.resoultDictionary[@"mounth"];
                NSString *day = self.resoultDictionary[@"day"];
                NSString *hour = self.resoultDictionary[@"hour"];
                NSString *minute = self.resoultDictionary[@"minute"];
                
                if ([key isEqualToString:@"year"])
                {
                    [self refreshMonthIsMaxYearState:[year isEqualToString:[self.yearArray lastObject]] MinYear:[year isEqualToString:self.yearArray[0]]];
                    [self refreshSelectDateWithTableViewTag:1];
                }
                if ([key isEqualToString:@"year"] || [key isEqualToString:@"mounth"])
                {
                    [self refreshDayIsMaxMonthState:([year isEqualToString:[self.yearArray lastObject]] && [mounth isEqualToString:[self.monthArray lastObject]]) MinMonth:([year isEqualToString:self.yearArray[0]] && [mounth isEqualToString:self.monthArray[0]])];
                    [self refreshSelectDateWithTableViewTag:2];
                }
                 if ([key isEqualToString:@"year"] || [key isEqualToString:@"mounth"] || [key isEqualToString:@"day"])
                {
                    [self refreshHourIsMaxDayState:([year isEqualToString:[self.yearArray lastObject]] && [mounth isEqualToString:[self.monthArray lastObject]] && [day isEqualToString:[self.dayArray lastObject]]) MinDay:([year isEqualToString:self.yearArray[0]] && [mounth isEqualToString:self.monthArray[0]] && [day isEqualToString:self.dayArray[0]])];
                    [self refreshSelectDateWithTableViewTag:3];
                }
                if ([key isEqualToString:@"year"] || [key isEqualToString:@"mounth"] || [key isEqualToString:@"day"] || [key isEqualToString:@"hour"])
                {
                    [self refreshMinuteIsMaxHourState:([year isEqualToString:[self.yearArray lastObject]] && [mounth isEqualToString:[self.monthArray lastObject]] && [day isEqualToString:[self.dayArray lastObject]]&& [hour isEqualToString:[self.hourArray lastObject]]) MinHour:([year isEqualToString:self.yearArray[0]] && [mounth isEqualToString:self.monthArray[0]] && [day isEqualToString:self.dayArray[0]]&& [hour isEqualToString:self.hourArray[0]])];
                    [self refreshSelectDateWithTableViewTag:4];
                }
                if (![key isEqualToString:@"seconds"])
                {
                    [self refreshSecondsIsMaxMinuteState:([year isEqualToString:[self.yearArray lastObject]] && [mounth isEqualToString:[self.monthArray lastObject]] && [day isEqualToString:[self.dayArray lastObject]]&& [hour isEqualToString:[self.hourArray lastObject]] && [minute isEqualToString:[self.minuteArray lastObject]]) MinMinute:([year isEqualToString:self.yearArray[0]] && [mounth isEqualToString:self.monthArray[0]] && [day isEqualToString:self.dayArray[0]]&& [hour isEqualToString:self.hourArray[0]] && [minute isEqualToString:self.minuteArray[0]])];
                    [self refreshSelectDateWithTableViewTag:5];
                }
            }
        }
    }
    self.contentTitleLabel.text = [self selectedTitmeResults];
}
- (void)refreshSelectDateWithTableViewTag:(NSInteger)tag {
    
    UITableView *table = [self.backView viewWithTag:tag];
    NSArray * cells =   table.visibleCells;
    for (BACustomTabelViewCell *cell in cells) {
        UILabel *titleLabel = [cell.contentView viewWithTag:100];
        if (titleLabel.alpha == 1.0)
        {
            [table scrollToRowAtIndexPath:cell.indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            
            NSString *key = @"";
            switch (table.tag) {
                case 0:
                    key = @"year";
                    break;
                case 1:
                    key = @"mounth";
                    break;
                case 2:
                    key = @"day";
                    break;
                case 3:
                    key = @"hour";
                    break;
                case 4:
                    key = @"minute";
                    break;
                case 5:
                    key = @"seconds";
                    break;
                default:
                    break;
            }
            
            if (!BAKit_stringIsBlank_pod(titleLabel.text))
            {
                [self.resoultDictionary setObject:titleLabel.text forKey:key];
            }
        }
    }
}

/**
 改变字体选中和非选中是的大小和透明度
 */
- (void)changeLabelWithTabelView:(UITableView *)tableView cell:(BACustomTabelViewCell *)cell
{
    
    CGRect rect = [tableView rectForRowAtIndexPath:cell.indexPath];
    CGRect viewRect = [tableView convertRect:rect toView:self.backView];
    
    CGFloat minY = tableView.center.y - _cellHight / 2.0 ;
    CGFloat maxY = tableView.center.y + _cellHight / 2.0 ;
    
    
    CGFloat cellY = viewRect.origin.y + viewRect.size.height / 2.0 ;
    UILabel *titleLabel = [cell.contentView viewWithTag:100];
    
    if (maxY > cellY && minY < cellY)
    {
        titleLabel.alpha = 1;
        
        UIFont *selectFont = [UIFont fontWithName:self.ba_pickViewFont.fontName size:self.ba_pickViewFont.pointSize + 5];
        titleLabel.font = selectFont;
    }
    else
    {
        titleLabel.font = self.ba_pickViewFont;
        titleLabel.alpha = 0.5;
    }
}

#pragma mark - customButton
- (void)handleButtonAction:(UIButton *)button
{
    if (button.tag == 1001)
    {
        self.resultBlock([self selectedTitmeResults]);
    }
    [self ba_pickViewHiddenAnimation];
}
- (NSString *)selectedTitmeResults
{
    // 确定
    NSString *resoultDateStr = @"";
    
    NSString *year = self.resoultDictionary[@"year"];
    if ([year containsString:@"年"])
    {
        year = [year substringToIndex:year.length - 1];
        self.bgShowYearLabel.text = year;
    }
    
    NSString *mouth = self.resoultDictionary[@"mounth"];
    if ([mouth containsString:@"月"])
    {
        mouth = [mouth substringToIndex:mouth.length - 1];
    }
    
    NSString *day = self.resoultDictionary[@"day"];
    if ([day containsString:@"日"])
    {
        day = [day substringToIndex:day.length - 1];
    }
    
    NSString *hour = self.resoultDictionary[@"hour"];
    if ([hour containsString:@"时"])
    {
        hour = [hour substringToIndex:hour.length - 1];
    }
    
    NSString *minute = self.resoultDictionary[@"minute"];
    if ([minute containsString:@"分"])
    {
        minute = [minute substringToIndex:minute.length - 1];
    }
    
    NSString *seconds = self.resoultDictionary[@"seconds"];
    if ([seconds containsString:@"秒"])
    {
        seconds = [seconds substringToIndex:seconds.length - 1];
    }
    
    switch (self.pickerViewType) {
        case BAKit_CustomDatePickerDateTypeYY:
        {
            resoultDateStr = [NSString stringWithFormat:@"%@",year];
        }
            break;
        case BAKit_CustomDatePickerDateTypeYM:
        {
            resoultDateStr = [NSString stringWithFormat:@"%@-%@",year,mouth];
        }
            break;
        case BAKit_CustomDatePickerDateTypeYMD:
        {
            resoultDateStr = [NSString stringWithFormat:@"%@-%@-%@",year,mouth,day];
        }
            break;
        case BAKit_CustomDatePickerDateTypeYMDHM:
        {
            resoultDateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,mouth,day,hour,minute];
        }
            break;
        case BAKit_CustomDatePickerDateTypeYMDHMS:
        {
            resoultDateStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@:%@",year,mouth,day,hour,minute,seconds];
        }
            break;
            
        case BAKit_CustomDatePickerDateTypeHM:
        {
            resoultDateStr = [NSString stringWithFormat:@"%@:%@",hour,minute];
        }
            break;
        case BAKit_CustomDatePickerDateTypeMD:
        {
            resoultDateStr = [NSString stringWithFormat:@"%@-%@",mouth,day];
        }
            break;
        case BAKit_CustomDatePickerDateTypeHMS:
        {
            resoultDateStr = [NSString stringWithFormat:@"%@:%@:%@",hour,minute,seconds];
        }
            break;
            
        default:
            break;
    }
    return resoultDateStr;
}
#pragma mark 计算出当月有多少天
- (void)refreshSecondsIsMaxMinuteState:(BOOL)maxState MinMinute:(BOOL)minState
{
    NSInteger min = 0;
    NSInteger max = 59;
    if (maxState == YES)
    {
        max = self.maxDate.second;
    }
    if (minState == YES)
    {
        min = self.minDate.second;
    }
    [self.secondArray removeAllObjects];
    for (NSInteger i = min; i < max+1; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%02li秒",(long)i];
        [self.secondArray addObject:str];
    }
    [self setSelectDate:@"seconds"];
    [self.secondTableView reloadData];
}

- (void)refreshMinuteIsMaxHourState:(BOOL)maxState MinHour:(BOOL)minState
{
    NSInteger min = 0;
    NSInteger max = 59;
    if (maxState == YES)
    {
        max = self.maxDate.minute;
    }
    if (minState == YES)
    {
        min = self.minDate.minute;
    }
    [self.minuteArray removeAllObjects];
    for (NSInteger i = min; i < max+1; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%02li分",(long)i];
        [self.minuteArray addObject:str];
    }
    [self setSelectDate:@"minute"];
    [self.minuteTableView reloadData];
}

- (void)refreshHourIsMaxDayState:(BOOL)maxState MinDay:(BOOL)minState
{
    NSInteger min = 0;
    NSInteger max = 23;
    if (maxState == YES)
    {
        max = self.maxDate.hour;
    }
    if (minState == YES)
    {
        min = self.minDate.hour;
    }
    [self.hourArray removeAllObjects];
    for (NSInteger i = min; i < max+1; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%02li时",(long)i];
        [self.hourArray addObject:str];
    }
    [self setSelectDate:@"hour"];
    [self.hourTableView reloadData];
}
- (void)refreshDayIsMaxMonthState:(BOOL)maxState MinMonth:(BOOL)minState
{
    NSString *year = self.resoultDictionary[@"year"];
    if ([year containsString:@"年"])
    {
        year = [year substringToIndex:year.length - 1];
    }
    NSString *mounth = self.resoultDictionary[@"mounth"];
    if ([mounth containsString:@"月"])
    {
        mounth = [mounth substringToIndex:mounth.length - 1];
    }
    
    NSString * dateStr = [NSString stringWithFormat:@"%@-%@",year,mounth];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM"];
    NSDate * date = [formatter dateFromString:dateStr];
    
    NSInteger min = 1;
    NSInteger max =  [self ba_totaldaysInMonth:date];
    
    if (maxState == YES)
    {
        max = self.maxDate.day;
    }
    if (minState == YES)
    {
        min = self.minDate.day;
    }
    
    [self.dayArray removeAllObjects];
    for (NSInteger i = min; i < max+1; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%02li日",(long)i];
        [self.dayArray addObject:str];
    }
    [self setSelectDate:@"day"];
    [self.dayTableView reloadData];
    
}

- (void)refreshMonthIsMaxYearState:(BOOL)maxState MinYear:(BOOL)minState
{
    NSInteger min = 1;
    NSInteger max = 12;
    if (maxState == YES)
    {
        max = self.maxDate.month;
    }
    if (minState == YES)
    {
        min = self.minDate.month;
    }
    [self.monthArray removeAllObjects];
    for (NSInteger i = min; i < max+1; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%02li月",(long)i];
        [self.monthArray addObject:str];
    }
    [self setSelectDate:@"mounth"];
    [self.monthTableView reloadData];
}

- (void)refreshYear
{
    [self.yearArray removeAllObjects];
    for (NSInteger i = self.minDate.year; i < self.maxDate.year+1; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%ld年",(long)i];
        [_yearArray addObject:str];
    }
    [self setSelectDate:@"year"];
}

- (void)refreshAllTime
{
    [self refreshYear];
    [self refreshMonthIsMaxYearState:self.maxDate.year <= self.defautDate.year MinYear:self.minDate.year == self.defautDate.year];
    [self refreshDayIsMaxMonthState:(self.maxDate.year <= self.defautDate.year && self.maxDate.month <= self.defautDate.month) MinMonth:(self.minDate.year == self.defautDate.year && self.minDate.month >= self.defautDate.month)];
    [self refreshHourIsMaxDayState:(self.maxDate.year <= self.defautDate.year && self.maxDate.month <= self.defautDate.month && self.maxDate.day <= self.defautDate.day) MinDay:(self.minDate.year == self.defautDate.year && self.minDate.month >= self.defautDate.month && self.minDate.day >= self.defautDate.day)];
    [self refreshMinuteIsMaxHourState:(self.maxDate.year <= self.defautDate.year && self.maxDate.month <= self.defautDate.month && self.maxDate.day <= self.defautDate.day && self.maxDate.hour <= self.defautDate.hour) MinHour:(self.minDate.year == self.defautDate.year && self.minDate.month >= self.defautDate.month && self.minDate.day >= self.defautDate.day && self.minDate.hour >= self.defautDate.hour)];
    [self refreshSecondsIsMaxMinuteState:(self.maxDate.year <= self.defautDate.year && self.maxDate.month <= self.defautDate.month && self.maxDate.day <= self.defautDate.day && self.maxDate.hour <= self.defautDate.hour && self.maxDate.minute <= self.defautDate.minute) MinMinute:(self.minDate.year == self.defautDate.year && self.minDate.month >= self.defautDate.month && self.minDate.day >= self.defautDate.day && self.minDate.hour >= self.defautDate.hour && self.minDate.minute >= self.defautDate.minute)];
}

- (void)setSelectDate:(NSString *)typeKey
{
    BAKit_WeakSelf
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.05 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        BAKit_StrongSelf
        NSString *defaultDateStr = [self.resoultDictionary objectForKey:typeKey];
        NSArray *dataArray;
        UITableView *tableView;
        if ([typeKey isEqualToString:@"year"]) {
            dataArray = self.yearArray;
            tableView = self.yearTableView;
        }else if ([typeKey isEqualToString:@"mounth"]){
            dataArray = self.monthArray;
            tableView = self.monthTableView;
        }else if ([typeKey isEqualToString:@"day"]){
            dataArray = self.dayArray;
            tableView = self.dayTableView;
        }else if ([typeKey isEqualToString:@"hour"]){
            dataArray = self.hourArray;
            tableView = self.hourTableView;
        }else if ([typeKey isEqualToString:@"minute"]){
            dataArray = self.minuteArray;
            tableView = self.minuteTableView;
        }else if ([typeKey isEqualToString:@"seconds"]){
            dataArray = self.secondArray;
            tableView = self.secondTableView;
        }
        
        NSInteger index = [dataArray indexOfObject:defaultDateStr];
        
        if (index < dataArray.count && index > 0)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index + 2 inSection:0];
            [tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:NO];
        }
    });
}

- (NSInteger)ba_totaldaysInMonth:(NSDate *)date
{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

- (void)refreshDayDefautDate
{
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%ld年",(long)self.defautDate.year] forKey:@"year"];
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%02li月",(long)self.defautDate.month] forKey:@"mounth"];
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%02li日",(long)self.defautDate.day] forKey:@"day"];
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%02li时",(long)self.defautDate.hour] forKey:@"hour"];
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%02li分",(long)self.defautDate.minute] forKey:@"minute"];
    [_resoultDictionary setObject:[NSString stringWithFormat:@"%02li秒",(long)self.defautDate.second] forKey:@"seconds"];
}

#pragma mark - setter / getter
- (void)setBa_maxDate:(NSDate *)ba_maxDate {
    _ba_maxDate = ba_maxDate;
    if ([_ba_maxDate ba_dateTimeIntervalSince1970InMilliSecond] < [self.defautDate ba_dateTimeIntervalSince1970InMilliSecond])
    {
        NSLog(@"最大时间小于默认选中时间,最大时间为默认选中时间");
        self.defautDate = _ba_maxDate;
    }
    self.maxDate = _ba_maxDate;
    [self refreshAllTime];
}

- (void)setBa_minDate:(NSDate *)ba_minDate {
    _ba_minDate = ba_minDate;
    if ([_ba_minDate ba_dateTimeIntervalSince1970InMilliSecond] > [self.defautDate ba_dateTimeIntervalSince1970InMilliSecond])
    {
        NSLog(@"最小时间大于默认选中时间,最小时间为默认选中时间");
        self.defautDate = _ba_minDate;
    }
    self.minDate = _ba_minDate;
    [self refreshAllTime];
}

- (void)setBa_defautDate:(NSDate *)ba_defautDate
{
    _ba_defautDate = ba_defautDate;
    self.defautDate = _ba_defautDate;
    [self refreshDayDefautDate];
    [self refreshAllTime];
}

// 存放滑动中选择的当前选中日期
- (NSMutableDictionary *)resoultDictionary
{
    if (!_resoultDictionary)
    {
        _resoultDictionary = [NSMutableDictionary dictionary];
        [self refreshDayDefautDate];
    }
    return _resoultDictionary;
}

// 创建每个分区日期选择器
- (UITableView *)yearTableView
{
    if (!_yearTableView)
    {
        _yearTableView = [self ba_creatTableView];
        _yearTableView.tag = 0;
        [self.backView addSubview:_yearTableView];
    }
    return _yearTableView;
}

- (UITableView *)ba_creatTableView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.separatorInset = UIEdgeInsetsMake(tableView.separatorInset.top, 0, tableView.separatorInset.bottom, 0);
    
    return tableView;
}

- (UITableView *)monthTableView
{
    if (!_monthTableView)
    {
        _monthTableView = [self ba_creatTableView];
        _monthTableView.tag = 1;
        
        [self.backView addSubview:_monthTableView];
    }
    return _monthTableView;
}

- (UITableView *)dayTableView
{
    if (!_dayTableView) {
        _dayTableView = [self ba_creatTableView];
        _dayTableView.tag = 2;
        
        [self.backView addSubview:_dayTableView];
    }
    return _dayTableView;
}

- (UITableView *)hourTableView{
    if (!_hourTableView) {
        _hourTableView = [self ba_creatTableView];
        _hourTableView.tag = 3;
        
        [self.backView addSubview:_hourTableView];
    }
    return _hourTableView;
}

- (UITableView *)minuteTableView{
    if (!_minuteTableView) {
        _minuteTableView = [self ba_creatTableView];
        _minuteTableView.tag = 4;
        
        [self.backView addSubview:_minuteTableView];
    }
    return _minuteTableView;
}

- (UITableView *)secondTableView{
    if (!_secondTableView) {
        _secondTableView = [self ba_creatTableView];
        _secondTableView.tag = 5;
        
        [self.backView addSubview:_secondTableView];
    }
    return _secondTableView;
}

- (UILabel *)bgShowYearLabel {
    if (!_bgShowYearLabel) {
        _bgShowYearLabel = [[UILabel alloc] init];
        _bgShowYearLabel.font = [UIFont systemFontOfSize:100];
        _bgShowYearLabel.textAlignment = NSTextAlignmentCenter;
        [self.backView addSubview:_bgShowYearLabel];
        _bgShowYearLabel.text = [NSString stringWithFormat:@"%ld",self.defautDate.year];
    }
    return _bgShowYearLabel;
}


// 初始化日期数据
- (NSDate *)defautDate {
    if (!_defautDate) {
        _defautDate = BAKit_Current_Date;
    }
    return _defautDate;
}

- (NSDate *)maxDate {
    if (!_maxDate) {
        _maxDate = self.defautDate;
    }
    return _maxDate;
}

- (NSDate *)minDate {
    if (!_minDate) {
        NSString *string = @"1970-01-01 00:00:00";
        NSDateFormatter *fmt = [NSDateFormatter ba_setupDateFormatterWithYMDHMS];
        _minDate = [fmt dateFromString:string];
    }
    return _minDate;
}
- (NSMutableArray *)yearArray
{
    if (!_yearArray)
    {
        _yearArray = [NSMutableArray array];
        
        [self refreshYear];
    }
    return _yearArray;
}

- (NSMutableArray *)monthArray
{
    if (!_monthArray) {
        _monthArray = [NSMutableArray array];
        [self refreshMonthIsMaxYearState:YES MinYear:NO];
    }
    return _monthArray;
}

- (NSMutableArray *)dayArray{
    if (!_dayArray) {
        _dayArray = [NSMutableArray array];
        [self refreshDayIsMaxMonthState:YES MinMonth:NO];
    }
    return _dayArray;
}

- (NSMutableArray *)hourArray{
    if (!_hourArray) {
        _hourArray = [NSMutableArray array];
        [self refreshHourIsMaxDayState:YES MinDay:NO];
    }
    return _hourArray;
}

- (NSMutableArray *)minuteArray{
    if (!_minuteArray) {
        _minuteArray = [NSMutableArray array];
        [self refreshMinuteIsMaxHourState:YES MinHour:NO];
    }
    return _minuteArray;
}

- (NSMutableArray *)secondArray{
    if (!_secondArray) {
        _secondArray = [NSMutableArray array];
        [self refreshSecondsIsMaxMinuteState:YES MinMinute:NO];
    }
    return _secondArray;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
        
        [self addSubview:_backView];
    }
    return _backView;
}

// 添加选中日期的分割线
- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc]init];
        _topLine.backgroundColor = BAKit_Color_Gray_9_pod;
        [self.backView addSubview:_topLine];
    }
    return _topLine;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [[UIView alloc]init];
        _bottomLine.backgroundColor = BAKit_Color_Gray_9_pod;
        
        [self.backView addSubview:_bottomLine];
    }
    return _bottomLine;
}

// 添加 取消和确定按钮的背景View
- (UIView *)toolBarView {
    if (!_toolBarView) {
        _toolBarView = [[UIView alloc]init];
        _toolBarView.backgroundColor = BAKit_Color_Gray_11_pod;
        [self.backView addSubview:_toolBarView];
    }
    return _toolBarView;
}

- (UIButton *)cancleButton
{
    if (!_cancleButton)
    {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [self.cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.cancleButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.cancleButton.tag = 1000;
        [self.toolBarView addSubview:self.cancleButton];
    }
    return _cancleButton;
}

- (UIButton *)sureButton
{
    if (!_sureButton)
    {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [self.sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.sureButton addTarget:self action:@selector(handleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        self.sureButton.tag = 1001;
        [self.toolBarView addSubview:self.sureButton];
    }
    return _sureButton;
}

- (UIWindow *)alertWindow
{
    if (!_alertWindow)
    {
        _alertWindow = [UIApplication sharedApplication].keyWindow;
        
        if (self.alertWindow.windowLevel != UIWindowLevelNormal)
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"windowLevel == %ld AND hidden == 0 " , UIWindowLevelNormal];
            self.alertWindow = [[UIApplication sharedApplication].windows filteredArrayUsingPredicate:predicate].firstObject;
        }
        self.alertWindow.backgroundColor = BAKit_Color_Translucent_pod;
    }
    return _alertWindow;
}

- (UILabel *)contentTitleLabel {
    if (!_contentTitleLabel)
    {
        _contentTitleLabel = [[UILabel alloc] init];
        _contentTitleLabel.font = [UIFont systemFontOfSize:15];
        _contentTitleLabel.textAlignment = NSTextAlignmentCenter;
        _contentTitleLabel.textColor = [UIColor blackColor];
        _contentTitleLabel.text = [self selectedTitmeResults];
        [self.toolBarView addSubview:_contentTitleLabel];
    }
    return _contentTitleLabel;
}

- (void)setBa_backgroundColor_toolBar:(UIColor *)ba_backgroundColor_toolBar
{
    _ba_backgroundColor_toolBar = ba_backgroundColor_toolBar;
    self.toolBarView.backgroundColor = ba_backgroundColor_toolBar;
}

- (void)setBa_backgroundColor_pickView:(UIColor *)ba_backgroundColor_pickView
{
    _ba_backgroundColor_pickView = ba_backgroundColor_pickView;
    self.backView.backgroundColor = ba_backgroundColor_pickView;
}

- (void)setBa_buttonTitleColor_cancle:(UIColor *)ba_buttonTitleColor_cancle
{
    _ba_buttonTitleColor_cancle = ba_buttonTitleColor_cancle;
    [self.cancleButton setTitleColor:ba_buttonTitleColor_cancle forState:UIControlStateNormal];
}

- (void)setBa_buttonTitleColor_sure:(UIColor *)ba_buttonTitleColor_sure
{
    _ba_buttonTitleColor_sure = ba_buttonTitleColor_sure;
    [self.sureButton setTitleColor:ba_buttonTitleColor_sure forState:UIControlStateNormal];
}

- (void)setBa_pickViewFont:(UIFont *)ba_pickViewFont
{
    _ba_pickViewFont = ba_pickViewFont;
}

- (void)setIsShowTitle:(BOOL)isShowTitle
{
    _isShowTitle = isShowTitle;
    if (_isShowTitle == YES)
    {
        self.contentTitleLabel.hidden = NO;
    }
    else
    {
        self.contentTitleLabel.hidden = YES;
    }
}

- (void)setBa_pickViewTitleFont:(UIFont *)ba_pickViewTitleFont
{
    _ba_pickViewTitleFont = ba_pickViewTitleFont;
    
    self.contentTitleLabel.font = ba_pickViewTitleFont;
}

- (void)setBa_pickViewTitleColor:(UIColor *)ba_pickViewTitleColor
{
    _ba_pickViewTitleColor = ba_pickViewTitleColor;
    self.contentTitleLabel.textColor = ba_pickViewTitleColor;
}

- (void)setBa_bgYearTitleFont:(UIFont *)ba_bgYearTitleFont {
    _ba_bgYearTitleFont = ba_bgYearTitleFont;
    self.bgShowYearLabel.font = _ba_bgYearTitleFont;
}

- (void)setBa_bgYearTitleColor:(UIColor *)ba_bgYearTitleColor {
    _ba_bgYearTitleColor = ba_bgYearTitleColor;
    self.bgShowYearLabel.textColor = _ba_bgYearTitleColor;
}

- (void)setBa_pickViewTextColor:(UIColor *)ba_pickViewTextColor
{
    _ba_pickViewTextColor = ba_pickViewTextColor;
}

- (void)setIsShowBackgroundYearLabel:(BOOL)isShowBackgroundYearLabel
{
    _isShowBackgroundYearLabel = isShowBackgroundYearLabel;
    
    if (_isShowBackgroundYearLabel == YES)
    {
        self.bgShowYearLabel.hidden = NO;
    }
    else
    {
        self.bgShowYearLabel.hidden = YES;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self.yearTableView reloadData];
    [self.monthTableView reloadData];
    [self.dayTableView reloadData];
    [self.hourTableView reloadData];
    [self.minuteTableView reloadData];
    [self.secondTableView reloadData];

}

- (void)ba_layoutSubViews
{
    self.frame = [UIScreen mainScreen].bounds;
    self.alertWindow.frame = self.window.bounds;
    
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    
    CGFloat min_view_w = CGRectGetWidth(self.frame);
    CGFloat min_view_h = CGRectGetHeight(self.frame);
    
    self.backgroundColor = BAKit_Color_Translucent_pod;
    
    min_x = BAKit_ViewSafeAreaInsets(self).left;
    min_y = min_view_h - BAKit_Default_Height - BAKit_ViewSafeAreaInsets(self).bottom;
    min_h = BAKit_Default_Height;
    min_w = min_view_w - BAKit_ViewSafeAreaInsets(self).left - BAKit_ViewSafeAreaInsets(self).right;
    if (self.pickerViewPositionType == BAKit_PickerViewPositionTypeCenter)
    {
        min_w = 280 * BAKit_ScaleXAndWidth;
    }
    self.backView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    CGFloat min_bgView_w = CGRectGetWidth(self.backView.frame);
    CGFloat min_bgView_h = CGRectGetHeight(self.backView.frame);
    
    if (self.pickerViewPositionType == BAKit_PickerViewPositionTypeCenter)
    {
        self.backView.center = self.center;
        [self.backView ba_view_setViewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:10];
    }
    
    _cellHight = (min_bgView_h - 40) / 5.0;
    
    CGFloat min_line_y = 0;
    
    min_x = 0;
    min_h = 40;
    min_w = min_bgView_w;
    
    CGFloat min_picker_y = 0;
    if (self.buttonPositionType == BAKit_PickerViewButtonPositionTypeNormal)
    {
        min_y = 0;
        min_picker_y = 40;
        min_line_y = min_bgView_h / 2.0 + min_picker_y / 2.0 - _cellHight / 2.0;
    }
    else
    {
        min_picker_y = 0;
        min_line_y = CGRectGetHeight(self.backView.frame)/2.0 - 20 - _cellHight / 2.0;
        min_y = min_bgView_h - min_h;
    }
    self.toolBarView.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 0;
    min_y = min_line_y;
    min_w = min_bgView_w;
    min_h = 0.5;
    self.topLine.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_y = min_line_y + self.cellHight;
    self.bottomLine.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 20;
    min_y = 0;
    min_w = 50;
    min_h = 40;
    self.cancleButton.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = CGRectGetWidth(self.toolBarView.frame) - min_w - 20;
    self.sureButton.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 20 + min_w + 10;
    min_w = CGRectGetMaxX(self.sureButton.frame) - CGRectGetMaxX(self.cancleButton.frame) - 50 - 20;
    self.contentTitleLabel.frame = CGRectMake(min_x, min_y, min_w, min_h);
    
    min_x = 0;
    min_y = min_picker_y;
    min_h = min_bgView_h - 40;
    
    self.bgShowYearLabel.frame = CGRectMake(min_x, min_y, min_bgView_w, min_h);
    
    switch (self.pickerViewType) {
        case BAKit_CustomDatePickerDateTypeYY:
        {
            min_w = min_bgView_w;
            self.yearTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
        }
            break;
        case BAKit_CustomDatePickerDateTypeYM:
        {
            min_w = min_bgView_w / 2.0;
            self.yearTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            min_x = CGRectGetMaxX(self.yearTableView.frame);
            self.monthTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
        }
            break;
        case BAKit_CustomDatePickerDateTypeYMD:
        {
            min_w = min_bgView_w / 3.0;
            self.yearTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            min_x = CGRectGetMaxX(self.yearTableView.frame);
            self.monthTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            min_x = CGRectGetMaxX(self.monthTableView.frame);
            self.dayTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
        }
            break;
        case BAKit_CustomDatePickerDateTypeYMDHM:
        {
            min_w = min_bgView_w / 5.0;
            self.yearTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            min_x = min_w;
            self.monthTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);

            min_x = min_w * 2;
            self.dayTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);

            min_x = min_w * 3;
            self.hourTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);

            min_x = min_w * 4;
            self.minuteTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);

        }
            break;
        case BAKit_CustomDatePickerDateTypeYMDHMS:
        {
            min_w = 1.5 * min_bgView_w / 6;
            self.yearTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            
            min_w = 0.9 * min_bgView_w / 6;
            min_x = CGRectGetMaxX(self.yearTableView.frame);
            self.monthTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            
            min_x = CGRectGetMaxX(self.monthTableView.frame);
            self.dayTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            
            min_x = CGRectGetMaxX(self.dayTableView.frame);
            self.hourTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            
            min_x = CGRectGetMaxX(self.hourTableView.frame);
            self.minuteTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            
            min_x = CGRectGetMaxX(self.minuteTableView.frame);
            self.secondTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
        }
            break;
        case BAKit_CustomDatePickerDateTypeHM:
        {
            min_w = min_bgView_w / 2.0;
            min_x = 0;
            self.hourTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            
            min_x = CGRectGetMaxX(self.hourTableView.frame);
            self.minuteTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
        }
            break;
        case BAKit_CustomDatePickerDateTypeMD:
        {
            min_w = min_bgView_w / 2.0;
            self.monthTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            
            min_x = CGRectGetMaxX(self.monthTableView.frame);
            self.dayTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
        }
            break;
            
        case BAKit_CustomDatePickerDateTypeHMS:
        {
            min_w = min_bgView_w / 3.0;
            self.hourTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            
            min_x = CGRectGetMaxX(self.hourTableView.frame);
            self.minuteTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
            
            min_x = CGRectGetMaxX(self.minuteTableView.frame);
            self.secondTableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
        }
            break;
        default:
            break;
    }
    [self setSelectDate:@"seconds"];
    [self setSelectDate:@"minute"];
    [self setSelectDate:@"hour"];
    [self setSelectDate:@"day"];
    [self setSelectDate:@"mounth"];
    [self setSelectDate:@"year"];
}

@end

@implementation BACustomTabelViewCell

@synthesize indexPath;

@end
