---
sourcePath: ru/tracker/api-ref/get-columns.md
---
# Получить параметры всех колонок

Запрос позволяет получить параметры всех колонок доски.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Чтобы получить параметры всех колонок доски, используйте HTTP-запрос с методом `GET`.

```
GET /{{ ver }}/boards/<идентификатор_доски>/columns
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<идентификатор_доски\> | Идентификатор доски | Число

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит JSON-массив с параметрами всех колонок доски.

    ```json
    [
        {
          "self": "https://{{ host }}/v2/boards/73/columns/1",
          "id": 1,
          "name": "Открыт",
          "statuses":
           [
              {
                  "self": "https://{{ host }}/v2/statuses/1",
                  "id": "1",
                  "key": "open",
                  "display": "Открыт"
              },
               ...
           ]
        },
         ...
    ]
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о колонке доски. |  Строка
    id | Идентификатор колонки. |  Число
    name | Название колонки. |  Строка
    [statuses](#statuses) | Массив содержит ключи возможных статусов задач, которые попадут в колонку.<br/>Список всех статусов задачи: [{{ link-tracker-statuses }}]({{ link-tracker-statuses }}) | Массив

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
