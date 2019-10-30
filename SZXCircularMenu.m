//
//  SZXCircularMenu.m
//  SectorMenu
//
//  Created by Alan_yo on 17/4/20.
//  Copyright © 2017年 easy. All rights reserved.
//

#import "SZXCircularMenu.h"
#import <QuartzCore/QuartzCore.h>
#import "UIView+MenuLayout.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface SZXCircularMenu ()
{
    UIFont *_font;
    UIImageView *_imageExchange;
    UIImageView *_imageMeeting;
    UIImageView *_imageQr;
    UIImageView *_imageCards;
    UIImageView *_imageContact;
    UILabel *_labelExchange;
    UILabel *_labelMeeting;
    UILabel *_labelQr;
    UILabel *_labelCards;
    UILabel *_labelContact;
}
@end

@implementation SZXCircularMenu

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _font                = [UIFont systemFontOfSize:14];
        
    }
    return self;
}

// 根据 type 值来创建对应的 imageView
- (void)setImageType:(NSString *)imageType {
    
    _imageType = imageType;
 
    // 获取对应的偏移值
    NSArray *pointArr = [self fanPointsCalculationLongY:(self.width * 0.5) * 0.5];
    
    switch ([imageType integerValue]) {
        case 0:
            
            // 群众交流
            _imageExchange = [self createImageView:_imageExchange point:[pointArr[0] CGPointValue]];
            _labelExchange = [self createLabel:_labelExchange     point:[pointArr[0] CGPointValue] string:Localized(@"exchange_collective")];
            
            [self addSubview:_imageExchange];
            [self addSubview:_labelExchange];
            break;
        case 1:
            
            // 二人交流
            _imageMeeting = [self createImageView:_imageMeeting point:[pointArr[1] CGPointValue]];
            _labelMeeting = [self createLabel:_labelMeeting     point:[pointArr[1] CGPointValue] string:Localized(@"exchange_private")];
            
            [self addSubview:_imageMeeting];
            [self addSubview:_labelMeeting];
            break;
        case 2:
            
            // 二维码
            _imageQr = [self createImageView:_imageQr point:[pointArr[2] CGPointValue]];
            _labelQr = [self createLabel:_labelQr     point:[pointArr[2] CGPointValue] string:Localized(@"exchange_qr")];
            
            [self addSubview:_imageQr];
            [self addSubview:_labelQr];
            break;
        case 3:
            
            // 名片识别
            _imageCards = [self createImageView:_imageCards point:[pointArr[3] CGPointValue]];
            _labelCards = [self createLabel:_labelCards     point:[pointArr[3] CGPointValue] string:Localized(@"exchange_ocr")];
            
            [self addSubview:_imageCards];
            [self addSubview:_labelCards];
            break;
        case 4:
            
            // 邀请好友
            _imageContact = [self createImageView:_imageContact point:[pointArr[4] CGPointValue]];
            _labelContact = [self createLabel:_labelContact     point:[pointArr[4] CGPointValue] string:Localized(@"exchange_contact")];
            
            [self addSubview:_imageContact];
            [self addSubview:_labelContact];
            break;
            
        default:
            break;
    }
}

// 封装创建参数
- (UIImageView *)createImageView:(UIImageView *)imageView point:(CGPoint)pointArr {
    
    CGSize imageSize = CGSizeMake(40, 40);
    
    if (kScreenHeight == 568) {
        imageSize = CGSizeMake(30, 30);
    }
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width * 0.5 - imageSize.width * 0.5, self.height - imageSize.height * 0.5, imageSize.width, imageSize.height)];
    
    imageView.x = imageView.x + pointArr.x;
    imageView.y = imageView.y + pointArr.y;
    return imageView;
}

// 封装创建参数
- (UILabel *)createLabel:(UILabel *)label point:(CGPoint)pointArr string:(NSString *)string {
    
    UIFont *font = [UIFont systemFontOfSize:16];
    
    if (kScreenHeight == 568) {
        
        font = [UIFont systemFontOfSize:14];
    }
    
    CGSize size = [_text sizeWithAttributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake((self.width * 0.5) - (size.width * 0.5), self.height - 10, size.width, 20)];

    label.text = string;
    label.font = font;
    
    [label sizeToFit];

    if ([string isEqualToString:Localized(@"exchange_ocr")]) {
        
        label.x = label.x + pointArr.x + 5;
        label.y = label.y + pointArr.y;
        
    }else if ([string isEqualToString:Localized(@"exchange_private")]){
        
        label.x = label.x + pointArr.x - 5;
        label.y = label.y + pointArr.y;
    }else if ([string isEqualToString:Localized(@"exchange_collective")] || [string isEqualToString:Localized(@"exchange_contact")]) {
        
        label.x = label.x + pointArr.x;
        label.y = label.y + pointArr.y + 5;
    }else {
        
        label.x = label.x + pointArr.x;
        label.y = label.y + pointArr.y - 15;
    }
    
    label.hidden = YES;
    
    return label;
}

// 根据 type 值来赋值对应的 image
- (void)setIconView:(NSString *)iconView {
    
    _iconView = iconView;
    
    switch (_imageType.integerValue) {
        case 0:
            _imageExchange.image = [UIImage imageNamed:iconView];
            break;
        case 1:
            _imageMeeting.image  = [UIImage imageNamed:iconView];
            break;
        case 2:
            _imageQr.image       = [UIImage imageNamed:iconView];
            break;
        case 3:
            _imageCards.image    = [UIImage imageNamed:iconView];
            break;
        case 4:
            _imageContact.image  = [UIImage imageNamed:iconView];
            break;
            
        default:
            break;
    }
}

// 根据选中状态来判断隐藏对应的 image
- (void)setSelectedTitle:(NSString *)selectedTitle {
    
    _selectedTitle = selectedTitle;
    
    if (_isSelected) {
        
        switch (selectedTitle.integerValue) {
            case 0:
                _imageExchange.hidden = YES;
                _labelExchange.hidden = NO;
                break;
            case 1:
                _imageMeeting.hidden  = YES;
                _labelMeeting.hidden  = NO;
                break;
            case 2:
                _imageQr.hidden       = YES;
                _labelQr.hidden       = NO;
                break;
            case 3:
                _imageCards.hidden    = YES;
                _labelCards.hidden    = NO;
                break;
            case 4:
                _imageContact.hidden  = YES;
                _labelContact.hidden  = NO;
                break;
                
            default:
                break;
        }
    }else {
        
        switch (selectedTitle.integerValue) {
            case 0:
                _imageExchange.hidden = NO;
                _labelExchange.hidden = YES;
                break;
            case 1:
                _imageMeeting.hidden  = NO;
                _labelMeeting.hidden  = YES;
                break;
            case 2:
                _imageQr.hidden       = NO;
                _labelQr.hidden       = YES;
                break;
            case 3:
                _imageCards.hidden    = NO;
                _labelCards.hidden    = YES;
                break;
            case 4:
                _imageContact.hidden  = NO;
                _labelContact.hidden  = YES;
                break;
                
            default:
                break;
        }
    }
}

- (void) setAngleTo:(float)angleTo {
    
    _angleTo = M_PI * angleTo / 180;
}

- (void) setAngleFrom:(float)angleFrom {
    
    _angleFrom = M_PI * angleFrom / 180;
}

- (void)drawRect:(CGRect)rect {
    
    UIColor *background = FriendlyRGBColor(238, 243, 242);
    
    CGRect f = self.bounds;
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    
    // Center of the circle
    CGContextTranslateCTM(ctx, f.origin.x + _menuCenter.x, f.origin.y + _menuCenter.y);
    
    // First arc point
    CGPoint from = CGPointMake(cosf(_angleFrom) * _radius, sinf(_angleFrom) * _radius);
    
    // Draw arc
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddArc(ctx, 0, 0, _radius, _angleFrom, _angleTo, NO);
    
    [background setFill];
    // 填充颜色
    // 渲染出现
    CGContextFillPath(ctx);

    // 分割线
    if (!_isSelected) {
        
        // 分割线
        CGContextMoveToPoint(ctx, from.x, from.y);
        CGContextAddLineToPoint(ctx, 0, 0);
        CGContextSetLineWidth(ctx, 1);
        [FriendlyRGBColor(217, 230, 233) setStroke]; // 正确的颜色
        CGContextStrokePath(ctx);
    }
 
    // 外部颜色圆弧
    if (_isSelected) {
        
        CGContextAddArc(ctx, 0, 0, _radius - 10, _angleFrom, _angleTo, NO);
        
        CGContextSetLineWidth(ctx, 20);
        [_upColor setStroke];
        //绘制圆弧
        CGContextDrawPath(ctx, kCGPathStroke);
    }else {
        CGContextAddArc(ctx, 0, 0, _radius - 15, _angleFrom, _angleTo, NO);
        
        CGContextSetLineWidth(ctx, 30);
        [_upColor setStroke];
        //绘制圆弧
        CGContextDrawPath(ctx, kCGPathStroke);
    }
    
    // 文字
    CGSize size = [_text sizeWithAttributes:@{NSFontAttributeName:_font, NSForegroundColorAttributeName:[UIColor whiteColor]}];
    float arc = _textRadius * fabs(_angleTo - _angleFrom);
    float offset = (arc - size.width) / 2;
    CGContextRotateCTM(ctx, M_PI_2 + (_angleTo + _angleFrom) / 2);
    
    CGRect titleRect = CGRectMake((-arc / 2 + offset), -_textRadius - size.height / 2, size.width, size.height);
    [_text drawInRect:titleRect withAttributes:@{NSFontAttributeName:_font, NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // bezierPathWithRect 这个办法是如果有两个的路径重叠了就会把重叠部分给裁剪掉的意思.
    // 镂空中心圆
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
    
    // 创建一个圆形path
    UIBezierPath *circlePath = [UIBezierPath bezierPath];
    // 选中状态下 切除的小圆扩大 10 半径
    circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width * 0.5 , rect.size.height)
                                                              radius:45
                                                          startAngle:0
                                                            endAngle:2 * M_PI
                                                           clockwise:NO];
    [path appendPath:circlePath];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
}

// Checks whether point is inside circle segment or not
- (BOOL)hitInside:(CGPoint)point {
    
    CGFloat width = self.width / 2;
    
    // 过滤透明圆圈
    if (self.tag == 0) {
        
        if (point.y > 175 && point.x > width - 45) {
            
            return NO;
        }
        
    }else if (self.tag == 1) {
        
        CGFloat widthX = kScreenWidth * 0.5 - 10;
        
        if (point.y > 190 && point.x > width - widthX / 2) {
            
            return NO;
        }
        
    }else if (self.tag == 2) {
        
        if (point.y > 175) {
            
            return NO;
        }
        
    }else if (self.tag == 3) {
        
        CGFloat widthX = kScreenWidth * 0.5 - 10;
        
        if (point.y > 190 && point.x < width + widthX / 2) {
            
            return NO;
        }

    }else {
        
        if (point.y > 175 && point.x < width + 45) {
            
            return NO;
        }
    }
    
    float x = point.x - self.bounds.origin.x - _menuCenter.x;
    float y = -point.y + self.bounds.origin.y + _menuCenter.y;
    float hypot = hypotf(x, y);
    if (hypot > _radius) return NO;
    
    float angle;
    if (x / hypot > 0) {
        angle = - asinf(y / hypot);
    } else if (x / hypot < 0) {
        angle = asinf(y / hypot) - M_PI;
    } else {
        angle = - M_PI_2;
    }
    
    return angle > _angleFrom && angle < _angleTo;
}

- (NSArray *)fanPointsCalculationLongY:(float)oneY {
    
    float W;
    float oneX;
    float tY;
    float tX;
    W = oneY / sin(DEGREES_TO_RADIANS(72));
    oneX = W * sin(DEGREES_TO_RADIANS(18));
    
    tY = W * sin(DEGREES_TO_RADIANS(36));
    tX = W * sin(DEGREES_TO_RADIANS(54));
    
    NSArray *array = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(-oneY, -oneX)],
                      [NSValue valueWithCGPoint:CGPointMake(-tY, -tX)],
                      [NSValue valueWithCGPoint:CGPointMake(0, -W)],
                      [NSValue valueWithCGPoint:CGPointMake(tY, -tX)],
                      [NSValue valueWithCGPoint:CGPointMake(oneY, -oneX)],
                      nil];
    
    return array;
}
@end
