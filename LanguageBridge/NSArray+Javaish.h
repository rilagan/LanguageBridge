//
//  NSArray+Javaish.h
//  LanguageBridge
//
//  Created by Ryan Ilagan on 1/4/14.
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
