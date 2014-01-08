//
//  NSString+Javaish.h
//  LanguageBridge
//
//  Created by Ryan Ilagan on 12/12/13.
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

@interface NSString (Javaish)

/**
 * \code
 * Calls stringByAppendingString
 * [@"hello " concat:@"world"] == @"hello world"
 * \endcode
 */
- (NSString *)concat:(NSString *)str;

/**
 * \code
 * [@"" contains:@"v"] == NO
 * [@"value is here" contains:@"is"] == YES
 * [@"hello" contains:@"l*o"] == NO
 * \endcode
 */
- (BOOL)contains:(NSString *)str;

/**
 * Calls hasSuffix
 */
- (BOOL)endsWith:(NSString *)suffix;

/**
 * Calls isEqualToString
 * \code
 * [@"" equals:@"v"] == NO
 * [@"value is here" equals:@"value is here"] == YES
 * [@"hello" equals:@"Hello"] == NO
 * \endcode
 */
- (BOOL)equals:(NSString *)otherString;

/**
 * Calls caseInsensitiveCompare
 * \code
 * [@"" equalsIgnoreCase:@"v"] == NO
 * [@"value is here" equalsIgnoreCase:@"value is here"] == YES
 * [@"hello" equalsIgnoreCase:@"HeLLo"] == YES
 * \endcode
 */
- (BOOL)equalsIgnoreCase:(NSString *)otherString;

/**
 * Calls rangeOfString
 * \code
 * [@"hello" indexOf:@"lllo"] == NSMakeRange(NSNotFound, 0)
 * [@"hello" indexOf:@"e"] == NSMakeRange(1, 1)
 * \endcode
 */
- (NSRange)indexOf:(NSString *)str;

/**
 * Calls rangeOfString
 * \code
 * [@"hello" indexOf:@"lllo" fromIndex:0] == NSMakeRange(NSNotFound, 0)
 * [@"test case" indexOf:@"e" fromIndex:2] == NSMakeRange(8, 1)
 * \endcode
 */
- (NSRange)indexOf:(NSString *)str fromIndex:(NSUInteger)idx;

/**
 * \code
 * [@" " isEmpty] == NO
 * [@"" isEmpty] == YES
 * \endcode
 */
- (BOOL)isEmpty;

/**
 * Calls rangeOfString with option NSBackwardsSearch
 * \code
 * [@"hello" lastIndexOf:@"hello"] == NSMakeRange(0, 5)
 * [@"hello" lastIndexOf:@"l"] == NSMakeRange(3, 1)
 * [@"hello" lastIndexOf:@"x"] == NSMakeRange(NSNotFound, 0)
 * \endcode
 */
- (NSRange)lastIndexOf:(NSString *)str;

/**
 * Calls rangeOfString with option NSBackwardsSearch
 * \code
 * [@"hello" lastIndexOf:@"o" fromIndex:3] == NSMakeRange(NSNotFound, 0)
 * [@"test case" lastIndexOf:@"e" fromIndex:7] == NSMakeRange(1, 1)
 * \endcode
 */
- (NSRange)lastIndexOf:(NSString *)str fromIndex:(NSUInteger)idx;

/**
 * \code
 * [@"hello" matches:@"hello"] == YES
 * [@"hhhello" matches:@"\\D+ello"] == YES
 * [@"hello" matches:@"he\\D\\Do"] == YES
 * [@"hello" matches:@"he\\D-\\Do"] == NO
 * \endcode
 */
- (BOOL)matches:(NSString *)pattern;

/**
 * \code
 * [@"hello" replaceAll:@"[aeiou]" with:@"*"] == @"h*ll*"
 *
 * [@"bbbbbvvbb" replaceAll:@"b" with:@"a"] == @"aaaaavvaa"
 * \endcode
 * Last example works but one should use stringByReplacingOccurrencesOfString instead
 * \endcode
 */
- (NSString *)replaceAll:(NSString *)pattern with:(NSString *)replacement;

/**
 * \code
 * [@"hello" replaceFirst:@"[aeiou]" with:@"*"] == @"h*llo"
 * [@"bbbbbvvbb" replaceFirst:@"b" with:@"a"] == @"abbbbvvbb"
 * [@"acacacvkvkvk" replaceFirst:@"[ck]" with:@"b"] == @"abacacvkvkvk"
 * \endcode
 */
- (NSString *)replaceFirst:(NSString *)pattern with:(NSString *)replacement;

/**
 * Calls hasPrefix
 * \code
 * [@"hello" startsWith:@"he"] == YES
 * [@"hello" startsWith:@"k"] == NO
 * \endcode
 */
- (BOOL)startsWith:(NSString *)prefix;

/**
 * \code
 * [@"string substringed" substringFromIndex:0] == @"string substringed"
 * [@"string after substring" substringFromIndex:13] == @"substring"
 * \endcode
 */
- (NSString *)substringFromIndex:(NSUInteger)beginIndex;

/**
 * \code
 * [@"string substringed" substringFromIndex:0 endIndex:18] == @"string substringed"
 * [@"string after substring" substringFromIndex:13 endIndex:22] == @"substring"
 * [@"string after substring" substringFromIndex:0 endIndex:3] == @"str"
 * \endcode
 */
- (NSString *)substringFromIndex:(NSUInteger)beginIndex endIndex:(NSUInteger)endIndex;

/**
 * \code
 * Calls lowercaseString
 * [@"HELlo" toLowerCase] == @"hello"
 * \endcode
 */
- (NSString *)toLowerCase;

/**
 * Calls uppercaseString
 * \code
 * [@"Hello" toUpperCase] == @"HELLO"
 * \endcode
 */
- (NSString *)toUpperCase;

/**
 * \code
 * [@"\tgoodbye\r\n" trim] == @"goodbye"
 * \endcode
 */
- (NSString *)trim;

@end
