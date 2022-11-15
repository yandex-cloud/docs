---
sourcePath: ru/tracker/api-ref/get-column.md
---
# Получить параметры колонки

Запрос позволяет получить параметры колонки доски.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Чтобы получить параметры колонки доски, используйте HTTP-запрос с методом `GET`.

```
GET /{{ ver }}/boards/<board-id>/columns/<column-id>
Host: {{ host }}
Authorization: OAuth <токен>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<board-id\> | Идентификатор доски | Число
\<column-id\> | Идентификатор колонки | Число

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит JSON-объект с параметрами колонки.

    ```json
    {
        "self": "{{ host }}/v2/boards/73/columns/1",
        "id": 1,
        "name": "Открыт",
        "statuses":
          [
             {
                "self": "{{ host }}/v2/statuses/1",
                "id": "1",
                "key": "open",
                "display": "Открыт"
             },
              ...
          ]
    }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о колонке доски. |  Строка
    id | Идентификатор колонки. |  Число
    name | Название колонки. |  Строка
    [statuses](#statuses) | Массив содержит ключи возможных статусов задач, которые попадут в колонку.<br/>Список всех статусов задачи: [{{ link-tracker-statuses }}]({{ link-tracker-statuses }}) | Массив.

    **Поля объекта** `statuses` {#statuses}

    {% include [status](../_includes/tracker/api/status.md) %}

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-400](../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
