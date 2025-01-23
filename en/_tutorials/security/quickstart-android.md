# {{ captcha-full-name }} in Android apps

To embed [{{ captcha-name }}](../../smartcaptcha/) in an Android app:
1. [Create JavaScript Interface](#create-js-interface).
1. [Configure WebView to work with CAPTCHA](#customize-webview).
1. [Retrieve the CAPTCHA test results](#get-result).

## Getting started {#before-begin}

1. [Host an HTML page](../../smartcaptcha/tutorials/mobile-app/website.md) on your server or use the `{{ captcha-mobile-site }}` page on the {{ yandex-cloud }} server.
1. [Create a CAPTCHA](../../smartcaptcha/operations/create-captcha.md).
1. See the **{{ ui-key.yacloud.common.overview }}** tab to [get the CAPTCHA keys](../../smartcaptcha/operations/get-keys.md):
   * **{{ ui-key.yacloud.smartcaptcha.label_client-key }}**: To load the page with CAPTCHA.
   * **{{ ui-key.yacloud.smartcaptcha.label_server-key }}**: To get the CAPTCHA challenge results.

## Create a JavaScript Interface {#create-js-interface}

1. Create a [class](../../smartcaptcha/concepts/js-interface.md) to receive messages using a callback function from your web page with CAPTCHA.
1. Define the `onGetToken(token: String)` method with the `@JavascriptInterface` annotation. It is called when the web page returns a token for passing CAPTCHA verification:

   ```kotlin
   class WebJsInterface {

     @JavascriptInterface
     fun onGetToken(token: String) {
       //Your code.
     }
   }
   ```

## Configure WebView to work with CAPTCHA {#customize-webview}

1. Create a **WebView** and add it to the screen.
1. Upload the URL of the web page with CAPTCHA to the **WebView**.
1. Insert this [query parameter](../../smartcaptcha/concepts/widget-methods.md#methods) into the URL: `sitekey=<client_side_key>`:

   ```kotlin
   val webView = findViewById<WebView>(R.id.webViewCaptcha)
   webView.loadUrl("CAPTCHA_page_URL?sitekey=<client_side_key>")
   ```

1. Add the created JavaScript Interface object to the **WebView**. Specify `NativeClient` as the second parameter (this is where the web page will send messages using a callback function):

   ```kotlin
   settings.javaScriptEnabled = true // Enables JavaScript execution.
   addJavascriptInterface(WebJsInterface(), "NativeClient")
   ```

## Retrieve the CAPTCHA test results {#get-result}

1. Save the CAPTCHA verification passed token. It will be returned in the `onGetToken(token: String)` method after the service processes an attempt.
1. To validate the token, send a POST request to `https://smartcaptcha.yandexcloud.net/validate`, providing the following parameters in `x-www-form-urlencoded` format:

   {% include [query-parameters](../../_includes/smartcaptcha/query-parameters.md) %}

   {% note info %}

   This logic must be implemented on the backend. Make sure the `secret` secret key does not end up in the Android app itself.

   {% endnote %}

   >Request example:
   >
   >```text
   >https://smartcaptcha.yandexcloud.net/validate?secret=<server_key>&ip=<user_IP_address>&token=<token>
   >```

1. Get a [server response](../../smartcaptcha/concepts/validation.md). It contains a JSON object with the `status` and `message` fields.

   >Here is an example:
   >
   >* It is a human:
   >
   >  ```json
   >  {
   >    "status": "ok",
   >    "message": ""
   >  }
   >```
   >
   >* It is a robot:
   >
   >  ```json
   >  {
   >    "status": "failed",
   >    "message": ""
   >  }