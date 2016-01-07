package com.psykar.cookiemanager;

import com.facebook.react.modules.network.ForwardingCookieHandler;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.Callback;

import java.io.IOException;
import java.net.URISyntaxException;
import java.net.URI;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


public class CookieManagerModule extends ReactContextBaseJavaModule {

    private ForwardingCookieHandler cookieHandler;

    public CookieManagerModule(ReactApplicationContext context) {
        super(context);
        this.cookieHandler = new ForwardingCookieHandler(context);
    }

    public String getName() {
        return "RNCookieManagerAndroid";
    }

    @ReactMethod
    public void set(ReadableMap cookie, final Callback callback) throws Exception {
        throw new Exception("Cannot call on android, try setFromResponse");
    }

    @ReactMethod
    public void setFromResponse(String url, String value, final Callback callback) throws URISyntaxException, IOException {
        Map headers = new HashMap<String, List<String>>();
        // Pretend this is a header
        headers.put("Set-cookie", Collections.singletonList(value));
        URI uri = new URI(url);
        this.cookieHandler.put(uri, headers);
        callback.invoke(true);
    }

    @ReactMethod
    public void getAll(Callback callback) throws Exception {
        throw new Exception("Cannot get all cookies on android, try getCookieHeader(url)");
    }

    @ReactMethod
    public void get(String url, Callback callback) throws URISyntaxException, IOException {
        URI uri = new URI(url);

        Map<String, List<String>> cookieMap = this.cookieHandler.get(uri, new HashMap());
        // If only the variables were public
        List<String> cookieList = cookieMap.get("Cookie");
        if (cookieList != null) {
            callback.invoke(cookieList.get(0));
        } else {
            callback.invoke(cookieList);
        }
    }

    @ReactMethod
    public void clearAll(final Callback callback) {
        this.cookieHandler.clearCookies(callback);
    }
}
