//
//  NSString+Javaish.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 12/12/13.
//
//

#import "NSString+Javaish.h"
#import "NSString+Base.h"

@implementation NSString (Javaish)

- (NSString *)concat:(NSString *)str {
    return [self stringByAppendingString:str];
}

- (BOOL)contains:(NSString *)str {
    return [self containsString:str];
}

- (BOOL)endsWith:(NSString *)suffix {
    return [self hasSuffix:suffix];
}

- (BOOL)equals:(NSString *)otherString {
    return [self isEqualToString:otherString];
}

- (BOOL)equalsIgnoreCase:(NSString *)otherString {
    return [self caseInsensitiveCompare:otherString] == NSOrderedSame;
}

- (NSRange)indexOf:(NSString *)str {
    return [self rangeOfString:str];
}

- (NSRange)indexOf:(NSString *)str fromIndex:(NSUInteger)idx {
    return [self rangeOfString:str options:0 range:NSMakeRange(idx, [self length]-idx)];
}

- (BOOL)isEmpty {
    return [self isEmptyString];
}

- (NSRange)lastIndexOf:(NSString *)str {
    return [self rangeOfString:str options:NSBackwardsSearch];
}

- (NSRange)lastIndexOf:(NSString *)str fromIndex:(NSUInteger)idx {
    return [self rangeOfString:str options:NSBackwardsSearch range:NSMakeRange(0, idx+1)];
}

- (BOOL)matches:(NSString *)pattern {
    NSPredicate *p = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    return [p evaluateWithObject:self];
}

- (NSString *)replaceAll:(NSString *)pattern with:(NSString *)replacement {
    return [self replaceAllStrings:pattern withReplacement:replacement];
}

- (NSString *)replaceFirst:(NSString *)pattern with:(NSString *)replacement {
    NSRange range = [self rangeOfString:pattern options:NSRegularExpressionSearch];
    NSRegularExpression *regex = [self regExWithPattern:pattern];
    return [regex stringByReplacingMatchesInString:self options:0 range:range withTemplate:replacement];
}

- (NSArray *)split:(NSString *)str {
    return [self splitString:str];
}

- (BOOL)startsWith:(NSString *)prefix {
    return [self hasPrefix:prefix];
}

- (NSString *)substringFromIndex:(NSUInteger)beginIndex {
    int length = [self length] - beginIndex;
    return [self substringWithRange:NSMakeRange(beginIndex, length)];
}

- (NSString *)substringFromIndex:(NSUInteger)beginIndex endIndex:(NSUInteger)endIndex {
    if (endIndex > [self length]) {
        endIndex = [self length];
    }
    int length = endIndex - beginIndex;
    return [self substringWithRange:NSMakeRange(beginIndex, length)];
}

- (NSString *)toLowerCase {
    return [self lowercaseString];
}

- (NSString *)toUpperCase {
    return [self uppercaseString];
}

- (NSString *)trim {
    return [self removeLeadingAndTrailingWhitespaces];
}

@end
