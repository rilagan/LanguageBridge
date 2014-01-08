//
//  NSString+Base.m
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

#import "NSString+Base.h"

@implementation NSString (Base)

- (BOOL)containsString:(NSString *)str {
    return [self rangeOfString: str].location != NSNotFound;
}

- (NSRange)indexOfString:(NSString *)str {
    return [self rangeOfString:str options:NSRegularExpressionSearch];
}

- (BOOL)isEmptyString {
    return [@"" isEqualToString:self];
}

- (NSArray *)splitString:(NSString *)str {
    NSRegularExpression *regex = [self regExWithPattern:str];
    int size = [self length];
    NSArray *array = [regex matchesInString:self options:0 range:NSMakeRange(0, size)];
    if ([array count] == 0) {
        return @[[self copy]];
    }
    NSMutableArray *strings = [[NSMutableArray alloc] init];
    __block int lastIndex = 0;
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSTextCheckingResult *match = obj;
        NSRange range = [match rangeAtIndex:0];
        [strings addObject:[self substringWithRange:NSMakeRange(lastIndex, range.location-lastIndex)]];
        lastIndex = range.location + range.length;
    }];
    if (lastIndex < size) {
        [strings addObject:[self substringWithRange:NSMakeRange(lastIndex, size - lastIndex)]];
    }
    
    return strings;
}

- (NSString *)replaceAllStrings:(NSString *)pattern withReplacement:(NSString *)replacement {
    NSRegularExpression *regex = [self regExWithPattern:pattern];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, [self length]) withTemplate:replacement];
}

- (NSString *)removeLeadingAndTrailingWhitespaces {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSRegularExpression *)regExWithPattern:(NSString *)pattern {
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:&error];
    if (error) {
        NSException *e = [NSException exceptionWithName:@"Regex Error" reason:[error localizedDescription] userInfo:nil];
        @throw e;
    } else {
        return regex;
    }
}

@end
