---
sourcePath: ru/tracker/api-ref/concepts/entities/links/get-links.md
---
# Получить связи сущности

Запрос позволяет получить информацию о связях [сущности](../about-entities.md) с другими сущностями.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../../access.md).

Для получения связей сущности используйте HTTP-запрос с методом `GET`.

```json
GET /{{ ver }}/entities/<entityType>/<id>/links
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity.md) %}

{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
[fields](../about-entities.md#query-params) | Дополнительные поля сущности, которые будут включены в ответ. | Строка

{% endcut %}

> Пример: Получить связи между сущностями
>
> - Используется HTTP-метод GET.
>
> ```
> GET /v2/entities/project/65a26adc46b9746d********/links?fields=id,summary
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-200](../../../../_includes/tracker/api/answer-200.md) %}

  Тело ответа содержит информацию о связях сущности в формате JSON.

  ```json
  [
      {
          "type": "is dependent by", 
          "linkFieldValues": {
              "summary": "Первый проект", 
              "id": "6582874de6db7f5f********"
          }
      }, 
      {
          "type": "relates", 
          "linkFieldValues": {
              "summary": "Второй проект",
              "id": "65868f3fe2b9ef74********"
          }
      }
  ]
  ```

  {% cut "Параметры ответа" %}

  Параметр | Описание | Тип данных
  -------- | -------- | ----------
  type | Тип связи: <ul><li>`is dependent by` — текущая сущность является блокером;</li><li>`depends on` — текущая сущность зависит от связываемой.</li><li>`relates` — простая связь.</li></ul> | Строка
  linkFieldValues | Список полей и их значений у связанных сущностей. Список полей указывается в параметре `fields` запроса. | Строка

  {% endcut %}

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

  {% include [error-400](../../../../_includes/tracker/api/answer-error-400.md) %}
  
  {% include [error-404](../../../../_includes/tracker/api/answer-error-404.md) %}
  
  {% include [error-422](../../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}
