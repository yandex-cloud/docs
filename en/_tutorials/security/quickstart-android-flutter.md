# {{ captcha-full-name }} in an Android app on Flutter

[Flutter](https://ru.wikipedia.org/wiki/Flutter) is a Google framework for developing mobile applications. With Flutter, you can create Android and iOS apps from a single codebase. This simplifies development and allows you to release your products faster. Flutter is powered by [Dart](https://ru.wikipedia.org/wiki/Dart), a programming language with readily available widgets and tooling for UI development.

In this tutorial, you will learn how to create a project comprised of a server and mobile application:
* The server application will provide an HTML page for loading {{ captcha-name }} and check the result of a CAPTCHA challenge solved by the mobile application user.
* The mobile application will show a page with the CAPTCHA and send a request to check the result.

To create the project:
1. [Create a CAPTCHA](#create-captcha).
1. [Prepare the development tools](#prepare-tools).
1. [Create and run the server application](#run-server-app).
1. [Create the mobile application](#create-mobile-app).
1. [Run the mobile application in the emulator and check {{ captcha-name }} operation](#test-app).

## Getting started {#before-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a CAPTCHA {#create-captcha}

1. [Create a CAPTCHA](../../smartcaptcha/operations/create-captcha.md).
1. See the **{{ ui-key.yacloud.common.overview }}** tab to [get the CAPTCHA keys](../../smartcaptcha/operations/get-keys.md):
   * **{{ ui-key.yacloud.smartcaptcha.label_client-key }}**: To load the page with CAPTCHA.
   * **{{ ui-key.yacloud.smartcaptcha.label_server-key }}**: To get the CAPTCHA challenge results.

## Prepare the development tools {#prepare-tools}

This guide assumes that you are using your PC to complete it.

1. [Install Python](https://www.python.org/downloads).
1. [Install Flask](https://pypi.org/project/Flask).
1. [Install the Flutter SDK](https://docs.flutter.dev/get-started/install).
1. [Install Android Studio](https://developer.android.com/studio).
1. In Android Studio, install the Dart and Flutter plugins:
   1. Go to **File → Settings → Plugins**.
   1. On the **Marketplace** tab, type `Dart` in the search field.
   1. Click **Install** to install the plugin. 
   1. In the same way, find and install the `Flutter` plugin.
1. Configure the path to the Flutter SDK:
   1. Go to **File → Settings → Languages & Frameworks → Flutter**.
   1. In the **Flutter SDK path** field, select the folder where you installed the Flutter SDK.

## Create and run the server application {#run-server-app}

1. Create a new folder, e.g., `web-captcha-app`.
1. In the `web-captcha-app` folder, create a file named `app.py`:

   {% cut "Server application code" %}

   ```python
   from flask import Flask, request, jsonify, render_template
   import requests

   app = Flask(__name__)

   SMARTCAPTCHA_SERVER_KEY = "<server_key>"

   # test endpoint
   @app.route('/', methods=['GET'])
   def helo():
       return "Hello from CAPTCHA App", 200
   
   # endpoint returning a page for embedding a CAPTCHA
   @app.route('/captcha', methods=['GET'])
   def render_captcha():
       return render_template("captcha.html")

   # endpoint for validating CAPTCHA challenge results
   @app.route('/validate-captcha', methods=['POST'])
   def validate_captcha():
       data = request.json
       token = data.get('token')

       if not token:
           return jsonify({"status": "error", "message": "Missing CAPTCHA token"}), 400

       # response validation
       response = requests.post(
           "https://smartcaptcha.yandexcloud.net/validate",
           data={
               "secret": SMARTCAPTCHA_SERVER_KEY,
               "token": token,
               "ip": request.remote_addr  # Optional: get user's IP
           },
           timeout=2
       )

       if response.status_code != 200:
           return jsonify({"status": "error", "message": "Captcha validation error"}), 500

       # response processing
       captcha_result = response.json()
       if captcha_result.get("status") == "ok":
           return jsonify({"status": "ok"}), 200
       else:
           return jsonify({"status": "robot"}), 200

   if __name__ == '__main__':
       app.run(debug=True, port=5000)
   ```

   {% endcut %}

1. In the `web-captcha-app` folder, create a folder named `templates` and create a `captcha.html` file in it:

   {% cut "HTML page with a CAPTCHA code" %}

   ```html
   <!DOCTYPE html>
   <html lang="en">
     <head>
       <title>SmartCaptcha Mobile</title>
       <meta charset="UTF-8" />
       <meta
         name="viewport"
         content="width=device-width, initial-scale=1, shrink-to-fit=no"
       />
       <script>
         function onSmartCaptchaReady() {
           if (!window.smartCaptcha) {
             throw new Error("SmartCaptcha is not present");
           }

           const params = getParameters();

           const widgetId = window.smartCaptcha.render(
             "captcha-container",
             params
           );

           window.smartCaptcha.subscribe(
             widgetId,
             "challenge-visible",
             handleChallengeVisible
           );

           window.smartCaptcha.subscribe(
             widgetId,
             "challenge-hidden",
             handleChallengeHidden
           );

           window.smartCaptcha.subscribe(widgetId, "success", handleSuccess);

           if (params.invisible) {
             window.smartCaptcha.execute(widgetId);
           }
         }

         function handleSuccess(token) {
           // Send the CAPTCHA token to Flutter using postMessage for webview_flutter
           if (window.jsBridge) {
             window.jsBridge.postMessage(token);
           }
         }

         function handleChallengeVisible() {
           console.log("Challenge became visible");
         }

         function handleChallengeHidden() {
           console.log("Challenge hidden");
         }

         function getParameters() {
           const result = {};

           if (!window.location.search) {
             return result;
           }

           const queryParams = new URLSearchParams(window.location.search);

           queryParams.forEach((value, key) => {
             result[key] = value;
           });

           result.test = result.test === "true";
           result.invisible = result.invisible === "true";
           result.hideShield = result.hideShield === "true";
           result.webview = true;

           return result;
         }
       </script>
    
       <script>
           function reloadPage() {
             if (window.jsBridge) {
               window.jsBridge.postMessage('pageReloaded');
             }
             window.location.reload();
           }
       </script>

       <script
         src="https://smartcaptcha.yandexcloud.net/captcha.js?render=onload&onload=onSmartCaptchaReady"
         defer
       ></script>
     </head>

     <body>
       <noscript>
         You need to enable JavaScript to run this app.
       </noscript>
       <div id="captcha-container" class="smart-captcha"></div>
       <div style="margin:20px"><button onclick="reloadPage()">Reload</a>
     </body>
   </html>
   ```

   {% endcut %}

1. In the command line, go to the `web-captcha-app` folder and run the server application:

   ```bash
   cd web-captcha-app
   python3 app.py
   ```

## Create the mobile application {#create-mobile-app}

1. In Android Studio, create a new project. To do this, go to **File → New → New Flutter Project**.
1. Check the path to the Flutter SDK and click **Next**.
1. In the **Project name** field, enter a name for the project, e.g., `mobile-captcha-app`.
1. Click **Create**.
1. After uploading the project, replace the contents of the `main.dart` file with this code:

   {% cut "Dart code for the mobile app" %}

   ```dart
   import 'package:flutter/material.dart';
   import 'package:webview_flutter/webview_flutter.dart';
   import 'package:http/http.dart' as http;
   import 'dart:convert';

   void main() {
     WidgetsFlutterBinding.ensureInitialized();
     runApp(MyApp());
   }

   class MyApp extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return MaterialApp(
         home: Scaffold(
           appBar: AppBar(
             title: Text('SmartCaptcha Example'),
           ),
           body: WebViewExample(),
         ),
       );
     }
   }

   class WebViewExample extends StatefulWidget {
     @override
     _WebViewExampleState createState() => _WebViewExampleState();
   }

   class _WebViewExampleState extends State<WebViewExample> {
     late final WebViewController _controller;
     String result = "";

     @override
     void initState() {
       super.initState();
       _controller = WebViewController()
         ..setJavaScriptMode(JavaScriptMode.unrestricted) // enable scripting
         ..addJavaScriptChannel(                          // open a channel for application responses
           'jsBridge',
           onMessageReceived: (message) {
             if (message.message == 'pageReloaded') {
               _handlePageReload();
             } else {
               String token = message
                   .message; // getting a token from CAPTCHA
               print("CAPTCHA token received: $token");
               _sendTokenToServer(token); // sending a token for validation
             }
           },
         );
       _loadCaptchaPageFromServer();
     }

     @override
     Widget build(BuildContext context) {
       return Column(
         children: [
           Expanded(child: WebViewWidget(controller: _controller)),
           SizedBox(height: 20),
           if (result.isNotEmpty)
             Text(
               result,
               style: TextStyle(fontSize: 20, color: result == "Passed" ? Colors.green : Colors.red),
             ),
         ],
       );
     }

     void _loadCaptchaPageFromServer() {
       setState(() {
         result = "Not Done";  // resetting status on initial page load
       });
       // uploading CAPTCHA
       _controller.loadRequest(Uri.parse('<server_application_URL>:5000/captcha?sitekey=<client_key>'));  
       // replace the placeholder with the obtained client key
     }

     void _handlePageReload() {
       setState(() {
         result = "Not Done"; // Resetting status on page reload
       });
     }

     Future<void> _sendTokenToServer(String token) async {
       const String serverValidationUrl = '<server_application_URL>:5000/validate-captcha';  
       // replace the placeholder with the obtained client key

       try {
         setState(() {
           result = "Checking"; // Setting token validation status
         });

         final response = await http.post(
           Uri.parse(serverValidationUrl),
           body: jsonEncode({'token': token}),
           headers: {
             'Content-Type': 'application/json',
           },
         );

         if (response.statusCode == 200) {
           var jsonResponse = jsonDecode(response.body);
           setState(() {
             result = jsonResponse['status'] == 'ok' ? 'Passed' : 'Robot';
           });
         } else {
           setState(() {
             result = 'Error';
           });
         }
       } catch (e) {
         print('Error: $e');
         setState(() {
           result = 'Error';
         });
       }
     }
   }
   ```

   {% note warning %}

   If you are running the server application on a computer with Flutter and Android Studio, do not use `http://localhost` as the server URL. Use an internal subnet IP address, e.g., `http://10.0.2.2`.

   {% endnote %}

   {% endcut %}


1. Add the required dependencies:
   1. Open the `pubspec.yaml` file in the project root.
   1. In the `dependencies` section, add `webview_flutter` and `http`:

    ```yaml
    dependencies:
    flutter:
        sdk: flutter

        # add webview_flutter and http
        webview_flutter: ^4.0.0
        http: ^0.13.5
    ```

1. To use HTTP for testing, do the following:
   1. Open the `\android\app\src\main\AndroidManifest.xml` file.
   1. Add `android:usesCleartextTraffic="true"` to the `application` section:

    ```
    <application
    android:label="capcha_app"
    android:name="${applicationName}"
    android:icon="@mipmap/ic_launcher"
    <!-- Add this row -->
    android:usesCleartextTraffic="true"
    >
    ```

## Run the application and test {{ captcha-name }} {#test-app}

To run your mobile app on the emulator:

1. In Android Studio, go to **Tools → Device Manager** and activate the mobile device, e.g., the pre-installed default **Medium Phone API 35**.
1. Run the `main.dart` file in one of the following ways:
   * In the top panel next to the file name, click the start button.
   * Go to **Run → Run 'main.dart'**.
1. Wait for the compilation to complete and the application to load into the emulator.

To test {{ captcha-name }}:

1. Solve the CAPTCHA challenge.
1. If you solved the challenge correctly, the red `Not Done` status at the bottom of the application screen will briefly change to `Checking` and then to the green `Passed` status.
1. To repeat the test, click **Reload** on the page below the CAPTCHA.
