---
sourcePath: ru/tracker/api-ref/concepts/issues/delete-link-issue.md
---
# Удалить связь с задачей

Запрос позволяет удалить связь задачи с другой задачей.

## Формат запроса {#rec-format}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы удалить связь текущей задачи с другой задачей, используйте HTTP-запрос с методом `DELETE`. 

```
DELETE /{{ ver }}/issues/<ключ_или_идентификатор_задачи>/links/<идентификатор_связи>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}


{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<ключ_или_идентификатор_задачи> | Идентификатор или ключ текущей задачи. | Строка
\<идентификатор_связи> | [Идентификатор связи с другой задачей](get-links.md). | Строка

{% endcut %}   
	

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-204](../../../_includes/tracker/api/answer-204.md) %}

  Тело ответа отсутствует.

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

   {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}