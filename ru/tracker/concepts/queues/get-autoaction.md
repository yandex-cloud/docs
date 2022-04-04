---
sourcePath: ru/tracker/api-ref/concepts/queues/get-autoaction.md
---
# Получить параметры автодействия

Запрос позволяет получить информацию об [автодействии](../../user/autoactions.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить параметры автодействия, используйте HTTP-запрос с методом `GET`. 

```json
POST /{{ ver }}/queues/<queue-id>/autoactions/<autoaction-id>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<queue-id\> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка или число
\<autoaction-id\> | Идентификатор автодействия. | Число    

{% endcut %}    

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

  Тело запроса содержит информацию об автодействии в формате JSON.

  ```json
  {
    "id": 9,
    "self": "{{ host }}/v2/queues/DESIGN/autoactions/9",
    "queue": {
        "self": "{{ host }}/v2/queues/DESIGN",
        "id": "26",
        "key": "DESIGN",
        "display": "Дизайн"
    },
    "name": "autoaction_name",
    "version": 4,
    "active": true,
    "created": "2021-04-15T04:49:44.802+0000",
    "updated": "2022-01-26T16:29:05.356+0000", 
    "filter": {
        "priority": [
            "critical"
        ]
    },
    "actions": [
        {
            "type": "Transition",
            "id": 1,
            "status": {
                "self": "{{ host }}/v2/statuses/2",
                "id": "2",
                "key": "needInfo",
                "display": "Требуется информация"
            }
        }
    ],
    "enableNotifications": false,
    "lastLaunch": "2022-02-01T14:09:48.216+0000",
    "totalIssuesProcessed": 0,
    "intervalMillis": 3600000,
    "calendar": {
            "id": 2
        }    
  }
  ```

   {% cut "Параметры ответа" %}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   id | Идентификатор автодействия. | Строка
   self | Ссылка на автодействие. | Строка
   [queue](#queue) | Очередь, в которой создано автодействие.| Может задаваться как объект, как строка (если передается [ключ очереди](../../manager/create-queue.md#key)), как число (если передается идентификатор очереди).
   name | Название автодействия. | Строка
   version | Версия автодействия. Каждое изменение автодействия увеличивает номер версии. | Число
   active | Статус автодействия. Допустимые значения:<ul><li>`true`— активный;</li><li>`false`— неактивный.</li></ul> | Логический
   created | Дата и время создания автодействия в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
   updated | Дата и время последнего изменения автодействия в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
   [filter](#filter) | Массив с условиями фильтрации полей задач, для которых сработает автодействие. | Массив объектов
   query| Строка запроса для фильтрации задач. | Строка
   [actions](#actions) | Массив с действиями над задачами. | Массив объектов
   enableNotifications| Статус отправки уведомления. Допустимые значения:<ul><li>`true`— отправлять;</li><li>`false`— не отправлять.</li></ul> | Логический
   lastLaunch | Дата и время последнего срабатывания автодействия в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
   totalIssuesProcessed| Количество задач, которые были проверены автодействием при последнем срабатывании. | Число
   intervalMillis| Периодичность запуска автодействия в миллисекундах. По умолчанию выставляется значение `3600000` (1 раз в час). | Число
   calendar | Период, в который автодействие активно. Имеет параметр `id` — идентификатор [графика работы](../../manager/schedule.md). | Объект

   **Поля объекта** `queue` {#queue}
    
   {% include [queue](../../../_includes/tracker/api/queue.md) %} 

    **Поля объектов массива** `filter` {#filter}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   filter | Массив с условиями фильтрации полей задач.<br/>Используйте запрос, чтобы получить идентфиикатор [глобального](../issues/get-global-fields.md) или [локального](../queues/get-local-fields.md) поля. |  Массив объектов

   **Поля объектов массива** `actions` {#actions}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   type | Тип действия. Допустимые значения:<ul><li>`Transition`— изменить статус задачи;</li><li>`Update`— изменить значения в полях;</li><li>`Event.comment-create`— добавить комментарий;</li><li>`Webhook`— отправить HTTP-запрос;</li><li>`CalculateFormula`— вычислить значение;</li></ul>| Строка
   id | Идентификатор действия. | Строка
   [status](#status) | Статус задачи. | Строка

   **Поля объектов массива** `status` {#status}

   {% include [status](../../../_includes/tracker/api/status.md) %}

   {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, ответное сообщение содержит информацию о возникших ошибках:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}