//
// Created by Neil on 21/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PlaceModel : NSObject

@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) NSString *neighbourhood;

+ (instancetype)placeWithCategories:(NSArray *)categories neighbourhood:(NSString *)neighbourhood;
@end