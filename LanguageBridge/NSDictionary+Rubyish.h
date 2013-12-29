//
//  NSDictionary+Rubyish.h
//  LanguageBridge
//
//  Created by Ryan Ilagan on 11/19/13.
//
//

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
