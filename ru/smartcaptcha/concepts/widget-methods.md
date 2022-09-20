# Методы установки виджета {{ captcha-full-name }}

Подключить виджет {{ captcha-name }} можно одним из двух методов:

* Автоматический.
* Расширенный.

В зависимости от метода подключения отличается способ передачи параметров для виджета.

## Автоматический метод подключения {#common-method}

В автоматическом методе JS-скрипт, который выполняет загрузку виджета на странице пользователя, добавляется на страницу по ссылке:

```html
<script src="https://captcha-api.yandex.ru/captcha.js" defer></script>
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
  data-sitekey="<Ключ_клиентской_части>"
  data-hl="<Язык>"
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


## Методы `window.smartCaptcha` {#methods}


### Метод render {#render}

Метод `render` служит для отрисовки виджета.

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

Первым параметром передается контейнер для встраивания виджета. `container` принимает на вход DOM-элемент или строку с id элемента. Вторым параметром функция принимает на вход объект с параметрами для капчи.

Метод возвращает `widgetId` - уникальный идентификатор виджета.

### Метод getResponse {#getresponse}

Метод `getResponse` возвращает текущее значение токена пользователя.

```ts
(widgetId: WidgetId | undefined) => string;
```

Аргумент `widgetId` – уникальный идентификатор виджета. Если аргумент не передан, будет возвращен результат первого отрисованного виджета.

### Метод reset {#reset}

Метод `reset` сбрасывает состояние виджета до начального.

```ts
(widgetId: WidgetId | undefined) => void;
```

Аргумент `widgetId` – уникальный идентификатор виджета. Если аргумент не передан, к начальному состоянию будет возвращен первый отрисованный виджет.

### Метод destroy {#destroy}

Метод `destroy` удаляет виджет и созданные им обработчики.

```ts
(widgetId: widgetId | undefined) => void;
```

Аргумент – `widgetId`, уникальный идентификатор виджета. Если аргумент не передан, будет удален первый отрисованный виджет.

### Метод subscribe {#subscribe}

Метод `subscribe` позволяет подписывать обработчики на определенные события виджета.
Например, можно следить за открытием и закрытием всплывающего окна с заданием. Это может быть полезно для показа клавиатуры на мобильных устройствах.

```ts
(widgetId: widgetId, event: SubscribeEvent, callback: Function) =>
  UnsubscribeFunction;
```

Аргументы:

* `widgetId` – уникальный идентификатор виджета.
* `event` – событие:

    ```ts
    type SubscribeEvent =
    | 'challenge-visible'
    | 'challenge-hidden'
    | 'network-error'
    | 'success';
    ```

    Описание событий:

    | Событие             | Когда происходит                              | Сигнатура обработчика     |
    | ------------------- | --------------------------------------------- | ------------------------- |
    | `challenge-visible` | Открытие всплывающего окна с заданием         | `() => void`              |
    | `challenge-hidden`  | Закрытие всплывающего окна с заданием         | `() => void`              |
    | `network-error`     | Возникла сетевая ошибка                       | `() => void`              |
    | `success`           | Успешная валидация пользователя               | `(token: string) => void` |

* `callback` – функция-обработчик:

    ```ts
    UnsubscribeFunction = () => viod;
    ```

Пример использования:

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
