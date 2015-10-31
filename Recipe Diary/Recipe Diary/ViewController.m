//
//  ViewController.m
//  Recipe Diary
//
//  Created by Ethan Hess on 10/24/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import "HeaderView.h"
#import "RecipeController.h"
#import "Recipe.h"
#import "TableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITableViewDelegate, refreshDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) DetailViewController *detailViewController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self registerTableView:self.tableView];
    [self.view addSubview:self.tableView];
    
    [self.tableView reloadData]; 
    
    [self setUpNavigationBar];
    
    self.detailViewController.delegate = self;
}

- (void)setUpNavigationBar {
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(pushToDetail)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshData)];
    self.navigationItem.leftBarButtonItem = refreshButton;
    
    //configure appearance further here
}

- (void)registerTableView:(UITableView *)tableView {
    
    [tableView registerClass:[TableViewCell class] forCellReuseIdentifier:@"cell"];

}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    
//    return [RecipeController sharedInstance].recipes.count;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 380;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [RecipeController sharedInstance].recipes.count; 
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    Recipe *recipe = [RecipeController sharedInstance].recipes[indexPath.section];
    
    cell.recipeImageView.image = [UIImage imageWithData:recipe.picture];
    cell.descriptionLabel.text = recipe.description;
    cell.titleLabel.text = recipe.title;
    
    return cell; 
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailViewController *detailViewController = [DetailViewController new];
    
    detailViewController.recipe = [RecipeController sharedInstance].recipes[indexPath.row];
    
    [self.navigationController pushViewController:detailViewController animated:YES]; 
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    
//    HeaderView *headerView = [HeaderView new];
//    
//    Recipe *recipe = [RecipeController sharedInstance].recipes[section];
//    
//    headerView.titleLabel.text = recipe.title;
//    
//    return headerView;
//    
//}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    
//    return 70;
//}

- (void)pushToDetail {
    
    DetailViewController *detailViewController = [DetailViewController new];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)refreshData {
    
    [self.tableView reloadData]; 
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [tableView beginUpdates];
        
        [[RecipeController sharedInstance]removeRecipe:[RecipeController sharedInstance].recipes[indexPath.section]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView reloadData]; 
        
        [tableView endUpdates];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
