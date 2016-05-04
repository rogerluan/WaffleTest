//
//  RecipeViewController+Factory.h
//  WaffleTest
//
//  Created by Roger Luan on 5/3/16.
//  Copyright © 2016 Roger Oba. All rights reserved.
//

#import "RecipeViewController.h"

@interface RecipeViewController (Factory)

/**
 *  Instanciates a new API manager, and returns a RecipeViewController.
 *
 *  @return RecipeViewController A factored View Controller
 */
+ (instancetype)factoryInstance;

@end
