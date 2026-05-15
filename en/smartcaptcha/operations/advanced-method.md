---
title: How to add a {{ captcha-full-name }} widget
description: In this tutorial, you will learn how to add a {{ captcha-name }} widget using the advanced method or on an as-needed basis.
---

# Adding the {{ captcha-name }} widget

## Adding the {{ captcha-name }} widget using the advanced method {#advanced}

You can control the widget loading process via the `window.smartCaptcha` [object](../concepts/widget-methods.md#methods). However, in this guide, we will use the `onloadFunction` callback function:

1. Add the widget’s JS script to the user’s page by placing the following code inside the `<head>` tag (or anywhere on the page):

    ```html
    <script
        src="https://{{ captcha-domain }}/captcha.js?render=onload&onload=onloadFunction"
        defer
    ></script>
    ```

1. Add an empty container on the page. The system will use it to insert the widget:

    ```html
    <div id="<container_ID>"></div>
    ```

    Where `id` is a random identifier.

1. Add the callback function code on the page:

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

    * `<container_ID>`: ID that was generated at the previous step.
    * `sitekey`: [Client-side key](../concepts/keys.md).
    * `hl`: [Language](../concepts/widget-methods.md#render) used for the widget and the challenge.

    Consider adding an existence check for the `window.smartCaptcha` object in the callback function. It will prevent errors caused by calling the function before the script has finished loading.

    {% include [info-container-height](../../_includes/smartcaptcha/info-container-height.md) %}

## Adding a {{ captcha-name }} widget with on-demand loading {#dynamic}

To add a widget with on-demand CAPTCHA loading, use the following approach:

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
scriptElement.src = 'https://{{ captcha-domain }}/captcha.js?render=onload&onload=onloadFunction';
scriptElement.onerror = handleScriptLoadingError;
document.body.appendChild(scriptElement);
```

## What's next {#whats-next}

* [Invisible CAPTCHA](../concepts/invisible-captcha.md).
* [Integrating CAPTCHA in React](../concepts/react.md).
