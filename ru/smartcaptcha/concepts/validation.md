# Валидация пользователя

{{ captcha-name }} проверяет запросы пользователей своими ML-алгоритмами и показывает задание только тем пользователям, запросы которых посчитал подозрительными.

При этом на странице необязательно размещать кнопку **Я не робот**.


## Обычная капча {#usual-captcha}

Обычная капча — способ подключения виджета {{ captcha-name }} с кнопкой **Я не робот**, клик по которой отправит запрос пользователя в {{ captcha-name }}. Если сервис посчитает запрос подозрительным, он предложит пользователю решить задание.


## Невидимая капча {#invisible-captcha}

Невидимая капча — способ подключения виджета SmartCaptcha, при котором кнопка **Я не робот** отсутствует на странице. Окно с заданием увидят только те пользователи, запросы которых сервис посчитает подозрительными.

Разработчик сам выбирает событие, когда сервис проверит пользователя.


## Результат проверки {#validation-result}

{{ captcha-name }}, проверив запрос, присваивает ему идентификатор — токен. По этому токену вы можете запросить у сервиса результат проверки запроса пользователя.

После проверки токен загружается в элемент `<input type="hidden" name="smart-token" value="<токен>" ...>` на странице пользователя. Например:

```HTML
<div id="captcha-container" class="smart-captcha" ...>
    <input type="hidden" name="smart-token" value="dD0xNjYyNDU3NDMzO2k9MmEwMjo2Yjg6YjA4MTpiNTk3OjoxOjFiO0Q9MjVCREY1RDgzMDBERjQ3QjExNkUyMDJDNjJFNEI3Q0Y0QjYzRkRDNzJEMkVGQzQyRUNDNjMxODgzMUM0REZBNzI1QUE1QzUwO3U9MTY2MjQ1NzQzMzk5MTEwNjQxNTtoPTg4MWRjMDc2YzE3MjkxNGUwNDgwMTVkYzhlZjU3ODQ0">
    ...
</div>
```

Где:

* `<div id="captcha-container" class="smart-captcha" ...>` — элемент `div` с виджетом.
* `value` — значение токена.

Чтобы узнать результат проверки, отправьте GET-запрос с токеном на адрес `https://smartcaptcha.yandexcloud.net/validate`:

```TEXT
https://smartcaptcha.yandexcloud.net/validate?secret=<ключ_сервера>&ip=<IP_адрес_пользователя>&token=<токен>
```

Где:

{% include [query-parameters](../../_includes/smartcaptcha/query-parameters.md) %}

### Ответ сервиса {#service-response}

В ответ сервис пришлет JSON-объект с полями `status` и `message`. Например:

1. Это человек:

    ```json
    {
        "status": "ok",
        "message": ""
    }
    ```

1. Это робот:

    ```json
    {
        "status": "failed",
        "message": ""
    }
    ```

1. Запрос с поддельным или поврежденным токеном. Это робот:

    ```json
    {
        "status": "failed",
        "message": "Token invalid or expired."
    }
    ```

### Ошибки в запросе {#errors}

Если запрос к `https://smartcaptcha.yandexcloud.net/validate` оформлен некорректно, сервис вернет ошибку. Например:

1. Запрос без ключа сервера:

    ```JSON
    {
        "status": "failed",
        "message": "Authentication failed. Secret has not provided."
    }
    ```

1. Запрос без токена или с поврежденным токеном:

    ```JSON
    {
        "status": "failed",
        "message": "Token invalid or expired."
    }
    ```

{% note info %}

Чтобы при обработке запроса от пользователя не было задержки, ошибки HTTP-протокола (код ответа не 200) рекомендуется обрабатывать как ответ сервиса `"status": "ok"`.

{% endnote %}


## Что дальше {#whats-next}

* Как подключить [невидимую капчу](./invisible-captcha.md).
* Капча в [React](./react.md).
