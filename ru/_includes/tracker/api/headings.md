#### Заголовки {#req-headers}

- **Host**
    {% if audience == "external" %}
    Адрес узла, предоставляющего API:
    ```
    https://api.tracker.yandex.net
    ```
    {% else %}
    ```
    https://st-api.yandex-team.ru/
    ```
    {% endif %}

- **Authorization**

    OAuth-токен в формате `OAuth <значение токена>`, например:
    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```
{% if audience == "external" %}
- **X-Org-ID**

    Идентификатор организации.
    
{% endif %}