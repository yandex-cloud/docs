---
sourcePath: ru/tracker/api-ref/concepts/queues/get-versions.md
---
# Получить версии очереди

Запрос позволяет получить информацию о [версиях очереди](../../manager/versions.md). Очередь выбирается при указании идентификатора или ключа.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Для получения версий очереди используйте HTTP-запрос с методом `GET`.

```http
GET /v2/queues/<ключ_или_идентификатор_очереди>/versions
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<ключ_или_идентификатор_очереди\> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка или число

{% endcut %}

> Пример: Получить версии очереди `TEST`.
>
> - Используется HTTP-метод `GET`.
>
> ```
> GET /v2/queues/TEST/versions HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    ```json
    [
        {
            "self": "https://{{ host }}/v2/versions/49***",
            "id": 49***,
            "version": 1,
            "queue": {
                "self": "https://{{ host }}/v2/queues/JUNE",
                "id": "1928",
                "key": "JUNE",
                "display": "june"
            },
            "name": "версия1",
            "description": "iohb ±!@#$%^&*()_+=-/\\?<>.,/§:»'|;",
            "startDate": "2017-06-09",
            "dueDate": "20227-06-09",
            "released": false,
            "archived": false
        },
        ...
    ]
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Ссылка на объект версии | Строка
    id | Идентификатор версии | Число
    version | Номер версии | Число
    [queue](#queue) | Объект с информацией об очереди | Объект
    name | Название версии | Строка
    description | Текстовое описание версии | Строка
    startDate | Начальная дата очереди | Строка
    dueDate | Конечная дата очереди | Строка
    released | Признак выпущенной версии | Логический
    archived | Признак архивной версии | Логический

    **Поля объекта** `queue` {#queue}
    
    {% include [queue](../../../_includes/tracker/api/queue.md) %}

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}