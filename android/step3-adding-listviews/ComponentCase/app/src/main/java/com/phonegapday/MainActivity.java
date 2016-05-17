package com.phonegapday;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.design.widget.NavigationView;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBarDrawerToggle;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.KeyEvent;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.ArrayAdapter;
import android.widget.BaseAdapter;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.phonegapday.componentcase.R;

import org.apache.cordova.ConfigXmlParser;
import org.apache.cordova.CordovaInterfaceImpl;
import org.apache.cordova.CordovaWebView;
import org.apache.cordova.CordovaWebViewImpl;
import org.apache.cordova.engine.SystemWebView;
import org.apache.cordova.engine.SystemWebViewEngine;
import org.json.JSONException;

import java.util.ArrayList;

public class MainActivity extends AppCompatActivity
        implements NavigationView.OnNavigationItemSelectedListener {

    private String TAG = "ComponentWrapper";
    private SystemWebView webView;
    private CordovaWebView webInterface;
    private CordovaInterfaceImpl stupidface = new CordovaInterfaceImpl(this);

    // need this for page navigation
    private String[] urls = new String[2];

    private LinearLayout bookmarkLayout;
    private ListView listView;
    private ArrayList<String> bookmarks = new ArrayList<String>();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        ActionBarDrawerToggle toggle = new ActionBarDrawerToggle(
                this, drawer, toolbar, R.string.navigation_drawer_open, R.string.navigation_drawer_close);
        drawer.setDrawerListener(toggle);
        toggle.syncState();

        NavigationView navigationView = (NavigationView) findViewById(R.id.nav_view);
        navigationView.setNavigationItemSelectedListener(this);

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


        //Set up the webview
        ConfigXmlParser parser = new ConfigXmlParser();
        parser.parse(this);

        webView = (SystemWebView) findViewById(R.id.WebViewComponent);
        webInterface = new CordovaWebViewImpl(new SystemWebViewEngine(webView));
        webInterface.init(stupidface, parser.getPluginEntries(), parser.getPreferences());

        urls[0] = parser.getLaunchUrl();
        urls[1] = urls[0].replace("index.html", "listeditor.html");
        webView.loadUrl(urls[0]);
    }

    protected ArrayList<String> getBookmarks() {
        return bookmarks;
    }

    protected void addItem(String item) {
        if(item != null) {
            bookmarks.add(item);
            ((BaseAdapter)listView.getAdapter()).notifyDataSetChanged();
        }
    }


    @Override
    public void onBackPressed() {
        DrawerLayout drawer = (DrawerLayout) findViewById(R.id.drawer_layout);
        if (drawer.isDrawerOpen(GravityCompat.START)) {
            drawer.closeDrawer(GravityCompat.START);
        } else {
            super.onBackPressed();
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    @SuppressWarnings("StatementWithEmptyBody")
    @Override
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

    // This is still required by Cordova
    @Override
    public void onDestroy()
    {
        webInterface.handleDestroy();
        super.onDestroy();
    }


    /**
     * Called when an activity you launched exits, giving you the requestCode you started it with,
     * the resultCode it returned, and any additional data from it.
     *
     * @param requestCode       The request code originally supplied to startActivityForResult(),
     *                          allowing you to identify who this result came from.
     * @param resultCode        The integer result code returned by the child activity through its setResult().
     * @param intent            An Intent, which can return result data to the caller (various data can be attached to Intent "extras").
     */
    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent intent) {
        super.onActivityResult(requestCode, resultCode, intent);
        stupidface.onActivityResult(requestCode, resultCode, intent);
    }

    /**
     * Called by the system when the user grants permissions!
     *
     * Note: The fragment gets priority over the activity, since the activity doesn't call
     * into the parent onRequestPermissionResult, which is why there's no override.
     *
     * @param requestCode
     * @param permissions
     * @param grantResults
     */
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

}
