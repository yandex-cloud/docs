# Получить историю изменений задачи

Запрос позволяет получить историю изменений задачи. Если количество записей в ответе более 50, необходимо использовать [параметр `perPage`](#params).

## Формат запроса {#section_erc_zwm_z2b}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить список изменений задачи, используйте HTTP-запрос с методом `GET`. 
```json
GET /{{ ver }}/issues/<issue-id>/changelog
Host: {{ host }}
Authorization: OAuth <токен>
X-Org-ID: <идентификатор организации>
```

### Параметры запроса

#### Заголовки

- **Host**

    Адрес узла, предоставляющего API:
    ```
    {{ host }}
    ```

- **Authorization**

    OAuth-токен в формате `OAuth <значение токена>`, например:
    ```
    OAuth 0c4181a7c2cf4521964a72ff57a34a07
    ```

- **X-Org-ID**

    Идентификатор организации.

#### Ресурс 

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<issue-id> | Идентификатор или ключ задачи. | Строка.

#### Дополнительные параметры {#params}

Параметр | Описание | Тип данных
-------- | -------- | ----------
id | Идентификатор изменения, за которым следуют запрашиваемые изменения. | Строка.
perPage | Количество изменений на странице. Если параметр не указан, по умолчанию на странице будет выведено 50 изменений. | Число.
field | Идентификатор [параметра изменений](#field). Например: `checklistItems` для просмотра изменений в чеклисте или `status` для просмотра всех обновлений статуса задачи.| Строка.
type | Ключ [типа изменения](#diff-type). | Строка.

## Формат ответа {#section_kms_pbr_1fb}

{% list tabs %}

- Запрос выполнен успешно

  В случае успешного выполнения запроса API возвращает ответ с кодом 200 OK. Тело ответа содержит JSON-массив с историей изменений задачи.
	
  ### Заголовки ответа {#answer-headers}
	
    Заголовки `Link` содержат ссылки на первую (`rel="first"`) и последующую (`rel="next"`) страницы ответа. По умолчанию на каждой странице располагается 50 изменений.
	
    ```
    ...
    Link: <https://api.tracker.yandex.net/v2/issues/SCR-8/changelog?perPage=50>; rel="first"
    Link: <https://api.tracker.yandex.net/v2/issues/SCR-8/changelog?id=5b9a1a88f7c605001c0e14a5&perPage=50>; rel="next"
    ...
    ```

  ### Тело ответа {#answer-body}

   
    ```json
    [
     {
            "id": "6033f986bd6c4a042c688392",
            "self": "https://api.tracker.yandex.net/v2/issues/TEST-27/changelog/6033f986bd6c4a042c688392",
            "issue": {
                "self": "https://api.tracker.yandex.net/v2/issues/TEST-27",
                "id": "6033f986bd6c4a042c688392",
                "key": "TEST-27",
                "display": "Название задачи"
            },
         "updatedAt": "2021-02-22T18:35:50.157+0000",
         "updatedBy": {
             "self": "https://api.tracker.yandex.net/v2/users/1234567890",
             "id": "1234567890",
             "display": "Имя Фамилия"
         },
         "type": "IssueCreated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "https://api.tracker.yandex.net/v2/fields/status",
                     "id": "status",
                     "display": "Статус"
                 },
                 "from": null,
                 "to": {
                     "self": "https://api.tracker.yandex.net/v2/statuses/1",
                     "id": "1",
                     "key": "open",
                     "display": "Открыт"
                 }
             }
         ]
     },
     {
         "id": "6033f98d4417c101b655b93b",
         "self": "https://api.tracker.yandex.net/v2/issues/TEST-27/changelog/6033f98d4417c101b655b93b",
         "issue": {
             "self": "https://api.tracker.yandex.net/v2/issues/TEST-27",
             "id": "6033f986bd6c4a042c688391",
             "key": "TEST-27",
             "display": "Название задачи"
         },
         "updatedAt": "2021-02-22T18:35:57.359+0000",
         "updatedBy": {
             "self": "https://api.tracker.yandex.net/v2/users/1234567890",
             "id": "1234567890",
             "display": "Имя Фамилия"
         },
         "type": "IssueUpdated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "https://api.tracker.yandex.net/v2/fields/followers",
                     "id": "followers",
                     "display": "Наблюдатели"
                 },
                 "from": null,
                 "to": [
                     {
                         "self": "https://api.tracker.yandex.net/v2/users/1234567890",
                         "id": "1234567890",
                         "display": "Имя Фамилия"
                     }
                 ]
             }
         ]
     },
     {
         "id": "6033f9954417c101b655b940",
         "self": "https://api.tracker.yandex.net/v2/issues/TEST-27/changelog/6033f9954417c101b655b940",
         "issue": {
             "self": "https://api.tracker.yandex.net/v2/issues/TEST-27",
             "id": "6033f986bd6c4a042c688391",
             "key": "TEST-27",
             "display": "Название задачи"
         },
         "updatedAt": "2021-02-22T18:36:05.553+0000",
         "updatedBy": {
             "self": "https://api.tracker.yandex.net/v2/users/1234567890",
             "id": "1234567890",
             "display": "Имя Фамилия"
         },
         "type": "IssueUpdated",
         "transport": "front",
         "fields": [
             {
                 "field": {
                     "self": "https://api.tracker.yandex.net/v2/fields/tags",
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
          
          
  #### Параметры ответа {#answer-params}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   id | Идентификатор изменения. | Строка.
   self | Адрес ресурса API, который содержит информацию об изменении. | Строка.
   [issue](#issue) | Блок с информацией о задаче. | Объект.
   updatedAt | Дата и время изменения задачи в формате `YYYY-MM-DDThh:mm:ss.sss±hhmm`. | Строка.
   [updatedBy](#updated-by) | Блок с информацией о пользователе, который внес изменение в задачу. | Объект.
   transport | Служебный параметр. | Строка.
   type | [Тип изменения](#diff-type). | Строка.
   [fields](#fields) | Массив объектов с информацией об измененных параметрах задачи. | Массив.      

   **Поля объекта** `issue` {#issue}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Ссылка на задачу. | Строка.
   id | Идентификатор задачи. | Строка.
   key | Ключ задачи. | Строка.
   display | Отображаемое название задачи. | Строка.

   **Поля объекта** `updatedBy` {#updated-by}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Ссылка на пользователя. | Строка.
   id | Идентификатор пользователя. | Строка.
   display | Отображаемое имя пользователя. | Строка.

   **Поля объектов массива** `fields` {#fields}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   [field](#field) | Блок с информацией об измененном параметре задачи. | Объект.
   [from](#from-to) | Блок с информацией о значении параметра до изменения. | Объект.
   [to](#from-to) | Блок с информацией о значении параметра после изменения. | Объект.

   **Поля объекта** `field` {#field}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Ссылка на измененный параметр задачи. | Строка.
   id | Идентификатор параметра задачи. | Строка.
   display | Отображаемое название параметра задачи. | Строка.

   **Поля объектов** `from` **и** `to` {#from-to}

   Параметр | Описание | Тип данных
   ----- | ----- | -----
   self | Ссылка на значение параметра задачи. | Строка.
   id | Идентификатор значения параметра задачи. | Строка.
   key | Ключ значения параметра. | Строка.
   display | Отображаемое название значения параметра. | Строка.
		
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

- Запрос выполнен с ошибкой

  Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:
	
  HTTP-код ошибки | Описание ошибки
  ----- | -----
  400 Bad Request | Один из параметров запроса имеет недопустимое значение или формат данных.
  403 Forbidden | У пользователя или приложения нет прав на доступ к ресурсу, запрос отклонен.
  404 Not Found | Запрашиваемый ресурс не найден.
  422 Unprocessable Entity | Ошибка валидации JSON, запрос отклонен.
  500 Internal Server Error | Внутренняя ошибка сервиса. Попробуйте повторно отправить запрос через некоторое время.
  503 Service Unavailable | Сервис API временно недоступен.

{% endlist %}