# Удалить внешнюю связь

Запрос позволяет удалить связь задачи с [объектом внешнего приложения](../../external-links.md).

## Формат запроса {#rec-format}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы удалить внешнюю связь, используйте HTTP-запрос с методом `DELETE`. 

```
DELETE /{{ ver }}/issues/<issue-id>/remotelinks/<external-link-id>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}


{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<issue-id> | Идентификатор или ключ текущей задачи. | Строка
\<external-link-id> | [Идентификатор внешней связи](get-external-links.md). | Строка

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

