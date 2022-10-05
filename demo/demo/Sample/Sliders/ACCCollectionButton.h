//
//  ACCCollectionButton.h
//  Pods
//
//  Created by butub on 2018/8/23.
//

#import <UIKit/UIKit.h>

//收藏按钮的显示增加图片加标题的样式，枚举默认值为0即只显示图片
typedef NS_ENUM(NSUInteger, ACCCollectionButtonDisplayMode) {
    ACCCollectionButtonDisplayModeImage = 0,
    ACCCollectionButtonDisplayModeTitleAndImage,
};

//不要在外部改selected状态.

@interface ACCCollectionButton : UIButton

- (void)beginTouchAnimation;

@property (nonatomic, copy) dispatch_block_t animateFinishblock;
@property (nonatomic, assign) ACCCollectionButtonDisplayMode displayMode;

@end
