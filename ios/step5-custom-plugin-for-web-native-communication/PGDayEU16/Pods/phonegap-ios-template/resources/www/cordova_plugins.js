cordova.define('cordova/plugin_list', function(require, exports, module) {
    module.exports = [
        {
            "file": "plugins/cordova-plugin-device/www/device.js",
            "id": "cordova-plugin-device.device",
            "pluginId": "cordova-plugin-device",
            "clobbers": [
                "device"
            ]
        },
        {
            "file": "plugins/cordova-plugin-console/www/console-via-logger.js",
            "id": "cordova-plugin-console.console",
            "pluginId": "cordova-plugin-console",
            "clobbers": [
                "console"
            ]
        },
        {
            "file": "plugins/cordova-plugin-console/www/logger.js",
            "id": "cordova-plugin-console.logger",
            "pluginId": "cordova-plugin-console",
            "clobbers": [
                "cordova.logger"
            ]
        },
        {
            "file": "plugins/cordova-plugin-pgdayeu16/www/PGDayEU16Plugin.js",
            "id": "cordova-plugin-pgdayeu16.PGDayEU16Plugin",
            "pluginId": "cordova-plugin-pgdayeu16",
            "clobbers": [
                "window.PGDayEU16Plugin"
            ]
        }
    ];
    module.exports.metadata = {};
});