cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/cordova-plugin-device/www/device.js",
        "id": "cordova-plugin-device.device",
        "clobbers": [
            "device"
        ]
    },
    {
        "file": "plugins/cordova-plugin-pgdayeu16/www/PGDayEU16Plugin.js",
        "id": "cordova-plugin-pgdayeu16.PGDayEU16Plugin",
        "clobbers": [
            "window.PGDayEU16Plugin"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-console": "1.0.3",
    "cordova-plugin-whitelist": "1.2.2",
    "cordova-plugin-device": "1.1.2",
    "cordova-plugin-pgdayeu16": "0.0.2"
};
// BOTTOM OF METADATA
});