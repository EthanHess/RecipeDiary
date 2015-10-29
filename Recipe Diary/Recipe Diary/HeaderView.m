//
//  HeaderView.m
//  Recipe Diary
//
//  Created by Ethan Hess on 10/24/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor cyanColor];
        
        self.titleLabel = [UILabel new];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:24];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.backgroundColor = [UIColor blueColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter; 
        self.titleLabel.layer.cornerRadius = 10;
        self.titleLabel.layer.borderColor = [[UIColor whiteColor]CGColor];
        self.titleLabel.layer.borderWidth = 1;
        self.titleLabel.layer.masksToBounds = YES;
        [self addSubview:self.titleLabel];
        
        NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_titleLabel);
        
        NSArray *verticalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_titleLabel]-10-|" options:0 metrics:nil views:viewsDictionary];
        
        NSArray *horizontalConstranits = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_titleLabel]-10-|" options:0 metrics:nil views:viewsDictionary];
        
        [self addConstraints:verticalConstraints];
        [self addConstraints:horizontalConstranits];
        
    }
    
    return self;
}


@end
