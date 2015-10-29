//
//  Ingredient+CoreDataProperties.h
//  Recipe Diary
//
//  Created by Ethan Hess on 10/26/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Ingredient.h"

NS_ASSUME_NONNULL_BEGIN

@interface Ingredient (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *quantity;
@property (nullable, nonatomic, retain) Recipe *recipe;

@end

NS_ASSUME_NONNULL_END
