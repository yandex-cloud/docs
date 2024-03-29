---
sourcePath: ru/tracker/api-ref/concepts/queues/change-trigger-actions.md
---
# Объекты действий триггера

Для управления действиями триггера укажите один или несколько объектов.

## Изменить статус задачи {#change-status}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип действия | `Transition` | Строка
status | Статус задачи | Ключ, идентификатор или имя статуса | Строка

> Пример:
> ```
> { "type": "Transition", "status": "В работе" }
> ```


## Вычислить значение {#calculate}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип действия | `CalculateFormula` | Строка
formula | Формула | Математическое выражение | Строка
resultField | Поле, в котором вычисляется значение | Ключ или имя поля | Строка

> Пример:
> ```
> { "type": "CalculateFormula", "formula": "now()+3M", "resultField": "start" }
> ```


## Изменить значения в полях {#change-fields}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип действия | `Update` | Строка
update | Список действий над полями | Объекты с полями `field` и `update` | Массив объектов

**Поля объекта** `update`:

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
field | Поле, которое нужно изменить | Ключ или имя поля | Строка
update | Объект действия над полем | <ul><li>Объект с полем `set`, значением которого является строка или объект с новым значением поля;</li><li>**null** — чтобы очистить поле. </li></ul> | Объект или NULL

> Пример:
> ```
> {
>    "type": "Update",
>    "update": [
>          { "field": "priority","update":{"set":{"key":"critical"}}
>          { "field": "Описание" }, "update": { "set": "Новая задача" }},
>          { "field": "Резолюция" }, "update": null },
>    ]
> }
> ```


## Переместить задачу {#move-task}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип действия | `Move` | Строка
queue | Очередь | Ключ очереди | Строка

> Пример:
> ```
> { "type": "Move", "queue": "TESTQUEUE"}
> ```


## Добавить комментарий {#add-comment}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип действия | `CreateComment` | Строка
text | Текст комментария | Текст | Строка
fromRobot | Отправлять от имени робота | `true` или `false` | Логический

> Пример:
> ```
> { "type": "CreateComment", "text": "Создано not_var{{currentDateTime.date}}", "fromRobot": false }
> ```


## Создать чеклист {#add-checklist}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип действия | `CreateChecklist` | Строка
checklistItems | Список пунктов чеклиста | Массив объектов с полями:<ul><li>`text` — описание (обязательное поле);</li><li>`assignee` — исполнитель;</li><li>`deadline` — дедлайн.</li></ul> | Массив объектов

> Пример:
> ```
> {
>    "type": "CreateChecklist",
>    "checklistItems": [
>          {
>             "text": "Сделать то",
>             "assignee": "ivanivanov",
>             "deadline": "2025-10-26",
>          },
>          {
>             "text": "Сделать это",
>             "assignee": "ivanivanov",
>             "deadline": "2025-10-26",
>          },
>          {   "text": "Отчитаться за все"}
>    ]
> }
> ```


## HTTP-запрос {#webhook}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип действия | `Webhook` | Строка
endpoint | Адрес | URL запроса | Строка
authContext | Способ авторизации | Объект с данными авторизации  | Строка
method | Метод запроса | Одно из значений:<ul><li>`GET`</li><li>`POST`</li><li>`PUT`</li><li>`DELETE`</li></ul> | Строка
contentType | Тип содержимого | `application/json` | Строка
headers | Заголовки | Объект с полями в формате ключ-значение | Объект
body | Тело запроса | Объект с данными или строка | Объект или Строка

**Допустимые объекты авторизации**

Тип авторизации | Объект 
----- | ----- 
NoAuth | `{ "type": "noauth" }` 
Basic | `{ "password": "********", "type": "basic", "login": "<логин>" }`
OAuth 2 | `{ "headerName": "Authorization", "type": "oauth", "accessToken": "********", "tokenType": "Bearer"}`

> Пример:
> ```
> {
>    "type": "Webhook",
>    "endpoint": "https://api.example.com/messenger/sendMessage",
>    "method": "GET",
>    "contentType": "application/json; charset=UTF-8",
>    "headers": { "Content-Language": "de-DE" },
>    "authContext": { "password": "********", "type": "basic", "login": "user1" },
>    "body": {"message":"Hallo, Welt!"}
> }
> ```


## Создать задачу {#create-task}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип действия | `CreateIssue` | Строка
queue | Очередь | Ключ очереди | Строка
summary | Название | Текст | Строка
fieldTemplates | Поля задачи | Объект с полями задачи | Объект
linkWithInitialIssue | Связать с задачей, которая запустила триггер | `true` или `false` | Логический
fromRobot | Создавать задачи от имени робота | Объект с полями задачи | `true` или `false` | Логический

**Параметры объекта с полями задачи**

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
followers | Наблюдатели | Массив с идентификаторами пользователей | Массив строк
dueDate | Дедлайн | Дата | Строка
description | Описание | Текст | Строка
assignee | Исполнитель | Идентификатор пользователя | Строка
priority | Приоритет | Ключ или имя приоритета | Строка
type |Тип задачи | Ключ или имя типа | Строка
tags | Список тегов | Массив строковых элементов | Массив строк

> Пример:
> ```
> {
>    "type": "CreateIssue",
>    "queue": "TESTQUEUE",
>    "summary": "Новая задача",
>    "fieldTemplates": {
>          "followers": ["user1", "user2"],
>          "dueDate": "2024-10-31",
>          "description": "Создана триггером not_var{{currentDateTime.date}}",
>          "assignee": "user3",
>          "priority": "critical",
>          "type": "milestone",
>          "tags": ["new task", "by trigger"]
>    },
>    "linkWithInitialIssue": true,
>    "fromRobot": true,
> }
> ```

