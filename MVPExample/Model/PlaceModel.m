//
// Created by Neil on 21/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import "PlaceModel.h"


@implementation PlaceModel

- (instancetype)initWithCategories:(NSArray *)categories neighourhood:(NSString *)neighbourhood
{
    self = [super init];
    if (self)
    {
        _categories = categories;
        _neighbourhood = neighbourhood;
    }

    return self;
}

+ (instancetype)placeWithCategories:(NSArray *)categories neighbourhood:(NSString *)neighbourhood
{
    return [[PlaceModel alloc] initWithCategories:categories neighourhood:neighbourhood];
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];

    [description appendFormat:@"category %@.2f,", self.categories];
    [description appendFormat:@"neighbourhood %@,", self.neighbourhood];

    [description appendString:@">"];
    return description;
}


@end