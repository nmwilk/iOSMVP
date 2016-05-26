//
// Created by Neil on 21/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//
// Exists simply to check Presenter interacts correctly.

#import <Foundation/Foundation.h>
#import "FilterViewProtocol.h"


@interface MockFilterView : NSObject <FilterViewProtocol>

@property (nonatomic) BOOL isNeighbourhoodsExpanded;
@property (nonatomic, strong) NSArray *selectedCategories;
@property (nonatomic, strong) NSArray *selectedNeighbourhoods;
@property (nonatomic) NSUInteger totalHits;
@property (nonatomic, strong) NSArray *visibleCategories;

@end