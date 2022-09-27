# Добавьте виджет {{ captcha-name }} расширенным методом

Вы управляете загрузкой виджета через [объект](../concepts/widget-methods.md#methods) `window.smartCaptcha`. В инструкции для этого используется callback-функция `onloadFunction`:

1. Подключите JS-скрипт к странице пользователя. Для этого разместите следующий код в любом месте страницы, например, внутри тега `<head>`:

    ```html
    <script
        src="https://captcha-api.yandex.ru/captcha.js?render=onload&onload=onloadFunction"
        defer
    ></script>
    ```

1. Добавьте на страницу пустой контейнер, в который будет вставлен виджет:

    ```html
    <div id="<id_контейнера>"></div>
    ```

    Где:

    `<id_контейнера>` — произвольный идентификатор.

1. Добавьте на страницу код callback-функции:

    ```html
    <script>
        function onloadFunction() {
        if (window.smartCaptcha) {
            const container = document.getElementById('<id_контейнера>');

            const widgetId = window.smartCaptcha.render(container, {
            sitekey: '<ключ_клиента>',
            hl: '<язык>',
            });
        }
        }
    </script>
    ```

    Где:

    * `<ключ_клиента>` — [ключ капчи](./get-keys.md);
    * `<язык>` — [язык](../concepts/widget-methods.md#render) виджета и задания.

    В код callback-функции стоит добавить проверку существования объекта `window.smartCaptcha`, чтобы не вызвать ошибку в случае вызова функции до завершения загрузки JS-скрипта.

    {% include [info-container-height](../../_includes/smartcaptcha/info-container-height.md) %}


## Что дальше {#whats-next}

* [Невидимая капча](../concepts/invisible-captcha.md).
* [Подключение капчи в React](../concepts/react.md).