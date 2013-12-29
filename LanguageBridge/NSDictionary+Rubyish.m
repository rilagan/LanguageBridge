//
//  NSDictionary+Rubyish.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 11/19/13.
//
//

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
