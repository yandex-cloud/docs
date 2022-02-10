# Getting started with {{ captcha-full-name }}

To get started with the service:

1. [Get the keys](#get-keys).
1. [Add the widget to the page](#add-widget).
1. [Check the user response](#check-answer).

## Get keys {#get-keys}

To use {{ captcha-name }}, you need to get the keys for the client and server parts. Using the client key, you can [add the widget](#add-widget) {{ captcha-name }} on your page. You'll need a server key to check the user [response](#check-answer).

To get the keys, contact your account manager.

## Add the widget to the page {#add-widget}

Connect the {{ captcha-name }} widget using one of the methods:

* A regular automatic method: to the user page, a JS script is added that automatically searches for every `div` block with a `smart-captcha` class and installs a widget to them.
* Advanced method: you control the widget connection via the `window.smartCaptcha` object as the JS script is loaded.

{% list tabs %}

- Regular method

    1. Add the JS script to the user page. To do this, place it anywhere on the page (for example, inside the `<head>` tag) code:

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
              const container = document.getElementById('<container ID>');
        
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

- Python

    ```py
    def check_captcha():
    
        token = request.form["smart-token"]
        print(f"token={token}", file=sys.stderr)
        resp = requests.get(
    
            "https://captcha-api.yandex.ru/validate",
    
            {
                "secret": "<The key for the server part>",
                "token": token,
                "ip": request.headers.get("X-Forwarded-For-Y", "127.0.0.1")
            }
        )
    
        print(f"status_code={resp.status_code}", file=sys.stderr)
        content = resp.content.decode()
        print(f"content={content}", file=sys.stderr)
        return json.loads(content)["status"] == "ok"
    ```

{% endlist %}

## What's next {#whats-next}

* Read more about [connection methods](./concepts/widget-methods.md) for the {{ captcha-name }} widget.

