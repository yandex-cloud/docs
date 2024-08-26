---
sourcePath: ru/tracker/api-ref/concepts/issues/get-attachment.md
---
# Скачать файл

Запрос позволяет скачать прикрепленный к задаче файл.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы скачать файл, используйте HTTP-запрос с методом `GET`.

```http
GET /{{ ver }}/issues/<ключ_или_идентификатор_задачи>/attachments/<идентификатор_файла>/<имя_файла>
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
\<имя_файла\> | Имя файла | Строка

{% endcut %}

> Пример: Скачать файл, прикрепленный к задаче `JUNE-2`.
>
> - Используется HTTP-метод `GET`.
>
> ```
> GET /v2/issues/JUNE-2/attachments/4159/attachment.txt HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}