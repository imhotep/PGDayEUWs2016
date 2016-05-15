package com.phonegapday.componentcase;

import org.apache.cordova.*;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

public class PGDayEU16Plugin extends CordovaPlugin {

  private static final String ACTION_RETRIEVE_LIST = "retrieveList";
  private static final String ACTION_ADD_TO_LIST = "addToList";

  @Override
  public boolean execute(String action, CordovaArgs args, CallbackContext callbackContext) throws JSONException {
    try {
      if (ACTION_RETRIEVE_LIST.equals(action)) {
        JSONArray items = new JSONArray(((MainActivity)cordova.getActivity()).getBookmarks());
        // TODO get from native list

        callbackContext.success(items);
        return true;

      } else if (ACTION_ADD_TO_LIST.equals(action)) {
        final JSONObject options = args.getJSONObject(0);
        if (!options.has("item"))  {
          callbackContext.error("item is required");
        } else {

            ((MainActivity)cordova.getActivity()).addItem(options.getString("item"));
          callbackContext.success();
          return true;
        }
      }
    } catch (Throwable t) {
      t.printStackTrace();
      callbackContext.error("ERROR: " + t.getMessage());
    }
    return false;
  }

}