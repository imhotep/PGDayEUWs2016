1. Create a new project in Android Studio
2. Import `framework` directory from `cordova-android` into existing project. Click `File` > `New` > `Import Module`. Name it _CordovaLib_
3. Right click on `app` in `Project` and select `New` > `Folder` > `Assets folder`
4. Right click on `assets` and select `New` > `Directory` and name it `www`
5. Add assets to it.
5. Right click on `res` and select `New` > `Directory` and name it xml
6. Drag and Drop config.xml to `res/xml` 
7. Create a `res/layout/fragment_main.xml`
  ```XML
    <?xml version="1.0" encoding="utf-8"?>
    <RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android"
      xmlns:tools="http://schemas.android.com/tools" android:layout_width="match_parent"
      android:layout_height="match_parent" android:paddingLeft="@dimen/activity_horizontal_margin"
      android:paddingRight="@dimen/activity_horizontal_margin"
      android:paddingTop="@dimen/activity_vertical_margin"
      android:paddingBottom="@dimen/activity_vertical_margin"
      tools:context=".MainActivity$PlaceholderFragment">

    <TextView android:id="@+id/section_label" android:layout_width="wrap_content"
        android:layout_height="wrap_content" />

    </RelativeLayout>
  ```
8. Right click on `java` and select `New` > `Fragment (blank)` and name it `NavigationDrawerFragment`
9. Edit `res/layout/fragment_navigation_drawer.xml` and add the following
  ```XML  
  <?xml version="1.0" encoding="utf-8"?>
  <ListView xmlns:android="http://schemas.android.com/apk/res/android"
      xmlns:tools="http://schemas.android.com/tools" android:layout_width="match_parent"
      android:layout_height="match_parent" android:choiceMode="singleChoice"
      android:divider="@android:color/transparent" android:dividerHeight="0dp"
      android:background="#cccc" tools:context=".NavigationDrawerFragment" />
  ```
10. Copy drawables from `NavigationDrawerActivity` to `res/` folder.
11. Create an android resource folder under `res` and select `menu`. Create two new menu resource files and call them `global` and `main`.
12. Replace content of `global.xml` with this

  ```XML
    <?xml version="1.0" encoding="utf-8"?>
    <menu xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto">
        <item android:id="@+id/action_settings" android:title="@string/action_settings"
            android:orderInCategory="100" app:showAsAction="never" />
    </menu>
  ```

13. Replace content of `main.xml` with
  
  ```XML
    <menu xmlns:android="http://schemas.android.com/apk/res/android"
        xmlns:app="http://schemas.android.com/apk/res-auto"
        xmlns:tools="http://schemas.android.com/tools" tools:context=".MainActivity">
        <item android:id="@+id/action_example" android:title="@string/action_example"
            app:showAsAction="withText|ifRoom" />
        <item android:id="@+id/action_settings" android:title="@string/action_settings"
            android:orderInCategory="100" app:showAsAction="never" />
    </menu>
  ```
14. Right click on `app` and select `Open Module Settings...` > Dependencies. Click on `+` and select `Module Dependency`. Select CordovaLib.
15. Add this line to your `res/values/dimens.xml`
  ```XML
    <!-- Per the design guidelines, navigation drawers should be between 240dp and 320dp:
       https://developer.android.com/design/patterns/navigation-drawer.html -->
      <dimen name="navigation_drawer_width">240dp</dimen>
  ```
14. Update `activity_main.xml` with the two views. Add the following:

  ```XML
  <!-- A DrawerLayout is intended to be used as the top-level content view using match_parent for both width and height to consume the full space available. -->
  <android.support.v4.widget.DrawerLayout xmlns:android="http://schemas.android.com/apk/res/android"
      xmlns:tools="http://schemas.android.com/tools" android:id="@+id/drawer_layout"
      android:layout_width="match_parent" android:layout_height="match_parent"
      tools:context=".MainActivity">

      <!-- As the main content view, the view below consumes the entire
           space available using match_parent in both dimensions. -->
      <FrameLayout android:id="@+id/container" android:layout_width="match_parent"
          android:layout_height="match_parent">
          <!-- Let's throw the WebView in here for no good reason -->
          <org.apache.cordova.engine.SystemWebView
              android:id="@+id/WebViewComponent"
              android:layout_width="match_parent"
              android:layout_height="match_parent">
          </org.apache.cordova.engine.SystemWebView>
      </FrameLayout>

      <!-- android:layout_gravity="start" tells DrawerLayout to treat
           this as a sliding drawer on the left side for left-to-right
           languages and on the right side for right-to-left languages.
           If you're not building against API 17 or higher, use
           android:layout_gravity="left" instead. -->
      <!-- The drawer is given a fixed width in dp and extends the full height of
           the container. -->
      <fragment android:id="@+id/navigation_drawer"
          android:layout_width="@dimen/navigation_drawer_width" android:layout_height="match_parent"
          android:layout_gravity="start"
          android:name="phonegap.com.componentcase.NavigationDrawerFragment"
          tools:layout="@layout/fragment_navigation_drawer" />

  </android.support.v4.widget.DrawerLayout>
  ```
  
15. add `NavigationDrawerFragment.java`

  ```Java
  package org.apache.cordova.componentcase;

  import android.support.v7.app.ActionBarActivity;
  import android.app.Activity;
  import android.support.v7.app.ActionBar;
  import android.support.v4.app.Fragment;
  import android.support.v4.app.ActionBarDrawerToggle;
  import android.support.v4.view.GravityCompat;
  import android.support.v4.widget.DrawerLayout;
  import android.content.SharedPreferences;
  import android.content.res.Configuration;
  import android.os.Bundle;
  import android.preference.PreferenceManager;
  import android.view.LayoutInflater;
  import android.view.Menu;
  import android.view.MenuInflater;
  import android.view.MenuItem;
  import android.view.View;
  import android.view.ViewGroup;
  import android.widget.AdapterView;
  import android.widget.ArrayAdapter;
  import android.widget.ListView;
  import android.widget.Toast;

  /**
   * Fragment used for managing interactions for and presentation of a navigation drawer.
   * See the <a href="https://developer.android.com/design/patterns/navigation-drawer.html#Interaction">
   * design guidelines</a> for a complete explanation of the behaviors implemented here.
   */
  public class NavigationDrawerFragment extends Fragment {

      /**
       * Remember the position of the selected item.
       */
      private static final String STATE_SELECTED_POSITION = "selected_navigation_drawer_position";

      /**
       * Per the design guidelines, you should show the drawer on launch until the user manually
       * expands it. This shared preference tracks this.
       */
      private static final String PREF_USER_LEARNED_DRAWER = "navigation_drawer_learned";

      /**
       * A pointer to the current callbacks instance (the Activity).
       */
      private NavigationDrawerCallbacks mCallbacks;

      /**
       * Helper component that ties the action bar to the navigation drawer.
       */
      private ActionBarDrawerToggle mDrawerToggle;

      private DrawerLayout mDrawerLayout;
      private ListView mDrawerListView;
      private View mFragmentContainerView;

      private int mCurrentSelectedPosition = 0;
      private boolean mFromSavedInstanceState;
      private boolean mUserLearnedDrawer;

      public NavigationDrawerFragment() {
      }

      @Override
      public void onCreate(Bundle savedInstanceState) {
          super.onCreate(savedInstanceState);

          // Read in the flag indicating whether or not the user has demonstrated awareness of the
          // drawer. See PREF_USER_LEARNED_DRAWER for details.
          SharedPreferences sp = PreferenceManager.getDefaultSharedPreferences(getActivity());
          mUserLearnedDrawer = sp.getBoolean(PREF_USER_LEARNED_DRAWER, false);

          if (savedInstanceState != null) {
              mCurrentSelectedPosition = savedInstanceState.getInt(STATE_SELECTED_POSITION);
              mFromSavedInstanceState = true;
          }

          // Select either the default item (0) or the last selected item.
          selectItem(mCurrentSelectedPosition);
      }

      @Override
      public void onActivityCreated(Bundle savedInstanceState) {
          super.onActivityCreated(savedInstanceState);
          // Indicate that this fragment would like to influence the set of actions in the action bar.
          setHasOptionsMenu(true);
      }

      @Override
      public View onCreateView(LayoutInflater inflater, ViewGroup container,
                               Bundle savedInstanceState) {
          mDrawerListView = (ListView) inflater.inflate(
                  R.layout.fragment_navigation_drawer, container, false);
          mDrawerListView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
              @Override
              public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                  selectItem(position);
              }
          });
          mDrawerListView.setAdapter(new ArrayAdapter<String>(
                  getActionBar().getThemedContext(),
                  android.R.layout.simple_list_item_activated_1,
                  android.R.id.text1,
                  new String[]{
                          getString(R.string.title_section1),
                          getString(R.string.title_section2),
                          getString(R.string.title_section3),
                  }));
          mDrawerListView.setItemChecked(mCurrentSelectedPosition, true);
          return mDrawerListView;
      }

      public boolean isDrawerOpen() {
          return mDrawerLayout != null && mDrawerLayout.isDrawerOpen(mFragmentContainerView);
      }

      /**
       * Users of this fragment must call this method to set up the navigation drawer interactions.
       *
       * @param fragmentId   The android:id of this fragment in its activity's layout.
       * @param drawerLayout The DrawerLayout containing this fragment's UI.
       */
      public void setUp(int fragmentId, DrawerLayout drawerLayout) {
          mFragmentContainerView = getActivity().findViewById(fragmentId);
          mDrawerLayout = drawerLayout;

          // set a custom shadow that overlays the main content when the drawer opens
          mDrawerLayout.setDrawerShadow(R.drawable.drawer_shadow, GravityCompat.START);
          // set up the drawer's list view with items and click listener

          ActionBar actionBar = getActionBar();
          actionBar.setDisplayHomeAsUpEnabled(true);
          actionBar.setHomeButtonEnabled(true);

          // ActionBarDrawerToggle ties together the the proper interactions
          // between the navigation drawer and the action bar app icon.
          mDrawerToggle = new ActionBarDrawerToggle(
                  getActivity(),                    /* host Activity */
                  mDrawerLayout,                    /* DrawerLayout object */
                  R.drawable.ic_drawer,             /* nav drawer image to replace 'Up' caret */
                  R.string.navigation_drawer_open,  /* "open drawer" description for accessibility */
                  R.string.navigation_drawer_close  /* "close drawer" description for accessibility */
          ) {
              @Override
              public void onDrawerClosed(View drawerView) {
                  super.onDrawerClosed(drawerView);
                  if (!isAdded()) {
                      return;
                  }

                  getActivity().supportInvalidateOptionsMenu(); // calls onPrepareOptionsMenu()
              }

              @Override
              public void onDrawerOpened(View drawerView) {
                  super.onDrawerOpened(drawerView);
                  if (!isAdded()) {
                      return;
                  }

                  if (!mUserLearnedDrawer) {
                      // The user manually opened the drawer; store this flag to prevent auto-showing
                      // the navigation drawer automatically in the future.
                      mUserLearnedDrawer = true;
                      SharedPreferences sp = PreferenceManager
                              .getDefaultSharedPreferences(getActivity());
                      sp.edit().putBoolean(PREF_USER_LEARNED_DRAWER, true).apply();
                  }

                  getActivity().supportInvalidateOptionsMenu(); // calls onPrepareOptionsMenu()
              }
          };

          // If the user hasn't 'learned' about the drawer, open it to introduce them to the drawer,
          // per the navigation drawer design guidelines.
          if (!mUserLearnedDrawer && !mFromSavedInstanceState) {
              mDrawerLayout.openDrawer(mFragmentContainerView);
          }

          // Defer code dependent on restoration of previous instance state.
          mDrawerLayout.post(new Runnable() {
              @Override
              public void run() {
                  mDrawerToggle.syncState();
              }
          });

          mDrawerLayout.setDrawerListener(mDrawerToggle);
      }

      private void selectItem(int position) {
          mCurrentSelectedPosition = position;
          if (mDrawerListView != null) {
              mDrawerListView.setItemChecked(position, true);
          }
          if (mDrawerLayout != null) {
              mDrawerLayout.closeDrawer(mFragmentContainerView);
          }
          if (mCallbacks != null) {
              mCallbacks.onNavigationDrawerItemSelected(position);
          }
      }

      @Override
      public void onAttach(Activity activity) {
          super.onAttach(activity);
          try {
              mCallbacks = (NavigationDrawerCallbacks) activity;
          } catch (ClassCastException e) {
              throw new ClassCastException("Activity must implement NavigationDrawerCallbacks.");
          }
      }

      @Override
      public void onDetach() {
          super.onDetach();
          mCallbacks = null;
      }

      @Override
      public void onSaveInstanceState(Bundle outState) {
          super.onSaveInstanceState(outState);
          outState.putInt(STATE_SELECTED_POSITION, mCurrentSelectedPosition);
      }

      @Override
      public void onConfigurationChanged(Configuration newConfig) {
          super.onConfigurationChanged(newConfig);
          // Forward the new configuration the drawer toggle component.
          mDrawerToggle.onConfigurationChanged(newConfig);
      }

      @Override
      public void onCreateOptionsMenu(Menu menu, MenuInflater inflater) {
          // If the drawer is open, show the global app actions in the action bar. See also
          // showGlobalContextActionBar, which controls the top-left area of the action bar.
          if (mDrawerLayout != null && isDrawerOpen()) {
              inflater.inflate(R.menu.global, menu);
              showGlobalContextActionBar();
          }
          super.onCreateOptionsMenu(menu, inflater);
      }

      @Override
      public boolean onOptionsItemSelected(MenuItem item) {
          if (mDrawerToggle.onOptionsItemSelected(item)) {
              return true;
          }

          if (item.getItemId() == R.id.action_example) {
              Toast.makeText(getActivity(), "Example action.", Toast.LENGTH_SHORT).show();
              return true;
          }

          return super.onOptionsItemSelected(item);
      }

      /**
       * Per the navigation drawer design guidelines, updates the action bar to show the global app
       * 'context', rather than just what's in the current screen.
       */
      private void showGlobalContextActionBar() {
          ActionBar actionBar = getActionBar();
          actionBar.setDisplayShowTitleEnabled(true);
          actionBar.setNavigationMode(ActionBar.NAVIGATION_MODE_STANDARD);
          actionBar.setTitle(R.string.app_name);
      }

      private ActionBar getActionBar() {
          return ((ActionBarActivity) getActivity()).getSupportActionBar();
      }

      /**
       * Callbacks interface that all activities using this fragment must implement.
       */
      public static interface NavigationDrawerCallbacks {
          /**
           * Called when an item in the navigation drawer is selected.
           */
          void onNavigationDrawerItemSelected(int position);
      }
  }
  ```

16. add `MainActivity.java`
17. Copy `www` folder from phonegap-start repository to your `assets/www`
