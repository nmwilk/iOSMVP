//
// Created by Neil on 20/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FilterPresenter.h"
#import "FilterModel.h"
#import "MockFilterView.h"
#import "PlaceModel.h"

@interface PlacesFilterViewTests : XCTestCase

@property (nonatomic, strong) FilterModel *model;
@property (nonatomic, strong) MockFilterView *view;
@property (nonatomic, strong) FilterPresenter *presenter;

@end


@implementation PlacesFilterViewTests

#pragma mark Test Setup

- (void)setUp
{
    [super setUp];

    self.model = [[FilterModel alloc] initWithPlaces:[self createTestPlaces]];
    self.view = [[MockFilterView alloc] init];
    self.presenter = [[FilterPresenter alloc] initWithView:self.view model:self.model];

    [self.presenter initialise];
}

- (NSArray<PlaceModel *> *)createTestPlaces
{
    return @[
            [PlaceModel placeWithCategories:@[@"C1"] neighbourhood:@"N1"],
            [PlaceModel placeWithCategories:@[@"C2"] neighbourhood:@"N1"],
            [PlaceModel placeWithCategories:@[@"C3"] neighbourhood:@"N1"],

            [PlaceModel placeWithCategories:@[@"C1", @"C4"] neighbourhood:@"N2"],
            [PlaceModel placeWithCategories:@[@"C2", @"C5"] neighbourhood:@"N2"],
            [PlaceModel placeWithCategories:@[@"C3", @"C6"] neighbourhood:@"N3"],

            [PlaceModel placeWithCategories:@[@"C7", @"C9"] neighbourhood:@"N4"],
            [PlaceModel placeWithCategories:@[@"C8", @"C8"] neighbourhood:@"N5"],
            [PlaceModel placeWithCategories:@[@"C9", @"C7"] neighbourhood:@"N6"],

            [PlaceModel placeWithCategories:@[@"C10"] neighbourhood:@"N6"],
            [PlaceModel placeWithCategories:@[@"C10"] neighbourhood:@"N6"],
            [PlaceModel placeWithCategories:@[@"C10"] neighbourhood:@"N7"]
    ];
}

#pragma mark - Neighbourhood Tests

- (void)test_cleanScreen
{
    XCTAssertEqual(0, self.view.selectedCategories.count);
    XCTAssertEqual(0, self.view.selectedNeighbourhoods.count);
    XCTAssertEqual(10, self.view.visibleCategories.count);
    XCTAssertEqual(12, self.view.totalHits);
    XCTAssertFalse(self.view.isNeighbourhoodsExpanded);
}

- (void)test_noFiltersActive_then_oneNeighbourhoodSelected
{
    [self.presenter neighbourhoodSelected:@"N1"];

    XCTAssertEqual(0, self.view.selectedCategories.count);
    XCTAssertEqual(1, self.view.selectedNeighbourhoods.count);
    XCTAssertEqual(3, self.view.visibleCategories.count);
    XCTAssertEqual(3, self.view.totalHits);
}

- (void)test_noFiltersActive_then_twoNeighbourhoodsSelected
{
    [self.presenter neighbourhoodSelected:@"N1"];
    [self.presenter neighbourhoodSelected:@"N6"];

    XCTAssertEqual(0, self.view.selectedCategories.count);
    XCTAssertEqual(2, self.view.selectedNeighbourhoods.count);

    XCTAssertEqual(6, self.view.visibleCategories.count);
    XCTAssertEqual(6, self.view.totalHits);
}

- (void)test_twoNeighbourhoodsSelected_then_oneDeselected
{
    [self.presenter neighbourhoodSelected:@"N1"];
    [self.presenter neighbourhoodSelected:@"N3"];

    XCTAssertEqual(4, self.view.visibleCategories.count);
    XCTAssertEqual(4, self.view.totalHits);

    [self.presenter neighbourhoodDeselected:@"N1"];

    XCTAssertEqual(2, self.view.visibleCategories.count);
    XCTAssertEqual(1, self.view.totalHits);
}

- (void)test_twoNeighbourhoodsSelected_then_allDeselected
{
    [self.presenter neighbourhoodSelected:@"N1"];
    [self.presenter neighbourhoodSelected:@"N3"];

    XCTAssertEqual(4, self.view.visibleCategories.count);
    XCTAssertEqual(4, self.view.totalHits);

    [self.presenter neighbourhoodsAllDeselected];

    XCTAssertEqual(0, self.view.selectedNeighbourhoods.count);
    XCTAssertEqual(12, self.view.totalHits);
}

#pragma mark - Category Tests

- (void)test_noFiltersActive_then_categorySelected
{
    [self.presenter categorySelected:@"C10"];

    XCTAssertEqual(1, self.view.selectedCategories.count);
    XCTAssertEqual(0, self.view.selectedNeighbourhoods.count);

    XCTAssertEqual(10, self.view.visibleCategories.count);
    XCTAssertEqual(3, self.view.totalHits);
}

- (void)test_noFiltersActive_then_categoriesSelected
{
    [self.presenter categorySelected:@"C10"];
    [self.presenter categorySelected:@"C9"];

    XCTAssertEqual(2, self.view.selectedCategories.count);
    XCTAssertEqual(0, self.view.selectedNeighbourhoods.count);

    XCTAssertEqual(10, self.view.visibleCategories.count);
    XCTAssertEqual(5, self.view.totalHits);
}

- (void)test_categoriesSelected_then_categoriesDeselected
{
    [self.presenter categorySelected:@"C10"];

    XCTAssertEqual(1, self.view.selectedCategories.count);
    XCTAssertEqual(3, self.view.totalHits);

    [self.presenter categorySelected:@"C9"];

    XCTAssertEqual(2, self.view.selectedCategories.count);
    XCTAssertEqual(5, self.view.totalHits);

    [self.presenter categoryDeselected:@"C9"];

    XCTAssertEqual(1, self.view.selectedCategories.count);
    XCTAssertEqual(3, self.view.totalHits);
}

- (void)test_categoriesSelected_then_categoriesAllDeselected
{
    [self.presenter categorySelected:@"C10"];
    XCTAssertEqual(1, self.view.selectedCategories.count);
    XCTAssertEqual(3, self.view.totalHits);

    [self.presenter categorySelected:@"C9"];
    XCTAssertEqual(2, self.view.selectedCategories.count);
    XCTAssertEqual(5, self.view.totalHits);

    [self.presenter categoryDeselected:@"C9"];
    XCTAssertEqual(1, self.view.selectedCategories.count);
    XCTAssertEqual(3, self.view.totalHits);

    [self.presenter categoryDeselected:@"C10"];
    XCTAssertEqual(0, self.view.selectedCategories.count);
    XCTAssertEqual(12, self.view.totalHits);
}

- (void)test_categoriesSelected_then_reset
{
    [self.presenter categorySelected:@"C10"];
    XCTAssertEqual(1, self.view.selectedCategories.count);
    XCTAssertEqual(3, self.view.totalHits);

    [self.presenter categorySelected:@"C9"];
    XCTAssertEqual(2, self.view.selectedCategories.count);
    XCTAssertEqual(5, self.view.totalHits);

    [self.presenter resetFilters];
    XCTAssertEqual(0, self.view.selectedCategories.count);
    XCTAssertEqual(12, self.view.totalHits);
}

- (void)test_neighbourhoodsFiltersCategories
{
    XCTAssertEqual(0, self.view.selectedCategories.count);
    XCTAssertEqual(10, self.view.visibleCategories.count);

    [self.presenter neighbourhoodSelected:@"N1"];

    XCTAssertEqual(0, self.view.selectedCategories.count);
    XCTAssertEqual(3, self.view.visibleCategories.count);
}

@end