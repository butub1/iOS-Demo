//
//  DMRegisterCenter.h
//  Demo
//
//  Created by butub on 2022/10/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

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


typedef void (^DMItemConfigBlock)(DMRegisterItem *item);

@interface DMRegisterCenter : NSObject

@property (nonatomic, readonly, nonnull) NSDictionary<NSString *, DMRegisterItem *> *demoItemsDict;
@property (nonatomic, readonly, nonnull) NSArray<NSString *> *demoKeysArray;


- (void)registerClass:(NSString *)class withBlock:(DMItemConfigBlock _Nullable)block;

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
