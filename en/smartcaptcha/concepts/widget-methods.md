# Widget installation methods {{ captcha-full-name }}

There are two methods to connect a {{ captcha-name }} widget:

* Automatic.
* Advanced.

Depending on the connection method, the method of transmitting parameters for the widget differs.

## Automatic connection method {#common-method}

In the automatic method, a JS script that loads the widget on the user page is added to the page by a link:

```html
<script src="https://captcha-api.yandex.ru/captcha.js" defer></script>
```

After uploading, the JS script searches for all containers suitable for loading a widget into them, and draws widgets in them.

You can load the widget using the `div` elements with the `smart-captcha` class:

```html
<div class="smart-captcha"></div>
```

Parameters for rendering the widget are set via container data attributes.

Example of a container with parameters for rendering a widget:

```html
<div
  class="smart-captcha"
  data-sitekey="<Client_part_key>"
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


## `window.smartCaptcha` methods {#methods}


### render method {#render}

The `render` method is used to draw the widget.

```ts
(
  container: HTMLElement | string,
  params: {
      sitekey: string;
      callback?: (token: string) => void;
      hl?: 'ru' | 'en' | 'be' | 'kk' | 'tt' | 'uk' | 'uz' | 'tr';
      invisible?: boolean;
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

`widgetId` argument: Unique widget ID. If no argument is passed in, the output of the first rendered widget is returned.

### reset method {#reset}

The `reset` method resets the widget to the initial state.

```ts
(widgetId: WidgetId | undefined) => void;
```

`widgetId` argument: Unique widget ID. If no argument has been passed in, the first rendered widget is reset.

### destroy method {#destroy}

The `destroy` method deletes widgets and any listeners they create.

```ts
(widgetId: WidgetId | undefined) => void;
```

The `WidgetId` argument is a unique widget ID. If the argument is not passed in, the first rendered widget will be deleted.

### subscribe method {#subscribe}

The `subscribe` method enables you to subscribe listeners to certain widget events.
For instance, you can listen for the opening and closing of a task popup window. This may be useful for displaying the keyboard on mobile devices.

```ts
(widgetId: widgetId, event: SubscribeEvent, callback: Function) =>
  UnsubscribeFunction;
```

Arguments:

* `widgetId`: Unique widget ID.
* `event`: Event:

   ```ts
   type SubscribeEvent =
   | 'challenge-visible'
   | 'challenge-hidden'
   | 'network-error'
   | 'success';
   ```

   Event descriptions:

   | Event | When it occurs | Handler signature: |
   | ------------------- | --------------------------------------------- | ------------------------- |
   | `challenge-visible` | Opening the task pop-up window | `() => void` |
   | `challenge-hidden` | Closing the task pop-up window | `() => void` |
   | `network-error` | A network error occurred | `() => void` |
   | `success` | Successful user validation | `(token: string) => void` |

* `callback`: Handler function:

   ```ts
   UnsubscribeFunction = () => viod;
   ```

Usage example:

```html
<div id="container"></div>

<script
  src="https://captcha-api.yandex.ru/captcha.js?render=onload&onload=onloadFunction"
  async
  defer
></script>

<script>
  function onloadFunction() {
    if (window.smartCaptcha) {
      const container = document.getElementById('container');
      const widgetId = window.smartCaptcha.render(container, {
        /* params */
      });

      const unsubscribe = window.smartCaptcha.subscribe(
        widgetId,
        'challenge-visible',
        () => console.log('challenge is visible')
      );
    }
  }
</script>
```

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
