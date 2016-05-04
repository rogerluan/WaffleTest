//
//  RecipeTableViewController+Factory.h
//  WaffleTest
//
//  Created by Roger Luan on 5/2/16.
//  Copyright © 2016 Roger Oba. All rights reserved.
//

#import "RecipeTableViewController.h"

@interface RecipeTableViewController (Factory)

/**
 *  Instanciates a new API manager, and returns a RecipeTableViewController.
 *
 *  @return RecipeTableViewController A factored View Controller
 */
+ (instancetype)factoryInstance;


@end
