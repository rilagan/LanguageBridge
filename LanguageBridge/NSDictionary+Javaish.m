//
//  NSDictionary+Javaish.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 1/3/14.
//  Copyright (c) 2014 Ryan Ilagan. All rights reserved.
//

#import "NSDictionary+Javaish.h"

@implementation NSDictionary (Javaish)

- (id)get:(id)key {
    return [self objectForKey:key];
}

- (BOOL)containsKey:(id)key {
    return [self objectForKey:key] != nil;
}

- (BOOL)isEmpty {
    return [self count] == 0;
}

- (NSUInteger)size {
    return [self count];
}

@end
