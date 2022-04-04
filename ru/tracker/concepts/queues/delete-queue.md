---
sourcePath: ru/tracker/api-ref/concepts/queues/delete-queue.md
---
# Удалить очередь

Запрос позволяет удалить очередь.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы удалить очередь, используйте HTTP-запрос с методом `DELETE`.

```
DELETE /{{ ver }}/queues/<queue-id>
Host: {{ host }}
Authorization: OAuth <токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<queue-id\> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка или число

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %} 
  
  Тело ответа отсутствует.

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}