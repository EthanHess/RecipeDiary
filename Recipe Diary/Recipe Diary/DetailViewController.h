//
//  DetailViewController.h
//  Recipe Diary
//
//  Created by Ethan Hess on 10/24/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "Ingredient.h"

@protocol refreshDelegate <NSObject>

- (void)refreshData;

@end

@interface DetailViewController : UIViewController

@property (nonatomic, strong) Recipe *recipe;
@property (nonatomic, strong) Ingredient *ingredient;
@property (nonatomic, strong) id<refreshDelegate> delegate;

@end
