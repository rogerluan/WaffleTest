//
//  RecipeTableViewController.h
//  WaffleTest
//
//  Created by Roger Luan on 5/2/16.
//  Copyright © 2016 Roger Oba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIManager.h"  

@interface RecipeTableViewController : UITableViewController

- (instancetype)initWithAPIManager:(APIManager *)APIManager;

@end
