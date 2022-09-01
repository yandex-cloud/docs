# Invisible CAPTCHA

Invisible CAPTCHA is a way of connecting the {{ captcha-name }} widget without the **"I’m not a robot"** button on the page. Only users whose requests are considered suspicious by {{ captcha-name }} will see the task pop-up window.

The developer chooses when the service will check the user, for example, when clicking the **submit** button.

Invisible CAPTCHA is only connected using the [advanced method](./widget-methods.md#extended-method).

## Connection algorithm {#installation-algorithm}

1. Load the CAPTCHA using the advanced method.

   ```html
   <script
     src="https://captcha-api.yandex.ru/captcha.js?render=onload&onload=onloadFunction"
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
         sitekey: '<Key for the client part>',
         invisbile: true, // Make captcha invisible
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
     <input type="submit" onsubmit="handleSubmit()">
   </form>
   ```

## Specifics {#specifics}

Invisible CAPTCHA requires less memory than normal CAPTCHA because it doesn't load the code that renders the **"I’m not a robot"** button.

However, widget loading times may vary for users. That's why we recommend warning users about the CAPTCHA to avoid any confusion while they wait.