//
//  NSArray+Javaish.h
//  LanguageBridge
//
//  Created by Ryan Ilagan on 1/4/14.
//  Copyright (c) 2014 Ryan Ilagan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Javaish)

/**
 * \code
 * NSArray *array = @[@1, @2, @3, @4, @5];
 * NSArray *subArray = @[@1, @2];
 * [array containsAll:subArray] == YES
 * subArray = @[@1, @6]
 * [array containsAll:subArray] == NO
 * \endcode
 */
- (BOOL)containsAll:(NSArray *)ary;

/**
 * Calls objectAtIndex
 */
- (id)get:(NSUInteger)idx;

/**
 * \code
 * [@[] isEmpty] == YES
 * [@[@1] isEmpty] == NO
 * \endcode
 */
- (BOOL)isEmpty;

/**
 * Calls count
 */
- (NSUInteger)size;

@end
