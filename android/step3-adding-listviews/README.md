1. Add the following line to your `res/values/strings.xml`
  
  ```XML
  <string name="add_bookmark">Add Bookmark</string>
  ```  
1. Right click on `res/layout` and select `New` -> `XML` -> `Layout XML File`. Name it `bookmark_main`. Make sure it looks like this
  
  ```XML
  <?xml version="1.0" encoding="utf-8"?>
  <LinearLayout xmlns:android="http://schemas.android.com/apk/res/android"
      android:id="@+id/bookmarkLayout"
      android:layout_width="match_parent"
      android:layout_height="match_parent"
      android:orientation="vertical"
      android:visibility="gone"
      android:weightSum="1">

      <ListView
          android:id="@+id/bookmarkView"
          android:layout_width="match_parent"
          android:layout_height="465dp"
          android:layout_gravity="center_horizontal" />

      <EditText
          android:id="@+id/bookmark"
          android:inputType="textUri"
          android:layout_width="fill_parent"
          android:layout_height="wrap_content"
          android:imeActionLabel="@string/add_bookmark" />
  </LinearLayout>
  ```
1. Add the following attributes to your `MainActivity.java`
  
  ```Java
  // need this for page navigation
  private String[] urls = new String[2];
  private ListView listView;
  private LinearLayout bookmarkLayout;
  private ArrayList<String> bookmarks = new ArrayList<String>();
  ```
2. Set up the native ListView by adding the following lines to your `onCreate` method. Fix imports
  
  ```Java
  // Set up the bookmark view
  bookmarks.add("http://google.com"); // dummy bookmark
  bookmarkLayout = (LinearLayout) findViewById(R.id.bookmarkLayout);
  listView = (ListView) findViewById(R.id.bookmarkView);
  if(listView != null) {
      listView.setAdapter(new ArrayAdapter<String>(this,
              android.R.layout.simple_list_item_activated_1,
              android.R.id.text1,
              bookmarks));
  }
  EditText bookmark = (EditText)findViewById(R.id.bookmark);
  if(bookmark != null) {
    bookmark.setOnEditorActionListener(new TextView.OnEditorActionListener() {
        @Override
        public boolean onEditorAction(TextView v, int actionId, KeyEvent event) {
            if (event != null && (event.getKeyCode() == KeyEvent.KEYCODE_ENTER)) {
                String text = v.getText().toString();
                addItem(text);
                v.setText("");
                InputMethodManager in = (InputMethodManager) getSystemService(Context.INPUT_METHOD_SERVICE);
                in.hideSoftInputFromWindow(
                        v.getApplicationWindowToken(),
                        InputMethodManager.HIDE_NOT_ALWAYS);
            }
            return false;
        }
    });
  }
  ```
3. Add the following methods
  
  ```Java
  protected ArrayList<String> getBookmarks() {
      return bookmarks;
  }

  protected void addItem(String item) {
      if(item != null) {
          bookmarks.add(item);
          ((BaseAdapter)listView.getAdapter()).notifyDataSetChanged();
      }
  }

  ```
3. Add this line to your `res/layout/content_main.xml`
  
  ```XML
  <include layout="@layout/bookmark_main"/>
  ```
4. Add these lines at the bottom of your `onCreate` method 
  
  ```Java
  urls[0] = parser.getLaunchUrl();
  urls[1] = urls[0].replace("index.html", "listeditor.html");
  webView.loadUrl(urls[0]);
  ```
5. Make sure your `onNavigationItemSelected` looks like this
  
  ```Java
  public boolean onNavigationItemSelected(MenuItem item) {
      // Handle navigation view item clicks here.
      int id = item.getItemId();

      if (id == R.id.nav_webview) {
          bookmarkLayout.setVisibility(View.GONE);
          webView.setVisibility(View.VISIBLE);
          webView.loadUrl(urls[0]);
      } else if (id == R.id.nav_list_webview) {
          bookmarkLayout.setVisibility(View.GONE);
          webView.setVisibility(View.VISIBLE);
          webView.loadUrl(urls[1]);
      } else if (id == R.id.nav_list_native) {
          bookmarkLayout.setVisibility(View.VISIBLE);
          webView.setVisibility(View.GONE);
      }

      DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
      drawer.closeDrawer(GravityCompat.START);
      return true;
  }
  ```
6. Make sure to add this attribute to your `<activity>` tag in your `AndroidManifest.xml`
  
  ```
  android:windowSoftInputMode="adjustPan"
  ```
7. To avoid seeing weird `eglCodecCommon` errors in the console add this to your filter: `^(?!eglCodecCommon)` 
