---
sourcePath: ru/tracker/api-ref/concepts/entities/links/add-links.md
---
# Связать сущности

Запрос позволяет создать связи между несколькими [сущностями](../about-entities.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../../access.md).

Для создания связей используйте HTTP-запрос с методом `POST`. Информация о связях передается в его теле в формате JSON. Связь создается между текущей сущностью (указывается в `<идентификатор_сущности>` запроса) и сущностями, идентификаторы которых указаны в полях `entity` тела запроса.

```json
POST /{{ ver }}/entities/<тип_сущности>/<идентификатор_сущности>/links
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
  "relationship": "<тип_связи>",
  "entity": "<идентификатор_связываемой_сущности>"
}
```

{% include [headings](../../../../_includes/tracker/api/headings.md) %}

{% include [resource](../../../../_includes/tracker/api/resource-entity.md) %}

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
relationship | Тип связи: <ul><li>`is dependent by` — текущая сущность является блокером;</li><li>`depends on` — текущая сущность зависит от связываемой;</li><li>`relates` — простая связь.</li></ul>  | Строка
entity | Идентификатор сущности, с которой устанавливается связь. Вместо него в запросе можно использовать идентификатор проекта или портфеля — значение поля `shortId`. | Строка

{% endcut %}

> Пример: Создать связь между сущностями
>
> - Используется HTTP-метод POST.
>
> ```
> POST /v2/entities/project/<идентификатор_проекта>/links
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> 
> [
>   {
>      "relationship":"is dependent by",
>      "entity": "6582874de6db7f5f********"
>   },
>   {
>      "relationship":"relates",
>      "entity": "65868f3fe2b9ef74********"
>   }
> ]
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
