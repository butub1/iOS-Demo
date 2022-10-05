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
}

@end
