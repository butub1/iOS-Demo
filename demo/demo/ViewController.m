//
//  ViewController.m
//  demo
//
//  Created by butub on 2022/6/22.
//

#import "ViewController.h"
#import "DMHalfScreenViewController.h"


@interface ViewController ()

@property (nonatomic, strong, nullable) UIButton *button2;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self syntaxTest];
    // Do any additional setup after loading the view.
}


- (void)setupUI
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2, 50, 100)];
    button.backgroundColor = [UIColor redColor];

    [self.view addSubview:button];
    [button addTarget:self action:@selector(tapButton) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 50, 100)];
    button2.backgroundColor = [UIColor blueColor];
    self.button2 = button2;
    
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(tapButton2) forControlEvents:UIControlEventTouchUpInside];
    
    /// image 初始没有accessiblity焦点
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [imageView setImage:[UIImage imageNamed:@"aniya0.jpeg"]];
    imageView.accessibilityLabel = @"asdf";
    imageView.accessibilityTraits = UIAccessibilityTraitImage;
    imageView.isAccessibilityElement = YES;
    [self.view addSubview:imageView];
    NSLog(@"%s %d %s", __FUNCTION__, __LINE__, __FILE__);
    
}

- (void)tapButton
{
    DMHalfScreenViewController *popup = [[DMHalfScreenViewController alloc] init];
    popup.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [self presentViewController:popup animated:YES completion:^{
        ;
    }];
    
}

- (void)tapButton2
{
//    self.button2.alpha = 0;
    
    [UIView transitionWithView:self.button2 duration:0.3 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        CGRect frame = CGRectOffset(self.button2.frame, 0, 50);
        self.button2.frame = frame;
    } completion:nil];
    
//    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
////        self.button2.alpha = 1;
////        CGRect frame = CGRectOffset(self.button2.frame, 0, 50);
////        self.button2.frame = frame;
//    } completion:^(BOOL finished) {
////        nil
//    }];
//    [UIView animateWithDuration:0.3
//                          delay:0
//                        options:UIViewAnimationOptionTransitionCrossDissolve
//                     animations:^{
////        self.button2.hidden = YES;
//        self.button2.alpha = 1;
//        CGRect frame = CGRectOffset(self.button2.frame, 10, 10);
//        self.button2.frame = frame;
//    }];
}

- (void)syntaxTest
{
    NSDictionary *obj = nil;
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSLog(@"True");
    } else {
        NSLog(@"False");
    }
}



@end
