---
sourcePath: ru/tracker/api-ref/concepts/bulkchange/bulk-move-info.md
---
# Информация о выполнении пакетной операции

Вы можете получить статус выполнения операции массового редактирования задач, а также список возникших ошибок для каждой задачи:
* [Получить статус выполнения пакетной операции](#status).
* [Получить список задач, для которых операция завершилась с ошибкой](#errors).

## Получить статус выполнения пакетной операции {#status}

### Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить статус выполнения пакетной операции, используйте HTTP-запрос с методом `GET`.

```json
GET /{{ ver }}/bulkchange/{id}
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<id> | Идентификатор запущенной пакетной операции в формате `593cd211ef7e8a33********`. | Строка

{% endcut %} 

### Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   Тело ответа содержит информацию о статусе пакетной операции в формате JSON.

   ```json
   {
      "id": "593cd211ef7e8a33********",
      "self": "https://{{ host }}/{{ ver }}/bulkchange/593cd211ef7e8a33********",
      "createdBy": {
         "self": "https://{{ host }}/{{ ver }}/users/1120000000******",
         "id": "111111",
         "display": "Иван Иванов",
         "passportUid": 12********
      },
      "createdAt": "2024-06-26T19:00:47.451+0000",
      "status": "FAILED",
      "statusText": "Завершился с ошибками",
      "executionChunkPercent": 100,
      "executionIssuePercent": 100,
      "totalIssues": 24,
      "totalCompletedIssues": 0
   }
   ```

   {% cut "Параметры ответа" %}

   Параметр | Описание | Тип данных
   -------- | -------- | ----------
   id | Идентификатор пакетной операции. | Строка
   self | Адрес ресурса API, который содержит информацию о пакетной операции. | Строка
   [createdBy](#createdBy) | Информация об инициаторе пакетной операции. | Объект
   createdAt | Дата и время создания пакетной операции. | Строка
   status | Статус пакетной операции. | Строка
   statusText | Описание статуса пакетной операции. | Строка
   executionChunkPercent | Служебный параметр. | Число
   executionIssuePercent | Служебный параметр. | Число
   totalIssues | Количество задач, которые должны быть отредактированы. | Число
   totalCompletedIssues | Количество задач, для которых пакетная операция завершилась успешно. | Число

   **Поля объекта** `createdBy` {#created-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   {% endcut %}

- Запрос выполнен с ошибкой

   Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

   {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}

## Получить список задач, для которых операция завершилась с ошибкой {#errors}

### Формат запроса {#query}

Перед выполнением запроса [получите доступ к API](../access.md).

Чтобы получить список задач, для которых пакетная операция завершилась с ошибкой, используйте HTTP-запрос с методом `GET`.

```json
GET /{{ ver }}/bulkchange/{id}/issues
Host: {{ host }}
Authorization: OAuth <OAuth-токен>
{{ org-id }}
```

{% include [headings](../../../_includes/tracker/api/headings.md) %}

{% cut "Ресурс" %}

Параметр | Описание | Тип данных
-------- | -------- | ----------
\<id> | Идентификатор запущенной пакетной операции в формате `593cd211ef7e8a33********`. | Строка

{% endcut %}

### Формат ответа {#answer}

{% list tabs %}

- Запрос выполнен успешно

   {% include [answer-200](../../../_includes/tracker/api/answer-200.md) %}

   Тело ответа содержит список задач, для которых пакетная операция завершилась с ошибкой, в формате JSON.

   ```json
   [
      {
         "issue": {
               "self": "https://{{ host }}/{{ ver }}/issues/TEST-1",
               "id": "593cd211ef668a33********",
               "key": "TEST-1",
               "display": "Тест"
         },
         "status": "FAILED",
         "statusText": "Изменения не выполнены",
         "error": {
               "errors": {
                  "resolution": "Выбранную резолюцию нельзя использовать для задачи этого типа в данной очереди."
               },
               "errorMessages": []
         }
      },
      {
         "issue": {
               "self": "https://{{ host }}/{{ ver }}/issues/TEST-4",
               "id": "593cd211ef756a33********",
               "key": "TEST-4",
               "display": "Задача"
         },
         "status": "FAILED",
         "statusText": "Изменения не выполнены",
         "error": {
               "errors": {
                  "resolution": "Выбранную резолюцию нельзя использовать для задачи этого типа в данной очереди."
               },
               "errorMessages": []
         }
      },
      ...
   ]
   ```

   {% cut "Параметры ответа" %}

   Параметр | Описание | Тип данных
   -------- | -------- | ----------
   [issue](#issue) | Блок с информацией о задаче. | Объект
   status | Тип ошибки выполнения пакетной операции. | Строка
   statusText | Описание ошибки выполнения пакетной операции. | Строка
   [error](#error) | Блок с информацией об ошибках, возникших в задаче при выполнении пакетной операции. | Объект

   **Поля объекта** `createdBy` {#created-by}

   {% include [user](../../../_includes/tracker/api/user.md) %}

   **Поля объекта** `error` {#error}

   Параметр | Описание | Тип данных
   -------- | -------- | ----------
   errors | Описание ошибок. | Объект
   errorMessages | Служебный параметр. | Массив

   {% endcut %}

- Запрос выполнен с ошибкой

   Если запрос не был успешно обработан, API возвращает ответ с кодом ошибки:

   {% include [error](../../../_includes/tracker/api/answer-error-400.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-401.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-403.md) %}

   {% include [error](../../../_includes/tracker/api/answer-error-422.md) %}

{% endlist %}