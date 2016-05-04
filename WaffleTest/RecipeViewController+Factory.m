//
//  RecipeViewController+Factory.m
//  WaffleTest
//
//  Created by Roger Luan on 5/3/16.
//  Copyright © 2016 Roger Oba. All rights reserved.
//

#import "RecipeViewController+Factory.h"

#import "APIManager.h"

@implementation RecipeViewController (Factory)

+ (instancetype)factoryInstance {
    RecipeViewController *viewController = [[RecipeViewController alloc] initWithAPIManager:[APIManager new]];
    return viewController;
}

@end
