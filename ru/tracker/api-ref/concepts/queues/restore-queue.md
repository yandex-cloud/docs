# Восстановить очередь

Запрос позволяет восстановить удаленную очередь.

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Для восстановления удаленной очереди используйте HTTP-запрос с методом `POST`.

```
POST /v2/queues/<queue-id>/_restore
Host: {{ host }}
Authorization: OAuth <токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<queue-id\> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка или число

{% endcut %}

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

    ```json
    {
        "self": "{{ host }}/v2/queues/TEST",
        "id": 3,
        "key": "TEST",
        "version": 5,
        "name": "Test",
        "lead": {
               "self": "{{ host }}/v2/users/1120000000016876",
               "id": "<id сотрудника>",
               "display": "<отображаемое имя сотрудника>"
        },
        "assignAuto": false,
        "defaultType": {
               "self": "{{ host }}/v2/issuetypes/1",
               "id": "1",
               "key": "bug",
               "display": "Ошибка"
        },
        "defaultPriority": {
               "self": "{{ host }}/v2/priorities/3",
               "id": "3",
               "key": "normal",
               "display": "Средний"
        },
        "denyVoting": false
    }
    ```

    {% cut "Параметры ответа" %}

    Параметр | Описание | Тип данных
    ----- | ----- | -----
    self | Ссылка на очередь. | Строка
    id | Идентификатор очереди. | Строка
    key | Ключ очереди. | Строка
    version | Версия очереди. Каждое изменение очереди увеличивает номер версии. | Число
    name | Название очереди. | Строка
    [lead](#lead) | Блок с информацией о владельце очереди. | Объект
    assignAuto | Автоматически назначить исполнителя для новых задач очереди:<ul><li>`true`— назначить;</li><li>`false`— не назначать.</li></ul> | Логический
    [defaultType](#default-type) | Блок с информацией о типе задачи по умолчанию. | Объект
    [defaultPriority](#default-priority) | Блок с информацией о приоритете задачи по умолчанию. | Объект
    denyVoting | Признак возможности голосования за задачи. | Логический

    {% include [user](../../../_includes/tracker/api/user.md) %}

    **Поля объекта** `defaultType` {#default-type}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Ссылка на тип задачи | Строка
    id | Идентификатор типа задачи | Строка
    key | Ключ типа задачи | Строка
    display | Отображаемое название типа задачи | Строка

    **Поля объекта** `defaultPriority` {#default-priority}

    Параметр | Описание | Тип данных
    -------- | -------- | ----------
    self | Ссылка на тип приоритета | Строка
    id | Идентификатор приоритета | Строка
    key | Ключ приоритета | Строка
    display | Отображаемое название приоритета | Строка

    {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}