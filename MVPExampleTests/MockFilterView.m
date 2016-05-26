//
// Created by Neil on 21/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import "MockFilterView.h"


@implementation MockFilterView

- (void)expandNeighbourhoods
{
    self.isNeighbourhoodsExpanded = YES;
}

- (void)categorySelectionChanged:(NSArray *)categories
{
    self.selectedCategories = [categories copy];
}

- (void)neighbourhoodSelectionChanged:(NSArray *)locations
{
    self.selectedNeighbourhoods = [locations copy];
}

- (void)filterUpdatedWithTotalHits:(NSUInteger)totalHits visibleCategories:(NSArray *)visibleCategories
{
    self.totalHits = totalHits;
    self.visibleCategories = visibleCategories;
}

@end