//
// Created by Neil on 26/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import "NSMutableArray+Unique.h"


@implementation NSMutableArray (Unique)

- (BOOL)addUniqueObject:(NSString *)name
{
    BOOL wasPresent = YES;
    if (![self containsObject:name])
    {
        [self addObject:name];
        wasPresent = NO;
    }

    return !wasPresent;
}

- (BOOL)removeUniqueObject:(NSString *)name
{
    BOOL wasPresent = NO;
    if ([self containsObject:name])
    {
        [self removeObject:name];
        wasPresent = YES;
    }

    return wasPresent;
}

@end