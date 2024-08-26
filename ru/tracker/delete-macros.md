---
sourcePath: ru/tracker/api-ref/delete-macros.md
---
# Удалить макрос

Запрос позволяет удалить макрос.

## Формат запроса {#section_nnm_hdt_sfb}

Перед выполнением запроса [получите доступ к API](concepts/access.md).

Чтобы удалить макрос, используйте HTTP-запрос с методом `DELETE`:

```http
DELETE /{{ ver }}/queues/<ключ_или_идентификатор_очереди>/macros/<идентификатор_макроса>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<ключ_или_идентификатор_очереди> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка
\<идентификатор_макроса> | Идентификатор макроса. | Строка

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