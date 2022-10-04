//
//  DMSampleViewController.m
//  Demo
//
//  Created by butub on 2022/9/17.
//

#import "DMSampleViewController.h"

#import "DMMacros.h"


dm_registerDemo(DMSampleViewController, {
    item.identifier = @"Sample.UIButton";
})


//@interface DMRegisterCenter( DMSampleViewController ) - (void)registerItemsFor_DMSampleViewController;@end; @implementation DMRegisterCenter( DMSampleViewController ) - (void)registerItemsFor_DMSampleViewController{ [self registerClass:@"DMSampleViewController" withBlock:^(DMRegisterItem *item) { { item.identifier = @"UIButton.Sample";} }]; }@end;

//#define registerDemo( block ) dm_registerDemo(getClassNameV2(__func__), block)

//@interface DMRegisterCenter( DMSampleViewController ) - (void)registerItemsFor_DMSampleViewController;@end; @implementation DMRegisterCenter( DMSampleViewController ) - (void)registerItemsFor_DMSampleViewController{ [self registerClass:@"DMSampleViewController" withBlock:{^(DMRegisterItem *item) { { ;} }]; }@end;

//@interface DMRegisterCenter( DMSampleViewController ) - (void)registerItemsFor_DMSampleViewController;@end; @implementation DMRegisterCenter( DMSampleViewController ) - (void)registerItemsFor_DMSampleViewController{ ([self registerClass:@"DMSampleViewController" withBlock:]); };@end;





//registerDemo(<#class#>, <#block#>);
/* 在这里搞出一个宏展开，自动产生一个category，并且自动注入到全局的列表中去
class
 path
 identifier
 description
@registerDemoClass()
 @registerDemoPath()
 @registerDemoDesction()

 @registerDemo {
    demo.identifier = @"";
    demo.descripthonURL = @"";
    demo.path = @"" /// 无则自动生成
    demo.author = @"";
    demo.icon = @"";
 }
*/




@interface DMSampleViewController () @end
@implementation DMSampleViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    DMRegisterCenter *center = DemoCenter();
    [center loadAllItemsFromCategories];
    NSDictionary *dict = [DemoCenter() demoItemsDict];
    NSLog(@"%@", dict);

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
