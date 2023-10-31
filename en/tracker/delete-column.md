---
sourcePath: ru/tracker/api-ref/delete-column.md
---
# Удалить колонку

Запрос позволяет удалить колонку.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Чтобы удалить колонку, используйте HTTP-запрос с методом `DELETE`.

```
DELETE /{{ ver }}/boards/<board-id>/columns/<column-id>
Host: {{ host }}
Authorization: OAuth <токен>
{{ org-id }}
If-Match: "<номер версии>"
```

{% cut "Заголовки" %}

- **Host**

    Адрес узла, предоставляющего API:
    ```
    {{ host }}
    ```

- **Authorization**

    OAuth-токен в формате `OAuth <значение токена>`, например:

    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```


- **X-Org-ID** или **X-Cloud-Org-ID**

    Идентификатор организации. Если у вас только организация {{ org-full-name }}, используйте заголовок `X-Cloud-Org-ID`, если только {{ ya-360 }} или оба типа организаций — `X-Org-ID`.


- **If-Match**

    Номер текущей версии доски.

{% endcut %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<board-id\> | Идентификатор доски | Число
\<column-id\> | Идентификатор колонки | Число

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-204](../_includes/tracker/api/answer-204.md) %}
    
    Тело ответа отсутствует.

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
