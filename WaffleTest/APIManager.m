//
//  APIManager.m
//  WaffleTest
//
//  Created by Roger Luan on 5/2/16.
//  Copyright © 2016 Roger Oba. All rights reserved.
//

#import "APIManager.h"

@implementation APIManager

static NSString * const SearchBaseURLString = @"http://food2fork.com/api/search/";
static NSString * const RecipeBaseURLString = @"http://food2fork.com/api/get/";
static NSString * const kAPIKey = @"37176991437f37ccf1cc0d18a51739c7";

#pragma mark - Public Methods -

- (void)fetchRecipeListWithCompletion:(nonnull RecipeListFetchCompletionBlock)completion {
    NSString *paramString = [NSString stringWithFormat:@"%@?key=%@",SearchBaseURLString,kAPIKey];
    NSURL *url = [[NSURL alloc] initWithString:paramString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [self showNetworkActivityIndicator:YES];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[[NSURLRequest alloc] initWithURL:url] completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self showNetworkActivityIndicator:NO];
        if (error) {
            completion(error,nil);
        } else {
            NSArray *recipes = [self recipesFromJSON:data error:&error];
            if (!error) {
                completion(nil,recipes);
            } else {
                completion(error,nil);
            }
        }
    }];
    [task resume];
}

- (void)fetchImageFromURL:(nonnull NSURL *)url withCompletion:(nonnull RecipeImageCompletionBlock)completion {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [self showNetworkActivityIndicator:YES];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        [self showNetworkActivityIndicator:NO];
        if (!error) {
            UIImage *image = [[UIImage alloc] initWithData:data];
            completion(nil,image);
        } else {
            completion(error,nil);
        }
    }];
}

- (void)fetchIngredientsFromRecipe:(nonnull Recipe *)recipe withCompletion:(nonnull RecipeIngredientsCompletionBlock)completion {
    NSString *paramString = [NSString stringWithFormat:@"%@?key=%@&rId=%@",RecipeBaseURLString,kAPIKey,recipe.recipeID];
    NSURL *url = [[NSURL alloc] initWithString:paramString];
    
    NSURLSession *session = [NSURLSession sharedSession];
    [self showNetworkActivityIndicator:YES];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:[[NSURLRequest alloc] initWithURL:url] completionHandler: ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        [self showNetworkActivityIndicator:NO];
        if (error) {
            completion(error,nil);
        } else {
            NSError *error = nil;
            NSDictionary *parsedObjects = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (error) {
                completion(error,nil);
            }
            NSArray *ingredients = [[parsedObjects objectForKey:@"recipe"] objectForKey:@"ingredients"];
            if (!error) {
                completion(nil,ingredients);
            } else {
                completion(error,nil);
            }
        }
    }];
    [task resume];
}

#pragma mark - Private Methods -

- (NSArray *)recipesFromJSON:(NSData *)data error:(NSError **)error {
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    NSMutableArray *recipes = [NSMutableArray new];
    NSArray *results = [parsedObject valueForKey:@"recipes"];
    
    for (NSDictionary *recipeDictionary in results) {
        Recipe *recipe = [Recipe new];
        recipe.recipeID = [recipeDictionary objectForKey:@"recipe_id"];
        recipe.title = [recipeDictionary objectForKey:@"title"];
        recipe.publisher = [recipeDictionary objectForKey:@"publisher"];
        recipe.imageURL = [NSURL URLWithString: [recipeDictionary objectForKey:@"image_url"]];
        recipe.sourceURL = [NSURL URLWithString:[recipeDictionary objectForKey:@"source_url"]];
        
        [recipes addObject:recipe];
    }
    return recipes;
}

- (void)showNetworkActivityIndicator:(BOOL)show {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:show];
}

@end
