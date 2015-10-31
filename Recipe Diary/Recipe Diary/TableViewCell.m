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
        self.descriptionLabel.numberOfLines = 0;
        self.descriptionLabel.layer.borderColor = [[UIColor blackColor]CGColor];
        [self addSubview:self.descriptionLabel];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = @"title";
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:24];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.layer.cornerRadius = 20;
        self.titleLabel.layer.borderWidth = 1;
        self.titleLabel.layer.borderColor = [[UIColor blackColor]CGColor];
        self.titleLabel.layer.masksToBounds = YES;
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_descriptionLabel, _recipeImageView, _titleLabel);
        
        NSArray *recipeConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_recipeImageView]-10-|" options:0 metrics:nil views:viewsDictionary];
        
        NSArray *labelConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_descriptionLabel]-10-|" options:0 metrics:nil views:viewsDictionary];
        
        NSArray *titleConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_titleLabel]-10-|" options:0 metrics:nil views:viewsDictionary];
        
        NSArray *verticalConstrains = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_titleLabel(==70)]-10-[_recipeImageView(==200)]-10-[_descriptionLabel(==70)]-10-|" options:0 metrics:nil views:viewsDictionary];
        
        [self addConstraints:recipeConstraints];
        [self addConstraints:labelConstraints];
        [self addConstraints:titleConstraints];
        [self addConstraints:verticalConstrains];
        
    }
    
    return self;
}

@end
