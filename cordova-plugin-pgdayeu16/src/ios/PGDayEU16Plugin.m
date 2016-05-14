#import "PGDayEU16Plugin.h"
#import "CordovaListEditorViewController.h"
#import "FirstViewController.h"

static NSString *const kPluginOptionItem = @"item";

@implementation PGDayEU16Plugin

- (void) retrieveList:(CDVInvokedUrlCommand*)command {
  // fetch the native editor which holds the list of items
  FirstViewController* fvc = [self viewController].tabBarController.viewControllers[0];

  CDVPluginResult * pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsArray:fvc.items];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) addToList:(CDVInvokedUrlCommand*)command {
  NSDictionary * args = [command.arguments objectAtIndex:0];
  NSString * item = args[kPluginOptionItem];
  if (item == nil) {
    CDVPluginResult * pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"item is required"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    return;
  }

  // fetch the native editor which holds the list of items we want to add this item to
  FirstViewController* fvc = [self viewController].tabBarController.viewControllers[0];
  [fvc.items addObject:item];
  [fvc.tableView reloadData];

  CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
