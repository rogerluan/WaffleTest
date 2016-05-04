//
//  RecipeTableViewController.m
//  WaffleTest
//
//  Created by Roger Luan on 5/2/16.
//  Copyright © 2016 Roger Oba. All rights reserved.
//

#import "RecipeTableViewController.h"
#import "RecipeViewController+Factory.h"
#import "RecipeTableViewCell.h"

static NSString * const reuseIdentifier = @"recipeCell";
static NSString * const ingredientsSegue = @"showIngredients";
static NSString * const mainStoryboardIdentifier = @"Main";
static NSString * const recipeTableViewController = @"RecipeTableViewController";

@interface RecipeTableViewController ()

@property (strong, nonatomic) NSArray *recipes;
@property (strong, nonatomic) APIManager *APIManager;

@end

@implementation RecipeTableViewController

- (instancetype)initWithAPIManager:(APIManager *)APIManager {
    self = [[UIStoryboard storyboardWithName:mainStoryboardIdentifier bundle:nil] instantiateViewControllerWithIdentifier:recipeTableViewController];
    
    if (!self) return nil;
    
    self.APIManager = APIManager;
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    [self refreshTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(RecipeTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    
    Recipe *recipe = [self.recipes objectAtIndex:indexPath.row];
    
    if (!cell.recipeImageView.image) {
        cell.recipeImageView.image = [UIImage imageNamed:@"placeholder"];
    }
    
    [self.APIManager fetchImageFromURL:recipe.imageURL withCompletion:^(NSError * _Nullable error, UIImage * _Nullable image) {
        if (!error && image) {
            recipe.image = image;
            cell.recipeImageView.image = recipe.image;
        } else {
            NSLog(@"Handle error here loading the image.");
        }
    }];
    cell.recipeTitleLabel.text = recipe.title;
    cell.recipePublisherLabel.text = recipe.publisher;
}

- (void)refreshTable {
    [self.refreshControl beginRefreshing];
    [self.APIManager fetchRecipeListWithCompletion:^(NSError * _Nullable error, NSArray * _Nullable recipes) {
        if (!error) {
            self.recipes = recipes;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"Handle error: %@",error.description);
        }
        [self.refreshControl endRefreshing];
    }];
}

#pragma mark - UITableView Delegate Methods - 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeViewController *viewController = [RecipeViewController factoryInstance];
    viewController.recipe = [self.recipes objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
