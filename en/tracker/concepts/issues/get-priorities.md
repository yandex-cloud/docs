---
sourcePath: ru/tracker/api-ref/concepts/issues/get-priorities.md
---
# Получить приоритеты

Запрос позволяет получить список приоритетов для задачи.

## Формат запроса {#section_rnm_x4j_p1b}

Перед выполнением запроса [получите доступ к API](../access.md).

Для получения списка приоритетов используйте HTTP-запрос с методом `GET`:

```json
GET /v2/priorities
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
localized |  Признак наличия переводов в ответе. Допустимые значения: <ul><li>`true` — В ответе содержатся описания приоритетов только на языке пользователя. Значение по умолчанию.</li><li>`false` — В ответе содержатся описания приоритетов на всех языках.</li></ul> | Логический

{% endcut %}

> Запрос приоритетов:
> 
> - Используется HTTP-метод GET.
> 
> ```
> GET /v2/priorities?localized=false HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#section_xc3_53j_p1b}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %} 

    Тело ответа содержит результаты в формате JSON.
    
    ```json
    [
        {
            "self": "{{ host }}/v2/priorities/5",
            "id": 5,
            "key": "blocker",
            "version": 1341632717561,
            "name": "Блокер",
            "order": 5
        },
        ...
    ]  
    ```
    
    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Адрес ресурса API, который содержит информацию о приоритете. | Строка
    id | Идентификатор приоритета. | Число
    key | Ключ приоритета. | Строка
    version | Версия приоритета. | Число
    name | Отображаемое название приоритета. При переданном в запросе `localized=false` данный параметр будет содержать дубликаты названия на других языках. | Строка
    order | Вес приоритета. Параметр влияет на порядок отображения приоритета в интерфейсе. | Число

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

{% endlist %}
