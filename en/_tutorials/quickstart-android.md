# {{ captcha-full-name }} in Android apps

To embed {{ captcha-name }} in an Android app:

1. [Create JavaScript Interface](#create-js-interface).
1. [Configure WebView to work with CAPTCHA](#customize-webview).
1. [Retrieve the CAPTCHA test results](#get-result).

## Getting started {#before-begin}

1. [Add HTML code](../smartcaptcha/tutorials/mobile-app/website.md) to work with {{ captcha-name }} (or use a ready-made `{{ captcha-mobile-site }}`).
1. Create a CAPTCHA following [this guide](../smartcaptcha/operations/create-captcha.md).
1. [Retrieve the CAPTCHA keys](../smartcaptcha/operations/get-keys.md). Copy the **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** and **{{ ui-key.yacloud.smartcaptcha.label_server-key }}** field values from the **{{ ui-key.yacloud.common.overview }}** tab of the CAPTCHA you created. You will need the **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** to load web pages using CAPTCHA and the **{{ ui-key.yacloud.smartcaptcha.label_server-key }}**, to get the CAPTCHA test results.

## Create a JavaScript Interface {#create-js-interface}

1. Create a [class](../smartcaptcha/concepts/js-interface.md) to receive messages using a callback function from your web page with CAPTCHA.
1. Define the `onGetToken(token: String)` method with the `@JavascriptInterface` annotation. It is called when the web page returns a token for passing CAPTCHA verification:

   ```kotlin
   class WebJsInterface {

       @JavascriptInterface
       fun onGetToken(token: String) {
           //your code
       }
   }
   ```

## Configure WebView to work with CAPTCHA {#customize-webview}

1. Create a **WebView** and add it to the screen.
1. Upload the URL of the web page with CAPTCHA to the **WebView**.
1. Add the `sitekey=<client_key>` [query parameter](../smartcaptcha/concepts/widget-methods.md#methods) to the URL:

   ```kotlin
     val webView = findViewById<WebView>(R.id.webViewCaptcha)
     webView.loadUrl("URL of the page with CAPTCHA?sitekey=<client_key>")
   ```

1. Add the created JavaScript Interface object to the **WebView**. Specify `NativeClient` as the second parameter (this is where the web page will send messages using a callback function):

   ```kotlin
     settings.javaScriptEnabled = true   // Enables Javascript execution
     addJavascriptInterface(WebJsInterface(), "NativeClient")
   ```

## Retrieve the CAPTCHA test results {#get-result}

1. Save the token for passing CAPTCHA verification. It is returned in the `onGetToken(token: String)` method once the service handles an attempt.
1. To validate the token, send a GET request to `https://smartcaptcha.yandexcloud.net/validate` with the following parameters:

   {% include [query-parameters](../_includes/smartcaptcha/query-parameters.md) %}

   {% note info "Note" %}

   This logic must be implemented on the backend. Make sure the `secret` key does not get to the Android app.

   {% endnote %}

   Sample request:

   ```text
     https://smartcaptcha.yandexcloud.net/validate?secret=<server_key>&ip=<user_IP>&token=<token>
   ```

1. Get a [server response](../smartcaptcha/concepts/validation.md). It contains a JSON object with the `status` and the `message` fields. For example:

   * It is a human:

      ```json
      {
          "status": "ok",
          "message": ""
      }
      ```

   * It is a robot:

      ```json
      {
          "status": "failed",
          "message": ""
      }
      ```
