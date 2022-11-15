---
sourcePath: ru/tracker/api-ref/concepts/issues/get-attachment-preview.md
---
# Скачать миниатюру

Запрос позволяет получить миниатюру графического файла, прикрепленного к задаче.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить миниатюру, используйте HTTP-запрос с методом `GET`.

```
GET /{{ ver }}/issues/<issue-id>/thumbnails/<attachment-id>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<issue-id\> | Идентификатор или ключ задачи | Строка
\<attachment-id\> | Уникальный идентификатор прикрепленного файла | Строка или число

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит миниатюру графического файла.

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}