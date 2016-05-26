//
// Created by Neil on 20/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import "FilterModel.h"
#import "PlaceModel.h"
#import "NSMutableArray+Unique.h"

@interface FilterModel ()

@property (nonatomic, strong) NSArray *selectedCategories;
@property (nonatomic, strong) NSArray *selectedNeighbourhoods;
@property (nonatomic, strong, readonly) NSArray *allPlaces;
@property (nonatomic, strong) NSMutableArray *categoriesAvailable;
@end

@implementation FilterModel

- (instancetype)initWithPlaces:(NSArray *)places
{
    self = [super init];
    if (self)
    {
        _allPlaces = [places copy];

        _categoriesAvailable = [NSMutableArray new];
        _placesMatched = [NSMutableArray new];
    }
    return self;
}

- (void)updateFiltersWithCategoriesSelected:(NSArray *)categories neighbourhoods:(NSArray *)neighbourhoods
{
    self.selectedCategories = [categories copy];
    self.selectedNeighbourhoods = [neighbourhoods copy];

    [self doFiltering];
}

- (void)resetFilters
{
    self.selectedCategories = @[];
    self.selectedNeighbourhoods = @[];

    [self doFiltering];
}

- (void)doFiltering
{
    [self.categoriesAvailable removeAllObjects];
    [self.placesMatched removeAllObjects];

    for (PlaceModel *place in self.allPlaces)
    {
        if (![self matchedOnNeighbourhood:place])
        {
            continue;
        }

        [self addToAvailableCategories:place.categories];

        if ([self match:place onCategories:self.selectedCategories])
        {
            [self.placesMatched addObject:place];
        }
    }
}

- (void)addToAvailableCategories:(NSArray *)categories
{
    for (NSString *category in categories)
    {
        [self.categoriesAvailable addUniqueObject:category];
    }
}

- (BOOL)matchedOnNeighbourhood:(PlaceModel *)model
{
    if (self.selectedNeighbourhoods == nil)
    {
        return NO;
    }

    if (self.selectedNeighbourhoods.count == 0)
    {
        return YES;
    }

    for (NSString *neighbourhood in self.selectedNeighbourhoods)
    {
        if ([model.neighbourhood isEqualToString:neighbourhood])
        {
            return YES;
        }
    }

    return NO;
}

- (BOOL)match:(PlaceModel *)model onCategories:(NSArray *)selectedCategories
{
    if (selectedCategories.count == 0)
    {
        return YES;
    }

    for (NSString *selectedCategory in selectedCategories)
    {
        for (NSString *category in model.categories)
        {
            if ([category isEqualToString:selectedCategory])
            {
                return YES;
            }
        }
    }

    return NO;
}

- (NSArray *)categoriesFiltered
{
    return self.categoriesAvailable;
}

- (NSUInteger)totalPlacesMatched
{
    return self.placesMatched.count;
}

- (void)updatePlaces:(NSArray *const)places
{
    _allPlaces = places;
}

@end