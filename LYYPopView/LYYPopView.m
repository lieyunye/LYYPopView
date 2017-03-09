//
//  LYYPopView.m
//  LYYPopView
//
//  Created by lieyunye on 2017/2/17.
//  Copyright © 2017年 lieyunye. All rights reserved.
//

#import "LYYPopView.h"

// 小三角的高度
#define kTriangleHeight 8.0

// 小三角的宽度
#define kTriangleWidth 10.0

// 弹出视图背景的圆角半径
#define kPopOverLayerCornerRadius 5.0

// 调整弹出视图背景四周的空隙
#define kRoundMargin 10.0

@interface LYYPopView()
@property (nonatomic, strong) CAShapeLayer *popLayer;
@end

@implementation LYYPopView

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"frame"];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // monitor frame property
        [self addObserver:self forKeyPath:@"frame" options:0 context:NULL];
        _popViewDirectionType = LYYPopViewDirectionTypeRight;
    }
    
    return self;
}

- (CAShapeLayer *)popLayer
{
    if (nil == _popLayer) {
        _popLayer = [[CAShapeLayer alloc]init];
        [self.layer addSublayer:_popLayer];
    }
    return _popLayer;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if([keyPath isEqualToString:@"frame"]) {
        CGRect newFrame = CGRectNull;
        if([object valueForKeyPath:keyPath] != [NSNull null]) {
            newFrame = [[object valueForKeyPath:keyPath] CGRectValue];
            [self setLayerFrame:newFrame];
            
        }
    }
}

- (void)setLayerFrame:(CGRect)frame
{
    float triangelX;
    if (_triangelX == 0) {
        triangelX = frame.size.width - 60;
    }else {
        triangelX = _triangelX;
    }
    
    // triangel must between left corner and right corner
    if (triangelX > frame.size.width - kPopOverLayerCornerRadius) {
        triangelX = frame.size.width - kPopOverLayerCornerRadius - 0.5 * kTriangleWidth;
    }else if (triangelX < kPopOverLayerCornerRadius) {
        triangelX = kPopOverLayerCornerRadius + 0.5 * kTriangleWidth;
    }
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint point0 = CGPointZero;
    CGPoint TrianglePoint1 = CGPointZero;
    CGPoint TrianglePoint2 = CGPointZero;
    CGPoint TrianglePoint3 = CGPointZero;
    CGPoint roundCorner1Point1 = CGPointZero;
    CGPoint roundCorner1Point2 = CGPointZero;
    CGPoint roundCorner2Point1 = CGPointZero;
    CGPoint roundCorner2Point2 = CGPointZero;
    CGPoint roundCorner3Point1 = CGPointZero;
    CGPoint roundCorner3Point2 = CGPointZero;
    CGPoint roundCorner0Point1 = CGPointZero;
    CGPoint roundCorner0Point2 = CGPointZero;
    

    switch (self.popViewDirectionType) {
        case LYYPopViewDirectionTypeUp:
        {
            point0 = CGPointMake(kPopOverLayerCornerRadius, 0);
           
            roundCorner1Point1 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, 0);
            roundCorner1Point2 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, 0 + kPopOverLayerCornerRadius);
            
            roundCorner2Point1 = CGPointMake(frame.size.width, frame.size.height - kPopOverLayerCornerRadius - kTriangleHeight);
            roundCorner2Point2 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, frame.size.height - kPopOverLayerCornerRadius - kTriangleHeight);
            
            TrianglePoint1 = CGPointMake(triangelX + kTriangleWidth, frame.size.height - kTriangleHeight);
            TrianglePoint2 = CGPointMake(triangelX + kTriangleWidth / 2.0, frame.size.height);
            TrianglePoint3 = CGPointMake(triangelX, frame.size.height - kTriangleHeight);
            
            roundCorner3Point1 = CGPointMake(kPopOverLayerCornerRadius, frame.size.height - kTriangleHeight);
            roundCorner3Point2 = CGPointMake(kPopOverLayerCornerRadius, frame.size.height - kPopOverLayerCornerRadius - kTriangleHeight);
           
            roundCorner0Point1 = CGPointMake(0, kPopOverLayerCornerRadius);
            roundCorner0Point2 = CGPointMake(kPopOverLayerCornerRadius, kPopOverLayerCornerRadius);
           
            [path moveToPoint:point0];

            [path addLineToPoint:roundCorner1Point1];
            [path addArcWithCenter:roundCorner1Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI_2 endAngle:0 clockwise:YES];
           
            [path addLineToPoint:roundCorner2Point1];
            [path addArcWithCenter:roundCorner2Point2 radius:kPopOverLayerCornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
            
            [path addLineToPoint:TrianglePoint1];
            [path addLineToPoint:TrianglePoint2];
            [path addLineToPoint:TrianglePoint3];
            
            [path addLineToPoint:roundCorner3Point1];
            [path addArcWithCenter:roundCorner3Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
           
            [path addLineToPoint:roundCorner0Point1];
            [path addArcWithCenter:roundCorner0Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI endAngle:3 * M_PI_2 clockwise:YES];
            
        }
            break;
        case LYYPopViewDirectionTypeDown:
        {
            point0 = CGPointMake(kPopOverLayerCornerRadius, kTriangleHeight);
           
            TrianglePoint1 = CGPointMake(triangelX, kTriangleHeight);
            TrianglePoint2 = CGPointMake(triangelX + kTriangleWidth / 2.0, 0);
            TrianglePoint3 = CGPointMake(triangelX + kTriangleWidth, kTriangleHeight);
            
            roundCorner1Point1 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, kTriangleHeight);
            roundCorner1Point2 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, kTriangleHeight + kPopOverLayerCornerRadius);
           
            roundCorner2Point1 = CGPointMake(frame.size.width, frame.size.height - kPopOverLayerCornerRadius);
            roundCorner2Point2 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, frame.size.height - kPopOverLayerCornerRadius);
           
            roundCorner3Point1 = CGPointMake(kPopOverLayerCornerRadius, frame.size.height);
            roundCorner3Point2 = CGPointMake(kPopOverLayerCornerRadius, frame.size.height - kPopOverLayerCornerRadius);
           
            roundCorner0Point1 = CGPointMake(0, kTriangleHeight + kPopOverLayerCornerRadius);
            roundCorner0Point2 = CGPointMake(kPopOverLayerCornerRadius, kTriangleHeight + kPopOverLayerCornerRadius);
            
            [path moveToPoint:point0];
            
            [path addLineToPoint:TrianglePoint1];
            [path addLineToPoint:TrianglePoint2];
            [path addLineToPoint:TrianglePoint3];
            
            [path addLineToPoint:roundCorner1Point1];
            [path addArcWithCenter:roundCorner1Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI_2 endAngle:0 clockwise:YES];
           
            [path addLineToPoint:roundCorner2Point1];
            [path addArcWithCenter:roundCorner2Point2 radius:kPopOverLayerCornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
           
            [path addLineToPoint:roundCorner3Point1];
            [path addArcWithCenter:roundCorner3Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
            
            [path addLineToPoint:roundCorner0Point1];
            [path addArcWithCenter:roundCorner0Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI endAngle:3 * M_PI_2 clockwise:YES];
        }
            break;
        case LYYPopViewDirectionTypeleft:
        {
            point0 = CGPointMake(kPopOverLayerCornerRadius + kTriangleHeight, 0);
            
            roundCorner1Point1 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, 0);
            roundCorner1Point2 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, 0 + kPopOverLayerCornerRadius);
            
            roundCorner2Point1 = CGPointMake(frame.size.width, frame.size.height - kPopOverLayerCornerRadius);
            roundCorner2Point2 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius, frame.size.height - kPopOverLayerCornerRadius);
    
            roundCorner3Point1 = CGPointMake(kPopOverLayerCornerRadius + kTriangleHeight, frame.size.height);
            roundCorner3Point2 = CGPointMake(kPopOverLayerCornerRadius + kTriangleHeight, frame.size.height - kPopOverLayerCornerRadius);
            
            TrianglePoint1 = CGPointMake(kTriangleHeight, triangelX + kTriangleWidth);
            TrianglePoint2 = CGPointMake(0, triangelX + kTriangleWidth / 2.0);
            TrianglePoint3 = CGPointMake(kTriangleHeight, triangelX);
            
            roundCorner0Point1 = CGPointMake(kTriangleHeight, kPopOverLayerCornerRadius);
            roundCorner0Point2 = CGPointMake(kTriangleHeight + kPopOverLayerCornerRadius, kPopOverLayerCornerRadius);
            
            [path moveToPoint:point0];
            
            [path addLineToPoint:roundCorner1Point1];
            [path addArcWithCenter:roundCorner1Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI_2 endAngle:0 clockwise:YES];
   
            [path addLineToPoint:roundCorner2Point1];
            [path addArcWithCenter:roundCorner2Point2 radius:kPopOverLayerCornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];
   
            [path addLineToPoint:roundCorner3Point1];
            [path addArcWithCenter:roundCorner3Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];
            
            [path addLineToPoint:TrianglePoint1];
            [path addLineToPoint:TrianglePoint2];
            [path addLineToPoint:TrianglePoint3];
            
            [path addLineToPoint:roundCorner0Point1];
            [path addArcWithCenter:roundCorner0Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI endAngle:3 * M_PI_2 clockwise:YES];
        }
            break;
        case LYYPopViewDirectionTypeRight:
        {
            point0 = CGPointMake(kPopOverLayerCornerRadius, 0);
            
            roundCorner1Point1 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius - kTriangleHeight, 0);
            roundCorner1Point2 = CGPointMake(frame.size.width - kPopOverLayerCornerRadius - kTriangleHeight, 0 + kPopOverLayerCornerRadius);
            
            TrianglePoint1 = CGPointMake(frame.size.width - kTriangleHeight, triangelX);
            TrianglePoint2 = CGPointMake(frame.size.width, triangelX + kTriangleWidth / 2.0);
            TrianglePoint3 = CGPointMake(frame.size.width - kTriangleHeight, triangelX + kTriangleWidth);

            roundCorner2Point1 = CGPointMake(frame.size.width - kTriangleHeight, frame.size.height - kPopOverLayerCornerRadius);
            roundCorner2Point2 = CGPointMake(frame.size.width - kTriangleHeight - kPopOverLayerCornerRadius, frame.size.height - kPopOverLayerCornerRadius);
            
            roundCorner3Point1 = CGPointMake(kPopOverLayerCornerRadius, frame.size.height);
            roundCorner3Point2 = CGPointMake(kPopOverLayerCornerRadius, frame.size.height - kPopOverLayerCornerRadius);
            
            roundCorner0Point1 = CGPointMake(0, kPopOverLayerCornerRadius);
            roundCorner0Point2 = CGPointMake(kPopOverLayerCornerRadius, kPopOverLayerCornerRadius);
            
            [path moveToPoint:point0];
            
            [path addLineToPoint:roundCorner1Point1];
            [path addArcWithCenter:roundCorner1Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI_2 endAngle:0 clockwise:YES];
            
            [path addLineToPoint:TrianglePoint1];
            [path addLineToPoint:TrianglePoint2];
            [path addLineToPoint:TrianglePoint3];
            
            [path addLineToPoint:roundCorner2Point1];
            [path addArcWithCenter:roundCorner2Point2 radius:kPopOverLayerCornerRadius startAngle:0 endAngle:M_PI_2 clockwise:YES];

            [path addLineToPoint:roundCorner3Point1];
            [path addArcWithCenter:roundCorner3Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI_2 endAngle:M_PI clockwise:YES];

            [path addLineToPoint:roundCorner0Point1];
            [path addArcWithCenter:roundCorner0Point2 radius:kPopOverLayerCornerRadius startAngle:M_PI endAngle:3 * M_PI_2 clockwise:YES];
        }
            break;
        default:
            break;
    }
    
    [path closePath];
    
    self.popLayer.path = path.CGPath;
    self.popLayer.fillColor = _layerColor? _layerColor.CGColor : [UIColor greenColor].CGColor;
}

- (void)showWithAnimated:(BOOL)animated completion:(void (^)(BOOL))completion {
    self.hidden = NO;
    
    if (animated) {
        self.layer.transform = CATransform3DMakeScale(0.98, 0.98, 1);
        [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.3 initialSpringVelocity:12 options:UIViewAnimationOptionCurveLinear animations:^{
            self.layer.transform = CATransform3DMakeScale(1, 1, 1);
        } completion:^(BOOL finished) {
            if (completion) {
                completion(finished);
            }
        }];
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.alpha = 1;
        } completion:nil];
    } else {
        if (completion) {
            completion(YES);
        }
    }
}

- (void)hideWithAnimated:(BOOL)animated completion:(void (^)(BOOL))completion {
    if (animated) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            self.hidden = YES;
            if (completion) {
                completion(finished);
            }
        }];
    } else {
        self.hidden = YES;
        if (completion) {
            completion(YES);
        }
    }
}

- (BOOL)isShowing {
    return self.superview && !self.hidden;
}
@end
