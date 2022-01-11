---
sourcePath: ru/tracker/api-ref/concepts/issues/delete-worklog.md
---
# Удалить запись о затраченном времени

Запрос позволяет удалить запись о времени, затраченном на выполнение задачи.

## Формат запроса {#section_fkp_5ng_jfb}

Чтобы удалить записи о затраченном на задачу времени, используйте HTTP-запрос с методом `DELETE`:

```json
DELETE /{{ ver }}/issues/<issue-id>/worklog/<worklog-id>
Host: {{ host }}
Authorization: OAuth <токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
--- | --- | ---
\<issues-id\> | Идентификатор или ключ задачи. | Строка
\<worklog-id\> | Идентификатор записи о затраченном времени. | Строка

{% endcut %}

## Формат ответа {#section_wlq_d5g_jfb}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}
    
    Тело ответа отсутствует.

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, ответное сообщение содержит информацию о возникших ошибках:

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}
