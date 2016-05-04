//
//  APIManager.h
//  WaffleTest
//
//  Created by Roger Luan on 5/2/16.
//  Copyright © 2016 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Recipe.h"

/**
 *  Completion block called when fetching the recipes list.
 *
 *  @param error        NSError containing any error that may occur.
 *  @param recipeList   NSArray containing the requested recipe list.
 */
typedef void(^RecipeListFetchCompletionBlock)(NSError * _Nullable error,NSArray * _Nullable recipes);

/**
 *  Completion block called when fetching the recipe image.
 *
 *  @param error    NSError containing any error that may occur.
 *  @param image    UIImage containing the recipe image.
 */
typedef void(^RecipeImageCompletionBlock)(NSError * _Nullable error,UIImage * _Nullable image);

/**
 *  Completion block called when fetching the recipe ingredients.
 *
 *  @param error    NSError containing any error that may occur.
 *  @param array    NSArray containing the recipe ingredients.
 */
typedef void(^RecipeIngredientsCompletionBlock)(NSError * _Nullable error,NSArray * _Nullable ingredients);

@interface APIManager : NSObject

/**
 *  Fetches a list of recipes, top rated first.
 *
 *  @param completion The completion block to call when the request completes.
 */
- (void)fetchRecipeListWithCompletion:(nonnull RecipeListFetchCompletionBlock)completion;

/**
 *  Fetches the image from the given URL.
 *
 *  @param url        URL of the image that is going to be fetched.
 *  @param completion The completion block to call when the request completes.
 */
- (void)fetchImageFromURL:(nonnull NSURL *)url withCompletion:(nonnull RecipeImageCompletionBlock)completion;

/**
 *  Fetches a list with the recipe ingredients.
 *
 *  @param recipe     The recipe that needs its ingredients fetched.
 *  @param completion The completion block to call when the request completes.
 */
- (void)fetchIngredientsFromRecipe:(nonnull Recipe *)recipe withCompletion:(nonnull RecipeIngredientsCompletionBlock)completion;

@end
