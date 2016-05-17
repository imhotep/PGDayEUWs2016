1. Create a new android project, set name to "ComponentCase", domain to "com.phonegapday". Click next.
![step1](../img/step1.png)
2. Check "Phone and Tablet" and set Minimum SDK to API 21: Android 5.0 (Lollipop)
![step1](../img/step2.png)
3. Click next and select "Navigation Drawer Activity".
![step1](../img/step3.png)
4. Click next and click Finish
![step1](../img/step4.png)
5. Clean up a few things
  1. open `res/menu/activity_main_drawer.xml` and make sure it looks like this
  ```XML
    <?xml version="1.0" encoding="utf-8"?>
    <menu xmlns:android="http://schemas.android.com/apk/res/android">
        <group android:checkableBehavior="single">
            <item
                android:id="@+id/nav_webview"
                android:title="Webview" />
            <item
                android:id="@+id/nav_list_webview"
                android:title="List (WebView)" />
            <item
                android:id="@+id/nav_list_native"
                android:title="List (Native)" />
        </group>
    </menu>
  ```
  2. open `res/layout/app_bar_main.xml` and delete the `FloatingActionButton`
  3. delete all `ic_menu*` from `res/drawable`
  3. open `res/layout/nav_header_main.xml` and change the first TextView's text by "ComponentCase". Delete the ImageView and the other TextView.
  4. open `res/values/dimens.xml` and change `nav_header_height` to '100dp'  
  5. open 'MainActivity' and delete lines 26-33 (FloatingActionButton) and make sure your `onNavigationItemSelected` method looks like this
  ```Java
    public boolean onNavigationItemSelected(MenuItem item) {
          // Handle navigation view item clicks here.
          int id = item.getItemId();

          if (id == R.id.nav_webview) {
              // Handle the camera action
          } else if (id == R.id.nav_list_webview) {

          } else if (id == R.id.nav_list_native) {

          }

          DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
          drawer.closeDrawer(GravityCompat.START);
          return true;
      }
  ```

