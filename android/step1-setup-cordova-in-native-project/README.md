1. Go to cordova-android/framework and run `android update project -p .` then run `ant jar`. There should be a `cordova-5.2.0-dev.jar` generated in the same folder.
2. Copy cordova-5.2.0-dev.jar to your `app/libs` folder.
3. Select `Project Files` on the left hand pane in Android Studio, right click on `cordova-5.2.0-dev.jar` and click `Add as Library`, click Ok.
3. Currently there is no easy way to install plugins in an Android Studio project. We will need to create a cordova android project, install plugins and then copy necessary files to the right location in our project. Run the following commands:
  `cordova create myApp`
  `cd myApp`
  `cordova platform add android`
  `cordova plugin add cordova-plugin-device`
  `cordova plugin add cordova-plugin-console`
  `cordova plugin add /path/to/cordova-plugin-pgdayeu16`
4. We will now create some folders that are used by cordova.
  1. Right click on `app` in `Project` and select `New` > `Folder` > `Assets folder`
  2. Right click on `assets` and select `New` > `Directory` and name it `www`
  3. Copy everything from `www-shared/www` to this newly created `assets/www`
  4. Right click on `res` and select `New` > `Directory` and name it xml
  5. Copy `/path/to/your/cordova_android_project/platforms/android/res/xml/config.xml` to your `ComponentCase/app/src/main/res/xml`
  6. Copy `cordova.js`, `cordova_plugins.js` and `plugins/` from `/path/to/your/cordova_android_project/platforms/assets/www/` to your `ComponentCase/app/src/main/assets/www`
  7. Copy `/path/to/your/cordova_android_project/platforms/android/src/org` to your `ComponentCase/app/src/main/java`
  8. Copy `/path/to/your/cordova_android_project/platforms/android/src/com/phonegapday/PGDayEU16Plugin.java` to your `ComponentCase/app/src/main/assets/src/main/java/com/phonegapday`
