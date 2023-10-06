---
sourcePath: ru/tracker/api-ref/concepts/queues/manage-access.md
---
# Выдать права доступа к очереди

Запрос позволяет настроить [доступы к очереди](../../manager/queue-access.md). 

## Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы настроить доступы к очереди, используйте HTTP-запрос с методом `PATCH`. Параметры запроса передаются в его теле в формате JSON.

```json
PATCH /{{ ver }}/queues/<queue-id>/permissions
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}

{
   "create": {
      "groups": [<идентификатор_группы_1>, <идентификатор_группы_2>]
   },
   "write": {
      "users": {
         "remove": ["<логин_пользователя_1>", "<идентификатор_пользователя_2>"]
      },
      "groups": {
         "add":[<идентификатор_группы_1>]
       },
      "roles": {
         "add":["author", "assignee"]
      }
   },
   "read": {
      "groups": {
         "add":[<идентификатор_группы_3>]
       },
      "roles": {
         "add":["follower"]
      }
   },
   "grant": {
      "users": {
         "remove": ["<идентификатор_аккаунта_пользователя_4>",  "<идентификатор_пользователя_2>"]
      },
   },
   
}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<queue-id\> | Идентификатор или ключ очереди. Ключ очереди чувствителен к регистру символов. | Строка

{% endcut %}

{% cut "Параметры тела запроса" %}

Тело запроса содержит информацию, необходимую для управления доступами.

**Допустимые поля объекта тела запроса**

Укажите в запросе хотя бы одно из полей:

Параметр | Описание | Тип данных
-------- | -------- | ----------
create | Разрешения на создание задач в очереди. | Объект
write | Разрешения на редактирование задач в очереди. | Объект
read | Разрешения на чтение задач в очереди. | Объект
grant | Разрешения на изменение настроек очереди. | Объект


**Допустимые поля объектов, к которым применяются разрешения**

Каждое из полей тела запроса содержит перечень пользователей, групп, ролей, к которым применяется действие разрешения. Укажите в перечне хотя бы одно из полей:

Параметр | Описание | Тип данных
-------- | -------- | ----------
users | Список пользователей. | Объект или массив элементов
groups | Список групп. | Объект или массив элементов
roles | Список ролей. | Объект или массив элементов

**Допустимые значения полей объектов, к которым применяются разрешения**

В каждом из полей можно указать либо массив идентификаторов, либо объект:

- Если указан массив идентификаторов, то разрешения для данных ресурсов будут созданы или перезаписаны в соответствии с запросом;
- Если указан объект, то разрешения будут добавлены или отозваны в соответствии с указанным ключом: 

Ключ | Описание | Тип данных
-------- | -------- | ----------
add | Добавить разрешение. | Массив элементов
remove | Отозвать разрешение. | Массив элементов

**Допустимые идентификаторы**

Тип ресурса | Идентификатор | Описание |Тип данных
-------- | -------- | ---------- | ----------
**users** | uid | Уникальный идентификатор учетной записи пользователя в {{ tracker-name }}. | Число
&nbsp; | passportUid | Уникальный идентификатор аккаунта пользователя в организации {{ ya-360 }} и Яндекс ID. | Число
&nbsp; | login | Логин пользователя. | Строка
&nbsp; | cloudUid | Уникальный идентификатор пользователя в {{ org-full-name }}. | Строка
&nbsp; | trackerUid | Уникальный идентификатор аккаунта пользователя в {{ tracker-name }}. | Число
**groups** | id | Идентификатор группы. | Число
**roles** | role_id | Идентификатор роли. | Строка

{% note info %}

Идентификаторы ролей:
* `author` — Автор,
* `assignee` — Исполнитель,
* `follower` — Наблюдатель,
* `access` — С правом доступа.

Идентификаторы групп можно получить запросом `{{ host }}/{{ ver }}/groups`.

{% endnote %}


{% endcut %}

> Пример 1: Выдать права на создание и редактирование задач в очереди с ключом `TESTQUEUE` пользователю с логином `user1`.
>
> - Используется HTTP-метод `PATCH`.
> - Права выдаются пользователю `user1` в очереди с ключом `TESTQUEUE`.
> - В результате запроса имеющиеся у пользователя права в очереди будут перезаписаны.
> ```
> PATCH /{{ ver }}/queues/TESTQUEUE/permissions HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
>
> {
>     "create": {
>        "users": ["user1"]
>     },
>     "write": {
>     "users": ["user1"]
>     }
> }
> ```

> Пример 2: Выдать право настройки очереди с ключом `TESTQUEUE` пользователю с логином `user1` и отозвать такое право у пользователя с уникальным идентификатором `1234567890`.
>
> - Используется HTTP-метод `PATCH`.
> - Пользователю `user1` выдается право настройки очереди с ключом `TESTQUEUE`.
> - У пользователя с идентификатором `1234567890` отзывается право настройки очереди с ключом `TESTQUEUE`.
> ```
> PATCH /{{ ver }}/queues/TESTQUEUE/permissions HTTP/1.1
> Host: {{ host }}
> Authorization: OAuth <OAuth-токен>
> {{ org-id }}
>
> {
>     "grant": {
>        "users": {
>           "add":["user1"],
>           "remove":['1234567890']
>        }
>     }
> }
> ```
   

## Формат ответа {#answer}

{% list tabs %}
- Запрос выполнен успешно
   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}
   ```json
   {
       "self": "https://api.tracker.yandex.net/v2/queues/TESTQUEUE/permissions",
       "version": 11,
       "create": {
           "self": "https://api.tracker.yandex.net/v2/queues/TESTQUEUE/permissions/create",
           "users": [
                { "self": "https://api.tracker.yandex.net/v2/users/9876543210", "id": "9876543210", "display": "Пользователь 1", "cloudUid": "ajej6h7nffmtaf*****", "passportUid": 9876543210 }
           ],
           "roles": [
               { "self": "https://api.tracker.yandex.net/v2/roles/author", "id": "author", "display": "Автор" },
               { "self": "https://api.tracker.yandex.net/v2/roles/queue-lead", "id": "queue-lead", "display": "Владелец очереди" },
               { "self": "https://api.tracker.yandex.net/v2/roles/assignee", "id": "assignee", "display": "Исполнитель" }
           ]
       },
       "write": {
           "self": "https://api.tracker.yandex.net/v2/queues/TESTQUEUE/permissions/write",
           "users": [
                { "self": "https://api.tracker.yandex.net/v2/users/9876543210", "id": "9876543210", "display": "Пользователь 1", "cloudUid": "ajej6h7nffmtaf*****", "passportUid": 9876543210 }
           ],
           "roles": [
               { "self": "https://api.tracker.yandex.net/v2/roles/author", "id": "author", "display": "Автор" },
               { "self": "https://api.tracker.yandex.net/v2/roles/queue-lead", "id": "queue-lead", "display": "Владелец очереди" },
               { "self": "https://api.tracker.yandex.net/v2/roles/assignee", "id": "assignee", "display": "Исполнитель" }
           ]
       },
       "grant": {
           "self": "https://api.tracker.yandex.net/v2/queues/TESTQUEUE/permissions/grant",
           "users": [
                { "self": "https://api.tracker.yandex.net/v2/users/9876543210", "id": "9876543210", "display": "Пользователь 1", "cloudUid": "ajej6h7nffmtaf*****", "passportUid": 9876543210 }
           ],
           "roles": [
               { "self": "https://api.tracker.yandex.net/v2/roles/author", "id": "author", "display": "Автор" },
               { "self": "https://api.tracker.yandex.net/v2/roles/queue-lead", "id": "queue-lead", "display": "Владелец очереди" },
               { "self": "https://api.tracker.yandex.net/v2/roles/assignee", "id": "assignee", "display": "Исполнитель" }
           ]
       }
   }

   ```

   {% cut "Параметры ответа" %}
   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Ссылка на объект выданных доступов в очереди. | Строка
   version | Номер версии. | Число
   create | Разрешения на создание задач в очереди. | Объект
   write | Разрешения на редактирование задач в очереди. | Объект
   read | Разрешения на чтение задач в очереди. | Объект
   grant | Разрешения на изменение настроек очереди. | Объект

   {% endcut %}

- Запрос выполнен с ошибкой

   Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

   {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

{% endlist %}

