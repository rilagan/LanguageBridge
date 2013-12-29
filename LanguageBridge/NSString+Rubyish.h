//
//  NSString+Rubyish.h
//  LanguageBridge
//
//  Created by Ryan Ilagan on 11/10/13.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Rubyish)

// Pattern Reference https://developer.apple.com/library/mac/documentation/Foundation/Reference/NSRegularExpression_Class/Reference/Reference.html#//apple_ref/doc/uid/TP40009708-CH1-SW48

/**
 * \code
 * [@"HELLO" capitalize] == @"Hello"
 * \endcode
 */
- (NSString *)capitalize;

/**
 * \code
 * [@"hello\n" chomp] == @"hello"
 * \endcode
 */
- (NSString *)chomp;

/**
 * \code
 * [@"hello" chomp:"llo"] == @"he"
 * \endcode
 */
- (NSString *)chomp:(NSString *)separator;

/**
 * \code
 * [@"string\r\n" chop] == @"string"
 * [@"string\n\r" chop] == @"string\n"
 * [@"string\n" chop] == @"string"
 * \endcode
 */
- (NSString *)chop;

/**
 * \code
 * [@"abcde" char] == @"a"
 * \endcode
 */
- (NSString *)chr;

/**
 * \code
 * Calls stringByAppendingString
 * [@"hello " concat:@"world"] == @"hello world"
 * \endcode
 */
- (NSString *)concat:(NSString *)str;

/**
 * \code
 * [@"hello world" count:@"lo"] == 5 
 * [@"hello world" count:@"ej-m"] == 4
 * \endcode
 */
- (NSInteger)count:(NSString *)str;

/**
 * \code
 * Calls lowercaseString
 * [@"HELlo" downcase] == @"hello"
 * \endcode
 */
- (NSString *)downcase;

/**
 * \code
 * [@" " empty] == NO
 * [@"" empty] == YES
 * \endcode
 */
- (BOOL)empty;

/**
 * Calls hasSuffix
 */
- (BOOL)endWith:(NSString *)suffix;

/**
 * \code
 * [@"hello" gsub:@"[aeiou]" replacement:@"*"] == @"h*ll*"
 *
 * [@"bbbbbvvbb" gsub:@"b" replacement:@"a"] == @"aaaaavvaa"
 * \endcode
 * Last example works but one should use stringByReplacingOccurrencesOfString instead
 */
- (NSString *)gsub:(NSString *)pattern replacement:(NSString *)replacement;

/**
 * \code
 * [@"hello" include:@"h"] == YES
 * [@"hello" include:@"g"] == NO
 * \endcode
 */
- (BOOL)include:(NSString *)str;

/**
 * \code
 * [@"hello" index:@"l*o"] == NSMakeRange(2, 3)
 * [@"hello" index:@"lllo"] == NSMakeRange(NSNotFound, 0)
 *
 * [@"hello" index:@"e"] == NSMakeRange(1, 1)
 * \endcode
 * Last example works but one should use rangeOfString instead
 */
- (NSRange)index:(NSString *)strOrRegEx;

/**
 * \code
 * [@"heo" insert:2 string:@"ll"] == @"hello"
 * \endcode
 */
- (NSString *)insert:(int)idx string:(NSString *)str;

/**
 * \code
 * [@"ello" prepend:@"H"] == @"Hello"
 * \endcode
 */
- (NSString *)prepend:(NSString *)str;

/**
 * \code
 * [@"teews" reverse] == @"sweet"
 * \endcode
 */
- (NSString *)reverse;

/**
 * \code
 * [@"hello" rindex:@"l"] == NSMakeRange(3, 1)
 * [@"hello" rindex:@"a"] == NSMakeRange(NSNotFound, 0)
 * [@"llohello" rindex:@"l*o"] == NSMakeRange(5, 3)
 * \endcode
 */
- (NSRange)rindex:(NSString *)strOrRegEx;

/**
 * \code
 * [@"hello dell" scan:@"el*"] == @[@"ell", @"ell"]
 * \endcode
 * TODO handle captures
 */
- (NSArray *)scan:(NSString *)strOrRegEx;

/**
 * \code
 * Calls length
 * [@"HELlo" size] == 5
 * \endcode
 */
- (NSUInteger)size;

/**
 * \code
 * [@"hello world" splitWithPattern:@" "] == @[@"hello", @"world"]
 * [@"a|b-c-d|e|f!g" splitWithPattern:@"[\\|\\-\\!]"] == @[@"a", @"b", @"c", @"d", @"e", @"f", @"g"]
 * \endcode
 */
- (NSArray *)split:(NSString *)strOrRegEx;

/**
 * \code
 * [@"data    value" squeeze:@" "] == @"data value"
 * [@"ddaattaa     vvaalluuee" squeeze:@"data value"] == @"data value"
 * [@"ddaattaa     vvaalluuee" squeeze:@"a-z "] == @"data value"
 * \endcode
 */
- (NSString *)squeeze:(NSString *)otherString;

/**
 * Calls hasPrefix
 */
- (BOOL)startWith:(NSString *)prefix;

/**
 * \code
 * [@"\tgoodbye\r\n" strip] == @"goodbye"
 * \endcode
 */
- (NSString *)strip;

/**
 * Calls uppercaseString
 * \code 
 * [@"Hello" upcase] == @"HELLO"
 * \endcode
 */
- (NSString *)upcase;

@end
