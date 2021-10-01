# Удалить тег из очереди

Запрос позволяет удалить тег из очереди.

{% note warning %}

Тег нельзя удалить, если он используется хотя бы в одной задаче очереди.

{% endnote %}

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы удалить тег, используйте HTTP-запрос с методом `POST`. Параметры запроса передаются в его теле в формате JSON.

```
POST /{{ ver }}/queues/<queue-id>/tags/_remove
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
    "tag": "<имя тега>"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<queue-id\> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка или число

{% endcut %}

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Значение | Тип данных
----- | ----- | -----
tag | Имя тега | Строка

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}
    
    Тело ответа отсутствует.

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}