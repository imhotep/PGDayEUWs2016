Cordova iOS - step 2
====================
Using CocoaPods to add Cordova

- [Install CocoaPods](https://guides.cocoapods.org/using/getting-started.html) if you haven't already: `sudo gem install cocoapods`
- Open a Terminal window and `cd` to the root of your iOS project (the folder where your `*.xcodeproj` file lives)
- Type `pod init` to create a fresh 'Podfile'
- Open the Podfile and change its contents to look like this (so you add the Cordova bits near the top) - note that our app's name is `PGDayEU16`:

```
platform :ios, '8.0'

# The latest published version of the Cordova-iOS library
pod 'Cordova'

# Any core Cordova plugins we need
pod 'cordova-plugin-console'
pod 'cordova-plugin-device'

# A handy starter template we'll add our own www bits to
pod 'phonegap-ios-template'

target 'PGDayEU16' do

end

target 'PGDayEU16Tests' do

end

target 'PGDayEU16UITests' do

end
```

- Go back to your Terminal and run `pod install`
- __IMPORTANT__: Once the dust settles open the `*.xcworkspace` file, not the `*.xcodeproj` file
- You should still be able to run the app on your phone - if not make sure your project structure in Xcode looks like this:

![ScreenShot](xcode-project-structure)