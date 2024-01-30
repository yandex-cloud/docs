---
sourcePath: ru/tracker/api-ref/delete-board.md
---
# Удалить доску

Запрос позволяет удалить доску задач.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Чтобы удалить доску, используйте HTTP-запрос с методом `DELETE`.

```
DELETE /{{ ver }}/boards/<идентификатор_доски>
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

    {% include [answer-204](../_includes/tracker/api/answer-204.md) %}
    
    Тело ответа отсутствует.

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
