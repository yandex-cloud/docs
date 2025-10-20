---
title: How to add the {{ captcha-full-name }} widget
description: Follow this guide to add the {{ captcha-name }} widget either via the advanced method or whenever required.
---

# Adding the {{ captcha-name }} widget

## Adding the {{ captcha-name }} widget via the advanced method {#advanced}

You control how the widget loads via the `window.smartCaptcha` [object](../concepts/widget-methods.md#methods). This guide uses the `onloadFunction` callback function for this:

1. Add the JS script to the user page. Do it by placing the following code anywhere on the page, e.g., inside the `<head>` tag:

    ```html
    <script
        src="https://smartcaptcha.yandexcloud.net/captcha.js?render=onload&onload=onloadFunction"
        defer
    ></script>
    ```

1. Add to the page an empty container for the widget:

    ```html
    <div id="<container_ID>"></div>
    ```

    Where `id` is a random ID.

1. Add the code of the callback function to the page:

    ```html
    <script>
        function onloadFunction() {
        if (window.smartCaptcha) {
            const container = document.getElementById('<container_ID>');

            const widgetId = window.smartCaptcha.render(container, {
                sitekey: '<client_key>',
                hl: '<language>',
            });
        }
        }
    </script>
    ```

    Where:

    * `<container_ID>`: ID generated at the previous step.
    * `sitekey`: [Client-side key](../concepts/keys.md).
    * `hl`: Widget and task [language](../concepts/widget-methods.md#render).

    Consider adding an existence check for the `window.smartCaptcha` object into the callback function code to avoid error should the function be called before the JS script has finished loading.

    {% include [info-container-height](../../_includes/smartcaptcha/info-container-height.md) %}

## Adding the {{ captcha-name }} widget that loads whenever required {#dynamic}

To add the widget and have your CAPTCHA load whenever required, use the following approach:

```js
window.onloadFunction = () => {
  if (window.smartCaptcha) {
    // Creating a CAPTCHA
  }
}

function handleScriptLoadingError() {
  // Error handling
}

const scriptElement = document.createElement('script');
scriptElement.src = 'https://smartcaptcha.yandexcloud.net/captcha.js?render=onload&onload=onloadFunction';
scriptElement.onerror = handleScriptLoadingError;
document.body.appendChild(scriptElement);
```

## What's next {#whats-next}

* [Invisible CAPTCHA](../concepts/invisible-captcha.md).
* [Connecting a CAPTCHA in React](../concepts/react.md).
