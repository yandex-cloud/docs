---
sourcePath: ru/tracker/api-ref/concepts/entities/delete-entity.md
---
# Удалить сущность

Запрос позволяет удалить сущность — [проект](../../manager/project-new.md) или [портфель проектов](../../manager/portfolio.md).

Запрос представляет унифицированный метод удаления проектов и портфелей, расширяющий возможности API [удаления проекта](../projects/delete-project.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы удалить сущность, используйте HTTP-запрос с методом `DELETE`.

```
DELETE /{{ ver }}//entities/<entityType>/<entityId>?withBoard=true
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<entityType> | Идентификатор сущности:<ul><li>project — проект;</li><li>portfolio — портфель.</li></ul>| Строка
\<entityId> | Идентификатор сущности. | Строка

{% note warning %}

Идентификатор сущности не совпадает с идентификатором проекта или портфеля.

{% endnote %}  

{% endcut %}

{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
withBoard | Удалить вместе с доской. | Логический

{% endcut %}

> Пример: Удалить проект
> 
> - Используется HTTP-метод DELETE.
> - Вместе с проектом удаляется доска задач.
>
> ```
> GET /v2/entities/project/655f328da834c763********?withBoard=true HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> 
> ```

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