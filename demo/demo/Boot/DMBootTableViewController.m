//
//  DMBootTableViewController.m
//  demo
//
//  Created by butub on 2022/7/6.
//

#import "DMBootTableViewController.h"

#import "DMMacros.h"

@interface DMBootTableViewController()

@property (nonatomic, strong) NSMutableArray<NSString *> *keysArray;

@end


@implementation DMBootTableViewController


- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];

    DMRegisterCenter *center = DemoCenter();
    [center loadAllItemsFromCategories];
    self.keysArray = [[center demoKeysArray] mutableCopy];
}

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
//    if ([vcClass isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = [[vcClass alloc] init];
        [self presentViewController:vc animated:YES completion:nil];
//    }
}


@end
