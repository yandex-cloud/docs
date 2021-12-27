---
sourcePath: ru/tracker/api-ref/concepts/issues/get-comments.md
---
# Получить комментарии к задаче

Запрос позволяет получить список комментариев к задаче.

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

> Запрос комментариев одной задачи:
> 
> Используется HTTP-метод GET.
>  
> ```
> GET /v2/issues/JUNE-3/comments HTTP/1.1
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
            "self": "{{ host }}/v2/issues/JUNE-2/comments/9849018",
            "id": 9849018,
            "longId" : "5fa15a24ac894475dd14ff07",
            "text": "Комментарий",
            "createdBy": {
                "self": "{{ host }}/v2/users/1120000000049224",
                "id": "<id сотрудника>",
                "display": "<отображаемое имя сотрудника>"
            },
            "updatedBy": {
                "self": "{{ host }}/v2/users/1120000000049224",
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

