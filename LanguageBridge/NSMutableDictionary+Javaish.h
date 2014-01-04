//
//  NSMutableDictionary+Javaish.h
//  LanguageBridge
//
//  Created by Ryan Ilagan on 1/4/14.
//  Copyright (c) 2014 Ryan Ilagan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (Javaish)

/**
 * Calls setObject forKey
 */
- (void)put:(id)key forObj:(id)obj;

/**
 * Calls setValuesForKeysWithDictionary
 */
- (void)putAll:(NSDictionary *)dict;

@end
