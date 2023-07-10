# Invisible CAPTCHA

Invisible CAPTCHA is a way of connecting the {{ captcha-name }} widget without the **"I’m not a robot"** button on the page. Only users whose requests are considered suspicious by {{ captcha-name }} will see the task pop-up window.

The developer chooses when the service will check the user, for example, when clicking the **submit** button.

Invisible CAPTCHA is only connected using the [advanced method](./widget-methods.md#extended-method).

## Connection algorithm {#installation-algorithm}

1. Load the CAPTCHA using the advanced method.

   ```html
   <script
     src="https://smartcaptcha.yandexcloud.net/captcha.js?render=onload&onload=onloadFunction"
     defer
   ></script>

   <div id="captcha-container"></div>
   ```

1. Render the CAPTCHA widget in invisible mode.

   ```html
   <script>
     function onloadFunction() {
       if (!window.smartCaptcha) {
         return;
       }

       window.smartCaptcha.render('captcha-container', {
         sitekey: '<Key_for_the_client_part>',
         invisible: true, // Make captcha invisible
         callback: callback,
       });
     }

     function callback(token) {
       console.log(token);
     }
   </script>
   ```

1. Call `window.smartCaptcha.execute()` when {{ captcha-name }} is to start validating the user. For example, when clicking the **submit** button.

   ```html
   <script>
   function handleSubmit() {
     if (!window.smartCaptcha) {
       return;
     }

     window.smartCaptcha.execute();
   }
   </script>

   <form id="form">
     <div id="captcha-container"></div>
    <input type="submit" onsubmit="handleSubmit()" />
   </form>
   ```

## Data processing notice {#data-processing-notice}

By default, a page with an invisible CAPTCHA renders a shield with a link to the document: [Notice on the terms of data processing by the service](https://yandex.com/legal/smartcaptcha_notice/).

The shield is positioned in the bottom-right corner. To move the shield, use the parameter `shieldPosition` of the `render` [method](./widget-methods.md#render), e.g.:

```js
window.smartCaptcha.render('captcha-container', {
  sitekey: '<client_part_key>',
  invisible: true,
  shieldPosition: 'top-left',
  callback: callback,
});
```

You can hide the shield by the `hideShield` parameter of the `render` [method](./widget-methods.md#render).

{% include [warning-hideshield](../../_includes/smartcaptcha/warning-hideshield.md) %}

## Specifics {#specifics}

* Invisible CAPTCHA requires less memory than normal CAPTCHA because it doesn't load the code that renders the **"I’m not a robot"** button.

   However, the widget loading time may vary for users. This is why we recommend warning users about the CAPTCHA to avoid any confusion while they are waiting.

* If a page has more than one widget, you need to provide a widget ID to the `execute` method.

   {% cut "Example" %}

   ```html
   <script
     src="https://smartcaptcha.yandexcloud.net/captcha.js?render=onload&onload=onloadFunction"
     defer
   ></script>

   <script>
     let widgetId;

     function onloadFunction() {
       if (!window.smartCaptcha) {
         return;
       }

       widgetId = window.smartCaptcha.render('captcha-container', {
         sitekey: '<Key_for_the_client_part>',
         invisible: true, // Make captcha invisible
         callback: callback,
       });
     }

     function callback(token) {
       if (typeof token === "string" && token.length > 0) {
           // Send the form to the backend
           console.log(token);
           document.querySelector('form').submit()
       }
     }

     function handleSubmit(event) {
       if (!window.smartCaptcha) {
         return;
       }

       window.smartCaptcha.execute(widgetId);
     }
   </script>

   <form id="form">
     <div id="captcha-container"></div>
     <button type="button" onclick="handleSubmit()">Submit</button>
   </form>
   ```

   {% endcut %}
