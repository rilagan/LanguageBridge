//
//  NSDictionary+Rubyish.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 11/19/13.
//
//  Copyright (c) 2014 Ryan Ilagan
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "NSDictionary+Rubyish.h"

@implementation NSDictionary (Rubyish)

- (void)eachKey:(void(^)(id k))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(key);
    }];
}

- (void)eachPair:(void(^)(id k, id o))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(key, obj);
    }];
}

- (void)eachValue:(void(^)(id o))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(obj);
    }];
}

- (BOOL)empty {
    return [self count] == 0;
}

- (id)fetch:(id)key {
    return [self objectForKey:key];
}

- (BOOL)include:(id)key {
    return [self objectForKey:key] != nil;
}

- (NSDictionary *)invert {
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    [self eachPair:^(id key, id obj) {
        [d setObject:key forKey:obj];
    }];
    return d;
}

- (NSArray *)keys {
    return [self allKeys];
}

- (BOOL)member:(id)key {
    return [self include:key];
}

- (NSDictionary *)select:(BOOL(^)(id k, id o))block {
    return [self findWithBlock:^BOOL(id key, id obj) {
        return block(key, obj);
    }];
}

- (NSDictionary *)reject:(BOOL(^)(id k, id o))block {
    return [self findWithBlock:^BOOL(id key, id obj) {
        return !block(key, obj);
    }];
}

- (NSDictionary *)findWithBlock:(BOOL(^)(id key, id obj))block {
    NSMutableDictionary *d = [[NSMutableDictionary alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (block(key, obj)) {
            [d setObject:obj forKey:key];
        }
    }];
    return d;
}

@end
