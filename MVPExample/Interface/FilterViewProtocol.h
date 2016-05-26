//
// Created by Neil on 20/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilterPresenterProtocol.h"

@protocol FilterViewProtocol <NSObject>

- (void)expandNeighbourhoods;

- (void)categorySelectionChanged:(NSArray *)categories;

- (void)neighbourhoodSelectionChanged:(NSArray *)locations;

- (void)filterUpdatedWithTotalHits:(NSUInteger)totalHits visibleCategories:(NSArray *)visibleCategories;

@end