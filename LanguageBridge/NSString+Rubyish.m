//
//  NSString+Rubyish.m
//  LanguageBridge
//
//  Created by Ryan Ilagan on 11/10/13.
//
//

#import "NSString+Rubyish.h"
#import "NSString+Base.h"

#define CHAR_RANGE @"\\D-\\D"

@implementation NSString (Rubyish)

- (NSString *)capitalize {
    NSInteger s = [self length];
    if (s == 0) {
        return [self copy];
    }
    unichar chars[s];
    for (NSInteger charIdx = 0; charIdx < s; charIdx++) {
        unichar charAt = [self characterAtIndex:charIdx];
        if (isalpha(charAt) && charIdx > 0 && [[NSCharacterSet uppercaseLetterCharacterSet] characterIsMember:charAt]) {
            chars[charIdx] = tolower(charAt);
        } else if (charIdx == 0 && isalpha(charAt) && [[NSCharacterSet lowercaseLetterCharacterSet] characterIsMember:charAt]) {
            chars[charIdx] = toupper(charAt);
        } else {
            chars[charIdx] = charAt;
        }
    }
    return [[NSString alloc] initWithCharacters:chars length:s];
}

- (NSString *)chomp {
    NSInteger s = [self length];
    if (s == 0) {
        return [self copy];
    }

    if ([self characterAtIndex:s-1] == '\n') {
        return [self removeTrailingCarriageReturn:s];
    } else if ([self characterAtIndex:s-1] == '\r') {
        return [self substringWithRange:NSMakeRange(0,s-1)];
    }
    return [self copy];
}

- (NSString *)chomp:(NSString *)separator {
    NSInteger s = [self length];
    if (s < [separator length]) {
        return [self copy];
    }
    if ([self hasSuffix:separator]) {
        return [self substringWithRange:NSMakeRange(0,(s-[separator length]))];
    }
    return [self copy];
}

- (NSString *)chop {
    NSInteger s = [self length];
    if (s == 0) {
        return [self copy];
    }
    
    if ([self characterAtIndex:s-1] == '\n') {
        return [self removeTrailingCarriageReturn:s];
    } else {
        return [self substringWithRange:NSMakeRange(0, s-1)];
    }
}

- (NSString *)removeTrailingCarriageReturn:(NSInteger)strLength {
    if (strLength > 1 && [self characterAtIndex:strLength-2] == '\r') {
        return [self substringWithRange:NSMakeRange(0, strLength-2)];
    } else {
        return [self substringWithRange:NSMakeRange(0, strLength-1)];
    }
}

- (NSString *)chr {
    if ([self length] == 0) {
        return [self copy];
    }
    unichar chars[1];
    chars[0] = [self characterAtIndex:0];
    return [[NSString alloc] initWithCharacters:chars length:1];
}

- (NSString *)concat:(NSString *)str {
    return [self stringByAppendingString:str];
}

- (NSInteger)count:(NSString *)str {
    NSMutableDictionary *charMap = [[NSMutableDictionary alloc] init];
    
    // handle range
    NSString *charRanges = [self charactersForRanges:str];
    if ([charRanges length] > 0) {
        str = [[str gsub:CHAR_RANGE replacement:@""] concat:charRanges];
    }
    
    BOOL same = YES;
    for (NSInteger charIdx = 0; charIdx < [str length]; charIdx++) {
        unichar charAt = [str characterAtIndex:charIdx];
        if (charAt == '^') {
            same = NO;
        } else {
            [charMap setObject:[NSNumber numberWithBool:same] forKey:[NSNumber numberWithChar:charAt]];
            same = YES;
        }
    }
    
    NSInteger letterCount = 0;
    for (NSInteger charIdx = 0; charIdx < [self length]; charIdx++) {
        unichar charAt = [self characterAtIndex:charIdx];
        NSEnumerator *enumerator = [charMap keyEnumerator];
        id object;
        while ((object = [enumerator nextObject])) {
            BOOL same = [((NSNumber *)[charMap objectForKey:object]) boolValue];
            unichar countedChar = [((NSNumber *)object) charValue];
            if ((countedChar == charAt) == same) {
                letterCount++;
            }
        }
    }    
    return letterCount;
}

- (NSString *)downcase {
    return [self lowercaseString];
}

- (BOOL)empty {
    return [self isEmptyString];
}

- (BOOL)endWith:(NSString *)suffix {
    return [self hasSuffix:suffix];
}

- (NSString *)gsub:(NSString *)pattern replacement:(NSString *)replacement {
    return [self replaceAllStrings:pattern withReplacement:replacement];
}

- (BOOL)include:(NSString *)str {
    return [self containsString:str];
}

- (NSRange)index:(NSString *)str {
    return [self indexOfString:str];
}

- (NSString *)insert:(int)idx string:(NSString *)str {
    NSMutableString *updatedString = [[NSMutableString alloc] initWithString:self];
    [updatedString insertString:str atIndex:idx];
    return updatedString;
}

- (NSString *)prepend:(NSString *)str {
    NSMutableString *updatedString = [[NSMutableString alloc] initWithString:str];
    [updatedString appendString:self];
    return updatedString;
}

- (NSArray *)scan:(NSString *)strOrRegEx {
    NSRegularExpression *regex = [self regExWithPattern:strOrRegEx];
    NSArray *array = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    NSMutableArray *matches = [[NSMutableArray alloc] init];
    for (NSTextCheckingResult *match in array) {
        NSRange matchRange = [match rangeAtIndex:0];
        [matches addObject:[self substringWithRange:matchRange]];
    }
    return matches;
}

- (BOOL)startWith:(NSString *)prefix {
    return [self hasPrefix:prefix];
}

- (NSString *)reverse {
    int s = [self length];
    if (s == 0) {
        return [self copy];
    }
    int charIdx = s;
    unichar chars[s-1];
    while (charIdx > 0) {
        chars[s-charIdx] = [self characterAtIndex:charIdx-1];
        charIdx--;
    }
    return [[NSString alloc] initWithCharacters:chars length:s];
}

- (NSRange)rindex:(NSString *)strOrRegEx {
    NSRegularExpression *regex = [self regExWithPattern:strOrRegEx];
    NSArray *array = [regex matchesInString:self options:0 range:NSMakeRange(0, [self length])];
    if ([array count] == 0) {
        return NSMakeRange(NSNotFound, 0);
    }
    NSTextCheckingResult *match = [array lastObject];
    return [match rangeAtIndex:0];
}

- (NSUInteger)size {
    return [self length];
}

- (NSArray *)split:(NSString *)str {
    return [self splitString:str];
}

- (NSString *)squeeze:(NSString *)otherString {
    NSUInteger s = [self length];
    NSUInteger os = [otherString length];
    if (s == 0 || s == 1 || os == 0) {
        return [self copy];
    }
    
    // handle range
    NSString *charRanges = [self charactersForRanges:otherString];
    if ([charRanges length] > 0) {
        otherString = [[otherString gsub:CHAR_RANGE replacement:@""] concat:charRanges];
        os = [otherString length];
    }
    
    unichar otherChars[os];
    for (NSUInteger charIdx = 0; charIdx < os; charIdx++) {
        otherChars[charIdx] = [otherString characterAtIndex:charIdx];
    }
    
    unichar chars[s];
    NSUInteger charCount = 1;
    unichar lastChar = [self characterAtIndex:0];
    chars[0] = lastChar;
    for (NSUInteger charIdx = 1; charIdx < s; charIdx++) {
        unichar charAt = [self characterAtIndex:charIdx];
        BOOL appendChar = YES;
        for (NSUInteger oCharIdx = 0; oCharIdx < os; oCharIdx++) {
            if (otherChars[oCharIdx] == lastChar && lastChar == charAt) {
                appendChar = NO;
                break;
            }
        }
        if (appendChar) {
            chars[charCount] = charAt;
            charCount++;
        }
        lastChar = charAt;
    }
    return [[NSString alloc] initWithCharacters:chars length:charCount];
}

- (NSString *)strip {
    return [self removeLeadingAndTrailingWhitespaces];
}

- (NSString *)upcase {
    return [self uppercaseString];
}

- (NSString *)charactersForRanges:(NSString *)otherString {
    NSRegularExpression *regEx = [otherString regExWithPattern:CHAR_RANGE];
    NSArray *array = [regEx matchesInString:otherString options:0 range:NSMakeRange(0, [otherString length])];
    NSMutableString *chars = [[NSMutableString alloc] init];
    for (NSTextCheckingResult *match in array) {
        NSRange matchRange = [match rangeAtIndex:0];
        unichar first = [otherString characterAtIndex:matchRange.location];
        unichar last = [otherString characterAtIndex:matchRange.location+matchRange.length-1];
        while (first <= last) {
            [chars appendFormat:@"%c", first];
            first++;
        }
    }
    return chars;
}


@end
