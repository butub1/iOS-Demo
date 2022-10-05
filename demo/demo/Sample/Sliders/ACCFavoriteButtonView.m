//
//  ACCFavoriteButtonView.m
//  Demo
//
//  Created by butub on 2022/2/4.
//

#import "ACCFavoriteButtonView.h"
#import "Masonry.h"

@interface ACCFavoriteButtonView ()



@end

@implementation ACCFavoriteButtonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];

        ACCCollectionButton *favoriteButton = [ACCCollectionButton buttonWithType:UIButtonTypeCustom];
        self.favoriteButton = favoriteButton;
        favoriteButton.contentMode = UIViewContentModeCenter;
        favoriteButton.backgroundColor = [UIColor grayColor];

        favoriteButton.displayMode = ACCCollectionButtonDisplayModeTitleAndImage;
        favoriteButton.titleLabel.font = [UIFont systemFontOfSize:15];
        [favoriteButton setImage:[UIImage imageNamed:@"iconStickerCollectionBeforeNew"] forState:UIControlStateNormal];
        [favoriteButton setImage:[UIImage imageNamed:@"iconStickerCollectionAfter"] forState:UIControlStateSelected];
        [favoriteButton setTitle:@"收藏" forState:UIControlStateNormal];
        [favoriteButton setTitle:@"已收藏" forState:UIControlStateSelected];
        favoriteButton.titleLabel.contentMode = UIViewContentModeLeft;
        favoriteButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        favoriteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        favoriteButton.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 1, 0);
        favoriteButton.titleEdgeInsets = UIEdgeInsetsMake(0, 18, 1, 0);






        [self addSubview:self.favoriteButton];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];

    [CATransaction begin];
//    [CATransaction setDisableActions:!self.isAnimated];
    self.favoriteButton.frame = self.bounds;
    [CATransaction commit];
}


- (void)setSelected:(BOOL)selected
{
    _selected = selected;

    self.favoriteButton.selected = _selected;

    CGFloat buttonWidth = [self getFavoriteButtonBackgroundWidthForState:_selected];
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(buttonWidth));
    }];
}

//- (UIButton *)favoriteButton
//{
//    if (!_favoriteButton) {
//        _favoriteButton = [ACCCollectionButton buttonWithType:UIButtonTypeCustom];
//        _favoriteButton.backgroundColor = [UIColor grayColor];
//        _favoriteButton.contentMode = UIViewContentModeCenter;
//        _favoriteButton.titleLabel.contentMode = UIViewContentModeCenter;
//        [_favoriteButton setTitle:@"收藏" forState:UIControlStateNormal];
//        [_favoriteButton setTitle:@"已收藏" forState:UIControlStateSelected];
//        _favoriteButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        _favoriteButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//        _favoriteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//        [_favoriteButton setImage:[UIImage imageNamed:@"iconStickerCollectionBeforeNew"] forState:UIControlStateNormal];
//        [_favoriteButton setImage:[UIImage imageNamed:@"iconStickerCollectionAfter"] forState:UIControlStateSelected];
//        _favoriteButton.imageEdgeInsets = UIEdgeInsetsMake(0, 18, 1, 0);
//        _favoriteButton.titleEdgeInsets = UIEdgeInsetsMake(0, 18, 1, 0);
//
//    }
//    return _favoriteButton;
//}


- (CGFloat)getFavoriteButtonBackgroundWidthForState:(BOOL)selected
{
        NSString *title = [self buttonTitleForState:selected];
        UIFont *font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
        NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
        NSStringDrawingUsesFontLeading;
        NSDictionary *attributes = @{NSFontAttributeName: font};
        CGSize textSize = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 21)
                                              options:opts
                                           attributes:attributes
                                              context:nil].size;
        // 按钮图片与标题间隔2，图片加左右间隔44
        return textSize.width + 46 + 18;

//    return 54.f;
}

- (NSString *)buttonTitleForState:(BOOL)selected
{
    if (selected) {
        return @"已收藏";
    }

    return @"收藏";
}




@end
