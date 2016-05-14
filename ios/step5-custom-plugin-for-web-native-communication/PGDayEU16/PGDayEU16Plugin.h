#import <Cordova/CDVPlugin.h>

@interface PGDayEU16Plugin : CDVPlugin

- (void) retrieveList:(CDVInvokedUrlCommand*)command;
- (void) addToList:(CDVInvokedUrlCommand*)command;

@end
