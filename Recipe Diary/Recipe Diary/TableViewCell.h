//
//  TableViewCell.h
//  Recipe Diary
//
//  Created by Ethan Hess on 10/24/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *recipeImageView;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end
