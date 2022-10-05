//
//  ACCFavoriteButtonView.h
//  Demo
//
//  Created by butub on 2022/2/4.
//

#import <UIKit/UIKit.h>
#import "ACCCollectionButton.h"
NS_ASSUME_NONNULL_BEGIN

@interface ACCFavoriteButtonView : UIView
@property (nonatomic, strong) ACCCollectionButton *favoriteButton;

@property (nonatomic, assign) BOOL selected;

@end

NS_ASSUME_NONNULL_END
