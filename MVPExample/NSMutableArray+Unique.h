//
// Created by Neil on 26/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (Unique)

- (BOOL)addUniqueObject:(NSString *)name;

- (BOOL)removeUniqueObject:(NSString *)name;
@end