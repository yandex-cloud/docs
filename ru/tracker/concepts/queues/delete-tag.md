---
sourcePath: ru/tracker/api-ref/concepts/queues/delete-tag.md
---
# Удалить тег из очереди

Запрос позволяет удалить тег из очереди.

{% note warning %}

Удалить тег может только владелец очереди или [администратор](../../role-model.md#admin). Перед удалением убедитесь, что тег не используется ни в одной из задач очереди.

{% endnote %}


## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы удалить тег, используйте HTTP-запрос с методом `POST`. Параметры запроса передаются в его теле в формате JSON.

```
POST /{{ ver }}/queues/<ключ_или_идентификатор_очереди>/tags/_remove
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
    "tag": "<имя_тега>"
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<ключ_или_идентификатор_очереди\> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка или число

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
