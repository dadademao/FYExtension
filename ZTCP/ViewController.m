//
//  ViewController.m
//  ZTCP
//
//  Created by fuyuan on 2017/5/2.
//  Copyright © 2017年 fuyuan. All rights reserved.
//

#import "ViewController.h"
#import <objc/message.h>
#import <UIKit/UIKit.h>
#import "NSObject+fy_obj.h"
#import "NSObject+FYExtension.h"
#import "MyModel.h"
@interface ViewController ()
@property (strong, nonatomic) NSString *home;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"dasd");
//    [self hello];,
    [UIImage imageNamed:@"x"];
    
    NSObject *obj = [NSObject new];
    obj.name = @"nda";
    NSLog(@"%@", obj.name);
    
    NSDictionary *dic = @{
                            @"name":@"dd",
                            @"dog" : @[
                                    @{
                                        @"name":@"haha"

                                        }
                                    ]
                            };
    MyModel *model = [MyModel modelWithDictionary:dic];
    
    NSLog(@"hahah");
    
    NSLog(@"%@",[MyModel dictionaryFromModel:model]);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void) hello {
    NSLog(@"helloWorld");
}



@end
