//
//  DMBaseViewController.m
//  Demo
//
//  Created by butub on 2022/6/16.
//

#import "DMSyntaxController.h"

//#import <Toast/Toast.h>

//#import "DMPopupViewController.h"

@interface DMSyntaxController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DMSyntaxController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dictionaryTest];
    [self readonlyPropertyTest];
    [self setupUI];
    [self syntaxTest];
    [self jsonTest];
    [self nonnullTestWithStr:nil];
    [self hitTestTest];
    // Do any additional setup after loading the view.
}

- (void)hitTestTest
{

}

- (void)nonnullTestWithStr:(NSString *)str
{
    self.nonnullString = str;
    NSLog(@"%@", self.nonnullString);
}

- (void)dictionaryTest
{
//    空参数
//    NSString *str = nil;
//    NSDictionary *dict = @{
//        @"1" : str
//    };

//    NSString *str = nil;
//    NSDictionary *dict = @{
//        @"1" : str ?: @""
//    };

    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"1"] = nil;

}

- (void)readonlyPropertyTest
{
    /// implement, extension, category, 都不覆写，有 synthesize 下划线变量
    _interfaceReadonlyProperty = @"";
    _interfaceReadWriteProperty = @"";


    /// implement覆写getter方法, extension, category, 都不覆写，有synthesize 下划线变量
    _interfaceReadonlyProperty = @""; /// readonly 属性, 重写 getter 方法，不再 synthesize
    _interfaceReadWriteProperty = @"";

    /// implement覆写getter方法, extension, category, 都不覆写，有synthesize 下划线变量
    _interfaceReadonlyProperty = @""; /// readonly 属性，无 setter 方法
    _interfaceReadWriteProperty = @""; /// readwrite 属性，两个方法都被重写， 不再 synthesize ; 只重写 setter, 会 synthesize getter
}

//- (NSString *)interfaceReadonlyProperty
//{
//
//}

//- (NSString *)interfaceReadWriteProperty
//{
//
//}

- (void)setInterfaceReadWriteProperty:(NSString *)interfaceReadWriteProperty
{

}

- (void)jsonTest
{
    NSMutableDictionary *d1 = [@{
        @"asd1f" : @1,
        @"asdf2" : @2
    } mutableCopy];

    d1[@"asdf3"] = @1;

    BOOL rst = [NSJSONSerialization isValidJSONObject:d1];
}

- (void)syntaxTest
{
    CGFloat zero = 0.f;
    NSInteger int_zero = 0;

    CGFloat float_result = 100.f / zero;
    NSInteger int_result = (NSInteger)(100.f / zero);

    CGFloat float_result_divide_int = 100.f / int_zero;
    NSInteger int_result_divide_int = 100 / int_zero;

    CGFloat float_zero_divide_int = 0 / int_zero;
    NSInteger int_zero_divide_int = 0.f / int_zero;

    NSLog(@"%ld %f", int_result, float_result);
    NSLog(@"int: %ld %f", int_result_divide_int, float_result_divide_int);

    NSLog(@"zero_int: %ld %f", int_zero_divide_int, float_zero_divide_int);

}


- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
//    CGRect windowFrame = [UIWindow a];
//    UIWindow *appWindow = [UIApplication sharedApplication].delegate.window;
//    CGRect windowFrame = appWindow.frame;

    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 100, 50)];
    button.titleLabel.text = @"pop";
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(tapButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];


    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 400, 32, 32)];
    imageView.image = [self p_getImageWithRatioWidth:9.f height:16.f longestSideLength:12.f];
    imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:imageView];

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];

}

- (UIImage *)p_getImageWithRatioWidth:(CGFloat)width
                               height:(CGFloat)height
                    longestSideLength:(CGFloat)longestSideLength
{
    return [self p_getImageWithRatioWidth:width height:height longestSideLength:longestSideLength imageWidth:32.f minPadding:4.f cornerRadius:2.f lineWidth:2.f lineColor:[UIColor whiteColor] screenRatio:1.f];
}

- (UIImage *)p_getImageWithRatioWidth:(CGFloat)width
                               height:(CGFloat)height
                    longestSideLength:(CGFloat)longestSide
                           imageWidth:(CGFloat)imageWidth
                           minPadding:(CGFloat)padding
                         cornerRadius:(CGFloat)cornerRadius
                            lineWidth:(CGFloat)lineWidth
                            lineColor:(UIColor *)lineColor
                          screenRatio:(CGFloat)screenRatio
{


    imageWidth = imageWidth * screenRatio;
    padding = padding * screenRatio;
    cornerRadius = cornerRadius * screenRatio;
    lineWidth = lineWidth * screenRatio;

    CGFloat longestSideLength = longestSide > 0.f ? longestSide : imageWidth - padding * 2;
    longestSideLength = longestSideLength * screenRatio;


    CGFloat width_ratio = width >= height ? 1.f : (width / height);
    CGFloat height_ratio = height >= width ? 1.f : (height / width);

    CGFloat rect_width = longestSideLength * width_ratio;
    CGFloat rect_height = longestSideLength * height_ratio;

    CGFloat rect_x = (imageWidth - rect_width) / 2.f;
    CGFloat rect_y = (imageWidth - rect_height) / 2.f;

    CGRect rectFrame = CGRectMake(rect_x, rect_y, rect_width, rect_height);
    CGSize imageSize = CGSizeMake(imageWidth, imageWidth);

//    imageSize = CGSizeMake(imageSize.width * screenRatio, imageSize.height * screenRatio);
//    rectFrame = CGRectMake(rectFrame.origin.x * screenRatio, rectFrame.origin.y * screenRatio, rectFrame.size.width * screenRatio, rectFrame.size.height * screenRatio);

    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    UIBezierPath *bezierPath_RoundedRect = [UIBezierPath bezierPathWithRoundedRect:rectFrame cornerRadius:cornerRadius];
        bezierPath_RoundedRect.lineWidth = lineWidth;

    [[UIColor clearColor] set];
    [bezierPath_RoundedRect fill];
    [[UIColor whiteColor] set];
    [bezierPath_RoundedRect stroke];



//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, size.width, image.size.height)];
//    [bezierPath_RoundedRect addClip];
//    [image drawAtPoint:CGPointZero];
    UIImage *newImage =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)tapButton
{
//    UIViewController *popVC = [[DMPopupViewController alloc] init];

//    [self.view makeToast:@"hit button"];

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
