//
//  DMBootTableViewController.m
//  demo
//
//  Created by butub on 2022/7/6.
//

#import "DMBootTableViewController.h"

#import "Masonry.h"

#import "DMMacros.h"
#import "DMSampleViewController.h"

@interface DMBootTableViewController()
//<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<NSString *> *keysArray;

@end


@implementation DMBootTableViewController


- (void)viewDidLoad
{
    [self setupUI];
    [self setupData];
}

- (void)setupUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
//    button.backgroundColor = [UIColor blueColor];
//    [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
//    [button mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//        make.width.height.equalTo(@50);
//    }];
}

- (void)tapButton:(id)sender
{
    DMSampleViewController *vc = [[DMSampleViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)setupData
{
    DMRegisterCenter *center = DemoCenter();
    [center loadAllItemsFromCategories];
    self.keysArray = [[center demoKeysArray] mutableCopy];
}


#pragma mark - tableView Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.keysArray.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = [self.keysArray objectAtIndex:indexPath.row];
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = [self.keysArray objectAtIndex:indexPath.row];
    DMRegisterItem *item = [[DemoCenter() demoItemsDict] objectForKey:key];
    Class vcClass = item.targetClass;
    UIViewController *vc = [[vcClass alloc] init];
    if ([vc isKindOfClass:[UIViewController class]]) {
//        [self presentModalViewController:vc animated:YES];
//        [self showViewController:vc sender:self];
        [self presentViewController:vc animated:YES completion:nil];
    }
}

- (UIModalPresentationStyle)modalPresentationStyle
{
//    return UIModalPresentationOverFullScreen;
//    return UIModalPresentationCustom;
//    return UIModalPresentationPopover;
    return UIModalPresentationFullScreen;
}

#pragma mark - getter

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
