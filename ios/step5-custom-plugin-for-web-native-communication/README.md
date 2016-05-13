Cordova iOS - step 5
====================
Adding a custom plugin for web-native communication

__This is a lot of stuff so you might want to just grab the code folder instead of following along__

## Let's add a plugin
We'll do this one manually (as opposed to using CocoaPods) as that's also useful to learn.

When the first steps below have been completed you'll end up with this:

![ScreenShot](plugin-native-code.png)

- In Xcode right-click your project (top left) and select `New Group`, call it `cordova-plugin-pgdayeu16`
- Right-click that new folder and click `New file...`, select `iOS` > `Source` > `Header File`, name it `PGDayEU16Plugin.h` and paste these contents:

```objective-c
#import <Cordova/CDVPlugin.h>

@interface PGDayEU16Plugin : CDVPlugin

- (void) retrieveList:(CDVInvokedUrlCommand*)command;
- (void) addToList:(CDVInvokedUrlCommand*)command;

@end
```

- Right-click the folder again and click `New file...`, select `iOS` > `Source` > `Objective-C File`, name it `PGDayEU16Plugin.m` (select your app's target when asked!) and paste these contents:

```objective-c
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
```

- Go to `Pods` > `phonegap-ios-template` > `Resources` and open `config.xml`, then add this somewhere near the other `<feature>` tags:

```xml
    <feature name="PGDayEU16Plugin">
      <param name="ios-package" value="PGDayEU16Plugin" />
    </feature>
```

- Go to `Pods` > `phonegap-ios-template` > `Resources` > `www` and open `cordova_plugins.js`, then add this to the top:
```js
        {
            "file": "plugins/cordova-plugin-pgdayeu16/www/PGDayEU16Plugin.js",
            "id": "cordova-plugin-pgdayeu16.PGDayEU16Plugin",
            "pluginId": "cordova-plugin-pgdayeu16",
            "clobbers": [
                "window.PGDayEU16Plugin"
            ]
        },
```

You have now added the Cordova plugin native files, the JS bridge and the necessary wiring, bravo!

## Let's use the plugin
The plugin has two functions: `retrieveList` and `addToList`.

For both web and native we will create a view with an input field and a list and the idea is to sync those lists.

The current native ViewController will become the native editor, for the web editor we'll add a third tab.

- Add a tab by opening `Main.storyboard` and dragging a `ViewController` onto the canvas
- Hold the `ctrl` key and drag from the 'Tab Bar Controller' to the new ViewController - that should add a new tab bar item
- .. TODO ..