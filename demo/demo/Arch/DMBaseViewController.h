//
//  DMBaseViewController.h
//  demo
//
//  Created by butub on 2022/7/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 【延后设计，避免过度提前设计】
/// 提供基础的依赖注入和Context能力
///  1. 依赖注入能力，方便解耦， 注入服务：
///  2. context能力帮助状态同步， context可以有各种category
///  3. 注入的容器是否挂载在context上

@interface DMBaseViewController : NSObject

@end

NS_ASSUME_NONNULL_END
