//
//  Recipe+CoreDataProperties.h
//  Recipe Diary
//
//  Created by Ethan Hess on 10/26/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Recipe.h"

NS_ASSUME_NONNULL_BEGIN

@interface Recipe (CoreDataProperties)

@property (nullable, nonatomic, retain) NSData *picture;
@property (nullable, nonatomic, retain) NSString *recipeDescription;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSOrderedSet<Ingredient *> *ingredients;

@end

@interface Recipe (CoreDataGeneratedAccessors)

- (void)insertObject:(Ingredient *)value inIngredientsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromIngredientsAtIndex:(NSUInteger)idx;
- (void)insertIngredients:(NSArray<Ingredient *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeIngredientsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInIngredientsAtIndex:(NSUInteger)idx withObject:(Ingredient *)value;
- (void)replaceIngredientsAtIndexes:(NSIndexSet *)indexes withIngredients:(NSArray<Ingredient *> *)values;
- (void)addIngredientsObject:(Ingredient *)value;
- (void)removeIngredientsObject:(Ingredient *)value;
- (void)addIngredients:(NSOrderedSet<Ingredient *> *)values;
- (void)removeIngredients:(NSOrderedSet<Ingredient *> *)values;

@end

NS_ASSUME_NONNULL_END
