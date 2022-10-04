//
//  DMMacros.h
//  Demo
//
//  Created by butub on 2022/9/17.
//

#import <Foundation/Foundation.h>

#import "DMRegisterCenter.h"

__unused static NSString *getClassNameV2(char *pathOrClassName) {
    NSString *lastPathComp = [[NSString stringWithUTF8String:pathOrClassName] lastPathComponent];
    NSRange plusRange = [lastPathComp rangeOfString:@"+"];
    if (plusRange.location != NSNotFound && plusRange.location < lastPathComp.length) {
        lastPathComp = [lastPathComp substringToIndex:plusRange.location];
    }
    NSRange dotRange = [lastPathComp rangeOfString:@"."];
    if (dotRange.location != NSNotFound && dotRange.location < lastPathComp.length) {
        lastPathComp = [lastPathComp substringToIndex:dotRange.location];
    }
    return lastPathComp;
}

//#import <AWELazyRegister/AWELazyRegisterStaticLoad.h>
//#define AWELazyRegisterModulePostPage "PostPage"
//#define AWERunForPostPage AWELazyRegisterPostPageClass(__FILE__)
//
//#define AWELazyRegisterPostPageClass(ClassName) \
//AWELazyRegisterBlock(AWELazyRegisterUniqueKey, AWELazyRegisterModulePostPage)\
//{\
//    NSString *className = getClassNameV2(ClassName);\
//    Class loadClass = objc_getClass(className.UTF8String);\
//    [loadClass _aweLazyRegisterPostPage];\
//}\

//NS_ASSUME_NONNULL_END
