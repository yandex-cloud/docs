# Массовое редактирование задач

Запрос позволяет изменить параметры нескольких задач одновременно.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы изменить задачи, используйте HTTP-запрос с методом `POST`. Параметры запроса передаются в его теле в формате JSON.

```json
POST /{{ ver }}/bulkchange/_update
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
  "issues": ["TEST-1", "TEST-2", "TEST-3"],
  "values": {
    "<параметр>": "<значение параметра>",
    "<параметр>": "<значение параметра>"
  }
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Параметры запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
notify | Признак уведомления об изменении задачи:<ul><li>`true` — пользователи, указанные в полях задачи, получат уведомления;</li><li>`false` — (по умолчанию) пользователи не получат уведомления.</li></ul> | Логический

{% endcut %}

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Описание | Тип данных
-------- | -------- | ----------
issues | Идентификаторы задач, которые необходимо отредактировать. | Строка
values | Параметры задач, которые будут изменены. Используйте параметры, доступные при [редактировании задачи](../issues/patch-issue.md#req-get-params). | Строка

{% endcut %}

> Пример: Изменить задачи.
>
>- Используется HTTP-метод POST.
>- Тип задач <q>TEST-1</q>, <q>TEST-2</q>, <q>TEST-3</q> меняется на <q>Ошибка</q>.
>
>```json
>POST /{{ ver }}/bulkchange/_update
>Host: {{ host }}
>Authorization: OAuth <OAuth-токен>
>{{ org-id }}
>{
>  "issues": ["TEST-1","TEST-2","TEST-3"],
>  "values": {
>    "type": {"name": "Ошибка"}
>  }
>}
>```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-201](../../../_includes/tracker/api/answer-201.md) %}

    Тело ответа содержит информацию об операции массового редактирования в формате JSON.

    ```json
    {
        "id": "1ab23cd4e56789012fg345h6",
        "self": "{{ host }}/v2/bulkchange/1ab23cd4e56789012fg345h6",
        "createdBy": {
            "self": "{{ host }}/v2/users/1234567890",
            "id": "1234567890",
            "display": "Имя Фамилия"
        },
        "createdAt": "2020-12-15T11:52:53.665+0000",
        "status": "CREATED",
        "statusText": "Операция массового редактирования задач создана.",
        "executionChunkPercent": 0,
        "executionIssuePercent": 0
    }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    id | Идентификатор операции массового редактирования. | Строка
    self | Адрес ресурса API, который содержит информацию о массовом редактировании. | Строка
    [createdBy](#createdBy) | Объект с информацией об инициаторе массового редактирования. | Объект
    createdAt | Дата и время создания операции массового редактирования. | Строка
    status | Статус операции массового редактирования. | Строка
    statusText | Описание статуса операции массового редактирования. | Строка
    executionChunkPercent | Служебный параметр. | Число
    executionIssuePercent | Служебный параметр. | Число

    **Поля объекта** `createdBy` {#createdBy}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Адрес ресурса API, который содержит информацию о пользователе. | Строка
    id | Идентификатор пользователя. | Число
    display | Отображаемое имя пользователя. | Строка

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-401.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}