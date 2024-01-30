---
sourcePath: ru/tracker/api-ref/concepts/issues/delete-attachment.md
---
# Удалить файл

Запрос позволяет удалить прикрепленный файл.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы удалить файл, используйте HTTP-запрос с методом `DELETE`.

```
DELETE /{{ ver }}/issues/<ключ_или_идентификатор_задачи>/attachments/<идентификатор_файла>/
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<ключ_или_идентификатор_задачи\> | Идентификатор или ключ задачи | Строка
\<идентификатор_файла\> | Уникальный идентификатор файла | Строка или число

{% endcut %}

> Пример: Удалить файл, прикрепленный к задаче `JUNE-2`.
>
> - Используется HTTP-метод `DELETE`.
>
> ```
> DELETE /v2/issues/JUNE-2/attachments/4159/ HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}

    Тело ответа отсутствует.

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}