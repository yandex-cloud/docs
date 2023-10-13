# Invisible {{ captcha-full-name }} in Android apps

To embed [invisible {{ captcha-name }}](../smartcaptcha/concepts/invisible-captcha.md) in an Android app:

1. [Create JavaScript Interface](#create-js-interface).
1. [Configure WebView to work with CAPTCHA](#customize-webview).
1. [Handle the event that triggered a CAPTCHA challenge to the user](#user-task).
1. [Retrieve the CAPTCHA test results](#get-result).

## Getting started {#before-begin}

1. [Add HTML code](../smartcaptcha/tutorials/mobile-app/website.md) to work with {{ captcha-name }} (or use a ready-made `{{ captcha-mobile-site }}`).
1. Create a CAPTCHA following [this guide](../smartcaptcha/operations/create-captcha.md).
1. [Retrieve the CAPTCHA keys](../smartcaptcha/operations/get-keys.md). Copy the **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** and **{{ ui-key.yacloud.smartcaptcha.label_server-key }}** field values from the **{{ ui-key.yacloud.common.overview }}** tab of the CAPTCHA you created. You will need the **{{ ui-key.yacloud.smartcaptcha.label_client-key }}** to load web pages using CAPTCHA and the **{{ ui-key.yacloud.smartcaptcha.label_server-key }}**, to get the CAPTCHA test results.

## Create a JavaScript Interface {#create-js-interface}

1. Create a [class](../smartcaptcha/concepts/js-interface.md) to receive messages using a callback function from your web page with CAPTCHA.
1. Define the methods with `@JavascriptInterface` annotations:

   * `onGetToken(token: String)`: Web page returns a token for passing CAPTCHA verification.
   * `onChallengeVisible()`: Opening the CAPTCHA challenge pop-up window.
   * `onChallengeHidden()`: Closing the CAPTCHA challenge pop-up window.

   ```kotlin
   class WebJsInterface {

       @JavascriptInterface
       fun onGetToken(token: String) {
           //your code
       }

       @JavascriptInterface
       fun onChallengeVisible() {
           //your code
       }

       @JavascriptInterface
       fun onChallengeHidden() {
           //your code
       }
   }
   ```

## Configure WebView to work with CAPTCHA {#customize-webview}

1. Create a **WebView** and add it to the screen.
1. Upload the URL of the web page with CAPTCHA to the **WebView**.
1. Add the [query parameters](../smartcaptcha/concepts/widget-methods.md#methods) to the URL:

   ```kotlin
     val webView = findViewById<WebView>(R.id.webViewCaptcha)
     webView.loadUrl("URL of the page with CAPTCHA?sitekey=<client_key>&invisible=true")
   ```

   Where:
   * `sitekey`: Previously obtained client key.
   * `invisible=true`: Switching CAPTCHA to invisible mode.

1. Add the created JavaScript Interface object to the **WebView**. Specify `NativeClient` as the second parameter (this is where the web page will send messages using a callback function):

   ```kotlin
     settings.javaScriptEnabled = true   // Enables Javascript execution
     addJavascriptInterface(WebJsInterface(), "NativeClient")
   ```

## Handle the event that triggered a CAPTCHA challenge to the user {#user-task}

1. Specify the **WebView** display logic using the `onChallengeVisible()` method. It is called once the CAPTCHA has shown a challenge to the user. Here is an implementation example of switching `visibility` (while the CAPTCHA was handling an action, the **WebView** status was `View.GONE`):

   ```kotlin
     val webView = activity.findViewById<WebView>(R.id.webViewCaptcha)
     webView.visibility = View.VISIBLE
   ```

1. Specify the logic for the event when the user fails a CAPTCHA challenge and collapses it. This calls the `onChallengeHidden()` method that hides the **WebView**. Example of the **WebView** returned to the `View.GONE` status:

   ```kotlin
     val webView = activity.findViewById<WebView>(R.id.webViewCaptcha)
     webView.visibility = View.GONE
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

## Specifics {#specifics}

Invisible CAPTCHA requires less memory than normal CAPTCHA because it does not load the code that renders the **I’m not a robot** button.

However, the widget loading time may vary for users. This is why we recommend warning users about the CAPTCHA to avoid any confusion while they are waiting.