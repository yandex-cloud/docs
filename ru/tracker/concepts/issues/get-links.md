---
sourcePath: ru/tracker/api-ref/concepts/issues/get-links.md
---
# Получить связи задачи

Запрос позволяет получить информацию о связях задачи. Задача выбирается при указании идентификатора или ключа задачи.

## Формат запроса {#section_rnm_x4j_p1b}

Перед выполнением запроса [получите доступ к API](../access.md).

Для получения списка связей задачи используйте HTTP-запрос с методом `GET`:

```json
GET /{{ ver }}/issues/<issue-id>/links
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}  

> Запрос связей задачи:
> 
> - Используется HTTP-метод GET.
> 
> ```
> GET /v2/issues/JUNE-2/links HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#section_xc3_53j_p1b}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    Тело ответа содержит результаты в формате JSON.

    ```json
    [
        {
            "self": "https://{{ host }}/v2/issues/JUNE-2/links/4709605",
            "id": 4709605,
            "type": {
                "self": "https://{{ host }}/v2/linktypes/subtask",
                "id": "subtask",
                "inward": "Подзадача",
                "outward": "Родительская задача"
            },
            "direction": "outward",
            "object": {
                "self": "https://{{ host }}/v2/issues/TREK-9844",
                "id": "593cd211ef7e8a332414f2a7",
                "key": "TREK-9844",
                "display": "subtask"
            },
            "createdBy": {
                "self": "https://{{ host }}/v2/users/1120000000049224",
                "id": "<id сотрудника>",
                "display": "<отображаемое имя сотрудника>"
            },
            "updatedBy": {
                "self": "https://{{ host }}/v2/users/1120000000049224",
                "id": "<id сотрудника>",
                "display": "<отображаемое имя сотрудника>"
            },
            "createdAt": "2017-06-11T05:16:01.421+0000",
            "updatedAt": "2017-06-11T05:16:01.421+0000",
            "assignee": {
                "self": "https://{{ host }}/v2/users/1120000000049224",
                "id": "<id сотрудника>",
                "display": "<отображаемое имя сотрудника>"
            },
            "status": {
                "self": "https://{{ host }}/v2/statuses/1",
                "id": "1",
                "key": "open",
                "display": "Открыт"
            }
        },
        ...
    ]
    ```

    #### Параметры ответа {#answer-params}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Адрес ресурса API, который содержит информацию о связи. | Строка
    id | Идентификатор связи. | Число
    [type](#type) | Блок с информацией о типе связи. | Объект
    direction | Тип связи задачи, указанной в запросе, по отношению к задаче в поле [object](#object-param). Возможны следующие значения:<ul><li>`outward` — задача, указанная в запросе, является основной для задачи в поле [object](#object-param).</li><li>`inward` — задача в поле [object](#object-param) является основной для задачи, указанной в запросе.</li></ul> | Строка
    [object](#object-block) {#object-param} | Блок с информацией о связанной задаче. | Объект
    [createdBy](#created-by) | Блок с информацией о создателе связи. | Объект
    [updatedBy](#updated-by) | Блок с информацией о последнем изменившем связанную задачу пользователе. | Объект
    createdAt | Дата и время создания связи. | Строка
    updatedAt | Дата и время изменения связи. | Строка
    [assignee](#assignee) | Исполнитель связанной задачи. | Объект
    [status](#status) | Статус связанной задачи. | Объект

    **Поля объекта** `type` {#type}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Ссылка на тип связи. | Строка
    id | Идентификатор типа связи. | Строка
    inward | Название типа связи задачи в поле [object](#object-param) по отношению к задаче, указанной в запросе. | Строка
    outward | Название типа связи задачи, указанной в запросе, по отношению к задаче в поле [object](#object-param). | Строка

    **Поля объекта** `object` {#object-block}

    {% include [issue](../../../_includes/tracker/api/issue.md) %}

    **Поля объекта** `createdBy` {#created-by}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Поля объекта** `updatedBy` {#updated-by}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Поля объекта** `assignee` {#assignee}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Поля объекта** `status` {#status}

    {% include [status](../../../_includes/tracker/api/status.md) %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}