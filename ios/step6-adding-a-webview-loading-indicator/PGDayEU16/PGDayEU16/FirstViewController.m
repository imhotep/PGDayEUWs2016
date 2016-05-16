//
//  FirstViewController.m
//  PGDayEU16
//
//  Created by Eddy Verbruggen on 12/05/16.
//  Copyright © 2016 Eddy Verbruggen. All rights reserved.
//

#import "FirstViewController.h"
#import "CordovaListEditorViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  _items = [NSMutableArray new];
  [_items addObject:@"First item"];
  [_items addObject:@"Second item"];
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // add the UI programmatically instead of via storyboard so it's easy to just copy-paste
  [self addTextField];
  [self addButton];
  [self addTable];
}

- (void) addTextField {
  _textField = [[UITextField alloc] initWithFrame:CGRectMake(17, 50, 200, 35)];
  _textField.borderStyle = UITextBorderStyleRoundedRect;
  _textField.placeholder = @"Add an item..";
  _textField.autocorrectionType = UITextAutocorrectionTypeNo;
  _textField.font = [UIFont systemFontOfSize:14];
  [self.view addSubview:_textField];
}

- (void) addButton {
  UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  button.frame = CGRectMake(230, 50, 50, 35);
  [button setTitle:@"Add" forState:UIControlStateNormal];
  [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:button];
}

- (void) addTable {
  CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
  CGRect frame = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height-100-tabBarHeight);
  self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
  self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  [self.view addSubview:self.tableView];
}

- (void) buttonPressed {
  if (![_textField.text isEqualToString:@""]) {
    [_items addObject:_textField.text];
    _textField.text = @"";
    [_tableView reloadData];

    // fetch the web editor which we need to send an event to JS
    CordovaListEditorViewController* cvc = self.tabBarController.viewControllers[1];
    [cvc notifyWebview];
  }
}

#pragma mark UITableViewDataSource implementation
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [_items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *CellIdentifier = @"Cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  cell.textLabel.text = [_items objectAtIndex:indexPath.row];
  return cell;
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
