{% cut "Заголовки" %}

- **Host**
        Адрес узла, предоставляющего API:
    ```
    https://api.tracker.yandex.net
    ```

- **Authorization**

    OAuth-токен в формате `OAuth <значение токена>`, например:
    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```
- **X-Org-ID** или **X-Cloud-Org-ID**

    Идентификатор организации. Если у вас только организация {{ org-full-name }}, используйте заголовок `X-Cloud-Org-ID`, если только {{ ya-360 }} или оба типа организаций — `X-Org-ID`.
    

- **Content-Type**

    Формат тела запроса. Должен иметь значение `multipart/form-data`.

{% endcut %}