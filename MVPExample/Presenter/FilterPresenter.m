//
// Created by Neil on 20/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import "FilterPresenter.h"
#import "FilterModel.h"
#import "FilterViewProtocol.h"
#import "NSMutableArray+Unique.h"


@interface FilterPresenter ()

@property (nonatomic, strong) NSMutableArray *selectedCategories;
@property (nonatomic, strong) NSMutableArray *selectedNeighbourhoods;
@property (nonatomic, strong) FilterModel *model;

@property (nonatomic, strong) id <FilterViewProtocol> view;
@end

@implementation FilterPresenter

- (instancetype)initWithView:(id <FilterViewProtocol>)view model:(FilterModel *)model
{
    self = [super init];
    if (self)
    {
        _view = view;
        _model = model;

        _selectedCategories = [NSMutableArray new];
        _selectedNeighbourhoods = [NSMutableArray new];
    }
    return self;
}

- (void)initialise
{
    [self.model updateFiltersWithCategoriesSelected:self.selectedCategories
                                     neighbourhoods:self.selectedNeighbourhoods];

    [self.view filterUpdatedWithTotalHits:self.model.totalPlacesMatched visibleCategories:self.model.categoriesFiltered];
}

- (void)showAllNeighbourhoods
{
    // don't change model, this is View-related only.
    [self.view expandNeighbourhoods];
}

- (void)neighbourhoodsAllDeselected
{
    if (self.selectedNeighbourhoods.count > 0)
    {
        [self.selectedNeighbourhoods removeAllObjects];

        [self.model updateFiltersWithCategoriesSelected:self.selectedCategories
                                         neighbourhoods:self.selectedNeighbourhoods];

        [self.view neighbourhoodSelectionChanged:self.model.selectedNeighbourhoods];
        [self.view filterUpdatedWithTotalHits:self.model.totalPlacesMatched
                            visibleCategories:self.model.categoriesFiltered];
    }
}

- (void)neighbourhoodSelected:(NSString *)neighbourhoodName
{
    if ([self.selectedNeighbourhoods addUniqueObject:neighbourhoodName])
    {

        [self.model updateFiltersWithCategoriesSelected:self.selectedCategories
                                         neighbourhoods:self.selectedNeighbourhoods];

        [self.view neighbourhoodSelectionChanged:self.model.selectedNeighbourhoods];
        [self.view filterUpdatedWithTotalHits:self.model.totalPlacesMatched
                            visibleCategories:self.model.categoriesFiltered];
    }
}

- (void)neighbourhoodDeselected:(NSString *)neighbourhoodName
{
    if ([self.selectedNeighbourhoods removeUniqueObject:neighbourhoodName])
    {

        [self.model updateFiltersWithCategoriesSelected:self.selectedCategories
                                         neighbourhoods:self.selectedNeighbourhoods];

        [self.view neighbourhoodSelectionChanged:self.model.selectedNeighbourhoods];
        [self.view filterUpdatedWithTotalHits:self.model.totalPlacesMatched
                            visibleCategories:self.model.categoriesFiltered];
    }
}

- (void)categorySelected:(NSString *)categoryName
{
    if ([self.selectedCategories addUniqueObject:categoryName])
    {
        [self updateAfterCategoriesChanged];
    }
}

- (void)categoryDeselected:(NSString *)categoryName
{
    if ([self.selectedCategories removeUniqueObject:categoryName])
    {

        [self updateAfterCategoriesChanged];
    }
}

- (void)resetFilters
{
    [self.selectedNeighbourhoods removeAllObjects];
    [self.selectedCategories removeAllObjects];

    [self.model resetFilters];

    [self.view neighbourhoodSelectionChanged:self.model.selectedNeighbourhoods];
    [self.view categorySelectionChanged:self.model.selectedCategories];
    [self.view filterUpdatedWithTotalHits:self.model.totalPlacesMatched
                        visibleCategories:self.model.categoriesFiltered];
}

- (void)updateAfterCategoriesChanged
{
    [self.model updateFiltersWithCategoriesSelected:self.selectedCategories
                                     neighbourhoods:self.selectedNeighbourhoods];

    [self.view categorySelectionChanged:self.model.selectedCategories];
    [self.view filterUpdatedWithTotalHits:self.model.totalPlacesMatched
                        visibleCategories:self.model.categoriesFiltered];
}

@end