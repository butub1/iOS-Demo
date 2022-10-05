//
//  DMCollectionViewDragViewController.m
//  Demo
//
//  Created by butub on 2022/9/26.
//

#import "DMCollectionViewDragViewController.h"

#import "Masonry.h"

#import "DMMacros.h"

@interface DMDragCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, copy) UIColor *color;

@end

@implementation DMDragCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)configWithTitle:(NSString *)title color:(UIColor *)color
{
    self.backgroundColor = color;
    self.label.text = title;
}

- (void)setupUI
{
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.centerY.equalTo(self.contentView);
    }];
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] initWithFrame:CGRectZero];
        _label.text = @"init";
    }
    return _label;
}

@end


@class DMTrashView;
@protocol DMTrashViewDelegate <NSObject>

- (void)trashView:(DMTrashView *)trashView removeItemAtIndex:(NSIndexPath *)indexPath;

@end


@interface DMTrashView : UIView <UIDropInteractionDelegate>

@property (nonatomic, weak) id<DMTrashViewDelegate> delegate;

@end

@implementation DMTrashView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI
{
    UIDropInteraction *interaction = [[UIDropInteraction alloc] initWithDelegate:self];
    [self addInteraction:interaction];
}


- (BOOL)dropInteraction:(UIDropInteraction *)interaction canHandleSession:(id<UIDropSession>)session
{

    return YES;
}

- (UIDropProposal *)dropInteraction:(UIDropInteraction *)interaction sessionDidUpdate:(id<UIDropSession>)session
{
    self.backgroundColor = [UIColor greenColor];
    return [[UIDropProposal alloc] initWithDropOperation:UIDropOperationMove];
}

- (void)dropInteraction:(UIDropInteraction *)interaction performDrop:(id<UIDropSession>)session
{
    UIDragItem *item = session.items.firstObject;

    NSNumber *num = item.localObject;

    self.backgroundColor = [UIColor redColor];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[num integerValue] inSection:0];

    [self.delegate trashView:self removeItemAtIndex:indexPath];
//    NSLog(@"num: %@", num);
}


- (void)dropInteraction:(UIDropInteraction *)interaction sessionDidEnter:(id<UIDropSession>)session
{

}

- (void)dropInteraction:(UIDropInteraction *)interaction sessionDidExit:(id<UIDropSession>)session
{
    self.backgroundColor = [UIColor redColor];
}

@end


dm_registerDemo(DMCollectionViewDragViewController, {
    item.identifier = @"Sample.Drag.CollectionView";
})

@interface DMCollectionViewDragViewController ()
<UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDragDelegate,
UICollectionViewDropDelegate,
DMTrashViewDelegate
>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) DMTrashView *trashView;

@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation DMCollectionViewDragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}


- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];

    /// collectionView
    self.collectionView.collectionViewLayout = self.layout;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.dragInteractionEnabled = YES; /// 允许拖动
    self.collectionView.reorderingCadence = UICollectionViewReorderingCadenceImmediate; ///  重拍顺序节奏
    self.collectionView.springLoaded = YES; /// 开启 spring load

    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.dragDelegate = self;
    self.collectionView.dropDelegate = self;

    [self.collectionView registerClass:[DMDragCell class] forCellWithReuseIdentifier:[self dragCellIdentifier]];

    [self.view addSubview:self.collectionView];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.right.equalTo(self.view).offset(-100);
        make.height.equalTo(@100);
        make.center.equalTo(self.view);
    }];

    /// trash
    [self.view addSubview:self.trashView];
    [self.trashView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-100);
        make.width.height.equalTo(@100);
    }];
}


- (NSString *)dragCellIdentifier
{
    return NSStringFromClass([DMDragCell class]);
}



#pragma mark - Getter


- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.minimumInteritemSpacing = 2;
        _layout.minimumInteritemSpacing = 6;
        _layout.itemSize = CGSizeMake(48, 48);
    }
    return _layout;
}


- (DMTrashView *)trashView
{
    if (!_trashView) {
        _trashView = [[DMTrashView alloc] initWithFrame:CGRectZero];
        _trashView.backgroundColor = [UIColor redColor];
        _trashView.delegate = self;
    }
    return _trashView;
}

- (NSMutableArray *)datas
{
    if (!_datas) {
        NSMutableArray *data = [NSMutableArray array];
        for (int i = 1; i <= 10; i++) {
            [data addObject:@(i)];
        }
        _datas = data;
    }
    return _datas;
}

#pragma mark - DMTrashViewDelegate


- (void)trashView:(DMTrashView *)trashView removeItemAtIndex:(NSIndexPath *)indexPath
{
    [self.datas removeObjectAtIndex:indexPath.row];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


#pragma mark - UICollectionView - DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    DMDragCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[self dragCellIdentifier] forIndexPath:indexPath];

    NSNumber *num = (NSNumber *)[self.datas objectAtIndex:indexPath.row];

    NSString *name = [NSString stringWithFormat:@"%@", num];

    [cell configWithTitle:name color:[UIColor blueColor]];

    return cell;
}


#pragma mark - UICollectionView - Delegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{


}


#pragma mark - UICollectionView - Drag

- (void)collectionView:(UICollectionView *)collectionView dragSessionWillBegin:(id<UIDragSession>)session
{
    /// pass
}

- (void)collectionView:(UICollectionView *)collectionView dragSessionDidEnd:(id<UIDragSession>)session
{
    /// pass
}

/// requried, 允许拖动的 cell, 返回多个， 一同拖动
- (NSArray<UIDragItem *> *)collectionView:(UICollectionView *)collectionView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = [NSString stringWithFormat:@"%@", @(indexPath.row)];

    NSNumber *data = @(indexPath.row); ///[self.datas objectAtIndex:indexPath.row ];

    NSItemProvider *provider = [[NSItemProvider alloc] initWithObject:name];

    UIDragItem *dragItem = [[UIDragItem alloc] initWithItemProvider:provider];

    dragItem.localObject = data;

    return @[dragItem];
}

//- (UIDragPreviewParameters *)collectionView:(UICollectionView *)collectionView dragPreviewParametersForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}




#pragma mark - UICollectionView - Drop

/// required, 使用 dropCoordinator 去处理当前 dropSession 的 item 到指定的位置，同时根据 dropItem 的数据更新数据源
- (void)collectionView:(UICollectionView *)collectionView performDropWithCoordinator:(id<UICollectionViewDropCoordinator>)coordinator
{
    NSIndexPath *dIndexPath = coordinator.destinationIndexPath;
    NSIndexPath *sIndexPath = coordinator.items.firstObject.sourceIndexPath;

    id<UIDropSession> session = [coordinator session];
    CGPoint location = [session locationInView:self.trashView];

    UIDragItem *item = coordinator.items.firstObject.dragItem;

    NSItemProvider *provider = item.itemProvider;

    __block NSNumber *num = @100;


//    if ([provider canLoadObjectOfClass:[NSNumber class] ]) {
//        [provider loadObjectOfClass:[NSNumber class] completionHandler:^(__kindof id<NSItemProviderReading>  _Nullable object, NSError * _Nullable error) {
//            num = object;
//        }];
//    }
    if (item.localObject) {
        NSNumber *row = item.localObject;
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[row integerValue] inSection:0];
        num = [self.datas objectAtIndex:[row integerValue]];
    }


    [coordinator dropItem:item toItemAtIndexPath:dIndexPath];


    [self.datas removeObjectAtIndex:sIndexPath.row];
    [self.datas insertObject:num atIndex:dIndexPath.row];

//    [self.collectionView reloadData];
    [collectionView performBatchUpdates:^{
        [collectionView deleteItemsAtIndexPaths:@[sIndexPath]];
        [collectionView insertItemsAtIndexPaths:@[dIndexPath]];
    } completion:^(BOOL finished) {
//        <#code#>
    }];

}

//- (BOOL)collectionView:(UICollectionView *)collectionView canHandleDropSession:(id<UIDropSession>)session
//{
//    return YES;
//}


- (UICollectionViewDropProposal *)collectionView:(UICollectionView *)collectionView dropSessionDidUpdate:(id<UIDropSession>)session withDestinationIndexPath:(NSIndexPath *)destinationIndexPath
{

//    CGPoint location = [session locationInView:[[UIApplication sharedApplication] windows].firstObject];
//    CGPoint location = [session locationInView:self.trashView];
//    BOOL inTrash =

    return [[UICollectionViewDropProposal alloc] initWithDropOperation:UIDropOperationMove intent:UICollectionViewDropIntentInsertAtDestinationIndexPath];
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


