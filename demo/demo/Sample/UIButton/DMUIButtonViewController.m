//
//  DMUIButtonViewController.m
//  demo
//
//  Created by butub on 2023/3/19.
//

#import "DMUIButtonViewController.h"

#import "DMMacros.h"

#import "Masonry.h"

dm_registerDemo(DMUIButtonViewController, {
    item.identifier = @"Sample.UIButton";
    item.author = @"hippo";
});


//= begin cell =====================================

/**  思考🤔
 如何通过配置，来定义好， 视图、行为、数据，并且做好数据的绑定
 * rails 中，是通过 ROUTER， 来用脚本语言的动态化语言，去做的配置和转发
 * java中， 是通过BEAN(我猜)， xml上绑定了数据和行为， 去做的配置和转发
 * 在OC中， 我们如何兼容ViewController这种框架，和， 我这种配置的框架性需求
 *  * 需要兼容一些东西，编译时， 和， 运行时， 我需要类似注解的机制， 或者自己构建这样的配置能力。
 *  * 依赖注入能力，并不是关键， 关键还是更好的绑定，更加方便的绑定，并且能够很好地，很方便地使用。
 *  * 我需要对系统框架做一点改变， 借用category来添加能力， 借助宏，来方便使用。
 
 * * 比如对于，UICollectionViewCell, 去做一个很方便的配置方法。
 *  * UICollectionViewCell + DMQuickHelper
 *   * configWithBlock(idenfifier, data, cell)
 *  * 注入方式，dm_register_cell(targetController,   configBlock(idenfifier, data, cell) {
        // 在这里配置，在这里搞，配置cell，你会在这里获取到data，
*          });
 * 哈哈哈， 其实有点好玩的。在OC中的注入，不可避免使用category，// 当然如果你喜欢使用 +load，其他运行时能力，也都是可以的，我喜欢category， 并且我对于性能不那么敏感/。
 */

@interface DMUICollectionCell : UICollectionViewCell

@property (nonatomic, copy) NSString *cellName; // optional

@property (nonatomic, copy) void (^configViewWithBlock)(NSString *identifier, id data, UICollectionViewCell *selfCell);

@end


@implementation DMUICollectionCell

- (void)configViewWithBlock:(NSString *)identifier data:(id)data selfCell:(UICollectionViewCell *)selfCell
{
    self.configViewWithBlock(identifier, data, self);
}

@end

#define dm_register_cell( targetVC , data, cellClass, configViewWithBlock) \
@interface cellClass : DMUICollectionCell \
@end \
@implementation cellClass \
- (void)configViewWithBlock:(NSString *)identifier data:(id)data selfCell:(UICollectionViewCell *)selfCell \
{\
    self.configViewWithBlock(identifier, data, self);\
}\
@end \
@interface DMRegisterCenter( targetVC ## _CellClass) \
- (void)user_register_ ## CellClass ## _For_ ## targetVC ##;\
@end; \
@implementation DMRegisterCenter( targetVC ## _CellClass ) \
- (void)user_register_ ## CellClass ## _For_ ## targetVC ##\
{\
    [self registerClass:@#class withBlock:^(DMRegisterItem *item) { \
        block \
    }]; \
}\
@end




//= end cell =====================================


//= begin DMUIButtonCell
@interface DMUIButtonCell : DMUICollectionCell

@end

@implementation DMUIButtonCell

-(void)configViewWithData:(id)data
{
    
}

@end

//= end DMUIButtonCell

#define registerCell(cellClass, dataClass) \


@interface DMUIButtonViewController ()

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation DMUIButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDefaultData];
    [self setupUI];
}

- (void)setupDefaultData
{
    
}

- (void)setupUI
{
    // config self.view
    self.view.backgroundColor = [UIColor colorWithRed:20.f green:96.f blue:97.f alpha:0.8f];
    
    // config collection view
    self.collectionView = [self buildUICollectionView];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(UICollectionViewFlowLayout *)buildUICollectionViewLayout
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    return layout;
}

- (UICollectionView *)buildUICollectionView
{
    UICollectionViewFlowLayout *layout = [self buildUICollectionViewLayout];
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    collectionView.delegate = self;
    collectionView.dataSource = self;
    
    [collectionView registerClass:<#(nullable Class)#> forCellWithReuseIdentifier:<#(nonnull NSString *)#>]
    
    return collectionView;
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
