//
//  CordovaListEditorViewController.m
//  PGDayEU16
//
//  Created by Eddy Verbruggen on 13/05/16.
//  Copyright © 2016 Eddy Verbruggen. All rights reserved.
//

#import "CordovaListEditorViewController.h"

@interface CordovaListEditorViewController ()
@property (nonatomic, strong) UIActivityIndicatorView *spinnerView;
@end

@implementation CordovaListEditorViewController

- (void)viewDidLoad {
  // we don't want the default "index.html" for this ViewController
  [self setStartPage:@"listeditor.html"];
  [super viewDidLoad];

  // configure a loading indicator; show here, and hide when CDVPageDidLoadNotification fires
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(hideLoadingIndicator:)
                                               name:CDVPageDidLoadNotification
                                             object:nil];

  [self showLoadingIndicator];
}

- (void)showLoadingIndicator
{
  self.spinnerView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
  const CGFloat spinnerSize = 30;
  //Position the spinner on screen's center taking the tabbar into account.
  CGRect viewBounds = self.view.bounds;
  CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
  self.spinnerView.frame = CGRectMake(roundf((viewBounds.size.width - spinnerSize) / 2),
                                      roundf((viewBounds.size.height - spinnerSize - tabBarHeight) / 2),
                                      spinnerSize,
                                      spinnerSize);
  self.spinnerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin| UIViewAutoresizingFlexibleLeftMargin| UIViewAutoresizingFlexibleRightMargin;
  [self.view addSubview:self.spinnerView];
  self.spinnerView.hidesWhenStopped = YES;
  [self.spinnerView startAnimating];
}

- (void)hideLoadingIndicator:(NSNotification*)notification
{
  [self.spinnerView stopAnimating];
}

- (void)notifyWebview {
  // calling a specific method is a bit too tightly coupled but it serves our purpose of showing how to do native-web comms
  [self.webViewEngine evaluateJavaScript:@"retrieveList()" completionHandler:nil];
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
