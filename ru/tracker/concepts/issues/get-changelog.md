---
sourcePath: ru/tracker/api-ref/concepts/issues/get-changelog.md
---
# Получить историю изменений задачи

Запрос позволяет получить историю изменений задачи. Если количество записей в ответе более 50, необходимо использовать [параметр `perPage`](#params).

## Формат запроса {#section_erc_zwm_z2b}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить список изменений задачи, используйте HTTP-запрос с методом `GET`. 
```json
GET /{{ ver }}/issues/<ключ_или_идентификатор_задачи>/changelog
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% include [resource-issue-id](../../../_includes/tracker/api/resource-issue-id.md) %}  

{% cut "Параметры запроса" %}

#### Дополнительные параметры {#params}

Параметр | Описание | Тип данных
-------- | -------- | ----------
id | Идентификатор изменения, за которым следуют запрашиваемые изменения. | Строка
perPage | Количество изменений на странице. Если параметр не указан, по умолчанию на странице будет выведено 50 изменений. | Число
field | Идентификатор [параметра изменений](#field). Например, `checklistItems` для просмотра изменений в чеклисте или `status` для просмотра всех обновлений статуса задачи.| Строка
type | Ключ [типа изменения](#diff-type). | Строка

{% endcut %}

## Формат ответа {#section_kms_pbr_1fb}

{% list tabs %}

- Запрос выполнен успешно

    {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}
  
    Тело ответа содержит JSON-массив с историей изменений задачи.
	
  {% cut "Заголовки ответа" %}
	
    Заголовки `Link` содержат ссылки на первую (`rel="first"`) и последующую (`rel="next"`) страницы ответа. По умолчанию на каждой странице располагается 50 изменений.
	
    ```
    ...
    Link: <{{ host }}/v2/issues/SCR-8/changelog?perPage=50>; rel="first"
    Link: <{{ host }}/v2/issues/SCR-8/changelog?id=5b9a1a88f7c60500********&perPage=50>; rel="next"
    ...
    ```
  {% endcut %}    

    ```json
    [
     {
         "id": "6033f986bd6c4a04********",
         "self": "https://{{ host }}/v2/issues/TEST-27/changelog/6033f986bd6c4a04********",
         "issue": {
             "self": "https://{{ host }}/v2/issues/TEST-27",
             "id": "6033f986bd6c4a04********",
             "key": "TEST-27",
             "display": "Название задачи"
         },
         "updatedAt": "2021-02-22T18:35:50.157+0000",
         "updatedBy": {
             "self": "https://{{ host }}/v2/users/71********",
             "id": "71********",
             "display": "Имя Фамилия"
         },
         "type": "IssueCreated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "https://{{ host }}/v2/fields/status",
                     "id": "status",
                     "display": "Статус"
                 },
                 "from": null,
                 "to": {
                     "self": "https://{{ host }}/v2/statuses/1",
                     "id": "1",
                     "key": "open",
                     "display": "Открыт"
                 }
             }
         ]
     },
     {
         "id": "6033f98d4417c101********",
         "self": "https://{{ host }}/v2/issues/TEST-27/changelog/6033f98d4417c101********",
         "issue": {
             "self": "https://{{ host }}/v2/issues/TEST-27",
             "id": "6033f986bd6c4a04********",
             "key": "TEST-27",
             "display": "Название задачи"
         },
         "updatedAt": "2021-02-22T18:35:57.359+0000",
         "updatedBy": {
             "self": "https://{{ host }}/v2/users/71********",
             "id": "71********",
             "display": "Имя Фамилия"
         },
         "type": "IssueUpdated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "https://{{ host }}/v2/fields/followers",
                     "id": "followers",
                     "display": "Наблюдатели"
                 },
                 "from": null,
                 "to": [
                     {
                         "self": "https://{{ host }}/v2/users/71********",
                         "id": "71********",
                         "display": "Имя Фамилия"
                     }
                 ]
             }
         ]
     },
     {
         "id": "6033f9954417c101********",
         "self": "https://{{ host }}/v2/issues/TEST-27/changelog/6033f9954417c101********",
         "issue": {
             "self": "https://{{ host }}/v2/issues/TEST-27",
             "id": "6033f986bd6c4a04********",
             "key": "TEST-27",
             "display": "Название задачи"
         },
         "updatedAt": "2021-02-22T18:36:05.553+0000",
         "updatedBy": {
             "self": "https://{{ host }}/v2/users/71********",
             "id": "71********",
             "display": "Имя Фамилия"
         },
         "type": "IssueUpdated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "https://{{ host }}/v2/fields/tags",
                     "id": "tags",
                     "display": "Теги"
                 },
                 "from": null,
                 "to": [
                     "Новый тег"
                 ]
             }
         ],
     },
     {
        "id": "62bab52ca16f631e********",
        "self": "https://{{ host }}/v2/issues/TEST-27/changelog/62bab52ca16f631e********",
        "issue": {
            "self": "https://{{ host }}/v2/issues/TEST-27",
            "id": "5fbc929b5b28572f********",
            "key": "TEST-27",
            "display": "Название задачи"
        },
        "updatedAt": "2022-06-28T08:00:44.155+0000",
        "updatedBy": {
            "self": "https://{{ host }}/v2/users/71********",
            "id": "71********",
            "display": "Имя Фамилия"
        },
        "type": "IssueWorkflow",
        "transport": "front",
        "fields": [
            {
                "field": {
                    "self": "https://{{ host }}/v2/fields/status",
                    "id": "status",
                    "display": "Статус"
                },
                "from": {
                    "self": "https://{{ host }}/v2/statuses/3",
                    "id": "3",
                    "key": "inProgress",
                    "display": "В работе"
                },
                "to": {
                    "self": "https://{{ host }}/v2/statuses/2",
                    "id": "2",
                    "key": "needInfo",
                    "display": "Требуется информация"
                }
            },
            {
                "field": {
                    "self": "https://{{ host }}/v2/fields/statusStartTime",
                    "id": "statusStartTime",
                    "display": "Статус изменен"
                },
                "from": "2022-06-28T07:29:45.753+0000",
                "to": "2022-06-28T08:00:44.156+0000"
            },
            {
                "field": {
                    "self": "https://{{ host }}/v2/fields/followers",
                    "id": "followers",
                    "display": "Наблюдатели"
                },
                "from": [
                    {
                        "self": "https://{{ host }}/v2/users/71********",
                        "id": "71********",
                        "display": "Имя Фамилия"
                    },
                    {
                        "self": "https://{{ host }}/v2/users/71********",
                        "id": "71********",
                        "display": "Имя Фамилия"
                    }
                ],
                "to": [
                    {
                        "self": "https://{{ host }}/v2/users/71********",
                        "id": "71********",
                        "display": "Имя Фамилия"
                    },
                    {
                        "self": "https://{{ host }}/v2/users/71********",
                        "id": "71********",
                        "display": "Имя Фамилия"
                    },
                    {
                        "self": "https://{{ host }}/v2/users/71********",
                        "id": "71********",
                        "display": "Имя Фамилия"
                    }
                ]
            }
        ], 
        "comments": {
            "added": [
                {
                    "self": "https://{{ host }}/v2/issues/TEST-27/comments/10",
                    "id": "10",
                    "display": "Текст комментария"
                }
            ]
        },
        "executedTriggers": [
            {
                "trigger": {
                    "self": "https://{{ host }}/v2/queues/TEST/triggers/29",
                    "id": "29",
                    "display": "Триггер-42"
                },
                "success": true,
                "message": "Успех"
            }
         ]
      }
    ]
    ``` 
          
  {% cut "Параметры ответа" %}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   id | Идентификатор изменения. | Строка
   self | Адрес ресурса API, который содержит информацию об изменении. | Строка
   [issue](#issue) | Блок с информацией о задаче. | Объект
   updatedAt | Дата и время изменения задачи в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка
   [updatedBy](#updated-by) | Блок с информацией о пользователе, который внес изменение в задачу. | Объект
   transport | Служебный параметр. | Строка
   type | [Тип изменения](#diff-type). | Строка
   [fields](#fields) | Массив объектов с информацией об измененных параметрах задачи. | Массив объектов
   [comments](#comments) | Блок с информацией о [комментарии](get-comments.md) к задаче. | Объект 
   [executedTriggers](#executedTriggers) | Блок с информацией о [триггере](../queues/get-trigger.md), который сработал в задаче. | Объект       

   **Поля объекта** `issue` {#issue}

   {% include [issue](../../../_includes/tracker/api/issue.md) %}

   **Поля объекта** `updatedBy` {#updated-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   **Поля объектов массива** `fields` {#fields}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   [field](#field) | Блок с информацией об измененном параметре задачи. | Объект
   [from](#from-to) | Информация о значении параметра до изменения. <ul><li>Если в поле можно записать несколько значений, то передается массив объектов. Например, поле `followers`.</li><li>Если в поле можно записать только одно значение, то оно передается в строковом формате. Например, поле `statusStartTime`.</li></ul> | Строка / Объект 
   [to](#from-to) | Информация о значении параметра после изменения. <ul><li>Если в поле можно записать несколько значений, то передается массив объектов. Например, поле `followers`.</li><li>Если в поле можно записать только одно значение, то оно передается в строковом формате. Например, поле `statusStartTime`.</li></ul> | Строка / Объект

   **Поля объекта** `field` {#field}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Ссылка на измененный параметр задачи. | Строка
   id | Идентификатор параметра задачи. | Строка
   display | Отображаемое название параметра задачи. | Строка

   **Поля объектов** `from` **и** `to` {#from-to} 

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Ссылка на значение параметра задачи. | Строка
   id | Идентификатор значения параметра задачи. | Строка
   key | Ключ значения параметра. | Строка
   display | Отображаемое название значения параметра. | Строка

   **Поля объекта** `comments` {#comments}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   [added](#added) | Блок с информацией о комментарии. | Объект

   **Поля объекта** `added` {#added}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Ссылка на объект комментария. | Строка
   id | Идентификатор комментария. | Число
   display | Текст комментария. | Строка

   **Поля объекта** `executedTriggers` {#executedTriggers}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   [trigger](#trigger) | Блок с информацией о триггере. | Объект
   success | Статус срабатывания триггера. Допустимые значения:<ul><li>`true`— успешно;</li><li>`false`— неуспешно.</li></ul>| Логический
   message | Действие, которое было выполнено при срабатывании триггера. | Строка

   **Поля объекта** `trigger` {#trigger}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Ссылка на объект триггера. | Строка
   id | Идентификатор триггера. | Число
   display | Отображаемое название триггера. | Строка
	
   **Тип изменения** `type` {#diff-type}
		
   Тип изменения | Описание
   ----- | -----
   IssueUpdated | Задача изменена.
   IssueCreated | Задача создана.
   IssueMoved | Задача перемещена в другую очередь.
   IssueCloned | Создан клон задачи.
   IssueCommentAdded | Добавлен комментарий к задаче.
   IssueCommentUpdated | Изменен комментарий к задаче.
   IssueCommentRemoved | Удален комментарий к задаче.
   IssueWorklogAdded | Добавлена запись о затраченном времени.
   IssueWorklogUpdated | Изменена запись о затраченном времени.
   IssueWorklogRemoved | Удалена запись о затраченном времени.
   IssueCommentReactionAdded | За комментарий проголосовали.
   IssueCommentReactionRemoved | Отозван голос за комментарий.
   IssueVoteAdded | За задачу проголосовали.
   IssueVoteRemoved | Отозван голос за задачу.
   IssueLinked | Создана связь с другой задачей.
   IssueLinkChanged | Изменен тип связи с другой задачей.
   IssueUnlinked | Удалена связь с другой задачей.
   RelatedIssueResolutionChanged | Изменена резолюция связанной задачи.
   IssueAttachmentAdded | К задаче прикреплен файл.
   IssueAttachmentRemoved | Прикрепленный к задаче файл удален.
   IssueWorkflow | Изменен статус задачи.

  {% endcut %}   

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

  {% include [answer-error-401](../../../_includes/tracker/api/answer-error-401.md) %}

  {% include [answer-error-403](../../../_includes/tracker/api/answer-error-403.md) %}

  {% include [answer-error-404](../../../_includes/tracker/api/answer-error-404.md) %}

  {% include [answer-error-422](../../../_includes/tracker/api/answer-error-422.md) %}

  {% include [answer-error-500](../../../_includes/tracker/api/answer-error-500.md) %}

  {% include [answer-error-503](../../../_includes/tracker/api/answer-error-503.md) %}

{% endlist %}