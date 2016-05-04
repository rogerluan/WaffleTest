//
//  RecipeTableViewController+Factory.m
//  WaffleTest
//
//  Created by Roger Luan on 5/2/16.
//  Copyright © 2016 Roger Oba. All rights reserved.
//

#import "RecipeTableViewController+Factory.h"
#import "APIManager.h"

@implementation RecipeTableViewController (Factory)

+ (instancetype)factoryInstance {
    RecipeTableViewController *viewController = [[RecipeTableViewController alloc] initWithAPIManager:[APIManager new]];
    return viewController;
}

@end
