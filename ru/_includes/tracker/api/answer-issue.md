```json
[
    {
    "self": "{{ host }}/v2/issues/TREK-9844",
    "id": "593cd211ef7e8a332414f2a7",
    "key": "TREK-9844",
    "version": 7,
    "lastCommentUpdatedAt": "2017-07-18T13:33:44.291+0000",
    "summary": "subtask",
    "parent": {
        "self": "{{ host }}/v2/issues/JUNE-2",
        "id": "593cd0acef7e8a332414f28e",
        "key": "JUNE-2",
        "display": "Task"
        },
    "aliases": [
            "JUNE-3"
        ],

    "updatedBy": {
        "self": "{{ host }}/v2/users/1120000000016876",
        "id": "<id сотрудника>",
        "display": "<отображаемое имя сотрудника>"
        },
    "description": "<#<html><head></head><body><div>test</div><div>&nbsp;</div><div>&nbsp;</div> </body></html>#>",
    "sprint": [
            {
        "self": "{{ host }}/v2/sprints/5317",
        "id": "5317",
        "display": "спринт1"
            }
        ],
    "type": {
        "self": "{{ host }}/v2/issuetypes/2",
        "id": "2",
        "key": "task",
        "display": "Задача"
        },
    "priority": {
        "self": "{{ host }}/v2/priorities/2",
        "id": "2",
        "key": "normal",
        "display": "Средний"
        },

    "createdAt": "2017-06-11T05:16:01.339+0000",
    "followers": [
        {
        "self": "{{ host }}/v2/users/1120000000016876",
        "id": "<id сотрудника>",
        "display": "<отображаемое имя сотрудника>"
        }
        ],
    "createdBy": {
        "self": "{{ host }}/v2/users/1120000000049224",
        "id": "<id сотрудника>",
        "display": "<отображаемое имя сотрудника>"
        },
    "votes": 0,
    "assignee": {
        "self": "{{ host }}/v2/users/1120000000049224",
        "id": "<id сотрудника>",
        "display": "<отображаемое имя сотрудника>"
        },
    "queue": {
        "self": "{{ host }}/v2/queues/TREK",
        "id": "111",
        "key": "TREK",
        "display": "Стартрек"
        },
    "updatedAt": "2017-07-18T13:33:44.291+0000",
    "status": {
        "self": "{{ host }}/v2/statuses/1",
        "id": "1",
        "key": "open",
        "display": "Открыт"
        },
    "previousStatus": {
        "self": "{{ host }}/v2/statuses/2",
        "id": "2",
        "key": "resolved",
        "display": "Решен"
        },
    "favorite": false
    },
    {...}
]
```

{% cut "Параметры ответа" %}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Адрес ресурса API, который содержит информацию о задаче. | Строка
   id | Идентификатор задачи. | Строка
   key | Ключ задачи. | Строка
   version | Версия задачи. Каждое изменение параметров задачи увеличивает номер версии. | Число
   lastCommentUpdatedAt | Дата и время последнего добавленного комментария. | Строка
   summary | Название задачи. | Строка
   [parent](#parent) | Объект с информацией о родительской задаче. | Объект
   aliases | Массив с информацией об альтернативных ключах задачи. | Массив строк
   [updatedBy](#updated-by) | Объект с информацией о последнем сотруднике, изменявшим задачу. | Объект
   description | Описание задачи. | Строка
   [sprint](#sprint) | Массив объектов с информацией о спринте. | Массив объектов
   [type](#type) | Объект с информацией о типе задачи. | Объект
   [priority](#priority) | Объект с информацией о приоритете. | Объект
   createdAt | Дата и время создания задачи. | Строка
   [followers](#followers) | Массив объектов с информацией о наблюдателях задачи. | Массив объектов
   [createdBy](#created-by) | Объект с информацией о создателе задачи. | Объект
   votes | Количество голосов за задачу. | Число
   [assignee](#assignee) | Объект с информацией об исполнителе задачи. | Объект
   [queue](#queue) | Объект с информацией об очереди задачи. | Объект
   updatedAt | Дата и время последнего обновления задачи. | Строка
   [status](#status) | Объект с информацией о статусе задачи. | Объект
   [previousStatus](#previous-status) | Объект с информацией о предыдущем статусе задачи. | Объект
   favorite | Признак избранной задачи:<ul><li>`true` — пользователь добавил задачу в избранное;</li><li>`false` — задача не добавлена в избранное.</li></ul> | Логический

   **Поля объекта** `parent`{#parent}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Адрес ресурса API, который содержит информацию о задаче. | Строка
   id | Идентификатор задачи. | Строка
   key | Ключ задачи. | Строка
   display | Отображаемое название задачи. | Строка

   **Поля объекта** `updatedBy` {#updated-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   {% include [sprint](../../../_includes/tracker/api/sprint.md) %}

   {% include [type](../../../_includes/tracker/api/type.md) %}

   {% include [priority](../../../_includes/tracker/api/priority.md) %}

   **Поля объектов массива** `followers` {#followers}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   **Поля объекта** `createdBy` {#created-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   **Поля объекта** `assignee` {#assignee}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   **Поля объекта** `queue` {#queue}

   {% include [queue](../../../_includes/tracker/api/queue.md) %}

   **Поля объекта** `status` {#status}

   {% include [status](../../../_includes/tracker/api/status.md) %}

   **Поля объекта** `previousStatus` {#previous-status}

   {% include [status](../../../_includes/tracker/api/status.md) %}

{% endcut %}  
