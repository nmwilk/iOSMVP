//
// Created by Neil on 20/04/2016.
// Copyright (c) 2016 Neil Wilkinson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FilterPresenterProtocol.h"

@protocol FilterViewProtocol;
@class FilterModel;


@interface FilterPresenter : NSObject <FilterPresenterProtocol>

- (instancetype)initWithView:(id <FilterViewProtocol>)view model:(FilterModel *)model;
- (void)initialise;
@end