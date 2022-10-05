//
//  DMLayoutViewController.m
//  Demo
//
//  Created by butub on 2022/9/28.
//

#import "DMLayoutViewController.h"

#import "DMMacros.h"

#import "Masonry.h"

@interface ContainerView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, assign) CGFloat collectionWidth;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton *button;

@end

@implementation ContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _collectionWidth = 100;
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

    layout.itemSize = CGSizeMake(48, 48);

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];

    self.button = [[UIButton alloc] initWithFrame:CGRectZero];
    self.button.backgroundColor = [UIColor greenColor];
    [self.button addTarget:self action:@selector(updateWidth) forControlEvents:UIControlEventTouchUpInside];

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"asdf"];

    [self addSubview:self.collectionView];
    [self addSubview:self.button];

    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.collectionView.mas_right).offset(20);
        make.width.height.equalTo(@48);
        make.right.lessThanOrEqualTo(self);
    }];

    [self updateLayout];
}

- (void)updateWidth
{
    self.collectionWidth += 50;
    [self updateLayout];
}

- (CGFloat)getWidth
{
    return self.collectionWidth;
}

- (void)updateLayout
{
//    [self.collectionView mas_remakeConstraints:<#^(MASConstraintMaker *make)block#>]
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(10);
        make.height.equalTo(@48);
//        make.right.equalTo(self.button.mas_left).offset(-20);
//        make.width.equalTo(@([self getWidth]));
    }];
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"asdf" forIndexPath:indexPath];

    cell.backgroundColor = [UIColor blueColor];

    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}


@end


dm_registerDemo(DMLayoutViewController, {
    item.identifier = @"Sample.Layout";
    item.author = @"butub";
})


@interface DMLayoutViewController ()

@end

@implementation DMLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}


- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    ContainerView *containerView = [[ContainerView alloc] initWithFrame:CGRectZero];

    [self.view addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
        make.height.equalTo(@48);
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
