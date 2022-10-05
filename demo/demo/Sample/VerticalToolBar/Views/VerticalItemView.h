//
//  VerticalItemView.h
//  Demo
//
//  Created by butub on 2022/5/20.
//

#import <UIKit/UIKit.h>

#import "VTItemData.h"

NS_ASSUME_NONNULL_BEGIN

/*
 接口设定，item，只管理自己的展示
 */

typedef NS_ENUM(NSUInteger, VTItemViewStatus) {
    VTItemViewStatusDefault = 0, /// 初始缩小状态
    VTItemViewStatusLoading = 1, /// 点击Loading状态
    VTItemViewStatusApplied = 2 /// 应用放大状态
};

@interface VerticalItemView : UIView

- (void)updateWithItemData:(VTItemData *)data;
- (void)updateWithStatus:(VTItemViewStatus)status;
- (void)updateAvaliableStatus:(NSArray<NSNumber *> *)statusArray; /// 支持的状态集

@end

NS_ASSUME_NONNULL_END
