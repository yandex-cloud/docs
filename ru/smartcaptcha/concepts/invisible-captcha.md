# Невидимая капча

Невидимая капча — это способ подключения виджета {{ captcha-name }}, при котором кнопка **Я не робот** отсутствует на странице. Окно с заданием увидят только те пользователи, запросы которых сервис {{ captcha-name }} посчитает подозрительными.

Разработчик сам выбирает, когда сервис проверит пользователя, например, по клику на **submit** формы.

Невидимая капча подключается только [расширенным методом](./widget-methods.md#extended-method).

## Алгоритм подключения {#installation-algorithm}

1. Загрузить капчу расширенным методом.

    ```html
    <script
      src="https://captcha-api.yandex.ru/captcha.js?render=onload&onload=onloadFunction"
      defer
    ></script>

    <div id="captcha-container"></div>
    ```

1. Отрисовать виджет капчи в невидимом режиме.

    ```html
    <script>
      function onloadFunction() {
        if (!window.smartCaptcha) {
          return;
        }

        window.smartCaptcha.render('captcha-container', {
          sitekey: '<Ключ_для_клиентской_части>',
          invisible: true, // Сделать капчу невидимой
          callback: callback,
        });
      }

      function callback(token) {
        console.log(token);
      }
    </script>
    ```

1. Вызвать `window.smartCaptcha.execute()`, когда {{ captcha-name }} должна начать валидацию пользователя. Например, при нажатии **submit** в форме.

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

## Особенности {#specifics}

Невидимая капча требует меньше памяти, чем обычная, так как не загружает код, который отрисовывает кнопку **Я не робот**.

Однако, у пользователей, которым будет показано задание, время загрузки виджета может варьироваться. Поэтому мы рекомендуем предупреждать пользователей о показе капчи, чтобы не приводить их в замешательство во время ожидания.