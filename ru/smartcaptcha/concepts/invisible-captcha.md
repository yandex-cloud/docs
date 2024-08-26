# Невидимая капча

Невидимая капча — это способ подключения виджета {{ captcha-name }}, при котором кнопка **Я не робот** отсутствует на странице. Окно с заданием увидят только те пользователи, запросы которых сервис {{ captcha-name }} посчитает подозрительными.

Разработчик сам выбирает, когда сервис проверит пользователя, например, по клику на **submit** формы.

Невидимая капча подключается только [расширенным методом](./widget-methods.md#extended-method).

## Алгоритм подключения {#installation-algorithm}

1. Загрузить капчу расширенным методом.

    ```html
    <script
      src="https://smartcaptcha.yandexcloud.net/captcha.js?render=onload&onload=onloadFunction"
      defer
    ></script>
    ```

1. Отрисовать виджет капчи в невидимом режиме.

    ```html
    <form id="form">
      <div id="captcha-container"></div>
      <input type="submit" />
    </form>
    
    <script>
    const form = document.getElementById('form');

    function onloadFunction() {
      if (!window.smartCaptcha) {
        return;
      }

      window.smartCaptcha.render('captcha-container', {
        sitekey: '<ключ_клиентской_части>',
        invisible: true, // Сделать капчу невидимой
        callback: callback,
      });
    }

    function callback(token) {
      form.submit();
    }
    </script>
    ```

1. Вызвать `window.smartCaptcha.execute()`, когда {{ captcha-name }} должна начать валидацию пользователя. Например, при нажатии **submit** в форме.

    ```html
    <form id="form">
      <div id="captcha-container"></div>
      <input type="submit" onsubmit="handleSubmit()" />
    </form>
    
    <script>
    const form = document.getElementById('form');

    function onloadFunction() {
      if (!window.smartCaptcha) {
        return;
      }

      window.smartCaptcha.render('captcha-container', {
        sitekey: '<ключ_клиентской_части>',
        invisible: true, // Сделать капчу невидимой
        callback: callback,
      });
    }

    function callback(token) {
      form.submit();
    }

    function handleSubmit(event) {
      event.preventDefault();
    
      if (!window.smartCaptcha) {
        return;
      }

      window.smartCaptcha.execute();
    }
    </script>
    ```

## Уведомление об обработке данных {#data-processing-notice}

По умолчанию на странице с невидимой капчей появляется блок со ссылкой, которая ведет на документ [Уведомление об условиях обработки данных сервисом](https://yandex.ru/legal/smartcaptcha_notice/).

Блок располагается в нижнем правом углу. Чтобы переместить блок, используйте параметр `shieldPosition` [метода](./widget-methods.md#render) `render`. Например:

```js
window.smartCaptcha.render('captcha-container', {
  sitekey: '<ключ_клиентской_части>',
  invisible: true,
  shieldPosition: 'top-left',
  callback: callback,
});
```

Вы можете скрыть блок, используя параметр `hideShield` [метода](./widget-methods.md#render) `render`.

{% include [warning-hideshield](../../_includes/smartcaptcha/warning-hideshield.md) %}

## Особенности {#specifics}

* Невидимая капча требует меньше памяти, чем обычная, так как не загружает код, который отрисовывает кнопку **Я не робот**.

    Однако, у пользователей, которым будет показано задание, время загрузки виджета может варьироваться. Поэтому мы рекомендуем предупреждать пользователей о показе капчи, чтобы не приводить их в замешательство во время ожидания.

* Если на странице более одного виджета, то нужно передавать идентификатор виджета в метод `execute`.

    {% cut "Пример" %}

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
          sitekey: '<ключ_клиентской_части>',
          invisible: true, // Сделать капчу невидимой
          callback: callback,
        });
      }

      function callback(token) {
        if (typeof token === "string" && token.length > 0) {
            // Отправить форму на бекенд
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
