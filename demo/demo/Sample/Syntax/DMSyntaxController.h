//
//  DMSyntaxController.h
//  Demo
//
//  Created by butub on 2022/6/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DMSyntaxController : UIViewController

@property (nonatomic, strong, nonnull) NSString *nonnullString;
@property (nonatomic, strong, readonly) NSString *interfaceReadonlyProperty;
@property (nonatomic, strong, readwrite) NSString *interfaceReadWriteProperty;

@end

NS_ASSUME_NONNULL_END
