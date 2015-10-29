//
//  RecipeController.h
//  Recipe Diary
//
//  Created by Ethan Hess on 10/25/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"
#import "Ingredient.h"
#import <UIKit/UIKit.h>

@interface RecipeController : NSObject

+ (RecipeController *)sharedInstance;

- (void)addRecipeWithTitle:(NSString *)title description:(NSString *)description andImage:(UIImage *)image;

- (void)addIngredientWithName:(NSString *)name andQuantity:(NSString *)quantity toRecipe:(Recipe *)recipe;

- (void)removeRecipe:(Recipe *)recipe;

- (void)removeIngredient:(Ingredient *)ingredient;

- (NSArray *)recipes;

- (NSArray *)ingredients; 

@end
