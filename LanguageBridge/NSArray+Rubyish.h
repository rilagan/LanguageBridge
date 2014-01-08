//
//  NSArray+Rubyish.h
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

#import <Foundation/Foundation.h>

@interface NSArray (Rubyish)

/**
 * \code
 * NSArray *a = @[@"a", @"b", @"c", @"d"];
 * [a at:0] == @"a"
 * [a at:4] == nil
 * [array at:-4] == @"a"
 * [array at:-5] == nil
 * \endcode
 */
- (id)at:(NSInteger)index;

/**
 * \code
 * NSArray *array = @[@1, @2, @3, @4];
 * NSArray *collectedArray = [array collect:^id(id obj) {
 *     NSInteger v = [((NSNumber *)obj)intValue];
 *     return [NSNumber numberWithInt:v * 2];
 * }];
 * collectedArray == @[@2, @4, @6, @8]
 * \endcode
 */
- (NSArray *)collect:(id(^)(id obj))block;

/**
 * \code
 * NSArray *array = @[@1, [NSNull null], @3, [NSNull null]];
 * [array compact] == @[@1, @3]
 * \endcode
 */
- (NSArray *)compact;

/**
 * \code
 * NSArray *first = @[@1, @2, @3, @4];
 * NSArray *second = @[@5, @6, @7];
 * [first concat:second] == @[@1, @2, @3, @4, @5, @6, @7]
 * \endcode
 */
- (NSArray *)concat:(NSArray *)otherArray;

/**
 * \code
 * NSArray *array = @[@1, @2, @3, @4, @5];
 * NSUInteger count = [array count:^BOOL(id obj) {
 *     NSInteger v = [((NSNumber *)obj)intValue];
 *     return (v % 2) == 0;
 * }];
 * v == 2
 * \endcode
 */
- (NSUInteger)count:(BOOL(^)(id obj))block;

/**
 * \code
 * NSArray *array = @[@1, @2, @3, @4];
 * NSArray *returnedArray = [array deleteAt:1];
 * returnedArray == @[@1, @3, @4];
 * [array deleteAt:99] == nil
 * \endcode
 */
- (NSArray *)deleteAt:(int)idx;

/**
 * \code
 * NSArray *array = @[@1, @2, @3, @4];
 * NSArray *returnedArray = [array deleteObj:@2];
 * returnedArray == @[@1, @3, @4];
 * [array deleteObj:@9] == nil
 * \endcode
 */
- (NSArray *)deleteObj:(id)obj;

/**
 * \code
 * NSArray *array = @[@1, @2, @3, @4];
 * NSArray *returnedArray = [array drop:2];
 * returnedArray == @[@3, @4];
 * \endcode
 */
- (NSArray *)drop:(NSUInteger)count;

/**
 * Calls enumerateObjectsUsingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
 */
- (void)each:(void(^)(id obj))block;

/**
 * \code
 * [@[] empty] == YES
 * [@[@1] empty] == NO
 * \endcode
 */
- (BOOL)empty;

/**
 * \code
 * NSArray *array = @[@1, @2, @3, @4];
 * id foundObj = [array find:^BOOL(id obj) {
 *     NSInteger v = [((NSNumber *)obj)intValue];
 *     return (v % 2) == 0;
 * }];
 * foundObj == @2
 * \endcode
 */
- (id)find:(BOOL(^)(id obj))block;

/**
 * \code
 * NSArray *array = @[@1, @2, @3, @4];
 * NSArray *returnedArray = [array findAll:^BOOL(id obj) {
 * NSInteger v = [((NSNumber *)obj)intValue];
 *     return (v % 2) == 0;
 * }];
 * array == @[@2, @4];
 * \endcode
 */
- (NSArray *)findAll:(BOOL(^)(id obj))block;

/**
 * \code
 * NSArray *nonFlattenedArray = @[@[@1, @2], @3, @[@[@4],@5],@6]
 * [nonFlattenedArray flatten] == @[@1, @2, @3, @4, @5, @6]
 * \endcode
 */
- (NSArray *)flatten;

/**
 * \code
 * NSArray *array = @[@"good", @"hello"];
 * [array include:@"hello"] == YES
 * \endcode
 */
- (BOOL)include:(id)obj;

/**
 * \code
 * NSArray *array = @[@1, @2, @3];
 * NSNumber *sum = [array inject:@0 block:^id(id memo, id obj) {
 *     int m = ((NSNumber *)memo).intValue;
 *     int o = ((NSNumber *)obj).intValue;
 *     return [NSNumber numberWithInt:m+o];
 * }];
 * sum == @6
 * \endcode
 */
- (id)inject:(id)initial block:(id(^)(id memo, id obj))block;

/**
 * Calls componentsJoinedByString
 */
- (NSString *)join:(NSString *)separator;

/**
 * \code
 * NSArray *array = @[@21, @1, @334, @4, @50];
 * [array max] == @334
 * Uses compare: as its underlying implementation
 * \endcode
 */
- (id)max;

/**
 * \code
 * NSArray *array = @[@21, @1, @334, @4, @50];
 * NSNumber *n = [array max:^NSComparisonResult(id a, id b) {
 *     return [a compare:b];
 * }]
 * n == @334
 * \endcode
 */
- (id)max:(NSComparisonResult(^)(id a, id b))block;

/**
 * \code
 * NSArray *array = @[@21, @1, @334, @4, @50];
 * [array min] == @1
 * \endcode
 * Uses compare: as its underlying implementation
 */
- (id)min;

/**
 * \code
 * NSArray *array = @[@21, @1, @334, @4, @50];
 * NSNumber *n = [array min:^NSComparisonResult(id a, id b) {
 *    return [a compare:b];
 * }]
 * n == @1
 * \endcode
 */
- (id)min:(NSComparisonResult(^)(id a, id b))block;

/**
 * \code
 * NSArray *array = @[@1, @2, @3, @4];
 * NSArray *returnedArray = [array reject:^BOOL(id obj) {
 *     NSInteger v = [((NSNumber *)obj)intValue];
 *     return (v % 2) == 0;
 * }];
 * returnedArray == @[@1, @3]
 * \endcode
 */
- (NSArray *)reject:(BOOL(^)(id obj))block;

/**
 * \code
 * NSArray *array = @[@1, @2, @3, @4, @5, @6];
 * [array reverse] == @[@6, @5, @4, @3, @2, @1]
 * \endcode
 */
- (NSArray *)reverse;

/**
 * Calls enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:(void (^)(id obj, NSUInteger idx, BOOL *stop))block
 */
- (void)reverseEach:(void(^)(id obj))block;

/**
 * \code
 * NSArray *array = @[@6, @2, @4, @4, @5, @6];
 * [array rindex:@6] == 5
 * [array rindex:@4] == 4
 * [array rindex:@7] == NSNotFound
 * \endcode
 */
- (NSUInteger)rindex:(id)obj;

/**
 * \code
 * NSArray *array = @[@1, @2, @3, @4, @5, @6];
 * [array rotate:1] == @[@2, @3, @4, @5, @6, @1]
 * [array rotate:6] == @[@1, @2, @3, @4, @5, @6]
 * [array rotate:36] == @[@1, @2, @3, @4, @5, @6]
 * [array rotate:-1] == @[@6, @1, @2, @3, @4, @5]
 * [array rotate:-6] == @[@1, @2, @3, @4, @5, @6]
 * [array rotate:-3] == @[@4, @5, @6, @1, @2, @3]
 * \endcode
 */
- (NSArray *)rotate:(NSInteger)count;

/**
 * Calls findAll
 */
- (NSArray *)select:(BOOL(^)(id obj))block;

/**
 * \code
 * NSArray *array = @[@6, @2, @4, @4, @5, @6];
 * [array slice:0 length:3] == @[@6, @2, @4]
 * [array slice:1 length:3] == @[@2, @4, @4]
 * [array slice:100 length:3] == @[]
 * [array slice:-1 length:1] == @[@6]
 * [array slice:-2 length:2] == @[@5, @6]
 * [array slice:-5 length:2] == @[@2, @4]
 * \endcode
 */
- (NSArray *)slice:(int)start length:(int)length;

/**
 * \code
 * NSArray *array = @[@6, @2, @4]
 * [array sort] == @[@2, @4, @6]
 * array = @[@"Jim", @"Tim", @"Alex"]
 * [array sort] == @[@"Alex", @"Jim", @"Tim"]
 * \endcode
 * Underlying implementation uses compare:
 */
- (NSArray *)sort;

/**
 * \code
 * NSArray *array = @[@6, @2, @4, @4, @5, @6];
 * __block int count = 0;
 * NSArray *taken = [array takeWhile:^BOOL(id obj) {
 *    BOOL take = count < 3;
 *    count++;
 *    return take;
 * }];
 * taken == @[@6, @2, @4]
 * \endcode
 */
- (NSArray *)takeWhile:(BOOL(^)(id obj))block;

/**
 * \code 
 * NSArray *array = @[@6, @2, @4, @4, @5, @6];
 * [array unique] == @[@6, @2, @4, @5]
 * \endcode
 */
- (NSArray *)unique;

@end
