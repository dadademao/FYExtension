//
//  NSObject+fy_obj.m
//  ZTCP
//
//  Created by fuyuan on 2017/5/3.
//  Copyright © 2017年 fuyuan. All rights reserved.
//

#import "NSObject+fy_obj.h"
#import <objc/message.h>
@implementation NSObject (fy_obj)


- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, @"name", name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (NSString *)name {
   return objc_getAssociatedObject(self, @"name");
    
}
@end
