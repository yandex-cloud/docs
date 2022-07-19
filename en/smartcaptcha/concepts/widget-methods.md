# Widget installation methods {{ captcha-full-name }}

There are two methods to connect a {{ captcha-name }} widget:

* Regular or automatic connection method.
* Advanced connection method.

Depending on the connection method you select, the method of transmitting parameters for the widget differs.

## Regular or automatic connection method {#common-method}

In the regular method, a JS script that loads the widget on the user page is added to the page by following an upload link:

```html
<script src="https://captcha-api.yandex.ru/captcha.js" defer></script>
```

After uploading, the JS script searches for all containers suitable for loading a widget into them, and draws widgets in them.

You can upload the widget to the `div` element with the `smart-captcha` class:

```html
<div class="smart-captcha"></div>
```

Parameters for rendering the widget are set via data attributes of the container in which the widget will be placed.

Example of a container with parameters for rendering a widget:

```html
<div
  class="smart-captcha"
  data-sitekey="<Key for the client part>"
  data-hl="<Language>"
></div>
```

Where:

| Data attribute | Value | Default value |
| --------------- | ---------------------------------------------------------------------------- | --------------------------- |
| `data-sitekey` | `string` | None |
| `data-hl` | `'ru'` \| `'en'` \| `'be'` \| `'kk'` \| `'tt'` \| `'uk'` \| `'uz'` \| `'tr'` | `window.navigator.language` |
| `data-callback` | `string` | None |

{% cut "Example of embedding the widget" %}

```html
<html>
  <head>
    <title>Authentication form</title>
    <script>
      function callback(token) {
        console.log(callback);
      }
    </script>
    <script src="https://captcha-api.yandex.ru/captcha.js" async defer></script>
  </head>

  <body>
    <p>Enter your username and password:</p>
    <form id="auth_form" action="" method="POST">
      <input id="csrf_token" name="csrf_token" type="hidden" />
      <label for="username">Name</label>
      <input id="username" type="text" name="user" />
      <label for="userpass">Password</label>
      <input id="userpass" type="password" name="password" />
      <div
        id="captcha-container"
        class="smart-captcha"
        data-sitekey="<Key for the client part>"
        data-hl="en"
        data-callback="callback"
      ></div>
      <input type="submit" value="Submit" />
    </form>
  </body>
</html>
```

{% endcut %}


## Advanced connection method {#extended-method}

In the advanced method, a JS script that loads the widget on the user page is added to the page by a link:

```html
<script src="https://captcha-api.yandex.ru/captcha.js?render=onload&onload=onloadFunction"></script>
```

In the `onload` parameter, a function is passed that contains parameters for rendering the widget. In this example, this is the `onloadFunction` function.

After loading the JS script, an access to the `window.smartCaptcha` object is shown along with methods for the widget.

{% cut "Sample onloadFunction code" %}

```html
<div id="<Container ID>"></div>

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

{% endcut %}

`window.smartCaptcha` provides three methods for interacting with the widget:

### render method {#render}

The `render` method is used to draw the widget.

```ts
(
  container: HTMLElement \| string,
  params: {
      sitekey: string;
      callback?: (token: string) => void;
      hl?: 'ru' | 'en' | 'be' | 'kk' | 'tt' | 'uk' | 'uz' | 'tr';
  }
) => WidgetId;
```

The first parameter passed is the container to embed the widget. The `container` accepts a DOM element or a string with the element ID as an input. The second parameter for the function is an object with captcha parameters.

The method returns `widgetId`, that is, a unique widget ID.

### GetResponse method {#getresponse}

The `getResponse` method returns the current value of the user token.

```ts
(widgetId: WidgetId | undefined) => string;
```

As an argument, the method accepts `widgetId`, a unique identifier of the widget. If no argument is passed, the result of the first rendered widget is returned.

### reset method {#reset}

The `reset` method resets the widget to the initial state.

```ts
(widgetId: WidgetId | undefined) => void
```

As an argument, the method accepts `widgetId`, a unique identifier of the widget. If no argument has been passed, the first rendered widget is reset.

{% cut "Example of embedding the widget" %}

```html
<script
  src="https://captcha-api.yandex.ru/captcha.js?render=onload&onload=smartCaptchaInit"
  defer
></script>

<script>
  function callback(token) {
    console.log(token);
    if (token) {
      document
        .getElementById('smartcaptcha-demo-submit')
        .removeAttribute('disabled');
    } else {
      document
        .getElementById('smartcaptcha-demo-submit')
        .setAttribute('disabled', '1');
    }
  }

  function smartCaptchaInit() {
    if (!window.smartCaptcha) {
      return;
    }

    window.smartCaptcha.render('captcha-container', {
      sitekey: '<Key for the client part>',
      callback: callback,
    });
  }

  function smartCaptchaReset() {
    if (!window.smartCaptcha) {
      return;
    }

    window.smartCaptcha.reset();
  }

  function smartCaptchaGetResponse() {
    if (!window.smartCaptcha) {
      return;
    }

    var resp = window.smartCaptcha.getResponse();
    console.log(resp);
    alert(resp);
  }
</script>
```

{% endcut %}