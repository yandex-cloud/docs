# Методы установки виджета {{ captcha-full-name }}

Подключить виджет {{ captcha-name }} можно одним из двух методов:

* Обычный или автоматический метод подключения.
* Расширенный метод подключения.

В зависимости от выбранного метода подключения способ передачи параметров для виджета отличается.

## Обычный или автоматический метод подключения {#common-method}

В обычном методе JS-скрипт, который выполняет загрузку виджета на странице пользователя, добавляется на страницу по ссылке для загрузки:

```html
<script src="https://captcha-api.yandex.ru/captcha.js" defer></script>
```

После загрузки JS-скрипт ищет все контейнеры, которые подходят для загрузки в них виджета, и отрисовывает в них виджеты.

Контейнером, который подходит для загрузки виджета, является элемент `div` с классом `smart-captcha`:

```html
<div class="smart-captcha"></div>
```

Параметры для отрисовки виджета задаются через data-атрибуты контейнера, в котором будет размещаться виджет.

Пример контейнера с параметрами для отрисовки виджета:

```html
<div
  class="smart-captcha"
  data-sitekey="<Ключ для клиентской части>"
  data-hl="<Язык>"
></div>
```

Описание параметров:

| Data-атрибут    | Значение                                                                     | Значение по-умолчанию       |
| --------------- | ---------------------------------------------------------------------------- | --------------------------- |
| `data-sitekey`  | `string`                                                                     | Отсутствует                 |
| `data-hl`       | `'ru'` \| `'en'` \| `'be'` \| `'kk'` \| `'tt'` \| `'uk'` \| `'uz'` \| `'tr'` | `window.navigator.language` |
| `data-callback` | `string`                                                                     | Отсутствует                 |

{% cut "Пример встраивания виджета" %}

```html
<html>
  <head>
    <title>Форма аутентификации</title>
    <script>
      function callback(token) {
        console.log(callback);
      }
    </script>
    <script src="https://captcha-api.yandex.ru/captcha.js" async defer></script>
  </head>

  <body>
    <p>Введите логин и пароль:</p>
    <form id="auth_form" action="" method="POST">
      <input id="csrf_token" name="csrf_token" type="hidden" />
      <label for="username">Name</label>
      <input id="username" type="text" name="user" />
      <label for="userpass">Password</label>
      <input id="userpass" type="password" name="password" />
      <div
        id="captcha-container"
        class="smart-captcha"
        data-sitekey="<Ключ для клиентской части>"
        data-hl="en"
        data-callback="callback"
      ></div>
      <input type="submit" value="Submit" />
    </form>
  </body>
</html>
```

{% endcut %}


## Расширенный метод подключения {#extended-method}

В расширенном методе JS-скрипт, который выполняет загрузку виджета на странице пользователя, добавляется на страницу по ссылке:

```html
<script src="https://captcha-api.yandex.ru/captcha.js?render=onload&onload=onloadFunction"></script>
```

В параметре `onload` передается функция, которая содержит параметры отрисовки виджета. В данном примере это функция `onloadFunction`.

После загрузки JS-скрипта появляется доступ к объекту `window.smartCaptcha` с методами для работы с виджетом.

{% cut "Пример кода onloadFunction" %}

```html
<div id="<id контейнера>"></div>

<script>
  function onloadFunction() {
    if (window.smartCaptcha) {
      const container = document.getElementById('<id контейнера>');

      const widgetId = window.smartCaptcha.render(container, {
        sitekey: '<Ключ для клиентской части>',
        hl: '<Язык>',
      });
    }
  }
</script>
```

{% endcut %}

`window.smartCaptcha` предоставляет три метода для взаимодействия с виджетом:

### Метод render {#render}

Метод `render` служит для отрисовки виджета.

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

Первым параметром передается контейнер для встраивания виджета. `container` принимает на вход DOM-элемент или строку с id элемента. Вторым параметром функция принимает на вход объект с параметрами для капчи.

Метод возвращает `widgetId` - уникальный идентификатор виджета.

### Метод getResponse {#getresponse}

Метод `getResponse` возвращает текущее значение токена пользователя.

```ts
(widgetId: WidgetId | undefined) => string;
```

В качестве аргумента метод принимает `widgetId`, уникальный идентификатор виджета. Если аргумент не передан, то будет возвращен результат первого отрисованного виджета.

### Метод reset {#reset}

Метод `reset` сбрасывает состояние виджета до начального.

```ts
(widgetId: WidgetId | undefined) => void
```

В качестве аргумента метод принимает `widgetId`, уникальный идентификатор виджета. Если аргумент не передан, то к начальному состоянию будет возвращен первый отрисованный виджет.

{% cut "Пример встраивания виджета" %}

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
      sitekey: '<Ключ для клиентской части>',
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