//
//  CordovaListEditorViewController.m
//  PGDayEU16
//
//  Created by Eddy Verbruggen on 13/05/16.
//  Copyright © 2016 Eddy Verbruggen. All rights reserved.
//

#import "CordovaListEditorViewController.h"

@interface CordovaListEditorViewController ()

@end

@implementation CordovaListEditorViewController

- (void)viewDidLoad {
  // we don't want the default "index.html" for this ViewController
  [self setStartPage:@"listeditor.html"];
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
  CGRect viewBounds = self.view.bounds;
  CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
  CGRect webViewBounds = CGRectMake(viewBounds.origin.x,
                                    viewBounds.origin.y,
                                    viewBounds.size.width,
                                    viewBounds.size.height - tabBarHeight);

  self.webView.frame = webViewBounds;
  self.webView.backgroundColor = [UIColor clearColor];

  [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
