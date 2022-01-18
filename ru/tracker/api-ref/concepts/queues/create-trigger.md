# Создать триггер

Запрос позволяет создать [триггер](../../user/trigger.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы создать триггер, используйте HTTP-запрос с методом `POST`. Параметры запроса передаются в его теле в формате JSON.

```json
POST /{{ ver }}/queues/<queue-id>/triggers
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
    "name": "<имя триггера>",
    "actions": [<параметры действия триггера>]
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<queue-id\> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка или число

{% endcut %}    

{% cut "Параметры тела запроса" %}

**Обязательные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
name | Название тригера. | Строка
[actions](#actions) | Массив с [действиями триггера](../../user/set-action.md).  | Массив объектов

**Дополнительные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
[conditions](#conditions) | Массив с [условиями срабатывания триггера](../../user/set-condition.md). | Массив объектов
active | Статус триггера. Допустимые значения:<ul><li>`true`— активный;</li><li>`false`— неактивный.</li></ul> | Логический

{% endcut %}

>Пример: Создать триггер, который срабатывает при заданном условии и меняет статус задачи.
>- Используется HTTP-метод POST.
>- Создается триггер для очереди DESIGN. 
>- Условие срабатывания триггера: текст комментария совпадает с <q>Open</q>. 
>- Действие триггера: переход задачи в статус <q>Открыт</q>.
>```json
>POST /v2/queues/DESIGN/triggers
>Host: {{ host }}
>Authorization: OAuth <OAuth-токен>
>{{ org-id }}
>{
>   "name": "TriggerName",
>   "actions": [
>       {
>           "type": "Transition",
>           "status": {
>               "key": "open"
>               }
>       }
>   ],
>   "conditions": [
>        {
>           "type": "CommentFullyMatchCondition",
>           "word": "Open"
>        }
>    ]
>}
>```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

  {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

  Тело запроса содержит информацию о созданном тригере в формате JSON.

    ```json
    {
    "id": 16,
    "self": "{{ host }}/v2/queues/DESIGN/triggers/16",
    "queue": {
        "self": "{{ host }}/v2/queues/DESIGN",
        "id": "26",
        "key": "DESIGN",
        "display": "Дизайн"
    },
    "name": "trigger_name",
    "order": "0.0002",
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
    "conditions": [
        {
            "type": "Or",
            "conditions": [
                {
                    "type": "Event.comment-create"
                }
            ]
        }
    ],
    "version": 1,
    "active": true
    }


   ```

   {% cut "Параметры ответа" %}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   id | Идентификатор триггера. | Строка
   self | Ссылка на триггер. | Строка
   [queue](#queue) | Очередь, в которой нужно создать триггер.| Может задаваться как объект, как строка (если передается [ключ очереди](../../manager/create-queue.md#key)), как число (если передается идентификатор очереди).
   name | Название триггера. | Строка
   order | Вес триггера. Параметр влияет на порядок отображения триггера в интерфейсе. | Строка
   [actions](#actions) | Массив с действиями триггера. | Массив объектов
   [conditions](#conditions) | Массив с условиями срабатывания триггера. | Массив объектов
   version | Версия триггера. Каждое изменение триггера увеличивает номер версии. | Число
   active | Статус триггера. Допустимые значения:<ul><li>`true`— активный;</li><li>`false`— неактивный.</li></ul> | Логический

   **Поля объекта** `queue` {#queue}
    
   {% include [queue](../../../_includes/tracker/api/queue.md) %} 

   **Поля объектов массива** `actions` {#actions}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   type | Тип действия. Допустимые значения:<ul><li>`Transition`— изменить статус задачи;</li><li>`Update`— изменить значения в полях;</li><li>`Move`— переместить задачу;</li><li>`Event.comment-create`— добавить комментарий;</li><li>`CreateChecklist`— создать чек-лист;</li><li>`Webhook`— отправить HTTP-запрос;</li><li>`CalculateFormula`— вычислить значение;</li><li>`Event.create`— создать задачу.</li></ul>| Строка
   id | Идентификатор действия. | Строка
   [status](#status) | Статус задачи. | Строка

   **Поля объектов массива** `conditions` {#conditions}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   type | Тип условия. Допустипые значения:<ul><li>`or`— логическое ИЛИ;</li><li>`and`— логическое И.</li></ul> | Строка
   conditions | Массив с условиями срабатывания триггера.<br/>Условие имеет параметр `type` — тип условия. Допустипые значения:<ul><li>`CommentNoneMatchCondition`— комментарий не содержит ни одного из фрагментов;</li><li>`CommentStringNotMatchCondition`— комментарий не содержит фрагмент;</li><li>`CommentFullyMatchCondition`— комментарий совпадает с;</li><li>`CommentAnyMatchCondition`— комментарий содержит любой из фрагментов;</li><li>`CommentStringMatchCondition`— комментарий содержит фрагмент;</li><li>`CommentAuthorNot`— автор комментария не;</li><li>`CommentAuthor`— автор комментария;</li><li>`CommentMessageExternal`— тип комментария `Письмо на почту`;</li><li>`CommentMessageInternal`— тип комментария `Комментарий в Трекере`.</li></ul>   |  Массив объектов

   **Поля объектов массива** `status` {#status}

   {% include [status](../../../_includes/tracker/api/status.md) %}

   {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, ответное сообщение содержит информацию о возникших ошибках:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-409](../../../_includes/tracker/api/answer-error-409.md) %}

    {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}