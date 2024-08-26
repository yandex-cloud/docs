---
sourcePath: ru/tracker/api-ref/concepts/queues/create-version.md
---
# Создать версию очереди

Запрос позволяет создать [версию очереди](../../manager/versions.md). 

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы создать версию очереди используйте HTTP-запрос с методом `POST`. Параметры запроса передаются в его теле в формате JSON.

```http
POST /{{ ver }}/versions/
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
   "queue": "<ключ_очереди>",
   "name": "<название_версии>
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Параметры тела запроса" %}

Тело запроса содержит информацию, необходимую для создания новой версии очереди:

**Обязательные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
queue | Ключ очереди. | Строка
name | Название версии. | Строка

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
description | Описание версии. | Строка
startDate | Дата начала версии в формате `YYYY-MM-DD`. | Строка
dueDate | Дата завершения версии в формате `YYYY-MM-DD`. | Строка

{% endcut %}

> Пример: Создать версию очереди `Test Queue`.
>
> - Используется HTTP-метод `POST`.
> - Создается версия очереди с ключом `TESTQUEUE`.
> - Задается название версии `version 0.1`.
> - Задается описание версии `Test version 1`.
> - Задается дата начала версии `2023.10.03`.
> - Задается дата завершения версии `2024.06.03`.
>
> ```
> POST /v2/queues/TEST/versions HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
>{
>   "queue": "TESTQUEUE",
>   "name": "version 0.1",
>   "description": "Test version 1",
>   "startDate": "2023-10-03",
>   "dueDate": "2024-06-03"
>}
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    ```json
    [
        {
            "self": "https://{{ host }}/v2/versions/1",
            "id": 1,
            "version": 1,
            "queue": {
                "self": "https://{{ host }}/v2/queues/TESTQUEUE",
                "id": "6",
                "key": "TESTQUEUE",
                "display": "Test Queue"
            },
            "name": "version 0.1",
            "description": "Test version 1",
            "startDate": "2023-10-03",
            "dueDate": "2024-06-03",
            "released": false,
            "archived": false
        }
    ]
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Ссылка на объект версии. | Строка
    id | Идентификатор версии. | Число
    version | Номер версии. | Число
    [queue](#queue) | Объект с информацией об очереди. | Объект
    name | Название версии. | Строка
    description | Текстовое описание версии. | Строка
    startDate | Дата начала версии. | Строка
    dueDate | Дата завершения версии. | Строка
    released | Признак выпущенной версии. | Логический
    archived | Признак архивной версии. | Логический

    **Поля объекта** `queue` {#queue}
    
    {% include [queue](../../../_includes/tracker/api/queue.md) %}

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}