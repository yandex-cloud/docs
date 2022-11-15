---
sourcePath: ru/tracker/api-ref/concepts/issues/delete-comment.md
---
# Удалить комментарий

Запрос позволяет удалить комментарий к задаче.

## Формат запроса {#section_rnm_x4j_p1b}

Чтобы удалить комментарий, используйте HTTP-запрос с методом `DELETE`:

```
DELETE /{{ ver }}/issues/<issue-id>/comments/<comment-id>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<issue-id> | Идентификатор или ключ текущей задачи. | Строка
\<comment-id> | [Уникальный идентификатор комментария](get-comments.md#section_xc3_53j_p1b) в числовом формате (id) или формате строки (longId). | Строка или число

{% endcut %} 

> Запрос на удаление комментария, прикрепленного к задаче `JUNE-2`:
> 
> - Используется HTTP-метод DELETE.
>  
> ```
> DELETE /v2/issues/JUNE-2/comments/53a170e8e4b07a4c3358d60a
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#section_xc3_53j_p1b}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}
    
    Тело ответа отсутствует.

- Запрос выполнен с ошибкой

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}