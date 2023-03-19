//
//  DMRegisterCenter.h
//  Demo
//
//  Created by butub on 2022/10/4.
//

#import <Foundation/Foundation.h>


/**
 这里还需要更多的设计，应该设计成这一个样子
  DMRegisterCent
 */

NS_ASSUME_NONNULL_BEGIN

/// 注册的item
@interface DMRegisterItem : NSObject
/// required, use for search
@property (nonatomic, copy, nonnull) NSString *identifier;
/// required, auto generate
@property (nonatomic, copy) Class targetClass;
/// optional
@property (nonatomic, copy, nullable) NSString *author;
@property (nonatomic, copy, nullable) NSString *email;
@property (nonatomic, copy, nullable) NSURL *iconURL;

@end

/// 注册的Cell
@interface DMRegisterCellItem : NSObject

@property (nonatomic, copy, nonnull) NSString *cellClass;
@property (nonatomic, copy, nonnull) NSString *identifier;

@end


typedef void (^DMItemConfigBlock)(DMRegisterItem *item);
typedef void (^DMCellItemConfigBlock)(DMRegisterCellItem *cellItem);

/// 注册容器, 一个简易实现
@interface DMRegisterCenter : NSObject

@property (nonatomic, readonly, nonnull) NSDictionary<NSString *, DMRegisterItem *> *demoItemsDict;
@property (nonatomic, readonly, nonnull) NSArray<NSString *> *demoKeysArray;


- (void)registerClass:(NSString *)class withBlock:(DMItemConfigBlock _Nullable)block; // 注册VC用
- (void)registerCellItemForVC:(NSString *)class WithBlock:(DMCellItemConfigBlock _Nullable)block;

@property (nonatomic, readonly, nonnull) NSDictionary<NSString *, DMRegisterCellItem *> *demoCellItemsDict;

+ (instancetype)sharedInstance;

- (void)loadAllItemsFromCategories;


@end

#define strongify(object) __typeof__(object) object = weak##_##object;

#define dm_registerDemo( class , block ) \
@interface DMRegisterCenter( class ) \
- (void)user_registerItemsFor_ ## class;\
@end; \
@implementation DMRegisterCenter( class ) \
- (void)user_registerItemsFor_ ## class\
{\
    [self registerClass:@#class withBlock:^(DMRegisterItem *item) { \
        block \
    }]; \
}\
@end

static inline DMRegisterCenter *DemoCenter()
{
    return [DMRegisterCenter sharedInstance];
};

NS_ASSUME_NONNULL_END
