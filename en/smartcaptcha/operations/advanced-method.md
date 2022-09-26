# Add a {{ captcha-name }} widget using the advanced method

You control how the widget loads using the `window.smartCaptcha` [object](../concepts/widget-methods.md#methods). The `onloadFunction` callback function is used for this in the instructions:

1. Add the JS script to the user page. To do this, place the following code anywhere on the page, for example, inside the `<head>` tag:

   ```html
   <script
       src="https://captcha-api.yandex.ru/captcha.js?render=onload&onload=onloadFunction"
       defer
   ></script>
   ```

1. Add an empty container where you want to install your widget, to the page:

   ```html
   <div id="<container_id>"></div>
   ```

   Where:

   `<container_id>`: Arbitrary ID.

1. Add the code of the callback function to the page:

   ```html
   <script>
       function onloadFunction() {
       if (window.smartCaptcha) {
           const container = document.getElementById('<container_id>');

           const widgetId = window.smartCaptcha.render(container, {
           sitekey: '<client_key>',
           hl: '<language>',
           });
       }
       }
   </script>
   ```

   Where:

   * `<client_key>`: [CAPTCHA key](./get-keys.md).
   * `<language>`: Widget and task [language](../concepts/widget-methods.md#render).

   Add a check for existence of the `window.smartCaptcha` object to avoid an error when the function is called before the JS script loading is complete.

   {% include [info-container-height](../../_includes/smartcaptcha/info-container-height.md) %}


## What's next {#whats-next}

* [Invisible CAPTCHA](../concepts/invisible-captcha.md).
* [Connecting a CAPTCHA in React](../concepts/react.md).