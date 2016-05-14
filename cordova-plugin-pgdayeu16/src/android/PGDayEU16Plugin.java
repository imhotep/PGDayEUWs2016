package ncom.phonegapday;

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
        JSONArray items = new JSONArray();
        // TODO get from native list

        callbackContext.success(items);
        return true;

      } else if (ACTION_ADD_TO_LIST.equals(action)) {
        final JSONObject options = args.getJSONObject(0);
        if (!options.has("item"))  {
          callbackContext.error("item is required");
        } else {
          // TODO add to native list
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