//
//  NSDictionary+Rubyish.h
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

#import <Foundation/Foundation.h>

@interface NSDictionary (Rubyish)

/**
 * Calls enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
 */
- (void)eachKey:(void(^)(id key))block;

/**
 * Calls enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
 */
- (void)eachPair:(void(^)(id key, id obj))block;

/**
 * Calls enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop)
 */
- (void)eachValue:(void(^)(id obj))block;

/**
 * \code
 * [@{} empty] == YES
 * [@{@2:@3} empty] == NO
 * \endcode
 */
- (BOOL)empty;

/**
 * Calls objectForKey
 */
- (id)fetch:(id)key;

/**
 * \code
 * [@{@2:@3} include:@2] == YES
 * [@{@2:@3} include:@4] == NO
 * \endcode
 */
- (BOOL)include:(id)key;

/**
 * \code
 * [@{@2:@3} invert] == @{@3:@2}
 * [@{@2:@3, @4:@5} invert] == @{@3:@2, @5:@4}
 * \endcode
 */
- (NSDictionary *)invert;

/**
 * Calls allKeys
 */
- (NSArray *)keys;

/**
 * \code
 * [@{@2:@3} member:@2] == YES
 * [@{@2:@3} member:@4] == NO
 * \endcode
 */
- (BOOL)member:(id)key;

/**
 * \code
 * NSDictionary *dict = @{@1:@2, @2:@3, @3:@4, @4:@6, @5:@6};
 * NSDictionary *selected = [dict select:^BOOL(id key, id obj) {
 *      NSNumber *num = (NSNumber *)obj;
 *      return [num intValue] % 2 == 0;
 * }];
 * selected == @{@1:@2, @3:@4, @4:@6, @5:@6}
 * \endcode
 */
- (NSDictionary *)select:(BOOL(^)(id key, id obj))block;

/**
 * \code
 * NSDictionary *dict = @{@1:@2, @2:@3, @3:@4, @4:@6, @5:@6};
 * NSDictionary *kept = [dict reject:^BOOL(id key, id obj) {
 *      NSNumber *num = (NSNumber *)obj;
 *      return [num intValue] % 2 == 0;
 * }];
 * kept == @{@2:@3}
 * \endcode 
 */
- (NSDictionary *)reject:(BOOL(^)(id key, id obj))block;

@end
