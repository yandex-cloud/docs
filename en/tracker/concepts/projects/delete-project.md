---
sourcePath: ru/tracker/api-ref/concepts/projects/delete-project.md
---
# Удалить проект

Запрос позволяет удалить [проект](../../manager/project-new.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы удалить проект, используйте HTTP-запрос с методом `DELETE`.

```
DELETE /{{ ver }}/projects/<project-id>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<project-id> | Идентификатор проекта | Число

{% endcut %}


## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}
    
    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}
    
    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}
    
{% endlist %}