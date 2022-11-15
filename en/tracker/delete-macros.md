---
sourcePath: ru/tracker/api-ref/delete-macros.md
---
# Удалить макрос

Запрос позволяет удалить макрос.

## Формат запроса {#section_nnm_hdt_sfb}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Чтобы удалить макрос, используйте HTTP-запрос с методом `DELETE`:

```
DELETE /{{ ver }}/queues/<queue-id>/macros/<macros-id>
Host: {{ host }}
Authorization: OAuth <токен>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<queue-id> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка
\<macros-id> | Идентификатор макроса. | Строка

{% endcut %} 

## Формат ответа {#section_p1j_lgt_sfb}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-204](../_includes/tracker/api/answer-204.md) %}
  
  Тело ответа отсутствует.

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-403](../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-500](../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../_includes/tracker/api/answer-error-503.md) %}
     
{% endlist %}