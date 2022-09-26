# Getting started with {{ captcha-full-name }}

To get started with the service:

1. [Create a CAPTCHA](#creat-captcha).
1. [Get keys](#get-keys).
1. [Add the widget to the page](#add-widget).
1. [Check the user response](#check-answer).


## Before you begin {#before-begin}

1. Go to the [management console]({{ link-console-main }}). Log in to {{ yandex-cloud }} or register if you don't have an account yet.
1. [On the billing page]({{ link-console-billing }}), make sure you linked a {% if audience != "internal" %}[billing account](../billing/concepts/billing-account.md){% else %}billing account{% endif %} and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, {% if audience != "internal" %}[create one](../billing/quickstart/index.md){% else %}create one{% endif %}.


## Create a CAPTCHA {#creat-captcha}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ captcha-full-name }}**.
   1. Click **Create captcha**.
   1. Enter a CAPTCHA name.
   1. Select the `Medium` complexity.
   1. Specify a list of sites where the CAPTCHA will be placed.
   1. Leave the standard **configuration type**.
   1. Click **Create**.

{% endlist %}


## Retrieve the CAPTCHA keys {#get-keys}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the appropriate folder.
   1. Select **{{ captcha-full-name }}**.
   1. Click the name of the CAPTCHA or [create](#creat-captcha) a new one.
   1. On the **Overview** tab, copy `client_key` and `server_key`.

{% endlist %}

With the client key, you can [add a {{ captcha-name }} widget](#add-widget) to your page. You will need a server key to [check the user response](#check-answer).


## Add the widget to the page {#add-widget}

Add the widget automatically:

1. Add the JS script to the user page. To do this, place the following code anywhere on the page (for example, inside the `<head>` tag):

   ```html
   <script src="https://captcha-api.yandex.ru/captcha.js" defer></script>
   ```

   The `captcha.js` script will automatically find all `div` elements with the `smart-captcha` class and install the widget in them.

1. Add an empty container (`div` element) to the page so that the `captcha.js` script loads the widget to it:

   ```html
   <div
       id="captcha-container"
       class="smart-captcha"
       data-sitekey="<client_key>"
   ></div>
   ```

   {% include [info-container-height](../_includes/smartcaptcha/info-container-height.md) %}

The **I’m not a robot** button will appear on the page. The service will check the user request after the user clicks the button. If the request seems suspicious, the service will ask the user to perform an action.


## Check the user response {#check-answer}

After the check, the user is given a unique token. The token is loaded to the `<input type="hidden" name="smart-token" value="<token>"` element inside the widget container. For example:

```html
<div id="captcha-container" class="smart-captcha" ...>
    <input type="hidden" name="smart-token" value="<token>">
    ...
</div>
```

To validate the token, send a GET request to `https://captcha-api.yandex.ru/validate` with the following parameters:

* `secret`: The key for the server part.
* `token`: The token received after the check has been passed.
* `ip`: The IP address of the user that originated the request to validate the token.

Example of the token validation function:

{% list tabs %}

- Node.js

   ```js
   const https = require('https'),
       querystring = require('querystring');

   const SMARTCAPTCHA_SERVER_KEY = "<server_key>";


   function check_captcha(token, callback) {
       const options = {
           hostname: 'captcha-api.yandex.ru',
           port: 443,
           path: '/validate?' + querystring.stringify({
               secret: SMARTCAPTCHA_SERVER_KEY,
               token: token,
               ip: '<user IP>', // Method for retrieving the user IP depends on your framework and proxy.
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
   define('SMARTCAPTCHA_SERVER_KEY', '<server_key>');

   function check_captcha($token) {
       $ch = curl_init();
       $args = http_build_query([
           "secret" => SMARTCAPTCHA_SERVER_KEY,
           "token" => $token,
           "ip" => $_SERVER['REMOTE_ADDR'], // You need to pass the user IP.
                                            // Method for retrieving the user IP depends on your proxy.
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


   SMARTCAPTCHA_SERVER_KEY = "<server_key>"


   def check_captcha(token):
       resp = requests.get(
           "https://captcha-api.yandex.ru/validate",
           {
               "secret": SMARTCAPTCHA_SERVER_KEY,
               "token": token,
               "ip": "<User IP>" # Method for retrieving the IP depends on your framework and proxy.                                   
                                                # For example, in Flask, this can be request.remote_addr
           },
           timeout=1
       )
       server_output = resp.content.decode()
       if resp.status_code != 200:
           print(f"Allow access due to an error: code={resp.status_code}; message={server_output}", file=sys.stderr)
           return True
       return json.loads(server_output)["status"] == "ok"
   token = "<token>" # For example, request.form["smart-token"]
   if check_captcha(token):
       print("Passed")
   else:
       print("Robot")
   ```

{% endlist %}


## What's next {#whats-next}

* Read more [about connection methods](./concepts/widget-methods.md) for the {{ captcha-name }} widget.