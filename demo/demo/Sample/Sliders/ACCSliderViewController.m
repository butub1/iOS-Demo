//
//  ViewController.m
//  Demo
//
//  Created by butub on 2022/1/28.
//

#import "ACCSliderViewController.h"
#import "Masonry.h"

#import "DMMacros.h"
#import "ACCFavoriteButtonView.h"
#import "ACCSlider.h"


dm_registerDemo(ACCSliderViewController, {
    item.identifier = @"Sample.UISlider.VibrateSlider";
    item.author = @"butub";
})

@interface ACCSliderViewController ()


@property (nonatomic, strong) ACCFavoriteButtonView *favoriteButtonView;
@property (nonatomic, strong) UISlider *slider;

@end

@implementation ACCSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];

    [self.favoriteButtonView.favoriteButton addTarget:self action:@selector(onButtonClicked) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.favoriteButtonView];

    [self.favoriteButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@0);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100);
//        make.width.equalTo(@(width));
        make.height.equalTo(@(40));
    }];

    [self.view addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.favoriteButtonView.mas_right).offset(20);
        make.centerY.equalTo(self.favoriteButtonView);
        make.right.equalTo(self.view).offset(-20);
    }];
}

- (void)onButtonClicked
{
//    self.favoriteButton.selected = !self.favoriteButton.selected;
//    CGFloat targetWidth = [self getFavoriteButtonBackgroundWidthForState:self.favoriteButton.selected];
//
//    [self.favoriteButton mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@(targetWidth));
//    }];
    self.favoriteButtonView.selected = !self.favoriteButtonView.favoriteButton.selected;

    [UIView animateWithDuration:0.3 animations:^{
        [self.favoriteButtonView.superview layoutIfNeeded];
    }];
}


- (ACCFavoriteButtonView *)favoriteButtonView
{
    if (!_favoriteButtonView) {
        _favoriteButtonView = [[ACCFavoriteButtonView alloc] initWithFrame:CGRectZero];
    }
    return _favoriteButtonView;
}


- (UISlider *)slider
{
    if (!_slider) {
        _slider = [[ACCSlider alloc] init];
        _slider.maximumValue = 100;
        _slider.minimumValue = 0;
        _slider.value = 50;
//        [_slider addTarget:self action:@selector(rangeSliderValueChange:forEvent:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}



@end
