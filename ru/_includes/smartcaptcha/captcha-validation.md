{{ captcha-name }}, проверив запрос, присваивает ему идентификатор — одноразовый токен. По этому токену вы можете запросить у сервиса результат проверки запроса пользователя. Токен действителен 5 минут. По истечении этого времени токен становится недействительным и пользователю необходимо снова пройти проверку.

После проверки токен загружается в элемент `<input type="hidden" name="smart-token" value="<токен>" ...>` на странице пользователя. Например:

```HTML
<div id="captcha-container" class="smart-captcha" ...>
    <input type="hidden" name="smart-token" value="dD0xNjYyNDU3NDMzO2k9MmEwMjo2Yjg6YjA4MTpiNTk3OjoxOjFiO0Q9MjVCREY1RDgzMDBERjQ3QjExNkUyMDJDNjJFNEI3Q0Y0QjYzRkRDNzJEMkV********DNjMxODgzMUM0REZBNzI1QUE1QzUwO3U9MTY2MjQ1NzQzMzk5MTEwNjQxNTtoPTg4MWRjMDc2YzE3MjkxNGUwNDgwMTVkYzhl********">
    ...
</div>
```

Где:

* `<div id="captcha-container" class="smart-captcha" ...>` — элемент `div` с виджетом.
* `value` — значение токена.

Чтобы узнать результат проверки, отправьте GET-запрос на адрес `https://smartcaptcha.yandexcloud.net/validate`:

```HTML
response = requests.get(
"https://smartcaptcha.yandexcloud.net/validate",
    {
    "secret": SMARTCAPTCHA_SERVER_KEY,
    "token": token,
    "ip": "<IP-адрес_пользователя>"
    }
)
```

Где:

{% include [query-parameters](../../_includes/smartcaptcha/query-parameters.md) %}

## Ответ сервиса {#service-response}

В ответ сервис пришлет JSON-объект с полями `status` и `message`. Когда поле `status` принимает значение `ok`, в JSON-объект добавляется поле `host`. Оно показывает, на каком сайте была пройдена проверка. Например:

1. Это человек. Проверка пройдена на сайте `example.com`:

    ```json
    {
        "status": "ok",
        "message": "",
        "host": "example.com"
    }
    ```

1. Это человек. Проверка пройдена на сайте `example.com` через порт `8080`:

    ```json
    {
        "status": "ok",
        "message": "",
        "host": "example.com:8080"
    }
    ```

1. Пустое поле `host`. Может означать, что облако заблокировано, или произошел внутренний сбой сервиса:

    ```json
    {
        "status": "ok",
        "message": "",
        "host": ""
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

## Ошибки в запросе {#errors}

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
