---
title: Getting started with {{ captcha-full-name }}
description: 4 simple steps to quickly integrate CAPTCHA on your website
---

# Getting started with {{ captcha-full-name }}

{{ captcha-full-name }}: Service for protection against bots and automated attacks.

To add a CAPTCHA to your HTML page:

1. [Create a CAPTCHA](#create-captcha) in {{ yandex-cloud }}.
1. [Copy the keys](#get-keys) from the CAPTCHA details page.
1. [Add the CAPTCHA widget code](#add-widget) on your HTML page.
1. [Check the user's response](#check-answer) via a POST request.

If you are having problems configuring {{ captcha-name }}:

* For Business and Premium [accounts](../support/pricing.md), contact [support]({{ link-console-support }}).
* Otherwise, contact your account manager who will put you in touch with technical support.

## Getting started {#before-begin}

1. Open the [management console]({{ link-console-main }}). Log in to {{ yandex-cloud }} or sign up if you have not already.
1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have an `ACTIVE` or `TRIAL_ACTIVE` [billing account](../billing/concepts/billing-account.md). If you do not have a billing account, [create one](../billing/quickstart/index.md).


## Create a CAPTCHA {#create-captcha}

{% include [user-data-to-ml](../_includes/smartcaptcha/user-data-to-ml.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select a folder.
    1. [Navigate](../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_smartcaptcha }}**.
    1. Click **{{ ui-key.yacloud.smartcaptcha.button_captcha-settings-create }}**.

    1. Specify the CAPTCHA name, e.g., `sm-captcha`.
    1. List the sites where you want your CAPTCHA to appear, e.g., `my-shop.com`.
    1. Do not change **{{ ui-key.yacloud.smartcaptcha.label_section-style }}**.
    1. Specify the default CAPTCHA settings or keep the existing ones:
       1. [Main challenge](./concepts/tasks.md#main-task): The first challenge given to the user.
       1. [Additional challenge](./concepts/tasks.md#additional-task): This challenge appears if the first challenge results are suspicious, or if the CAPTCHA is set to maximum difficulty.
       1. [Difficulty level](./concepts/tasks.md#task-difficulty), `{{ ui-key.yacloud.smartcaptcha.value_complexity-medium }}`.

         You can add [challenge options](concepts/captcha-variants.md) and configure incoming traffic rules to show different CAPTCHAs to different users. In this example, you will configure a single CAPTCHA that will apply by default to all users.

       ![step9-10](../_assets/smartcaptcha/quickstart/step9-10.png)

    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}


## Get the CAPTCHA keys {#get-keys}

{% list tabs group=instructions %}

- Management console {#console}
    
    Once you have created a CAPTCHA, select it in the list and copy its two keys:
    * **{{ ui-key.yacloud.smartcaptcha.label_client-key }}**: Required for adding a {{ captcha-name }} widget to the your website or HTML page.
    * **{{ ui-key.yacloud.smartcaptcha.label_server-key }}**: Required to [check the user’s response](#check-answer).

    Store the keys in a secure place.

    ![step4-get-keys](../_assets/smartcaptcha/quickstart/step4-get-keys.png)

{% endlist %}

## Add the widget to your page {#add-widget}

Add the widget via the automated approach:

1. Add the widget’s JS script to your HTML page by placing the following code inside the `<head>` tag (or anywhere on the page):

    ```html
    <script src="https://{{ captcha-domain }}/captcha.js" defer></script>
    ```

    The `captcha.js` script will automatically find all `div` elements with the `smart-captcha` class and add the widget to them.

1. On the page, add an empty `div` container for the CAPTCHA widget.

    ```html
    <div
        id="captcha-container"
        class="smart-captcha"
        data-sitekey="<client_key>"
    ></div>
    ```

    Where `<client_key>` is the key that you copied after creating the CAPTCHA.

    {% include [info-container-height](../_includes/smartcaptcha/info-container-height.md) %}

An **I’m not a robot** button will appear on the page. When the user clicks the button, the service will verify their request.
If the request looks suspicious, the service will prompt the user to solve a CAPTCHA.

## Verify the user’s response {#check-answer}

After CAPTCHA verification, the user receives a unique token which is placed in the CAPTCHA widget container as an `<input>` element:

```html
<div id="captcha-container" class="smart-captcha" ...>
    <input type="hidden" name="smart-token" value="<token>">
    ...
</div>
```

To validate the token, make a POST request to `https://{{ captcha-domain }}/validate`, providing the following variables in `x-www-form-urlencoded` format:

```
secret=<server_key>&token=<token>&ip=<user_IP_address>
```

Where:

{% include [query-parameters](../_includes/smartcaptcha/query-parameters.md) %}

Token validation function example:

{% list tabs group=programming_language %}

- cURL {#curl}

    ```bash
    curl -X POST https://{{ captcha-domain }}/validate \
      -d "secret=<server_key>" \
      -d "token=<token_from_form>" \
      -d "ip=<user_IP_address>"
    ```

- Node.js {#node}

    ```js
    const https = require('https'),
        querystring = require('querystring');

    const SMARTCAPTCHA_SERVER_KEY = "<server_key>";


    function check_captcha(token, callback) {
        const postData = querystring.stringify({
            secret: SMARTCAPTCHA_SERVER_KEY,
            token: token,
            ip: '<user_IP_address>', // How you get the user’s IP address depends on your framework and proxy.
        });
    
        const options = {
            hostname: '{{ captcha-domain }}',
            port: 443,
            path: '/validate',
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
                'Content-Length': Buffer.byteLength(postData),
            },
        };
    
        const req = https.request(options, (res) => {
            let content = '';
    
            res.on('data', (chunk) => {
                content += chunk;
            });
    
            res.on('end', () => {
                if (res.statusCode !== 200) {
                    console.error(`Allow access due to an error: code=${res.statusCode}; message=${content}`);
                    callback(true);
                    return;
                }
    
                try {
                    const parsedContent = JSON.parse(content);
                    callback(parsedContent.status === 'ok');
                } catch (err) {
                    console.error('Error parsing response: ', err);
                    callback(true);
                }
            });
        });
    
        req.on('error', (error) => {
            console.error(error);
            callback(true);
        });
    
        // Adding POST data to the request body
        req.write(postData);
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

- PHP {#php}

    ```php
    define('SMARTCAPTCHA_SERVER_KEY', '<server_key>');

    function check_captcha($token) {
        $ch = curl_init("https://{{ captcha-domain }}/validate");
        $args = [
            "secret" => SMARTCAPTCHA_SERVER_KEY,
            "token" => $token,
            "ip" => "<user_IP_address>", // You need to provide the user’s IP address.
                        // How you get the user’s IP address depends on your proxy.
        ];
        curl_setopt($ch, CURLOPT_TIMEOUT, 1);
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($args));
        curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    
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

    $token = "<token>"; // For example, $_POST['smart-token'];
    if (check_captcha($token)) {
        echo "Passed\n";
    } else {
        echo "Robot\n";
    }
    ```

- Python {#python}

    ```py
    import requests
    import sys
    import json

    SMARTCAPTCHA_SERVER_KEY = "<server_key>"

    def check_captcha(token):
        resp = requests.post(
           "https://{{ captcha-domain }}/validate",
           data={
              "secret": SMARTCAPTCHA_SERVER_KEY,
              "token": token,
              "ip": "<user_IP_address>"   # How you get the IP address depends on your framework and proxy.
                                                # In Flask, for example, you can use `request.remote_addr`.
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

The service will respond with a JSON object containing the following fields:

* `status`: Validation result, `ok` or `failed`. If the validation is successful, the JSON object is updated with the `host` field indicating the website where validation took place.
* `message`: Validation message, e.g., `Invalid or expired Token`.

To process responses correctly, refer to their `status` field. Use the `message` field for diagnostic purposes only.
  
For response examples and processing details, see [User validation](concepts/validation.md#service-response).

## FAQ {#faq}

**How to test the CAPTCHA?**

Open the CAPTCHA page in incognito mode or use a VPN to increase the chance of getting a challenge.

**How to customize the CAPTCHA appearance?**

See [Advanced widget settings](./concepts/widget-methods.md).

**What should I do if the CAPTCHA does not appear?**

Make sure the domain is listed among allowed websites in the CAPTCHA settings.

## See also {#links}

* [Widget integration methods](./concepts/widget-methods.md)
* [Style customization options](./concepts/captcha-variants.md)
* [API Reference](./api-ref/)