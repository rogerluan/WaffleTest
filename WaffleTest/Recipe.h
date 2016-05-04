//
//  Recipe.h
//  WaffleTest
//
//  Created by Roger Luan on 5/2/16.
//  Copyright © 2016 Roger Oba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Recipe : NSObject

@property (strong, nonatomic) NSString *recipeID;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *publisher;
@property (strong, nonatomic) NSURL *imageURL;
@property (strong, nonatomic) UIImage *image;
@property (strong, nonatomic) NSURL *sourceURL;
@property (strong, nonatomic) NSArray *ingredients;


@end
