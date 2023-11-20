---
sourcePath: ru/tracker/api-ref/concepts/queues/change-trigger-conditions.md
---
# Объекты условий срабатывания триггера

Чтобы задать условия срабатывания триггера, укажите один или несколько объектов.

## События {#events}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип условия | Одно из значений:<ul><li>`Event.update` — Задача изменилась;</li><li>`CalculationFormulaWatch` — Поля формулы изменились;</li><li>`Event.comment-create` — Создан комментарий;</li><li>`Event.create` — Создана задача;</li></ul> | Строка

> Пример:
> ```
> {"type": "Event.update"}
> ```


## Чеклист {#checklist}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип условия | `ChecklistDone` | Строка

> Пример:
> ```
> {"type": "ChecklistDone"}
> ```


## Текст комментария {#comment-text}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип условия | Одно из значений:<ul><li>`CommentNoneMatchCondition` — Не содержит ни одного из фрагментов;</li><li>`CommentStringNotMatchCondition` — Не содержит фрагмент;</li><li>`CommentFullyMatchCondition` — Совпадает с;</li><li>`CommentAnyMatchCondition` — Содержит любой из фрагментов;</li><li>`CommentStringMatchCondition` — Содержит фрагмент;</li></ul> | Строка
word | Текст комментария | Строки для поиска | Строка или Массив строк
ignoreCase | Игнорировать регистр | `true` или `false` | Логический
removeMarkup | Игнорировать разметку | `true` или `false` | Логический
noMatchBefore | Не соответствовал до этого | `true` или `false` | Логический

**Тип данных в зависимости от типа условия**

Тип условия | Тип данных
----- | ----- 
`CommentNoneMatchCondition` | Массив строк
`CommentStringNotMatchCondition` | Строка
`CommentFullyMatchCondition` | Строка
`CommentAnyMatchCondition` | Массив строк
`CommentStringMatchCondition` | Строка

> Пример:
> ```
> {
> 	"type": "CommentNoneMatchCondition", 
> 	"words": ["Version 0.1", "Version 0.2"], 
> 	"ignoreCase": true, 
> 	"removeMarkup": true, 
> 	"noMatchBefore": false 
> }
> ```

 
## Автор комментария {#comment-author}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип условия | Одно из значений:<ul><li>`CommentAuthorNot` — Значение поля не равно;</li><li>`CommentAuthor` — Значение поля равно.</li></ul> | Строка
user | Автор комментария | Идентификатор пользователя  | Строка

> Пример:
> ```
> { "type": "CommentAuthorNot", "user": "user1" }
> ```

## Тип комментария {#comment-type}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип условия | Одно из значений:<ul><li>`CommentMessageInternal` — Комментарий в Трекере;</li><li>`CommentMessageExternal` — Письмо на почту.</li></ul> | Строка
user | Автор комментария | Идентификатор пользователя  | Строка

> Пример:
> ```
> { "type": "CommentMessageInternal" }
> ```


## Действие со связью {#relationship}

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип условия | Одно из значений:<ul><li>`UpdatedLinkCondition` — Связь обновлена;</li><li>`CreatedLinkCondition` — Связь создана;</li><li>`RemovedLinkCondition` — Связь удалена.</li></ul> | Строка
relationship | Тип связи между задачами | Список связей | Массив строк

{% cut "Типы связей" %}

* `relates` — простая связь.
* `is dependent by` — текущая задача является блокером.
* `depends on` — текущая задача зависит от связываемой.
* `is subtask for` — текущая задача является подзадачей связываемой.
* `is parent task for` — текущая задача является родительской для связываемой задачи.
* `duplicates` — текущая задача дублирует связываемую.
* `is duplicated by` — связываемая задача дублирует текущую.
* `is epic of` — текущая задача является эпиком связываемой. Связь такого типа можно установить только для задач типа "Эпик".
* `has epic` — связываемая задача является эпиком текущей. Связь такого типа можно установить только для задач типа "Эпик".

{% endcut %}

> Пример:
> ```
> { "type": "RemovedLinkCondition", "relationship": ["is parent task for", "is epic of"] }
> ```


## Поля задачи {#task-fields}

В общем случае условие срабатывания триггера, связанное с полем задачи, может быть описано объектом с двумя обязательными параметрами:

Параметр | Описание | Допустимые значения | Тип данных
----- | ----- | ----- | -----
type | Тип условия | <идентификатор_условия> | Строка
field | Поле задачи | <идентификатор_поля> | Строка

Объект может также содержать дополнительные параметры.

Доступные значения типа условия зависят от конкретного поля задачи. Дополнительные параметры объекта зависят от комбинации обязательных параметров. 

### Значение поля

Для большинства полей доступны следующие три типа условий, связанных со значением поля:

Тип условия | Описание | Дополнительные параметры | Тип данных 
----- | ----- | ----- | -----
`FieldChangedCondition` | Значение поля изменилось | Без параметров | &nbsp;
`FieldEquals` | равно | `value` | Строка 
`FieldBecameEqual` | стало равно | `value` | Строка  

{% cut "Список полей, для которых применимы условия" %}

Поле | Идентификатор 
----- | ----- 
Очередь | queue
Тип | type
Приоритет | priority
Ключ | key
Задача | summary
Описание \* | description
Статус | status
Резолюция | resolution
Статус изменен | statusStartTime
Создано | createdAt
Обновлено | updatedAt
Разрешен | resolvedAt
Последний комментарий | lastCommentUpdatedAt
Дедлайн | deadline
Дата начала | start
Дата завершения | end
Автор | createdBy
Исполнитель | assignee
Наблюдатели | followers
Доступ | access
Изменил | updatedBy
Решивший | resolvedBy
Рассылки | followingMaillists
Проект | project
Теги | tags
Компоненты | components
Найдено в версиях | affectedVersions
Исправить в версиях | fixVersions
Родительский тикет | parent
Старая очередь | previousQueue
Проголосовали | votedBy
Проголосовало | votes
Комментариев без сообщения | commentWithoutExternalMessageCount
Комментариев с сообщением | commentWithExternalMessageCount
Доски | boards
Нужен ответ пользователя | pendingReplyFrom
Предыдущая очередь | lastQueue
Суммарный процент участия | participantPercentsTotal
Возможно спам | possibleSpam
Тип статуса | statusType
QA-инженер | qaEngineer
Первоначальная оценка | originalEstimation
Оценка | estimation
Затрачено времени | spent
Epic | epic
Story Points | storyPoints
Спринт | sprint
От \* | emailFrom
Кому | emailTo
Копия | emailCc
Создано по письму на адрес \* | emailCreatedBy

\* Для полей, отмеченных звездочкой, вместо типа условия **равно** (`FieldEquals`) используется **Равно строке** (`FieldEqualsString`).

{% endcut %}

> Примеры:
> ```
> { "type": "FieldChangedCondition", "field": "Приоритет" }
> { "type": "FieldEquals", "field": "Приоритет", "value": "blocker" }
> { "type": "FieldBecameEqual", "field": "Приоритет", "value": "blocker" }
> ```

### Состояние поля

Условия, связанные с наличием в поле значения:

Тип условия | Описание | Дополнительные параметры  
----- | ----- | ----- 
`FieldIsNotEmpty` | Значение поля не пусто | Без параметров
`FieldIsEmpty` | Значение поля пусто | Без параметров 
`FieldBecameEmpty` | Значение поля удалено | Без параметров  
`FieldBecameNotEmpty` | Значение поля установлено | Без параметров  

{% cut "Список полей, для которых применимы условия" %}

Поле | Идентификатор 
----- | ----- 
Описание | description
Резолюция | resolution
Статус изменен | statusStartTime
Разрешен | resolvedAt
Последний комментарий | lastCommentUpdatedAt
Дедлайн | deadline
Дата начала | start
Дата завершения | end
Исполнитель | assignee
Наблюдатели | followers
Доступ | access
Решивший | resolvedBy
Рассылки | followingMaillists
Проект | project
Теги | tags
Компоненты | components
Найдено в версиях | affectedVersions
Исправить в версиях | fixVersions
Родительский тикет | parent
Старая очередь | previousQueue
Проголосовали | votedBy
Доски | boards
Нужен ответ пользователя | pendingReplyFrom
Предыдущая очередь | lastQueue
Суммарный процент участия | participantPercentsTotal
Возможно спам | possibleSpam
Тип статуса | statusType
QA-инженер | qaEngineer
Первоначальная оценка | originalEstimation
Оценка | estimation
Затрачено времени | spent
Epic | epic
Story Points | storyPoints
Спринт | sprint
От | emailFrom
Кому | emailTo
Копия | emailCc
Создано по письму на адрес | emailCreatedBy

{% endcut %}

> Примеры:
> ```
> { "type": "FieldIsNotEmpty", "field": "assignee" }
> { "type": "FieldIsEmpty", "field": "assignee" }
> { "type": "FieldBecameEmpty", "field": "assignee" } 
> { "type": "FieldBecameNotEmpty", "field": "assignee" } 
> ```


### Дата

Условия, связанные с датами:

Тип условия | Описание | Дополнительные параметры | Тип данных 
----- | ----- | ----- | -----
`DateEqualCondition` | Дата совпадает | `value` | Строка в формате даты
`DateGreaterCondition` | Позднее | `value` | Строка в формате даты
`DateGreaterOrEqualCondition` | Позднее или равно | `value` | Строка в формате даты
`DateLessCondition` | Раньше | `value` | Строка в формате даты
`DateLessOrEqualCondition` | Раньше или равно | `value` | Строка в формате даты

{% cut "Список полей, для которых применимы условия" %}

Поле | Идентификатор 
----- | ----- 
Статус изменен | statusStartTime
Создано | createdAt
Обновлено | updatedAt
Разрешен | resolvedAt
Последний комментарий | lastCommentUpdatedAt
Дедлайн | deadline
Дата начала | start
Дата завершения | end

{% endcut %}

> Примеры:
> ```
> { "type": "DateEqualCondition", "field": "resolvedAt", "value": "2023-10-28T09:25:00"} 
> { "type": "DateGreaterCondition", "field": "resolvedAt", "value": "2023-10-28T09:25:00"}
> { "type": "DateGreaterOrEqualCondition", "field": "resolvedAt", "value": "2023-10-28T09:25:00"}
> { "type": "DateLessCondition", "field": "resolvedAt", "value": "2023-10-28T09:25:00"}
> { "type": "DateLessOrEqualCondition", "field": "resolvedAt", "value": "2023-10-28T09:25:00"}
> ```

### Группы пользователей

Условия, связанные с датами:

Тип условия | Описание | Дополнительные параметры | Тип данных 
----- | ----- | ----- | -----
`UserInGroups` | Пользователь входит в одну из групп | `value` | Строка или Массив строк
`UserNotInGroups` | Пользователь не входит ни в одну из групп | `value` | Строка или Массив строк

{% cut "Список полей, для которых применимы условия" %}

Поле | Идентификатор 
----- | ----- 
Автор | createdBy
Исполнитель | assignee
Изменил | updatedBy
Решивший | resolvedBy
QA-инженер | qaEngineer

{% endcut %}

> Примеры:
> ```
> {"type": "UserInGroups", "field": "createdBy","value": "1"}
> {"type": "UserNotInGroups", "field": "createdBy","value": ["1", "4"]}
> ```

### Количество элементов

Условия, связанные с количеством элементов:

Тип условия | Описание | Дополнительные параметры | Тип данных 
----- | ----- | ----- | ----- 
`Container.SizeGreater` | Количество элементов больше | `value` | Число
`Container.SizeGreaterOrEquals` | Количество элементов больше или равно | `value` | Число
`Container.SizeLess` | Количество элементов меньше | `value` | Число
`Container.SizeLessOrEquals` | Количество элементов меньше или равно | `value` | Число
`Container.SizeNotEquals` | Количество элементов не равно | `value` | Число
`Container.SizeEquals` | Количество элементов равно | `value` | Число
`ContainerContainsNone` | Не содержит ни одного элемента | <ul><li>`value`</li><li>`noMatchBefore`</li></ul> | <ul><li>Массив</li><li>Логический</li></ul>
`ContainerContainsAll` | Содержит все элементы | <ul><li>`value`</li><li>`noMatchBefore`</li></ul> | <ul><li>Массив</li><li>Логический</li></ul>
`ContainerContainsAny` | Содержит любой из элементов | <ul><li>`value`</li><li>`noMatchBefore`</li></ul> | <ul><li>Массив</li><li>Логический</li></ul>

{% cut "Список полей, для которых применимы условия" %}

Поле | Идентификатор 
----- | ----- 
Наблюдатели | followers
Доступ | access
Теги | tags
Компоненты | components
Найдено в версиях | affectedVersions
Исправить в версиях | fixVersions
Проголосовали | votedBy
Доски | boards
Нужен ответ пользователя | pendingReplyFrom
Спринт | sprint
Копия | emailCc
Кому | emailTo
Рассылки | followingMaillists

{% endcut %}

> Примеры:
> ```
> { "type": "Container.SizeGreater", "field": "followers", "value": 5 }
> { "type": "Container.SizeGreaterOrEquals", "field": "followers", "value": 5 }
> { "type": "Container.SizeLess", "field": "followers", "value": 5 }
> { "type": "Container.SizeLessOrEquals", "field": "followers", "value": 5 }
> { "type": "Container.SizeNotEquals", "field": "followers", "value": 5 }
> { "type": "Container.SizeEquals", "field": "followers", "value": 5 }
> { "type": "ContainerContainsNone", "field": "followers", "value": ["user11"], "noMatchBefore": false }
> { "type": "ContainerContainsAll", "field": "followers", "value": ["user11", "user22"], "noMatchBefore": false }
> { "type": "ContainerContainsAny", "field": "followers", "value": ["user33", "user35"], "noMatchBefore": false }
> ```


### Числовые значения

Условия, связанные с числовыми значениями:

Тип условия | Описание | Дополнительные параметры | Тип данных 
----- | ----- | ----- | ----- 
`GreaterCondition` | больше | `value` | Число
`GreaterOrEqualCondition` | больше или равно | `value` | Число
`LessCondition` | меньше | `value` | Число
`LessOrEqualCondition` | меньше или равно | `value` | Число
`BecameGreaterCondition` | стало больше | `value` | Число
`BecameGreaterOrEqualCondition` | стало больше или равно | `value` | Число
`BecameLessCondition` | стало меньше | `value` | Число
`BecameLessOrEqualCondition` | стало меньше или равно | `value` | Число

{% cut "Список полей, для которых применимы условия" %}

Поле | Идентификатор 
----- | ----- 
Проголосовало | votes
Комментариев без сообщения | commentWithoutExternalMessageCount
Комментариев с сообщением | commentWithExternalMessageCount
Суммарный процент участия | participantPercentsTotal
Возможно спам | possibleSpam
Первоначальная оценка | originalEstimation
Оценка | estimation
Затрачено времени | spent
Story Points | storyPoints

{% endcut %}

> Примеры:
> ```
> { "type": "GreaterCondition", "field": "spent", "value": 50400000 },  
> { "type": "GreaterOrEqualCondition", "field": "spent", "value": 50400000 }, 
> { "type": "LessCondition", "field":  "spent", "value": 50400000 }, 
> { "type": "LessOrEqualCondition",  "spent", "value": 50400000 }, 
> { "type": "BecameGreaterCondition", "field": "votes", "value": 6 },  
> { "type": "BecameGreaterOrEqualCondition", "field": "votes", "value": 6 },
> { "type": "BecameLessCondition", "field": "votes", "value": 6 },
> { "type": "BecameLessOrEqualCondition", "field": "votes", "value": 6 }
> ```


### Строковые значения

Условия, связанные со строковыми значениями:

Тип условия | Описание | Дополнительные параметры | Тип данных 
----- | ----- | ----- | ----- 
`ContainsNoneOfStrings` | Не содержит ни одного из фрагментов | <ul><li>`value`</li><li>`ignoreCase`</li></ul> | <ul><li>Массив</li><li>Логический</li></ul>
`FieldEqualsString` | Равно строке | <ul><li>`value`</li><li>`ignoreCase`</li></ul> | <ul><li>Строка</li><li>Логический</li></ul>
`ContainsAnyOfStrings` | Содержит любой из фрагментов | <ul><li>`value`</li><li>`ignoreCase`</li></ul> | <ul><li>Массив</li><li>Логический</li></ul>

{% cut "Список полей, для которых применимы условия" %}

Поле | Идентификатор 
----- | ----- 
Ключ | key
Задача | summary
Описание | description
От | emailFrom
Создано по письму на адрес | emailCreatedBy

{% endcut %}

> Примеры:
> ```
> { "type": "ContainsNoneOfStrings", "field": "summary", "value": ["Test task", "Test Version"], "ignoreCase": true }
> { "type": "FieldEqualsString", "field": "summary", "value": "New Task", "ignoreCase": false }
> { "type": "ContainsAnyOfStrings", "field": "summary", "value": ["Test task", "Test Version", "New Task"], "ignoreCase": false } 
> ```

