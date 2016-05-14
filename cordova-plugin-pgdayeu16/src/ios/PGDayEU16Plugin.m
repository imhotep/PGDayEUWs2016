#import "PGDayEU16Plugin.h"

static NSString *const kPluginOptionItem = @"item";

@implementation PGDayEU16Plugin

- (void) retrieveList:(CDVInvokedUrlCommand*)command {
  NSDictionary * items = nil; // TODO get native list

  CDVPluginResult * pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:items];
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
  // TODO add item to native list

  CDVPluginResult * pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end