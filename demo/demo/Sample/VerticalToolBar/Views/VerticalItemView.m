//
//  VerticalItemView.m
//  Demo
//
//  Created by butub on 2022/5/20.
//

#import "VerticalItemView.h"


@interface VerticalItemView ()
@property (nonatomic, copy, nullable) VTItemData *data;
@property (nonatomic, strong, nullable) UIImageView *iconImageView; /// 图片
@property (nonatomic, strong, nullable) UIView *loadingView; /// LoadingView
@property (nonatomic, strong, nullable) UIView *roundView; /// 边框
@end



@implementation VerticalItemView

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
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews
{

}


#pragma mark - getter




@end
