# Getting started with {{ captcha-full-name }}

To get started with the service:

1. [Create a captcha](#creat-captcha).
1. [Get keys](#get-keys).
1. [Add the widget to the page](#add-widget).
1. [Check the user response](#check-answer).

## Create a captcha {#creat-captcha}

1. In the [management console]({{ link-console-main }}), select the appropriate folder.
1. Select **{{ captcha-full-name }}**.
1. Click **Create captcha**.
1. Enter a captcha name.
1. Select the complexity:
   * **Easy**: A simple captcha.
   * **Medium**: A captcha of intermediate complexity.
   * **Hard**: A difficult captcha.
1. Specify a list of sites where the captcha will be placed.
1. Click **Create**.

## Get keys {#get-keys}

To use {{ captcha-name }}, you need to get the keys for the client and server parts. Using a client key, you can [add the {{ captcha-name }} widget](#add-widget) on your page. You'll need a server key to [check the user response](#check-answer).

To get the keys:

1. In the [management console]({{ link-console-main }}), select the appropriate folder.
1. Select **{{ captcha-full-name }}**.
1. Click the name of the captcha or [create](#creat-captcha) a new one.
1. On the **Overview** tab, copy the client and the server keys.

## Add the widget to the page {#add-widget}

Connect the {{ captcha-name }} widget using one of the methods:

* A regular automatic method: to the user page, a JS script is added that automatically searches for every `div` block with a `smart-captcha` class and installs a widget to them.
* Advanced method: you control the widget connection via the `window.smartCaptcha` object as the JS script is loaded.

{% list tabs %}

- Regular method

   1. Add the JS script to the user page. To do this, place the following code anywhere on the page (for example, inside the `<head>` tag):

      ```html
      <script src="https://captcha-api.yandex.ru/captcha.js" defer></script>
      ```

   1. To the page, add an empty container (a `div` element) where your {{ captcha-name }} widget will be added automatically:

      ```html
      <div
        id="captcha-container"
        class="smart-captcha"
        data-sitekey="<Key for the client part>"
      ></div>
      ```

      {% note info %}

      During the upload, the widget changes the height of its host container to `100px`. This might result in an undesirable layout shift on the page because the container height has changed. To avoid this shift, set the `100px` container height before the widget is loaded.

      ```html
      <div ... style="height: 100px"></div>
      ```

      {% endnote %}

- Advanced method

   In this example, loading of the widget is controlled by calling the `onloadFunction` callback function during the JS script loading.

   1. Add the JS script to the user page. To do this, place the following code anywhere on the page (for example, inside the `<head>` tag):

      ```html
      <script
        src="https://captcha-api.yandex.ru/captcha.js?render=onload&onload=onloadFunction"
        defer
      ></script>
      ```

   1. Add an empty container where you want to install your widget, to the page:

      ```html
      <div id="<container ID>"></div>
      ```

   1. Add the code of the callback function to the page:

      ```html
      <script>
        function onloadFunction() {
          if (window.smartCaptcha) {
            const container = document.getElementById('<Container ID>');

            const widgetId = window.smartCaptcha.render(container, {
              sitekey: '<Key for the client part>',
              hl: '<Language>',
            });
          }
        }
      </script>
      ```

      Add a check for existence of the `window.smartCaptcha` object to avoid an error when the function is called before the JS script loading is complete.

      {% note info %}

      During the upload, the widget changes the height of its host container to `100px`. This might result in an undesirable layout shift on the page due to the height change. To avoid this shift, set the `100px` container height before the widget is loaded.

      ```html
      <div ... style="height: 100px"></div>
      ```

      {% endnote %}

{% endlist %}

## Check the user response {#check-answer}

After the check is complete, the user is issued a unique token to be stored in a hidden field in the form. To validate the token, send a GET request to `https://captcha-api.yandex.ru/validate` with the following parameters:

* `secret`: The key for the server part.
* `token`: The token received after the check has been passed.
* `ip`: The IP address of the user that originated the request to validate the token.

Example of the token validation function:

{% list tabs %}

- Node.js

   ```js
   const https = require('https'),
       querystring = require('querystring');

   const SMARTCAPTCHA_SERVER_KEY = "<Key for the server part>";


   function check_captcha(token, callback) {
       const options = {
           hostname: 'captcha-api.yandex.ru',
           port: 443,
           path: '/validate?' + querystring.stringify({
               secret: SMARTCAPTCHA_SERVER_KEY,
               token: token,
               ip: '127.0.0.1', // Pass the user's IP.
                                // How to get the IP properly depends on your framework and proxy.
           }),
           method: 'GET',
       };
       const req = https.request(options, (res) => {
           res.on('data', (content) => {
               if (res.statusCode !== 200) {
                   console.error(`Allow access due to an error: code=${res.statusCode}; message=${content}`);
                   callback(true);
                   return;
               }
               callback(JSON.parse(content).status === 'ok');
           });
       });
       req.on('error', (error) => {
           console.error(error);
           callback(true);
       });
       req.end();
   }


   let token = "<token>";
   check_captcha(token, (passed) => {
       if (passed) {
           console.log("Passed");
       } else {
           console.log("Robot");
       }
   });
   ```

- PHP

   ```php
   define('SMARTCAPTCHA_SERVER_KEY', '<Key for the server part>');

   function check_captcha($token) {
       $ch = curl_init();
       $args = http_build_query([
           "secret" => SMARTCAPTCHA_SERVER_KEY,
           "token" => $token,
           "ip" => $_SERVER['REMOTE_ADDR'], // Pass the user's IP.
                                            // How to get the IP properly depends on your proxy.
       ]);
       curl_setopt($ch, CURLOPT_URL, "https://captcha-api.yandex.ru/validate?$args");
       curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
       curl_setopt($ch, CURLOPT_TIMEOUT, 1);

       $server_output = curl_exec($ch);
       $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
       curl_close($ch);

       if ($httpcode !== 200) {
           echo "Allow access due to an error: code=$httpcode; message=$server_output\n";
           return true;
       }
       $resp = json_decode($server_output);
       return $resp->status === "ok";
   }

   $token = $_POST['smart-token'];
   if (check_captcha($token)) {
       echo "Passed\n";
   } else {
       echo "Robot\n";
   }
   ```

- Python

   ```py
   import requests
   import sys
   import json


   SMARTCAPTCHA_SERVER_KEY = "<Key for the server part>"


   def check_captcha(token):
       resp = requests.get(
           "https://captcha-api.yandex.ru/validate",
           {
               "secret": SMARTCAPTCHA_SERVER_KEY,
               "token": token,
               "ip": "127.0.0.1"  # Pass the user's IP.
                                  # How to get the IP properly depends on your framework and proxy.
                                  # For example, in Flask, this can be request.remote_addr
           },
           timeout=1
       )
       server_output = resp.content.decode()
       if resp.status_code != 200:
           print(f"Allow access due to an error: code={resp.status_code}; message={server_output}", file=sys.stderr)
           return True
       return json.loads(server_output)["status"] == "ok"
   token = "<token>"  # For example, request.form["smart-token"]
   if check_captcha(token):
       print("Passed")
   else:
       print("Robot")
   ```

{% endlist %}

## What's next {#whats-next}

* Read more [about connection methods](./concepts/widget-methods.md) for the {{ captcha-name }} widget.
