//
//  DMPassThroughViewController.m
//  Demo
//
//  Created by butub on 2022/9/29.
//

#import "DMPassThroughViewController.h"

#import "Masonry.h"

#import "DMMacros.h"


@interface DMPassThroughView : UIView

@property (nonatomic, strong) NSNumber *lastX;
@property (nonatomic, strong) NSNumber *lastY;

@end

@implementation DMPassThroughView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self){
        if ([self needProcessLeftRgihtWithPoint:point event:event]) {
            return self;
        }
        return nil;
    }
    return hitView;
}

- (BOOL)needProcessLeftRgihtWithPoint:(CGPoint)point event:(UIEvent *)event
{
    if (!_lastX || !_lastY) {
        _lastX = @(point.x);
        _lastY = @(point.y);
    } else {
        CGFloat dx = [_lastX floatValue] - point.x;
        CGFloat dy = [_lastY floatValue] - point.y;

        _lastX = @(point.x);
        _lastY = @(point.y);

        if (fabs(dx) > fabs(dy)) { ///
            return NO;
        } else {
            return YES;
        }
    }
    return YES;
}

@end


dm_registerDemo(DMPassThroughViewController, {
    item.identifier = @"Gesture.HitTest.Passthrough";
    item.author = @"butub";
})


@interface DMPassThroughViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIView *passThroughView;
@property (nonatomic, strong) DMPassThroughView *frontView;


@end

@implementation DMPassThroughViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}


- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];

    UIView *passThroughView = [[UIView alloc] initWithFrame:CGRectZero];
    self.passThroughView = passThroughView;


    UISwipeGestureRecognizer *leftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeAction:)];
    leftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    [passThroughView addGestureRecognizer:leftGesture];

    UISwipeGestureRecognizer *rightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeAction:)];
    rightGesture.direction =  UISwipeGestureRecognizerDirectionRight;
    [passThroughView addGestureRecognizer:rightGesture];

    passThroughView.backgroundColor = [UIColor blackColor];
    passThroughView.alpha = 0.5;

    [self.view addSubview:passThroughView];
    [passThroughView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    DMPassThroughView *frontView = [[DMPassThroughView alloc] initWithFrame:CGRectZero];
    self.frontView = frontView;

    UISwipeGestureRecognizer *upGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeAction2:)];
    upGesture.direction = UISwipeGestureRecognizerDirectionUp;
    [frontView addGestureRecognizer:upGesture];

    UISwipeGestureRecognizer *downGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeAction2:)];
    downGesture.direction = UISwipeGestureRecognizerDirectionDown;
    [frontView addGestureRecognizer:downGesture];

    upGesture.delegate = self;

    frontView.backgroundColor = [UIColor greenColor];
    frontView.alpha = 0.5;

    [self.view addSubview:frontView];

    [frontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(passThroughView);
        make.left.equalTo(passThroughView).offset(20);
        make.right.equalTo(passThroughView).offset(-20);
        make.height.equalTo(@60);
    }];

}

- (void)handleSwipeAction:(UISwipeGestureRecognizer *)swipeGesture
{
    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionLeft) {
        self.passThroughView.backgroundColor = [UIColor redColor];
    }

    if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight) {
        self.passThroughView.backgroundColor = [UIColor yellowColor];
    }
}


- (void)handleSwipeAction2:(UISwipeGestureRecognizer *)swipeGesture
{
    if (swipeGesture.direction & UISwipeGestureRecognizerDirectionUp) {
        self.frontView.backgroundColor = [UIColor blueColor];
    }

    if (swipeGesture.direction & UISwipeGestureRecognizerDirectionDown) {
        self.frontView.backgroundColor = [UIColor grayColor];
    }
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return YES;
}

//- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
//{
//
//    touch
//
//    return NO;
//
//}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveEvent:(UIEvent *)event
{

    return YES;

}

@end
