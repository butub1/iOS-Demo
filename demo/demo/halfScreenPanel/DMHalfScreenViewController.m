//
//  DMHalfScreenViewController.m
//  demo
//
//  Created by butub on 2022/6/23.
//

#import "DMHalfScreenViewController.h"

#import <Foundation/Foundation.h>

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
