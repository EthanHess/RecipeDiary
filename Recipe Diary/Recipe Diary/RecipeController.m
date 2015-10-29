//
//  RecipeController.m
//  Recipe Diary
//
//  Created by Ethan Hess on 10/25/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import "RecipeController.h"
#import "Stack.h"

@implementation RecipeController

+ (RecipeController *)sharedInstance {
    static RecipeController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [RecipeController new];
    });
    
    return sharedInstance;
    
}

- (NSArray *)recipes {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Recipe"];
    
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return objects;
}

- (NSArray *)ingredients {
    
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Ingredient"];
    
    NSArray *objects = [[Stack sharedInstance].managedObjectContext executeFetchRequest:fetchRequest error:NULL];
    
    return objects;
}

- (void)addRecipeWithTitle:(NSString *)title description:(NSString *)description andImage:(UIImage *)image {
    
    NSData *data = [NSData dataWithData:UIImageJPEGRepresentation(image, 100)];
    
    Recipe *recipe = [NSEntityDescription insertNewObjectForEntityForName:@"Recipe" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    recipe.picture = data;
    recipe.title = title;
    recipe.recipeDescription = description;
    
    [self synchronize]; 
    
}

- (void)addIngredientWithName:(NSString *)name andQuantity:(NSString *)quantity toRecipe:(Recipe *)recipe {
    
    Ingredient *ingredient = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:[Stack sharedInstance].managedObjectContext];
    
    ingredient.recipe = recipe;
    ingredient.name = name;
    ingredient.quantity = quantity;
    
    [self synchronize];
}

- (void)removeRecipe:(Recipe *)recipe {
    
    [recipe.managedObjectContext deleteObject:recipe];
    [self synchronize];
}

- (void)removeIngredient:(Ingredient *)ingredient {
    
    [ingredient.managedObjectContext deleteObject:ingredient];
    [self synchronize]; 
}

// save to core data

- (void)synchronize {
    
    [[Stack sharedInstance].managedObjectContext save:NULL];
}

@end

