//
//  DMHalfScreenViewController.m
//  demo
//
//  Created by butub on 2022/6/23.
//

#import "DMHalfScreenViewController.h"

#import <Foundation/Foundation.h>

#import "DMMacros.h"

dm_registerDemo(DMHalfScreenViewController, {
    item.identifier = @"Sample.HalfScreen.VC实现";
})

@interface DMHalfScreenViewController ()

@end

@implementation DMHalfScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor grayColor];
    /// setup UI
    CGRect panelFrame = CGRectMake(0, 350, self.view.bounds.size.width, 350);
    UIView *panelView = [[UIView alloc] initWithFrame:panelFrame];
    panelView.backgroundColor = [UIColor blueColor];
    
    UIControl *backView = [[UIControl alloc] initWithFrame:self.view.frame];
    [backView addTarget:self action:@selector(tapExitButton) forControlEvents:UIControlEventTouchUpInside];
//    UIView *backView = [[UIView alloc] initWithFrame:self.view.frame];
    backView.backgroundColor = [UIColor clearColor];
    
    UIButton *exitButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 50, 100)];
    exitButton.backgroundColor = [UIColor yellowColor];
    [exitButton addTarget:self action:@selector(tapExitButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backView];
    [self.view addSubview:panelView];
    [self.view addSubview:exitButton];
}

- (void)tapExitButton
{
    [self dismissViewControllerAnimated:YES completion:^{
        ;
    }];
}

- (UIModalPresentationStyle)modalPresentationStyle
{
    return UIModalPresentationOverFullScreen;
//    return UIModalPresentationCustom;
//    return UIModalPresentationPopover;
//    return UIModalPresentationFullScreen;
}

@end
