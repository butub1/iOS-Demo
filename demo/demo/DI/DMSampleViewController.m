//
//  DMSampleViewController.m
//  Demo
//
//  Created by butub on 2022/9/17.
//

#import "DMSampleViewController.h"

#import "DMMacros.h"


dm_registerDemo(DMSampleViewController, {
    item.identifier = @"DI.Sample";
    item.author = @"butub";
    item.email = @"butub666@gmail.com";
})

@interface DMSampleViewController ()

@end

@implementation DMSampleViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
}

- (UIModalPresentationStyle)modalPresentationStyle
{
//    return UIModalPresentationOverFullScreen;
//    return UIModalPresentationCustom;
    return UIModalPresentationPopover;
//    return UIModalPresentationFullScreen;
}

@end
