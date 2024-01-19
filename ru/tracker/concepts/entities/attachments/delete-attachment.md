---
sourcePath: ru/tracker/api-ref/concepts/entities/attachments/delete-attachment.md
---
# Удалить файл

Запрос позволяет удалить прикрепленный файл.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../../access.md).

Чтобы удалить файл, используйте HTTP-запрос с методом `DELETE`.

```json
DELETE /{{ ver }}/entities/<entityType>/<id>/attachments/<attachmentId>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity-attach.md) %}

> Пример: Удалить файл, прикрепленный к сущности (проекту).
>
> - Используется HTTP-метод DELETE.
>
> ```
> DELETE /v2/entities/project/6586d6fee2b9ef74********/attachments/123
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-204](../../../../_includes/tracker/api/answer-204.md) %}

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

  {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}
  
  {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}
  
  {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
