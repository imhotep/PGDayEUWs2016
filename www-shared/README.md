This is the platform-agnostic www folder - the contents of this folder can be copied to the native project's www folders.

The contents of this folder will be:
- index.html which will be the same as currently is in ios/step3/resources
- listeditor.html(?) which will have a text field and a list.

The third tab/section of the app will be native and will also have a textfield and a list.

The data is stored in a local variable in native code, so we need a plugin to `addToList` and `retrieveList` as well.