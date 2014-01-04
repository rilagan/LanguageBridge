//
//  NSMutableDictionary+Javaish.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 1/4/14.
//  Copyright (c) 2014 Ryan Ilagan. All rights reserved.
//

#import "NSMutableDictionary+Javaish.h"

@implementation NSMutableDictionary (Javaish)

- (void)put:(id)key forObj:(id)obj {
    [self setObject:obj forKey:key];
}

- (void)putAll:(NSDictionary *)dict {
    [self setValuesForKeysWithDictionary:dict];
}

@end
