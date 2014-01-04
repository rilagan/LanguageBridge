//
//  NSDictionary+Javaish.h
//  LanguageBridge
//
//  Created by Ryan Ilagan on 1/3/14.
//  Copyright (c) 2014 Ryan Ilagan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Javaish)

/**
 * \code
 * [@{@2:@3} containsKey:@2] == YES
 * [@{@2:@3} containsKey:@3] == NO
 * \endcode
 */
- (BOOL)containsKey:(id)key;

/**
 * Calls objectForKey
 */
- (id)get:(id)key;

/**
 * \code
 * [@{} isEmpty] == YES
 * [@{@2:@3} isEmpty] == NO
 * \endcode
 */
- (BOOL)isEmpty;

/**
 * Calls count
 */
- (NSUInteger)size;

@end
