//
//  NSObject+FYExtension.m
//  ZTCP
//
//  Created by fuyuan on 2017/5/3.
//  Copyright © 2017年 fuyuan. All rights reserved.
//

#import "NSObject+FYExtension.h"
#import <objc/runtime.h>
@implementation NSObject (FYExtension) 

+ (instancetype) modelWithDictionary:(NSDictionary *)dictoinary {
    id objc = [[self alloc] init];
    unsigned int count = 0;
    Ivar *varList = class_copyIvarList(self, &count);
    for (int i = 0; i < count; i++) {
        Ivar var = varList[i];
        
        NSString *ivar_name = [NSString stringWithUTF8String:ivar_getName(var)];
        NSString *key = [ivar_name substringFromIndex:1];
        
        NSString *ivar_type = [NSString stringWithUTF8String:ivar_getTypeEncoding(var)];
        ivar_type = [ivar_type stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        ivar_type = [ivar_type stringByReplacingOccurrencesOfString:@"@" withString:@""];
        
        id value = dictoinary[key];
        if ([value isKindOfClass:[NSDictionary class]] && ![ivar_type hasPrefix:@"NS"]) {
            Class class = NSClassFromString(ivar_type);
            if (class) {
                value = [class modelWithDictionary:value];
            }
        } else if ([value isKindOfClass:[NSArray class]] && [self respondsToSelector:@selector(arrayContainModelClass)]) {
            id idSelf = self;
            NSString *className = [idSelf performSelector:@selector(arrayContainModelClass)][key];
            Class class = NSClassFromString(className);
            NSMutableArray *modelAry = [NSMutableArray array];
            for (NSDictionary *dic in value) {
                id model = [class modelWithDictionary:dic];
                [modelAry addObject:model];
            }
            value = modelAry;
        }
        if (value) {
            [objc setValue:value forKey:key];
        }
    }
    return objc;
}


+ (NSDictionary *) dictionaryFromModel:(id)model {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    Ivar *varList = class_copyIvarList([model class], &count);
    for (int i = 0; i < count; i++) {
        Ivar var = varList[i];
        NSString *var_name = [NSString stringWithUTF8String:ivar_getName(var)];
        NSString *key = [var_name substringFromIndex:1];
        NSString *varType = [NSString stringWithUTF8String:ivar_getTypeEncoding(var)];
        varType = [varType stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        varType = [varType stringByReplacingOccurrencesOfString:@"@" withString:@""];
        Class class = NSClassFromString(varType);
        id value = [model valueForKey:key];
        if ([value isKindOfClass:[NSObject class]] && ![varType hasPrefix:@"NS"]) {
            if (value) {
                value = [class dictionaryFromModel:value];
            }
        } else if ([value isKindOfClass:[NSArray class]] && [self respondsToSelector:@selector(arrayContainModelClass)]) {
            id idSelf = self;
            
            NSString *class_name = [idSelf arrayContainModelClass][key];
            Class modelClass = NSClassFromString(class_name);
            NSMutableArray *subDicAry = [NSMutableArray array];
            if (modelClass) {
                for (NSObject *model in value) {
                    NSDictionary *dic = [modelClass dictionaryFromModel:model];
                    [subDicAry addObject:dic];
                }
            }
            value = subDicAry;
        }
        if (value) {
            [dic setValue:value forKey:key];
        }
        
    }
    return dic;
    
}
@end
