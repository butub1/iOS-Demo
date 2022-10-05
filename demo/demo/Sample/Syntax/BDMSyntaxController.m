//
//  GestureController.m
//  Demo
//
//  Created by butub on 2022/2/18.
//

#import "BDMSyntaxController.h"


NSString * const kDMPassThroughViewString = @"abc";
NSString * kDMPassThroughViewString2 = @"abc";

@implementation BDMSyntaxController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self test];
}


- (NSArray *)test
{
    /// 语法错误
//    NSDictionary *dict = @(nil); /// Illegal type 'void *' used in a boxed expression

    /// 传入nil
//    id s = nil;
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    dict[@"?"] = @(s);

//    NSArray *newArray = @[@"?"];

    return @[];
}







@end
