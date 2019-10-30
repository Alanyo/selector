//
//  SZXCircularMenu.h
//  SectorMenu
//
//  Created by Alan_yo on 17/4/20.
//  Copyright © 2017年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SZXCircularMenu : UIControl

// Angles in degrees
@property (nonatomic, assign) float angleFrom, angleTo;

// 半径
@property (nonatomic, assign) float radius, iconRadius, textRadius;;

// 中心
@property (nonatomic, assign) CGPoint menuCenter;

// 填充颜色
@property (nonatomic, strong) UIColor *upColor;

// 图片
@property (nonatomic, copy) NSString *iconView;

@property (nonatomic, copy) NSString *imageType;
// 文字
@property (nonatomic, copy) NSString *text;

// 調整文字 xAndy
@property (nonatomic, assign) BOOL textX, textY;

// 选中状态
@property (nonatomic, assign) BOOL isSelected;

// 显示选中文字
@property (nonatomic, copy) NSString *selectedTitle;

- (BOOL)hitInside:(CGPoint)point;

@end
