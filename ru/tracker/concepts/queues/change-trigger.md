---
sourcePath: ru/tracker/api-ref/concepts/queues/change-trigger.md
---
# Изменить триггер с помощью запроса к API

Запрос позволяет изменить [триггер](../../user/trigger.md).

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы изменить триггер, используйте HTTP-запрос с методом `PATCH`. Параметры запроса передаются в его теле в формате JSON.

```json
PATCH /{{ ver }}/queues/<queue-id>/triggers/<trigger-id>?version=<trigger-current-version>
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
    "name": "<имя_триггера>",
    "actions": [<параметры_действия_триггера>]
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
----- | ----- | -----
\<queue-id\> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка или число
\<trigger-id\> | Идентификатор триггера. | Число
\<trigger-current-version\> | Текущая версия триггера. | Число

{% note info %}

Текущую версию триггера можно найти в ответе на [GET-запрос к настройкам триггера](get-trigger.md).

{% endnote %}

{% endcut %}    

{% cut "Параметры тела запроса" %}

**Дополнительные параметры**

Параметр | Описание | Тип данных
----- | ----- | -----
name | Название триггера. | Строка
actions | Массив с [объектами действий триггера](change-trigger-actions.md).  | Массив объектов
conditions | Массив с [условиями срабатывания триггера](#conditions). | Массив объектов
active | Статус триггера. Допустимые значения:<ul><li>`true`— активный;</li><li>`false`— неактивный.</li></ul> | Логический
before | Идентификатор триггера, перед которым нужно поместить данный триггер. | Число

**Условия срабатывания триггера** {#conditions} 

В зависимости от того, должны ли сработать все или хотя бы одно из условий, в поле **conditions** можно указать либо массив элементарных объектов условий срабатывания триггера (в этом случае триггер сработает при выполнении всех условий), либо массив с объектами, включающими как массив элементарных объектов условий срабатывания триггера, так и тип логического объединения условий:

* Элементарный [объект условия срабатывания триггера](change-trigger-conditions.md);
* Объект с указанием типа объединения условий срабатывания триггера:

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   type | Тип логического объединения условий. Допустимые значения:<ul><li>`Or`— логическое ИЛИ (`Любое`);</li><li>`And`— логическое И (`Все`).</li></ul> | Строка
   conditions | Массив с элементарными [объектами условия срабатывания триггера](change-trigger-conditions.md). | Массив объектов

{% note info %}

Условия срабатывания триггера (элементарные объекты и объекты с указанием типа объединения) могут быть [сгруппированы с помощью объекта с указанием типа объединения](#condition-group).
По умолчанию используется тип объединения <q>логическое И</q> (`"type": "And"`). Этот тип указывать не нужно.
При объединении с типом <q>логическое ИЛИ</q> (`"type": "Or"`) необходимо указать тип объединения.

{% endnote %}

{% endcut %}

Примеры:

1. [Изменить триггер, срабатывающий при выполнении хотя бы одного из условий](#or-condition). 
1. [Изменить триггер, срабатывающий при выполнении всех условий](#and-condition). 
1. [Изменить триггер, срабатывающий при выполнении группы условий](#condition-group). 
1. [Отключить триггер](#deactivation). 
1. [Переместить триггер в списке и активировать](#move-before). 

Пример 1: Изменить условия срабатывания триггера. Триггер должен срабатывать при выполнении хотя бы одного из заданных условий. {#or-condition}
>- Используется HTTP-метод `PATCH`.
>- Изменяется триггер для очереди DESIGN. 
>- ID триггера — 16, текущая версия — 1. 
>- Меняется условие срабатывания триггера: текст комментария совпадает с фразой <q>Need info</q> или <q>Нужна информация</q>. 
>- Действие триггера: переход задачи в статус <q>Требуется информация</q>.
>```json
>PATCH /{{ ver }}/queues/DESIGN/triggers/16?version=1
>Host: {{ host }}
>Authorization: OAuth <OAuth-токен>
>{{ org-id }}
>{
>   "actions": [
>       {
>           "type": "Transition",
>           "status": {
>               "key": "needInfo"
>               }
>       }
>   ],
>   "conditions": [
>        {
>            "type": "Or",
>            "conditions": [
>                { "type": "CommentFullyMatchCondition", "word": "Need info"},
>                { "type": "CommentFullyMatchCondition", "word": "Нужна информация"}
>            ]
>        }
>    ]
>}
>```

Пример 2: Изменить условия срабатывания триггера. Триггер должен срабатывать при выполнении всех заданных условий. {#and-condition}
>- Используется HTTP-метод `PATCH`.
>- Изменяется триггер для очереди DESIGN. 
>- ID триггера — 16, текущая версия — 2. 
>- Меняется условие срабатывания триггера: текст комментария совпадает с фразой <q>Need info</q> и статус задачи равен `В работе`. 
>```json
>PATCH /{{ ver }}/queues/DESIGN/triggers/16?version=2
>Host: {{ host }}
>Authorization: OAuth <OAuth-токен>
>{{ org-id }}
>{
>   "actions": [
>       {
>           "type": "Transition",
>           "status": {
>               "key": "needInfo"
>               }
>       }
>   ],
>}
>```

Пример 3: Изменить условия срабатывания и действие триггера. Триггер должен срабатывать при выполнении одной из групп условий. {#condition-group}
>- Используется HTTP-метод `PATCH`.
>- Изменяется триггер для очереди DESIGN. 
>- ID триггера — 16, текущая версия — 2. 
>- Меняется условие срабатывания триггера — триггер срабатывает, если выполняется одна из групп условий:
>-  - Текст комментария совпадает с фразой <q>Need info</q> и статус задачи равен `В работе`;
>-  - Текст комментария совпадает с фразой <q>No data</q> ;
>- Меняется действие триггера: переход задачи в статус <q>Требуется информация</q>.
>```json
>PATCH /{{ ver }}/queues/DESIGN/triggers/16?version=2
>Host: {{ host }}
>Authorization: OAuth <OAuth-токен>
>{{ org-id }}
>{
>   "actions": [
>       {
>           "type": "Transition",
>           "status": {
>               "key": "needInfo"
>               }
>       }
>   ],
>   "conditions": [
>       {
>           "conditions": [
>               {
>                   "conditions": [
>                       {
>                           "ignoreCase": false,
>                           "noMatchBefore": false,
>                           "removeMarkup": false,
>                           "type": "CommentFullyMatchCondition",
>                           "word": "Need info"
>                       },
>                       {     "type": "FieldEquals", 
>                             "field":"status",
>                             "value":"inProgress" 
>                       }
>                   ],
>                   "type": "And"
>               },
>               {
>                   "ignoreCase": false,
>                   "noMatchBefore": false,
>                   "removeMarkup": false,
>                   "type": "CommentFullyMatchCondition",
>                   "word": "No data"
>               }
>           ],
>           "type": "Or"
>       }
>   ]
>}
>```

Пример 4: Отключить триггер. {#deactivation}
>- Используется HTTP-метод `PATCH`.
>- Изменяется триггер для очереди DESIGN. 
>- ID триггера — 16, текущая версия — 3. 
>- Триггер деактивируется.
>```json
>PATCH /{{ ver }}/queues/DESIGN/triggers/16?version=3
>Host: {{ host }}
>Authorization: OAuth <OAuth-токен>
>{{ org-id }}
>{
>   "active": false,
>}
>```

Пример 5: Переместить триггер в списке и активировать. {#move-before}
>- Используется HTTP-метод `PATCH`.
>- Изменяется триггер для очереди DESIGN. 
>- ID триггера — 16, текущая версия — 4. 
>- Триггер переносится в позицию перед триггером с идентификатором `6` и активируется.
>```json
>PATCH /{{ ver }}/queues/DESIGN/triggers/16?version=4
>Host: {{ host }}
>Authorization: OAuth <OAuth-токен>
>{{ org-id }}
>{
>   "before": 6,
>   "active": true,
>}
>```

## Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   Тело запроса содержит информацию о созданном триггере в формате JSON.

   ```json
   {
      "id": 16,
      "self": "https://{{ host }}/{{ ver }}/queues/DESIGN/triggers/16",
      "queue": {
         "self": "https://{{ host }}/{{ ver }}/queues/DESIGN",
         "id": "26",
         "key": "DESIGN",
         "display": "Дизайн"
      },
      "name": "TriggerName",
      "order": "0.0002",
      "actions": [
         {
            "type": "Transition",
            "id": 2,
            "status": {
               "self": "https://{{ host }}/{{ ver }}/statuses/2",
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
                  "type": "CommentFullyMatchCondition", 
                  "word": "Need info", 
                  "ignoreCase": true, 
                  "removeMarkup": true, 
                  "noMatchBefore": false 
               },
               { 
                  "type": "CommentFullyMatchCondition", 
                  "word": "Нужна информация", 
                  "ignoreCase": true, 
                  "removeMarkup": true, 
                  "noMatchBefore": false 
               }
            ]
         }
         ],
         "version": 2,
         "active": true
      }

   ```

   {% cut "Параметры ответа" %}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   id | Идентификатор триггера. | Строка
   self | Ссылка на триггер. | Строка
   queue | Очередь, в которой нужно создать триггер.| Объект
   name | Название триггера. | Строка
   order | Вес триггера. Параметр влияет на порядок отображения триггера в интерфейсе. | Строка
   [actions](#actions) | Массив с действиями триггера. | Массив объектов
   [conditions](#conditions) | Массив с условиями срабатывания триггера. | Массив объектов
   version | Версия триггера. Каждое изменение триггера увеличивает номер версии. | Число
   active | Статус триггера. | Логический

   **Поля объекта** `queue` {#queue}
    
   {% include [queue](../../../_includes/tracker/api/queue.md) %} 

   {% endcut %}

- Запрос выполнен с ошибкой

    Если запрос не был успешно обработан, ответное сообщение содержит информацию о возникших ошибках:

    {% include [answer-error-400](../../../_includes/tracker/api/answer-error-400.md) %}

    {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

    {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

    {% include [answer-error-409](../../../_includes/tracker/api/answer-error-409.md) %}

    {% include [answer-error-412](../../../_includes/tracker/api/answer-error-412.md) %}

    {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

    {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

    {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}