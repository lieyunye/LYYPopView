//
//  LYYPopView.h
//  LYYPopView
//
//  Created by lieyunye on 2017/2/17.
//  Copyright © 2017年 lieyunye. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LYYPopViewDirectionTypeUp,
    LYYPopViewDirectionTypeDown,
    LYYPopViewDirectionTypeleft,
    LYYPopViewDirectionTypeRight,
} LYYPopViewDirectionType;

@interface LYYPopView : UIView
@property (nonatomic, assign) LYYPopViewDirectionType popViewDirectionType;
@property (nonatomic, strong) UIColor *layerColor;
@property (nonatomic, assign) CGFloat triangelX;
- (void)showWithAnimated:(BOOL)animated completion:(void (^)(BOOL))completion;
- (void)hideWithAnimated:(BOOL)animated completion:(void (^)(BOOL))completion;

- (BOOL)isShowing;
@end
