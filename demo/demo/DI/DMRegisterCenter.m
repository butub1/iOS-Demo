//
//  DMRegisterCenter.m
//  Demo
//
//  Created by butub on 2022/10/4.
//

#import "DMRegisterCenter.h"

#import <objc/runtime.h>

@implementation DMRegisterItem

@end

@interface DMRegisterCenter ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, DMRegisterItem *> *demosDict;
@property (nonatomic, strong) NSMutableDictionary<NSString *, DMRegisterCellItem *> *demoCellsDict;
@end

@implementation DMRegisterCenter

+ (instancetype)sharedInstance
{
    static DMRegisterCenter *shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (void)registerClass:(NSString *)class withBlock:(void (^_Nullable)(DMRegisterItem *))block
{
    DMRegisterItem *item = [[DMRegisterItem alloc] init];
    item.targetClass = NSClassFromString(class);
    if (block) {
        block(item);
        [self.demosDict setObject:item forKey:item.identifier];
    } else {
        NSAssert(NO, @"register item Error");
    }
}

- (void)loadAllItemsFromCategories
{
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);
    for (int i = 0; i < count; i++) {
        SEL methodSelector = method_getName(methods[i]);
        NSString *methodName = [NSString stringWithUTF8String:sel_getName(methodSelector)];
        if ([methodName hasPrefix:@"user_"]) { // 我要把所有user开头的category的运行上， 那么就能注册上
            [self performSelector:methodSelector];
        }
    }
    free(methods);
}

- (NSDictionary<NSString *,DMRegisterItem *> *)demoItemsDict
{
    return self.demosDict;
}

- (NSArray<NSString *> *)demoKeysArray
{
    return [self.demosDict allKeys];
}

- (void)registerCellItemForVC:(NSString *)class WithCell:(NSString *)cellClass
{
    
}

#pragma mark - getter

- (NSMutableDictionary<NSString *,DMRegisterItem *> *)demosDict
{
    if (!_demosDict) {
        _demosDict = [NSMutableDictionary dictionary];
    }
    return _demosDict;
}

- (NSDictionary<NSString *,DMRegisterCellItem *> *)demoCellsDict
{
    if (!_demoCellsDict) {
        _demoCellsDict = [NSMutableDictionary dictionary];
    }
    return _demoCellsDict;
}

@end
