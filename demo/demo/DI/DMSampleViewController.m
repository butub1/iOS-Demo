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

@interface DMSampleViewController ()

@end

@implementation DMSampleViewController
- (void)viewDidLoad
{
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor greenColor];

//    DMRegisterCenter *center = DemoCenter();
//    [center loadAllItemsFromCategories];
//    NSDictionary *dict = [DemoCenter() demoItemsDict];
//    NSLog(@"%@", dict);

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
