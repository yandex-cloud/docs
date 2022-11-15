---
sourcePath: ru/tracker/api-ref/concepts/issues/get-external-links.md
---
# Получить список внешних связей задачи

Запрос позволяет получить список связей задачи с [объектами внешних приложений](../../external-links.md).

## Формат запроса {#rec-format}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить список внешних связей задачи, используйте HTTP-запрос с методом `GET`. 

```
GET /{{ ver }}/issues/<issue-id>/remotelinks
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %} 	

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    Тело запроса содержит информацию о внешних связях задачи в формате JSON.

    ```json
   [ 

     {
        "self": "{{ host }}/{{ ver }}/issues/<issue-id>/remotelinks/51299313",
        "id": 51299313,
        "type": {
            "self": "{{ host }}/{{ ver }}/linktypes/relates",
            "id": "relates",
            "inward": "Связана",
            "outward": "Связана"
        },
        "direction": "outward",
        "object": {
            "self": "{{ host }}/{{ ver }}/applications/ru.yandex.bitbucket/objects/<object-id>",
            "id": "<object-id>",
            "key": "<object-key>",
            "application": {
                "self": "{{ host }}/{{ ver }}/applications/<application-id>",
                "id": "<application-id>",
                "type": "<application-type>",
                "name": "<application-name>"
            }
        },
        "createdBy": {
            "self": "{{ host }}/{{ ver }}/users/1120000000044110",
            "id": "user-name",
            "display": "display-user-name"
        },
        "updatedBy": {
            "self": "{{ host }}/{{ ver }}/users/1120000000044110",
            "id": "user-name",
            "display": "display-user-name"
        },
        "createdAt": "2021-07-14T18:59:54.552+0000",
        "updatedAt": "2021-07-14T18:59:54.552+0000"
     },
     ...
   ] 
    ```
   
  {% cut "Параметры ответа" %}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию о внешней связи.| Строка
  id | Идентификатор связи. | Строка
  [type](#type) | Блок с информацией о типе связи. | Объект
  direction {#direction} | <q>Направление</q> связи. Параметр релевантен для несимметричных типов связей, например <q>Родительская задача</q> — <q>Подзадача</q>. Возможны следующие значения:<ul><li>`outward` — условное направление связи от задачи к связанному объекту.</li><li>`inward` — условное направление связи от связанного объекта к задаче.</li></ul> | Строка
  [object](#object){#object-param} | Блок с информацией об объекте внешнего приложения. | Объект
  [createdBy](#createdBy) | Блок с информацией о создателе связи. | Объект
  [updatedBy](#updatedBy) | Блок с информацией о последнем сотруднике, изменявшим связь.  | Объект
  createdAt | Дата и время создания связи. | Строка
  updatedAt | Дата и время последнего обновления связи. | Строка

  
  **Поля объекта** `type` {#type}
  
   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Адрес ресурса API, который содержит информацию о типе связи. | Строка
   id | Идентификатор типа связи. | Строка
   inward | Название типа связи в зависимости от [<q>направления</q>](#direction). | Строка
   outward | Название типа связи в зависимости от [<q>направления</q>](#direction). | Строка
  
  **Поля объекта** `object` {#object}
 
  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию об объекте внешнего приложения. | Строка
  id | Идентификатор объекта. | Строка
  key | Ключ объекта. | Строка
  [application](#application) | Блок с информацией о внешнем приложении. | Объект

  **Поля объекта** `application` {#application}

  Параметр | Описание | Тип данных
  ----- | ----- | -----
  self | Адрес ресурса API, который содержит информацию о внешнем приложении. | Строка
  id | Идентификатор приложения. | Строка
  type | Тип приложения. | Строка
  name | Отображаемое название приложения. | Строка


  **Поля объекта** `createdBy` {#createdBy}

  {% include [user](../../../_includes/tracker/api/user.md) %}
  

  **Поля объекта** `updatedBy` {#updatedBy}
  
  {% include [user](../../../_includes/tracker/api/user.md) %}

  {% endcut %}   

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

