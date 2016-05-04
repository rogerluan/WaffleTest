//
//  RecipeViewController.m
//  WaffleTest
//
//  Created by Roger Luan on 5/2/16.
//  Copyright © 2016 Roger Oba. All rights reserved.
//

#import "RecipeViewController.h"
@import SafariServices;

static NSString * const reuseIdentifier = @"recipeInformationCell";
static NSString * const mainStoryboardIdentifier = @"Main";
static NSString * const recipeViewController = @"RecipeViewController";

@interface RecipeViewController () <UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) APIManager *APIManager;

@end

@implementation RecipeViewController

#pragma mark - Lifecycle -

- (instancetype)initWithAPIManager:(APIManager *)APIManager {
    self = [[UIStoryboard storyboardWithName:mainStoryboardIdentifier bundle:nil] instantiateViewControllerWithIdentifier:recipeViewController];
    
    if (!self) return nil;
    
    self.APIManager = APIManager;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageView.image = self.recipe.image;
    [self fetchRecipeIngredients];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Requests - 

- (void)fetchRecipeIngredients {
    [self.APIManager fetchIngredientsFromRecipe:self.recipe withCompletion:^(NSError * _Nullable error, NSArray * _Nullable ingredients) {
        if (!error) {
            self.recipe.ingredients = ingredients;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } else {
            NSLog(@"Handle error: %@",error.description);
        }
    }];
}

#pragma mark - UITableView Data Source Methods -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1;
        case 1: return 1;
        default: return [self.recipe.ingredients count];
    }
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            cell.textLabel.text = self.recipe.title;
            cell.textLabel.textColor = [UIColor colorWithRed:0.969 green:0.396 blue:0.090 alpha:1.000];
            break;
        }
        case 1: {
            cell.textLabel.text = self.recipe.publisher;
            cell.textLabel.textColor = [UIColor blackColor]; //this is needed because it reuse the cells.
            break;
        }
        default: {
            cell.textLabel.text = [self.recipe.ingredients objectAtIndex:indexPath.row];
            cell.textLabel.textColor = [UIColor blackColor]; //this is needed because it reuse the cells.
            break;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0: return NSLocalizedString(@"Recipe", @"RecipeVC Section Title");
        case 1: return NSLocalizedString(@"Publisher", @"RecipeVC Section Title");
        default: return NSLocalizedString(@"Ingredients", @"RecipeVC Section Title");
    }
}

#pragma mark - UITableView Delegate Methods - 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        SFSafariViewController *safariVC = [[SFSafariViewController alloc] initWithURL:self.recipe.sourceURL entersReaderIfAvailable:NO];
        [self presentViewController:safariVC animated:YES completion:nil];
    }
}

@end
