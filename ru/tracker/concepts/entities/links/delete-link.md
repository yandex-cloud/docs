---
sourcePath: ru/tracker/api-ref/concepts/entities/links/delete-link.md
---
# Удалить связь сущностей

Запрос позволяет удалить связь между двумя [сущностями](../about-entities.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../../access.md).

Для удаления связи используйте HTTP-запрос с методом `DELETE`. Связь удаляется между текущей сущностью (идентификатор указывается в `<id>` запроса) и сущностью, идентификатор которой указан в параметре `right` запроса.

```json
DELETE /{{ ver }}/entities/<entityType>/<id>/links
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity.md) %}

{% cut "Параметры запроса" %}

**Обязательные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
right | Идентификатор сущности, с которой удаляется связь. | Строка

{% endcut %}

> Пример: Удалить связь между сущностями
>
> - Используется HTTP-метод DELETE.
>
> ```
> DELETE /v2/entities/project/65a26adc46b9746d********/links?right=6582874de6db7f5f********
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

  {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}
  
  {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}
  
  {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
