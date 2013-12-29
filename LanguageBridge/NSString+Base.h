//
//  NSString+Base.h
//  LanguageBridge
//
//  Created by Ryan Ilagan on 12/12/13.
//
//

#import <Foundation/Foundation.h>

@interface NSString (Base)

- (BOOL)containsString:(NSString *)str;

- (NSRange)indexOfString:(NSString *)str;

- (BOOL)isEmptyString;

- (NSArray *)splitString:(NSString *)str;

- (NSRegularExpression *)regExWithPattern:(NSString *)pattern;

- (NSString *)replaceAllStrings:(NSString *)pattern withReplacement:(NSString *)replacement;

- (NSString *)removeLeadingAndTrailingWhitespaces;

@end
