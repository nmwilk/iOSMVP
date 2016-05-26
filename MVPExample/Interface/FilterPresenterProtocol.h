//
// Created by Neil on 20/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FilterPresenterProtocol <NSObject>

- (void)initialise;

- (void)showAllNeighbourhoods;

- (void)neighbourhoodsAllDeselected;

- (void)neighbourhoodSelected:(NSString *)neighbourhoodName;

- (void)neighbourhoodDeselected:(NSString *)neighbourhoodName;

- (void)categorySelected:(NSString *)categoryName;

- (void)categoryDeselected:(NSString *)categoryName;

- (void)resetFilters;

@end