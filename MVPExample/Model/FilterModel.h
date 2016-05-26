//
// Created by Neil on 20/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterModel : NSObject

@property (nonatomic, strong, readonly) NSMutableArray *placesMatched;

- (instancetype)initWithPlaces:(NSArray *)places;

- (void)updateFiltersWithCategoriesSelected:(NSArray *)categories neighbourhoods:(NSArray *)neighbourhoods;

- (void)resetFilters;

- (NSArray *)selectedCategories;

- (NSArray *)selectedNeighbourhoods;

- (NSArray *)categoriesFiltered;

- (NSUInteger)totalPlacesMatched;

- (void)updatePlaces:(NSArray *const)places;

@end