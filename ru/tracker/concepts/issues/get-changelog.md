---
sourcePath: ru/tracker/api-ref/concepts/issues/get-changelog.md
---
# Получить историю изменений задачи

Запрос позволяет получить историю изменений задачи. Если количество записей в ответе более 50, необходимо использовать [параметр `perPage`](#params).

## Формат запроса {#section_erc_zwm_z2b}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить список изменений задачи, используйте HTTP-запрос с методом `GET`. 
```json
GET /{{ ver }}/issues/<issue-id>/changelog
Host: {{ host }}
Authorization: OAuth <токен>
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
    Link: <{{ host }}/v2/issues/SCR-8/changelog?id=5b9a1a88f7c605001c0e14a5&perPage=50>; rel="next"
    ...
    ```
  {% endcut %}    

    ```json
    [
     {
            "id": "6033f986bd6c4a042c688392",
            "self": "{{ host }}/v2/issues/TEST-27/changelog/6033f986bd6c4a042c688392",
            "issue": {
                "self": "{{ host }}/v2/issues/TEST-27",
                "id": "6033f986bd6c4a042c688392",
                "key": "TEST-27",
                "display": "Название задачи"
            },
         "updatedAt": "2021-02-22T18:35:50.157+0000",
         "updatedBy": {
             "self": "{{ host }}/v2/users/1234567890",
             "id": "1234567890",
             "display": "Имя Фамилия"
         },
         "type": "IssueCreated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "{{ host }}/v2/fields/status",
                     "id": "status",
                     "display": "Статус"
                 },
                 "from": null,
                 "to": {
                     "self": "{{ host }}/v2/statuses/1",
                     "id": "1",
                     "key": "open",
                     "display": "Открыт"
                 }
             }
         ]
     },
     {
         "id": "6033f98d4417c101b655b93b",
         "self": "{{ host }}/v2/issues/TEST-27/changelog/6033f98d4417c101b655b93b",
         "issue": {
             "self": "{{ host }}/v2/issues/TEST-27",
             "id": "6033f986bd6c4a042c688391",
             "key": "TEST-27",
             "display": "Название задачи"
         },
         "updatedAt": "2021-02-22T18:35:57.359+0000",
         "updatedBy": {
             "self": "{{ host }}/v2/users/1234567890",
             "id": "1234567890",
             "display": "Имя Фамилия"
         },
         "type": "IssueUpdated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "{{ host }}/v2/fields/followers",
                     "id": "followers",
                     "display": "Наблюдатели"
                 },
                 "from": null,
                 "to": [
                     {
                         "self": "{{ host }}/v2/users/1234567890",
                         "id": "1234567890",
                         "display": "Имя Фамилия"
                     }
                 ]
             }
         ]
     },
     {
         "id": "6033f9954417c101b655b940",
         "self": "{{ host }}/v2/issues/TEST-27/changelog/6033f9954417c101b655b940",
         "issue": {
             "self": "{{ host }}/v2/issues/TEST-27",
             "id": "6033f986bd6c4a042c688391",
             "key": "TEST-27",
             "display": "Название задачи"
         },
         "updatedAt": "2021-02-22T18:36:05.553+0000",
         "updatedBy": {
             "self": "{{ host }}/v2/users/1234567890",
             "id": "1234567890",
             "display": "Имя Фамилия"
         },
         "type": "IssueUpdated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "{{ host }}/v2/fields/tags",
                     "id": "tags",
                     "display": "Теги"
                 },
                 "from": null,
                 "to": [
                     "Новый тег"
                 ]
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
   [fields](#fields) | Массив объектов с информацией об измененных параметрах задачи. | Массив      

   **Поля объекта** `issue` {#issue}

   {% include [issue](../../../_includes/tracker/api/issue.md) %}

   **Поля объекта** `updatedBy` {#updated-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   **Поля объектов массива** `fields` {#fields}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   [field](#field) | Блок с информацией об измененном параметре задачи. | Объект
   [from](#from-to) | Блок с информацией о значении параметра до изменения. | Объект
   [to](#from-to) | Блок с информацией о значении параметра после изменения. | Объект

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