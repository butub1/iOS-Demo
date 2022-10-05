//
//  ACCCollectionButton.m
//  Pods
//
//  Created by huchunhao on 2018/8/23.
//

#import "ACCCollectionButton.h"

@interface ACCCollectionButton ()<CAAnimationDelegate>

@property (nonatomic, strong) CABasicAnimation *basicAnimation1;
@property (nonatomic, strong) CABasicAnimation *basicAnimation2;
@property (nonatomic, strong) CABasicAnimation *basicAnimation3;
@property (nonatomic, strong) CABasicAnimation *basicAnimation4;
@property (nonatomic, strong) CAAnimationGroup *aniGroup1;
@property (nonatomic, strong) CAAnimationGroup *aniGroup2;
@property (nonatomic, strong) CABasicAnimation *alphaAnimation1;
@property (nonatomic, strong) CABasicAnimation *alphaAnimation2;

@end

NSString * const ACCAniGroupKey = @"ACCAniGroupKey";

@implementation ACCCollectionButton

/**
 动画逻辑：
 |time |0.0s|0.1s|0.2s|0.3s|0.4s|
 |scale|1.0 |1.2 |0.1 |1.2 |1.0 |
 |alpha|1.0 |1.0 |0.0 |1.0 |1.0 |
 ps: 在0.2秒时切换selected状态
 */
- (void)beginTouchAnimation
{
    switch (self.displayMode) {
        case ACCCollectionButtonDisplayModeImage:
            [self beginFirstTouchAnimation];
            break;
        case ACCCollectionButtonDisplayModeTitleAndImage:
            self.selected = !self.selected;
            break;
    }
}

- (void)beginFirstTouchAnimation
{
    //
    self.basicAnimation1 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    self.basicAnimation1.duration = 0.1f;
    self.basicAnimation1.fromValue = @1.0f;
    self.basicAnimation1.toValue = @1.2f;
    self.basicAnimation1.beginTime = 0.0f;
    self.basicAnimation1.repeatCount = 1;
    //
    self.basicAnimation2 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    self.basicAnimation2.duration = 0.1f;
    self.basicAnimation2.fromValue = @1.2f;
    self.basicAnimation2.toValue = @0.1f;
    self.basicAnimation2.repeatCount = 1;
    self.basicAnimation2.beginTime = 0.1f;
    //
    self.alphaAnimation1 = [CABasicAnimation animationWithKeyPath:@"alpha"];
    self.alphaAnimation1.duration = 0.1f;
    self.alphaAnimation1.beginTime = 0.1f;
    self.alphaAnimation1.fromValue = @1.0f;
    self.alphaAnimation1.toValue = @0.0f;
    self.alphaAnimation1.repeatCount = 1;
    //
    self.aniGroup1 = [CAAnimationGroup animation];
    self.aniGroup1.duration = 0.2f;
    self.aniGroup1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.aniGroup1.fillMode = kCAFillModeForwards;
    self.aniGroup1.removedOnCompletion = NO;
    self.aniGroup1.animations = @[self.basicAnimation1, self.basicAnimation2, self.alphaAnimation1];
    [self.aniGroup1 setValue:@"group1" forKey:ACCAniGroupKey];
    self.aniGroup1.delegate = self;
    
    [self.imageView.layer addAnimation:self.aniGroup1 forKey:nil];
}

- (void)beginSecondTouchAnimation
{
    //
    self.basicAnimation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    self.basicAnimation3.duration = 0.1f;
    self.basicAnimation3.fromValue = @0.1f;
    self.basicAnimation3.toValue = @1.2f;
    self.basicAnimation3.repeatCount = 1;
    self.basicAnimation3.beginTime = 0.0f;
    //
    self.basicAnimation4 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    self.basicAnimation4.duration = 0.1f;
    self.basicAnimation4.fromValue = @1.2f;
    self.basicAnimation4.toValue = @1.0f;
    self.basicAnimation4.repeatCount = 1;
    self.basicAnimation4.beginTime = 0.1f;
    //
    self.alphaAnimation2 = [CABasicAnimation animationWithKeyPath:@"alpha"];
    self.alphaAnimation2.duration = 0.1f;
    self.alphaAnimation2.beginTime = 0.0f;
    self.alphaAnimation2.fromValue = @0.0f;
    self.alphaAnimation2.toValue = @1.0f;
    self.alphaAnimation2.repeatCount = 1;
    //
    self.aniGroup2 = [CAAnimationGroup animation];
    self.aniGroup2.duration = 0.2f;
    self.aniGroup2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    self.aniGroup2.fillMode = kCAFillModeForwards;
    self.aniGroup2.removedOnCompletion = NO;
    self.aniGroup2.animations = @[self.basicAnimation3, self.basicAnimation4, self.alphaAnimation2];
    [self.aniGroup2 setValue:@"group2" forKey:ACCAniGroupKey];
    self.aniGroup2.delegate = self;
    [self.imageView.layer addAnimation:self.aniGroup2 forKey:nil];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //第一段缩放结束后更改button状态
    if (flag && [[anim valueForKey:ACCAniGroupKey] isEqualToString:[self.aniGroup1 valueForKey:ACCAniGroupKey]]) {
        self.selected = !self.selected;
        [self beginSecondTouchAnimation];
    } else if (flag && [[anim valueForKey:ACCAniGroupKey] isEqualToString:[self.aniGroup2 valueForKey:ACCAniGroupKey]]) {
        [self.imageView.layer removeAllAnimations];
    }
    if (self.animateFinishblock) {
        self.animateFinishblock();
    }
}

@end
