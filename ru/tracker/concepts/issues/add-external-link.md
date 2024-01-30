---
sourcePath: ru/tracker/api-ref/concepts/issues/add-external-link.md
---
# Добавить внешнюю связь

Запрос позволяет создать связь для работы с [объектом внешнего приложения](../../external-links.md).

## Формат запроса {#rec-format}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы создать внешнюю связь, используйте HTTP-запрос с методом `POST`. 

```
POST /{{ ver }}/issues/<ключ_или_идентификатор_задачи>/remotelinks?backlink=true
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
    "relationship": "RELATES",
    "key": "<ключ_объекта>",
    "origin": "<идентификатор_приложения>"
}
```


{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}  

{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
backlink |Значение `true` следует указать, чтобы при добавлении связи выполнить [запрос из {{ tracker-name }} для создания дублирующей связи во внешнем приложении](../../ext-app-setup.md#create). | Логический

{% endcut %}

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
relationship |Тип связи. Рекомендуем использовать значение `RELATES` — связан. | Строка
key |   Ключ объекта во внешнем приложении. | Строка
origin | Идентификатор приложения, с объектом которого нужно создать связь. | Строка

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}
  
  Тело запроса содержит информацию о созданной связи в формате JSON.

   ```json
    {
        "self": "https://{{ host }}/{{ ver }}/issues/<ключ_или_идентификатор_задачи>/remotelinks/51******", 
        "id": 51******,
        "type": {
            "self": "https://{{ host }}/{{ ver }}/linktypes/relates",
            "id": "relates",
            "inward": "Связана",
            "outward": "Связана"
        },
        "direction": "outward",
        "object": {
            "self": "https://{{ host }}/{{ ver }}/applications/ru.yandex.bitbucket/objects/13570010********",
            "id": "13570010********",
            "key": "TEST-17",
            "application": {
                "self": "https://{{ host }}/{{ ver }}/applications/25811000********",
                "id": "25811000********",
                "type": "app",
                "name": "test-app"
            }
        },
        "createdBy": {
            "self": "https://{{ host }}/{{ ver }}/users/11********",
            "id": "11********",
            "display": "display-user-name"
        },
        "updatedBy": {
            "self": "https://{{ host }}/{{ ver }}/users/11********",
            "id": "11********",
            "display": "display-user-name"
        },
        "createdAt": "2021-07-19T06:18:09.327+0000",
        "updatedAt": "2021-07-19T06:18:09.327+0000"
    }

    ```
   
    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Адрес ресурса API, который содержит информацию о внешней связи. | Строка
    id | Идентификатор связи. | Строка
    [type](#type) | Блок с информацией о типе связи. | Объект
    direction {#direction} | «Направление» связи. Параметр релевантен для несимметричных типов связей, например «Родительская задача» — «Подзадача». Возможны следующие значения:<ul><li>`outward` — задача, указанная в запросе, является основной для объекта.</li><li>`inward` — объект является основным для задачи, указанной в запросе.</li></ul> | Строка
    [object](#object){#object-param} | Блок с информацией об объекте внешнего приложения. | Объект
    [createdBy](#createdBy) | Блок с информацией о создателе связи. | Объект
    [updatedBy](#updatedBy) | Блок с информацией о последнем сотруднике, изменявшим связь. | Объект
    createdAt | Дата и время создания связи. | Строка
    updatedAt | Дата и время последнего обновления связи. | Строка

  
    **Поля объекта** `type` {#type}
  
    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Адрес ресурса API, который содержит информацию о типе связи. | Строка
    id | Идентификатор типа связи. | Строка
    inward | Название типа связи в зависимости от [«направления»](#direction). | Строка
    outward | Название типа связи в зависимости от [«направления»](#direction). | Строка
  
  
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

