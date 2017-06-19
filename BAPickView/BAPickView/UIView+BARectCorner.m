//
//  UIView+BARectCorner.m
//  BAKit
//
//  Created by boai on 2017/6/6.
//  Copyright © 2017年 BAHome. All rights reserved.
//

#import "UIView+BARectCorner.h"
#import "BAKit_ConfigurationDefine.h"

@implementation UIView (BARectCorner)

- (void)ba_view_setViewRectCornerType:(BAKit_ViewRectCornerType)type viewCornerRadius:(CGFloat)viewCornerRadius
{
    self.viewCornerRadius = viewCornerRadius;
    self.viewRectCornerType = type;
}

#pragma mark - view 的 角半径，默认 CGSizeMake(0, 0)
- (void)setupButtonCornerType
{
    UIRectCorner corners;
    CGSize cornerRadii;
    
    cornerRadii = CGSizeMake(self.viewCornerRadius, self.viewCornerRadius);
    if (self.viewCornerRadius == 0)
    {
        cornerRadii = CGSizeMake(0, 0);
    }
    
    switch (self.viewRectCornerType)
    {
        case BAKit_ViewRectCornerTypeBottomLeft:
        {
            corners = UIRectCornerBottomLeft;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomRight:
        {
            corners = UIRectCornerBottomRight;
        }
            break;
        case BAKit_ViewRectCornerTypeTopLeft:
        {
            corners = UIRectCornerTopLeft;
        }
            break;
        case BAKit_ViewRectCornerTypeTopRight:
        {
            corners = UIRectCornerTopRight;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomLeftAndBottomRight:
        {
            corners = UIRectCornerBottomLeft | UIRectCornerBottomRight;
        }
            break;
        case BAKit_ViewRectCornerTypeTopLeftAndTopRight:
        {
            corners = UIRectCornerTopLeft | UIRectCornerTopRight;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomLeftAndTopLeft:
        {
            corners = UIRectCornerBottomLeft | UIRectCornerTopLeft;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomRightAndTopRight:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomRightAndTopRightAndTopLeft:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerTopLeft;
        }
            break;
        case BAKit_ViewRectCornerTypeBottomRightAndTopRightAndBottomLeft:
        {
            corners = UIRectCornerBottomRight | UIRectCornerTopRight | UIRectCornerBottomLeft;
        }
            break;
        case BAKit_ViewRectCornerTypeAllCorners:
        {
            corners = UIRectCornerAllCorners;
        }
            break;
            
        default:
            break;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame         = self.bounds;
    maskLayer.path          = maskPath.CGPath;
    self.layer.mask         = maskLayer;
}

#pragma mark - setter / getter

- (void)setViewRectCornerType:(BAKit_ViewRectCornerType)viewRectCornerType
{
    BAKit_Objc_setObj(@selector(viewRectCornerType), @(viewRectCornerType));
    [self setupButtonCornerType];
}

- (BAKit_ViewRectCornerType)viewRectCornerType
{
    return [BAKit_Objc_getObj integerValue];
}

- (void)setViewCornerRadius:(CGFloat)viewCornerRadius
{
    BAKit_Objc_setObj(@selector(viewCornerRadius), @(viewCornerRadius));
}

- (CGFloat)viewCornerRadius
{
    return [BAKit_Objc_getObj integerValue];
}

@end
