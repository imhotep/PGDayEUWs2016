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
        }
    ];
    module.exports.metadata = {};
});