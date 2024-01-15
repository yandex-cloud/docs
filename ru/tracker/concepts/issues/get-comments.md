---
sourcePath: ru/tracker/api-ref/concepts/issues/get-comments.md
---
# Получить комментарии к задаче

Запрос позволяет получить список комментариев к задаче. 

По умолчанию запрос возвращает только первую страницу, на которой отображается 50 комментариев. Если комментариев больше 50, используйте [постраничное отображение результатов](#pagination).

## Формат запроса {#section_rnm_x4j_p1b}

Перед выполнением запроса [получите доступ к API](../access.md).

Для получения комментариев используйте HTTP-запрос с методом `GET`:

```json
GET /{{ ver }}/issues/<issue-id>/comments
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %} 

{% cut "Параметры запроса" %}

**Дополнительные параметры**
Параметр | Описание | Тип данных
----- | ----- | -----
expand |  Дополнительные поля, которые будут включены в ответ: <ul><li>`attachments` — вложения;</li><li>`html` — HTML-разметка комментария;</li><li>`all` — все дополнительные поля.</li></ul> | Строка

{% endcut %}

> Запрос комментариев одной задачи:
> 
> Используется HTTP-метод GET.
>  
> ```
> GET /v2/issues/JUNE-3/comments?expand=all HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
> ```

## Формат ответа {#section_xc3_53j_p1b}

{% list tabs %}

- Запрос выполнен успешно


    {% include [answer-200](../../../_includes/tracker/api/answer-200.md %}

    Тело ответа содержит JSON-массив с информацией о комментариях:

    ```json
    [
        {
            "self": "https://{{ host }}/v2/issues/JUNE-2/comments/9849018",
            "id": 9849018,
            "longId" : "5fa15a24ac894475dd14ff07",
            "text": "Комментарий **номер один.**",
            "textHtml": "<p>Комментарий <strong>номер один.</strong></p>\n",
            "attachments": [{ "self": "https://{{ host }}/v2/issues/JUNE-3/attachments/1", "id": "1", "display": "Untitled.png" }],
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
            "createdAt": "2017-06-11T05:11:12.347+0000",
            "updatedAt": "2017-06-11T05:11:12.347+0000",
            "version": 1,
            "type" : "standard",
            "transport" : "internal"   
        },
        ...
    ]
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Ссылка на объект комментария | Строка
    id | Идентификатор комментария | Число
    longId | Идентификатор комментария в виде строки | Строка
    text | Текст комментария. | Строка
    textHtml | HTML-разметка комментария. | Строка
    attachments | Вложения. | Строка
    [createdBy](#object-fields-createdBy) | Объект с информацией о создателе комментария. | Объект
    [updatedBy](#object-fields-updatedBy) | Объект с информацией о сотруднике, внесшем последнее изменение в комментарий. | Объект
    createdAt | Дата и время создания комментария в формате:<br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ``` | Строка
    updatedAt | Дата и время обновления комментария.<br/>``` YYYY-MM-DDThh:mm:ss.sss±hhmm ``` | Строка
    version | Версия комментария. Каждое изменение комментария увеличивает номер версии. | Число
    type | Тип комментария:<ul><li>`standart` — отправлен через интерфейс {{ tracker-name }};</li><li>`incoming` — создан из входящего письма;</li><li>`outcoming` — создан из исходящего письма.</li></ul> | Строка
    transport | Способ добавления комментария:<ul><li>`internal` — через интерфейс {{ tracker-name }};</li><li>`email` — через письмо.</li></ul> | Строка

    **Поля объекта** `createdBy` {#object-fields-createdBy}

    {% include [user](../../../_includes/tracker/api/user.md) %}
       
    **Поля объекта** `updatedBy` {#object-fields-updatedBy}

    {% include [user](../../../_includes/tracker/api/user.md) %}

    {% endcut %}  

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

## Постраничное отображение комментариев {#pagination}

Для постраничного отображения результатов используйте в строке запроса дополнительные параметры:

```json
GET /{{ ver }}/issues/<issue-id>/comments?perPage=20&id=123
```

где: 

* `perPage` — количество комментариев на странице; 

* `id` — значение параметра `id` у комментария, после которого начнется запрашиваемая страница. 

Ссылки на первую и следующую страницы указаны в заголовке ответа **Link**.

О постраничном отображении результатов читайте также в разделе [Общий формат запросов](../../common-format.md#displaying-results).