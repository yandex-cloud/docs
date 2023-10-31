---
sourcePath: ru/tracker/api-ref/concepts/issues/get-issue.md
---
# Получить параметры задачи

Запрос позволяет получить информацию о задаче.

## Формат запроса {#section_rnm_x4j_p1b}

Перед выполнением запроса [получите доступ к API](../access.md).

Для получения задачи используйте HTTP-запрос с методом `GET`:

```json
GET /v2/issues/<issue-id>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}  

{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
expand |  Дополнительные поля, которые будут включены в ответ: <ul><li>`transitions` — переходы по жизненному циклу;</li><li>`attachments` — вложения.</li></ul> | Строка

{% endcut %}

> Запрос одной задачи с указанием необходимых полей:
> 
> - Используется HTTP-метод GET.
> - В ответе включено отображение приложений.
> 
> ```
> GET /v2/issues/JUNE-3?expand=attachments HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит результаты в формате JSON.

    {% include [answer-issue](../../../_includes/tracker/api/answer-issue.md) %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}