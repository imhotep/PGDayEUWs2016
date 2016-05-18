1. open `res/layout/content_main.xml` and replace the TextView with the following
  
  ```XML
    <org.apache.cordova.engine.SystemWebView
        android:id="@+id/WebViewComponent"
        android:layout_width="match_parent"
        android:layout_height="match_parent">
    </org.apache.cordova.engine.SystemWebView>
  ``` 
2. Add the following attributes to `MainActivity.java`. Make sure you fix the imports.
  
  ```Java
    private String TAG = "ComponentWrapper";
    private SystemWebView webView;
    private CordovaWebView webInterface;
    private CordovaInterfaceImpl stupidface = new CordovaInterfaceImpl(this);
  ```
3. Add the following lines at the bottom of your `onCreate` method

  ```Java
  //Set up the webview
  ConfigXmlParser parser = new ConfigXmlParser();
  parser.parse(this);

  webView = (SystemWebView) findViewById(R.id.WebViewComponent);
  webInterface = new CordovaWebViewImpl(new SystemWebViewEngine(webView));
  webInterface.init(stupidface, parser.getPluginEntries(), parser.getPreferences());
  webView.loadUrl(parser.getLaunchUrl());
  ```

4. These methods are required for `CordovaWebView` to work properly. Add them and fix imports

  ```Java
    @Override
    public void onDestroy()
    {
        webInterface.handleDestroy();
        super.onDestroy();
    }


    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
        super.onActivityResult(requestCode, resultCode, intent);
        stupidface.onActivityResult(requestCode, resultCode, intent);
    }

    public void onRequestPermissionsResult(int requestCode, String permissions[],
                                           int[] grantResults) {
        try
        {
            stupidface.onRequestPermissionResult(requestCode, permissions, grantResults);
        }
        catch (JSONException e)
        {
            Log.d(TAG, "JSONException: Parameters fed into the method are not valid");
            e.printStackTrace();
        }

    }

  ```
