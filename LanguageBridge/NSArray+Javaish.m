//
//  NSArray+Javaish.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 1/4/14.
//  Copyright (c) 2014 Ryan Ilagan. All rights reserved.
//

#import "NSArray+Javaish.h"

@implementation NSArray (Javaish)

- (BOOL)containsAll:(NSArray *)ary {
    __block BOOL allFound = YES;
    [ary enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![self containsObject:obj]) {
            allFound = NO;
            *stop = YES;
        }
    }];
    return allFound;
}

- (id)get:(NSUInteger)idx {
    return [self objectAtIndex:idx];
}

- (BOOL)isEmpty {
    return [self count] == 0;
}

- (NSUInteger)size {
    return [self count];
}

@end
