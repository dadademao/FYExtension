//
//  NSObject+FYExtension.h
//  ZTCP
//
//  Created by fuyuan on 2017/5/3.
//  Copyright © 2017年 fuyuan. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol ObjectModelDelegate <NSObject>
@optional
+ (NSDictionary *)arrayContainModelClass;

@end

@interface NSObject (FYExtension) <ObjectModelDelegate>
+ (instancetype) modelWithDictionary:(NSDictionary *)dictoinary;
+ (NSDictionary *) dictionaryFromModel:(id)model;
@end
