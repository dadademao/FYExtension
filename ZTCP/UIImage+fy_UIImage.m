
//
//  UIImage+fy_UIImage.m
//  ZTCP
//
//  Created by fuyuan on 2017/5/3.
//  Copyright © 2017年 fuyuan. All rights reserved.
//

#import "UIImage+fy_UIImage.h"
#import <objc/message.h>
@implementation UIImage (fy_UIImage)


+ (void)load {
    Method method1 = class_getClassMethod(self, @selector(imageNamed:));
    Method method2 = class_getClassMethod(self, @selector(fy_imageNamed:));
    method_exchangeImplementations(method1, method2);
}


+ (instancetype)fy_imageNamed:(NSString *)name {
    UIImage *image = [UIImage fy_imageNamed:name];
    if (image) {
        NSLog(@"成功");
    } else {
        NSLog(@"fail");
    }
    return image;
    
}
@end
