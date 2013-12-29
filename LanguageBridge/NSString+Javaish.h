//
//  NSString+Javaish.h
//  LanguageBridge
//
//  Created by Ryan Ilagan on 12/12/13.
//
//

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
 * \code
 * \endcode
 */
- (NSRange)indexOf:(NSString *)str;

/**
 * \code
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
 * \code
 * \endcode
 */
- (NSRange)lastIndexOf:(NSString *)str;

/**
 * \code
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
 * \code
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
