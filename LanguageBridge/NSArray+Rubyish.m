//
//  NSArray+Rubyish.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 11/14/13.
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

#import "NSArray+Rubyish.h"

@implementation NSArray (Rubyish)

- (id)at:(NSInteger)index {
    NSInteger size = [self count];
    if ((index < 0 && abs(index) > size) || index >= size) {
        return nil;
    }
    if (index < 0) {
        index = size + index;
    }
    return [self objectAtIndex:index];
}

- (NSArray *)collect:(id(^)(id obj))block {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [array addObject:block(obj)];
    }];
    return array;
}

- (NSArray *)compact {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (obj != [NSNull null]) {
            [array addObject:obj];
        }
    }];
    return array;
}

- (NSArray *)concat:(NSArray *)otherArray {
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self];
    [array addObjectsFromArray:otherArray];
    return array;
}

- (NSUInteger)count:(BOOL(^)(id obj))block {
    __block NSUInteger c = 0;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block(obj)) {
            c++;
        }
    }];
    return c;
}

- (NSArray *)deleteAt:(NSInteger)idx {
    if (idx >= [self count]) {
        return nil;
    }
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self];
    [array removeObjectAtIndex:idx];
    return array;
}

- (NSArray *)deleteObj:(id)obj {
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:self];
    [array removeObject:obj];
    if ([array count] == [self count]) {
        return nil;
    }
    return array;
}

- (NSArray *)deleteIf:(BOOL (^)(id obj))block {
    return [self keepWithBlock:^BOOL(id o) {
        return !block(o);
    }];
}

- (NSArray *)drop:(NSUInteger)count {
    if (count == 0) {
        return [self copy];
    } else if (count >= [self count]) {
        return @[];
    }
    
    NSMutableArray *arrayToUpdate = [[NSMutableArray alloc] initWithArray:self];
    [arrayToUpdate removeObjectsInRange:NSMakeRange(0,count)];
    return arrayToUpdate;
}

- (void)each:(void (^)(id obj))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (BOOL)empty {
    return [self count] == 0;
}

- (id)find:(BOOL(^)(id obj))block {
    __block id firstFoundObj = nil;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block(obj)) {
            firstFoundObj = obj;
            *stop = YES;
        }
    }];
    return firstFoundObj;
}

- (NSArray *)findAll:(BOOL(^)(id obj))block {
    NSMutableArray *objectsToKeep = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block(obj)) {
            [objectsToKeep addObject:obj];
        }
    }];
    return objectsToKeep;
}

- (NSArray *)flatten {
    NSMutableArray *objectsToReturn = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj respondsToSelector:@selector(flatten)]) {
            NSArray *flattenObjs = [obj performSelector:@selector(flatten)];
            [objectsToReturn addObjectsFromArray:flattenObjs];
        } else {
            [objectsToReturn addObject:obj];
        }
    }];
    return objectsToReturn;
}

- (BOOL)include:(id)objIncluded {
    return [self indexOfObject:objIncluded] != NSNotFound;
}

- (id)inject:(id)initial block:(id(^)(id memo, id obj))block {
    if ([self count] == 0) {
        return initial;
    }
    __block id returnVal = initial;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        returnVal = block(returnVal, obj);
    }];
    return returnVal;
}

- (NSString *)join:(NSString *)separator {
    return [self componentsJoinedByString:separator];
}

- (id)max {
    return [self maxMin:^NSComparisonResult(id a, id b) {
        return [a compare:b];
    } compareValue:NSOrderedAscending];
}

- (id)max:(NSComparisonResult(^)(id a, id b))block {
    return [self maxMin:block compareValue:NSOrderedAscending];
}

- (id)min {
    return [self maxMin:^NSComparisonResult(id a, id b) {
        return [a compare:b];
    } compareValue:NSOrderedDescending];
}

- (id)min:(NSComparisonResult(^)(id a, id b))block {
    return [self maxMin:block compareValue:NSOrderedDescending];
}

- (id)maxMin:(NSComparisonResult(^)(id a, id b))block compareValue:(NSComparisonResult)compareValue {
    NSUInteger size = [self count];
    if (size == 0) {
        return nil;
    } else if (size == 1) {
        return [self firstObject];
    }
    __block id maxMinValue = [self firstObject];
    for (NSUInteger i = 1; i < size; i++) {
        id obj = [self objectAtIndex:i];
        if (block(maxMinValue, obj) == compareValue) {
            maxMinValue = obj;
        }
    }
    return maxMinValue;
}

- (NSArray *)reject:(BOOL(^)(id obj))block {
    NSMutableArray *objectsToRemove = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block(obj)) {
            [objectsToRemove addObject:obj];
        }
    }];
    if ([objectsToRemove count] == 0) {
        return [self copy];
    }
    NSMutableArray *arrayToUpdate = [[NSMutableArray alloc] initWithArray:self];
    [arrayToUpdate removeObjectsInArray:objectsToRemove];
    return arrayToUpdate;
}

- (NSArray *)reverse {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [array addObject:obj];
    }];
    return array;
}

- (void)reverseEach:(void(^)(id obj))block {
    [self enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        block(obj);
    }];
}

- (NSUInteger)rindex:(id)objToFind {
    return [self indexOfObjectWithOptions:NSEnumerationReverse passingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return [objToFind isEqual:obj];
    }];
}

- (NSArray *)rotate:(int)count {
    if (count == 0) {
        return [self copy];
    }
    BOOL flip = count < 0;
    count = abs(count);
    int size = [self count];
    count = count % size;

    int firstStart = 0, firstLength, secondStart, secondLength;
    if (flip) {
        firstLength = size - count;
        secondStart = size - count;
        secondLength = count;
    } else {
        firstLength = count;
        secondStart = count;
        secondLength = size - count;
    }
    NSArray *firstPart = [self subarrayWithRange:NSMakeRange(firstStart, firstLength)];
    NSArray *secondPart = [self subarrayWithRange:NSMakeRange(secondStart, secondLength)];    
    return [secondPart concat:firstPart];
}

- (NSArray *)select:(BOOL(^)(id obj))block {
    return [self findAll:block];
}

- (NSArray *)slice:(int)start length:(int)length {
    int size = [self count];
    if (start >= size) {
        return @[];
    } else if (start < 0) {
        start = size - abs(start);
    }
    if (start + length > size) {
        length = size;
    }
    return [self subarrayWithRange:NSMakeRange(start, length)];
}

- (NSArray *)sort {
    return [self sortedArrayUsingSelector:@selector(compare:)];
}

- (NSArray *)takeWhile:(BOOL(^)(id obj))block {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        BOOL take = block(obj);
        if (take) {
            [array addObject:obj];
        } else {
            *stop = YES;
        }
    }];
    return array;
}

- (NSArray *)unique {
    NSMutableSet *s = [[NSMutableSet alloc] init];
    NSMutableArray *uniqItems = [[NSMutableArray alloc] init];
    [self each:^(id obj) {
        if (![s containsObject:obj]) {
            [s addObject:obj];
            [uniqItems addObject:obj];
        }
    }];
    return uniqItems;
}

- (NSArray *)keepWithBlock:(BOOL(^)(id obj))block {
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    [self each:^(id o) {
        if (block(o)) {
            [objects addObject:o];
        }
    }];
    return objects;
}

@end
