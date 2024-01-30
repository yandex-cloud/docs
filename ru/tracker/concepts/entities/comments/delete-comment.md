---
sourcePath: ru/tracker/api-ref/concepts/entities/comments/delete-comment.md
---
# Удалить комментарий

Запрос позволяет удалить комментарий [сущности](../about-entities.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../../access.md).

Для удаления комментария используйте HTTP-запрос с методом `DELETE`.

```json
DELETE /{{ ver }}/entities/<тип_сущности>/<идентификатор_сущности>/comments/<идентификатор_комментария>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity-comment.md) %}

{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
notify | Уведомлять пользователей, которые указаны в полях **Автор**, **Ответственный**, **Участники**, **Заказчики** и **Наблюдатели**. Значение по умолчанию — `true`. | Логический
notifyAuthor | Уведомлять автора изменений. Значение по умолчанию — `false`. | Логический

{% endcut %}

> Пример: Удалить комментарий
>
> - Используется HTTP-метод DELETE.
>
> ```
> DELETE /v2/entities/project/<идентификатор_проекта>/comments/16
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
