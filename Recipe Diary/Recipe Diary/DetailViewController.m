//
//  DetailViewController.m
//  Recipe Diary
//
//  Created by Ethan Hess on 10/24/15.
//  Copyright © 2015 Ethan Hess. All rights reserved.
//

#import "DetailViewController.h"
#import "RecipeController.h"

@interface DetailViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, strong) UIImage *chosenImage;
@property (nonatomic, strong) UIButton *addIngredientButton;
@property (nonatomic, strong) UIButton *addPhotoButton;
@property (nonatomic, strong) UIBarButtonItem *saveButton;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UITextField *titleField;
@property (nonatomic, strong) UITextView *descriptionField;


@end

@implementation DetailViewController

- (void)updateWithRecipe:(Recipe *)recipe {
    
    self.recipe = recipe;
    self.imageView.image = [UIImage imageWithData:recipe.picture];
    self.titleField.text = recipe.title;
    self.descriptionField.text = recipe.description;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveRecipe)];
    self.navigationItem.rightBarButtonItem = self.saveButton;
    
    //set up scroll view
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 1200)];
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1200);
    [self.view addSubview:self.scrollView];
    
    //set up image view
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(50, 50, self.view.frame.size.width - 100, self.view.frame.size.width - 100)];
    self.imageView.image = [UIImage imageNamed:@"imagePickerBackground"];
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height / 2;
    self.imageView.layer.borderColor = [[UIColor blackColor]CGColor];
    self.imageView.layer.borderWidth = 1;
    self.imageView.layer.masksToBounds = YES;
    [self.scrollView addSubview:self.imageView];
    
    //set up image picker
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.allowsEditing = YES;
    self.imagePicker.delegate = self;
    [self.imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    
    //set up ingredient button
    
    self.addIngredientButton = [[UIButton alloc]initWithFrame:CGRectMake(50, self.imageView.frame.size.height + 150, self.view.frame.size.width / 4, 50)];
    self.addIngredientButton.layer.cornerRadius = 10;
    self.addIngredientButton.layer.borderWidth = 1;
    self.addIngredientButton.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.addIngredientButton setTitle:@"Add Ingredient" forState:UIControlStateNormal];
    self.addIngredientButton.titleLabel.numberOfLines = 0;
    self.addIngredientButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:8];
    self.addIngredientButton.backgroundColor = [UIColor redColor];
    [self.addIngredientButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addIngredientButton addTarget:self action:@selector(addIngredient) forControlEvents:UIControlEventTouchUpInside];
    [self.scrollView addSubview:self.addIngredientButton];
    
    //set up add photo button
    
    self.addPhotoButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.frame.size.width - (self.addIngredientButton.frame.size.width + 50), self.imageView.frame.size.height + 150, self.view.frame.size.width / 4, 50)];
    self.addPhotoButton.layer.cornerRadius = 10;
    self.addPhotoButton.layer.borderWidth = 1;
    self.addPhotoButton.layer.borderColor = [[UIColor blackColor]CGColor];
    [self.addPhotoButton setTitle:@"Add Photo" forState:UIControlStateNormal];
    self.addPhotoButton.titleLabel.numberOfLines = 0;
    self.addPhotoButton.titleLabel.font = [UIFont fontWithName:@"Chalkduster" size:8];
    self.addPhotoButton.backgroundColor = [UIColor blueColor];
    [self.addPhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.addPhotoButton addTarget:self action:@selector(popImagePicker) forControlEvents:UIControlEventTouchUpInside];
    //    [self.view addSubview:self.addIngredientButton];
    [self.scrollView addSubview:self.addPhotoButton];
    
    //set up text field
    self.titleField = [[UITextField alloc]initWithFrame:CGRectMake(50, self.imageView.frame.size.height + 80, self.view.frame.size.width - 100, 50)];
    self.titleField.delegate = self;
    self.titleField.borderStyle = UITextBorderStyleRoundedRect;
    self.titleField.placeholder = @"Recipe Title";
    [self.scrollView addSubview:self.titleField];
    
    //set up text view
    self.descriptionField = [[UITextView alloc]initWithFrame:CGRectMake(50, self.imageView.frame.size.height + 250, self.view.frame.size.width - 100, 200)];
    self.descriptionField.delegate = self;
    self.descriptionField.layer.borderColor = [[UIColor blackColor]CGColor];
    self.descriptionField.layer.borderWidth = 1;
    self.descriptionField.layer.cornerRadius = 10;
    [self.scrollView addSubview:self.descriptionField];
    
    //set up tableView
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(50, self.imageView.frame.size.height + 500, self.view.frame.size.width - 100, 300) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.layer.cornerRadius = 10;
    self.tableView.layer.borderWidth = 1;
    self.tableView.layer.borderColor = [[UIColor blackColor]CGColor];
    [self registerTableView:self.tableView];
    [self.scrollView addSubview:self.tableView];
    
    [self.tableView reloadData];
    
    [self updateWithRecipe:self.recipe];
    
}

#pragma tableViewDataSource and Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.recipe.ingredients.count;
}

- (void)registerTableView:(UITableView *)tableView {
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Remove ingredient?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma imagePicker methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    self.chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = self.chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)popImagePicker {
    
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (void)addIngredient {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Add Ingredient" message:@"Enter info" preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Name";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"Quantity";
//        textField.keyboardType = UIKeyboardTypeDecimalPad;
    }];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSArray *textFields = [alertController textFields];
        
        NSString *nameString = ((UITextField *)textFields[0]).text;
        NSString *quantityString = ((UITextField *)textFields[1]).text;
        
        [[RecipeController sharedInstance]addIngredientWithName:nameString andQuantity:quantityString toRecipe:self.recipe];
        
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)saveRecipe {
    
    [[RecipeController sharedInstance]addRecipeWithTitle:self.titleField.text description:self.descriptionField.text andImage:self.chosenImage];
    
    [self refreshTableViewData];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    [textField resignFirstResponder];
    
}

//weird awkwardly written text view delegate method

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if( [text rangeOfCharacterFromSet:[NSCharacterSet newlineCharacterSet]].location == NSNotFound ) {
        return YES;
    }
    
    [textView resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTableViewData {
    
    [self.delegate refreshData];
    
    //fix error with delegate
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
