0. Make sure you have [NodeJS](https://nodejs.org) installed. If you already have [NodeJS](https://nodejs.org) installed make sure you `npm install -g plugman`
1. Go to **Android Studio** > `Preferences` > `Plugins` and click on _install JetBrains Plugin_ button.
2. Search for `PhoneGap` and install it. Make sure you don't install the **PhoneGap/Cordova Plugin**
3. Restart **Android Studio** 
4. Go to `Tools` > `PhoneGap` > `Initialize Project`
5. Copy everything from www-shared/www to this newly created assets/www
6. Go to `Tools` > `PhoneGap` > `Install Plugin from npm`
7. Type in `cordova-plugin-device`
8. Go to `Tools` > `PhoneGap` > `Install Plugin from npm`
9. Type in `cordova-plugin-console`
10. Go to `Tools` > `PhoneGap` > `Install Plugin from filesystem`
11. Select `cordova-plugin-pgdayeu16` which can be found at the root of this repository 
