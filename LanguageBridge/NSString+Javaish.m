//
//  NSString+Javaish.m
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
