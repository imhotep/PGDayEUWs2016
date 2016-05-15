cordova.define("cordova-plugin-pgdayeu16.PGDayEU16Plugin", function(require, exports, module) {
function PGDayEU16Plugin() {
}

PGDayEU16Plugin.prototype.retrieveList = function (options, successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "PGDayEU16Plugin", "retrieveList", [options]);
};

PGDayEU16Plugin.prototype.addToList = function (options, successCallback, errorCallback) {
  cordova.exec(successCallback, errorCallback, "PGDayEU16Plugin", "addToList", [options]);
};

PGDayEU16Plugin.install = function () {
  if (!window.plugins) {
    window.plugins = {};
  }

  window.PGDayEU16Plugin = new PGDayEU16Plugin();
  return window.PGDayEU16Plugin;
};

cordova.addConstructor(PGDayEU16Plugin.install);
});
