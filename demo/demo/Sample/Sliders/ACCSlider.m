//
//  ACCSlider.m
//  Demo
//
//  Created by butub on 2022/2/5.
//

#import "ACCSlider.h"
#import <AudioToolbox/AudioServices.h>

@interface ACCSlider ()

@property (nonatomic, assign) float lastValue;
@property (nonatomic, strong) UIImpactFeedbackGenerator *feedBackGenertor;
@property (nonatomic, assign) BOOL leftVibrated;
@property (nonatomic, assign) BOOL rightVibrated;

@end

@implementation ACCSlider

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setupUI];
        [self setupGesture];
//        [self setupDefaultState];
        [self addObserver:self forKeyPath:@"value" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
        self.value = 70;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"value"]) {
//        NSLog(@"ZPJ: Value change from: %@ to %@", change[NSKeyValueChangeOldKey], change[NSKeyValueChangeNewKey]);
    }
}

- (void)setupGesture
{
    [self addTarget:self action:@selector(rangeSliderValueChange:forEvent:) forControlEvents:UIControlEventValueChanged];
//    [self addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
}


#pragma mark - Action


- (void)valueChanged:(UISlider *)slider
{
    [self p_adsorptionIfNeed];
//    self.lastValue = self.value;
}

- (void)rangeSliderValueChange:(UISlider *)slider forEvent:(UIEvent *)event
{
//    [self handleValueChanged];
//    [self p_adsorptionIfNeed];
    UITouch *touchEvent = [[event allTouches] anyObject];
    switch (touchEvent.phase) {
        case UITouchPhaseBegan:
//            [self p_showLabel];
            break;
        case UITouchPhaseStationary:
        case UITouchPhaseMoved: {
            [self p_adsorptionIfNeed];
            break;
        }
        case UITouchPhaseEnded:
//            [self p_adsorptionIfNeed];
            break;
        case UITouchPhaseCancelled: {
//            [self p_hideLabelWithTimer];
            break;
        }
        default:
            break;
    }
//
//    self.continuous = YES;

}

#pragma mark - Private Helper

/// 磁吸
- (void)p_adsorptionIfNeed
{
    if (YES) {
//        CGRect thumbImageRect = [self thumbRectForBounds:self.bounds trackRect:[self trackRectForBounds:self.bounds] value:self.value];
//        CGFloat currentPosition = CGRectGetMidX(thumbImageRect) / self.bounds.size.width;
        float defaultValue = self.minimumValue + (self.maximumValue - self.minimumValue) * 0.7;
        static BOOL vibrated;
        if (fabs(self.value - defaultValue) <= 10) {
//            CGFloat nearValue = self.minimumValue + self.defaultIndicatorPosition * (self.maximumValue - self.minimumValue);
            BOOL left = self.value < defaultValue  && self.lastValue < self.value;
            BOOL right = self.value > defaultValue && self.lastValue > self.value;

            if (left || right) {
                if (!vibrated) {
                    [self p_vibrate];
                    vibrated = YES;
                }
//                            [self setValue:defaultValue animated:YES];
//                if (left && !self.leftVibrated) {
//                    [self p_vibrate];
//                    self.leftVibrated = YES;
//                    self.rightVibrated = NO;
//                }
//                if (right && !self.rightVibrated) {
//                    [self p_vibrate];
//                    self.rightVibrated = YES;
//                    self.leftVibrated = NO;
//                }
//                if (fabs(self.value - defaultValue) == 10) {
//
//                }
                NSLog(@"ZPJ:OK v: %f d:%f l:%f", self.value, defaultValue, self.lastValue);

                self.value = defaultValue;
                [self setValue:defaultValue animated:NO];

//                [self sendActionsForControlEvents:UIControlEventValueChanged];

//                self.continuous = NO;
//                            self.value = defaultValue;
//                            if ([self.delegate respondsToSelector:@selector(slider:didFinishSlidingWithValue:)]) {
//                                [self.delegate slider:self didFinishSlidingWithValue:defaultValue];
//                            }

            } else {
                NSLog(@"ZPJ:WRong v: %f d:%f l:%f", self.value, defaultValue, self.lastValue);
            }
        } else {
            vibrated = NO;
            self.lastValue = self.value;
        }

    }
}

- (void)p_vibrate
{
    if (@available(iOS 10.0, *)) {
//        if ([UIDevice acc_isBetterThanIPhone7]) {
            if (!self.feedBackGenertor) {
                self.feedBackGenertor = [[UIImpactFeedbackGenerator alloc] initWithStyle:UIImpactFeedbackStyleLight];
            }
            [self.feedBackGenertor prepare];
            [self.feedBackGenertor impactOccurred];
//        }
    } else {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }

}


@end
