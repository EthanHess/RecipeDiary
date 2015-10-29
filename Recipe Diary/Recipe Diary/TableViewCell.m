//
//  TableViewCell.m
//  Recipe Diary
//
//  Created by Ethan Hess on 10/24/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.recipeImageView = [UIImageView new];
        self.recipeImageView.translatesAutoresizingMaskIntoConstraints = NO;
        self.recipeImageView.image = [UIImage imageNamed:@"imagePickerBackground"];
        self.recipeImageView.layer.cornerRadius = 20;
        self.recipeImageView.layer.borderColor = [[UIColor blackColor]CGColor];
        self.recipeImageView.layer.borderWidth = 1;
        self.recipeImageView.layer.masksToBounds = YES;
        [self addSubview:self.recipeImageView];
        
        self.descriptionLabel = [UILabel new];
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.descriptionLabel.text = @"description";
        self.descriptionLabel.textAlignment = NSTextAlignmentCenter;
        self.descriptionLabel.font = [UIFont fontWithName:@"Chalkduster" size:12];
        self.descriptionLabel.textColor = [UIColor blackColor];
        self.descriptionLabel.layer.cornerRadius = 20;
        self.descriptionLabel.layer.borderWidth = 1;
        self.descriptionLabel.layer.masksToBounds = YES;
        self.descriptionLabel.layer.borderColor = [[UIColor blackColor]CGColor];
        [self addSubview:self.descriptionLabel];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_descriptionLabel, _recipeImageView);
        
        NSArray *recipeConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_recipeImageView]-10-|" options:0 metrics:nil views:viewsDictionary];
        
        NSArray *labelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_descriptionLabel]-10-|" options:0 metrics:nil views:viewsDictionary];
        
//        NSLayoutConstraint *equalConstraint = [NSLayoutConstraint constraintWithItem:self.descriptionLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.recipeImageView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
        
        NSArray *verticalConstrains = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_recipeImageView(==200)]-10-[_descriptionLabel(==70)]-10-|" options:0 metrics:nil views:viewsDictionary];
        
        [self addConstraints:recipeConstraints];
        [self addConstraints:labelConstraints];
        [self addConstraints:verticalConstrains];
//        [self addConstraint:equalConstraint];
        
    }
    
    return self;
}

@end
