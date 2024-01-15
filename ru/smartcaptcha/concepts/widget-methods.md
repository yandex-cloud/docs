---
title: "Методы установки виджета {{ captcha-full-name }}"
description: "Вы можете подключить виджет {{ captcha-name }} автоматическим или расширенным методом. В зависимости от метода подключения отличается способ передачи параметров для виджета."
---

# Методы установки виджета {{ captcha-full-name }}

Подключить виджет {{ captcha-name }} можно одним из двух методов:

* Автоматический.
* Расширенный.

В зависимости от метода подключения отличается способ передачи параметров для виджета.

## Автоматический метод подключения {#common-method}

В автоматическом методе JS-скрипт, который выполняет загрузку виджета на странице пользователя, добавляется на страницу по ссылке:

```html
<script src="https://smartcaptcha.yandexcloud.net/captcha.js" defer></script>
```

После загрузки JS-скрипт ищет все контейнеры, которые подходят для загрузки в них виджета, и отрисовывает в них виджеты.

Для загрузки виджета подходят элементы `div` с классом `smart-captcha`:

```html
<div class="smart-captcha"></div>
```

Параметры для отрисовки виджета задаются через data-атрибуты контейнера.

Пример контейнера с параметрами для отрисовки виджета:

```html
<div
  class="smart-captcha"
  data-sitekey="<ключ_клиентской_части>"
  data-hl="<язык>"
></div>
```

Где:

| Data-атрибут    | Значение                                                                     | Значение по умолчанию       |
| --------------- | ---------------------------------------------------------------------------- | --------------------------- |
| `data-sitekey`  | `string`                                                                     | Отсутствует                 |
| `data-hl`       | `'ru'` \| `'en'` \| `'be'` \| `'kk'` \| `'tt'` \| `'uk'` \| `'uz'` \| `'tr'` | `window.navigator.language` |
| `data-callback` | `string`                                                                     | Отсутствует                 |

{% cut "Пример встраивания виджета" %}

```html
<html>
  <head>
    <meta charset="UTF-8">
    <title>Форма аутентификации</title>
    <script>
      function callback(token) {
        console.log(callback);
      }
    </script>
    <script src="https://smartcaptcha.yandexcloud.net/captcha.js" async defer></script>
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
        data-sitekey="<ключ_клиентской_части>"
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
<script src="https://smartcaptcha.yandexcloud.net/captcha.js?render=onload&onload=onloadFunction"></script>
```

В параметре `onload` передается функция, которая содержит параметры отрисовки виджета. В данном примере это функция `onloadFunction`.

После загрузки JS-скрипта появляется доступ к объекту `window.smartCaptcha` с методами для работы с виджетом.

{% cut "Пример кода onloadFunction" %}

```html
<div id="<идентификатор_контейнера>"></div>

<script>
  function onloadFunction() {
    if (window.smartCaptcha) {
      const container = document.getElementById('<идентификатор_контейнера>');

      const widgetId = window.smartCaptcha.render(container, {
        sitekey: '<ключ_клиентской_части>',
        hl: '<язык>',
      });
    }
  }
</script>
```

{% endcut %}


## Методы window.smartCaptcha {#methods}


### Метод render {#render}

Метод `render` служит для отрисовки виджета.

```ts
(
  container: HTMLElement | string,
  params: {
      sitekey: string;
      callback?: (token: string) => void;
      hl?: 'ru' | 'en' | 'be' | 'kk' | 'tt' | 'uk' | 'uz' | 'tr';
      test?: boolean;
      webview?: boolean;
      invisible?: boolean;
      shieldPosition?: `top-left` | `center-left` | `bottom-left` | `top-right` | `center-right` | `bottom-right`;
      hideShield?: boolean;
  }
) => WidgetId;
```

Где:

* `container` — контейнер для виджета. Можно передать DOM-элемент или идентификатор контейнера.
* `params` — объект с параметрами для капчи:
    * `sitekey` — [ключ клиентской части](./keys.md).
    * `callback` — функция-обработчик.
    * `hl` — язык виджета.
    * `test` — включение работы капчи в режиме тестирования. Пользователь всегда будет получать задание. Используйте это свойство только для отладки и тестирования.
    * `webview` — запуск капчи в **WebView**. Используется для повышения точности оценки пользователей при добавлении капчи в мобильные приложения с помощью **WebView**.
    * `invisible` — [невидимая капча](./invisible-captcha.md).
    * `shieldPosition` — расположение [блока](./invisible-captcha.md#data-processing-notice) с уведомлением об обработке данных.
    * `hideShield` — скрыть [блок](./invisible-captcha.md#data-processing-notice) с уведомлением об обработке данных.

{% include [warning-hideshield](../../_includes/smartcaptcha/warning-hideshield.md) %}

Метод возвращает `widgetId` — уникальный идентификатор виджета.

### Метод getResponse {#getresponse}

Метод `getResponse` возвращает текущее значение токена пользователя.

```ts
(widgetId: WidgetId | undefined) => string;
```

Аргумент `widgetId` — уникальный идентификатор виджета. Если аргумент не передан, будет возвращен результат первого отрисованного виджета.

### Метод execute {#execute}

Метод `execute` запускает проверку пользователя. Используется чтобы начать проверку невидимой капчи при каком-то событии, например, при нажатии на кнопку отправки формы аутентификации.

```ts
(widgetId: WidgetId | undefined) => void;
```

Аргумент `widgetId` — уникальный идентификатор виджета. Если аргумент не передан, проверка будет запущена на первом отрисованном виджете.

### Метод reset {#reset}

Метод `reset` сбрасывает состояние виджета до начального.

```ts
(widgetId: WidgetId | undefined) => void;
```

Аргумент `widgetId` — уникальный идентификатор виджета. Если аргумент не передан, к начальному состоянию будет возвращен первый отрисованный виджет.

### Метод destroy {#destroy}

Метод `destroy` удаляет виджет и созданные им обработчики.

```ts
(widgetId: WidgetId | undefined) => void;
```

Аргумент — `widgetId`, уникальный идентификатор виджета. Если аргумент не передан, будет удален первый отрисованный виджет.

### Метод subscribe {#subscribe}

Метод `subscribe` позволяет подписывать обработчики на определенные события виджета.
Например, можно следить за открытием и закрытием всплывающего окна с заданием. Это может быть полезно для показа клавиатуры на мобильных устройствах.

```ts
(widgetId: widgetId, event: SubscribeEvent, callback: Function) =>
  UnsubscribeFunction;
```

Где:

* `widgetId` — уникальный идентификатор виджета.
* `event` — событие:

    ```ts
    type SubscribeEvent =
    | 'challenge-visible'
    | 'challenge-hidden'
    | 'network-error'
    | 'success'
    | 'token-expired';
    ```

    Описание событий:

    | Событие             | Когда происходит                             | Сигнатура обработчика     |
    | ------------------- | ---------------------------------------------| ------------------------- |
    | `challenge-visible` | Открытие всплывающего окна с заданием        | `() => void`              |
    | `challenge-hidden`  | Закрытие всплывающего окна с заданием        | `() => void`              |
    | `network-error`     | Возникла сетевая ошибка                      | `() => void`              |
    | `success`           | Успешная валидация пользователя              | `(token: string) => void` |
    | `token-expired`     | Токен прохождения проверки стал невалидным | `() => void`              |

* `callback` — функция-обработчик:

    ```ts
    UnsubscribeFunction = () => void;
    ```

Пример использования:

```html
<div id="container"></div>

<script
  src="https://smartcaptcha.yandexcloud.net/captcha.js?render=onload&onload=onloadFunction"
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

{% cut "Пример встраивания виджета" %}

```html
<form>
  <div id="captcha-container"></div>
  <button id="smartcaptcha-demo-submit" disabled="1">Submit</button>
</form>

<script
  src="https://smartcaptcha.yandexcloud.net/captcha.js?render=onload&onload=smartCaptchaInit"
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
      sitekey: '<ключ_клиентской_части>',
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
