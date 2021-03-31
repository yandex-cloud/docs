# Аудитный лог событий

Формат записей в аудитном логе событий универсален для всех операций. Значения некоторых полей определяются сервисом-источником и типом события.

Объект события — ресурс сервиса, над которым производится операция. Субъект события — аккаунт, от имени которого производится операция.

## Схема данных {#scheme}

```json
[{
  "event_id": string,
  "event_source": string,
  "event_type": string,
  "event_time": string,
  "authentication": {
    "authenticated": boolean,
    "subject_type": string,
    "subject_id": string,
    "subject_name": string
  },
  "authorization": {
    "authorized": boolean
  },
  "resource_metadata": {
    "cloud_id": string,
    "cloud_name": string,
    "folder_id": string,
    "folder_name": string
  },
  "request_metadata": {
    "remote_address": string,
    "user_agent": string,
    "request_id": string
  },
  "event_status": string,
  "details": {
    object
  }
}]
```

Поле | Описание
--- | ---
`event_id` | **string**<br/>Идентификатор события.
`event_source` | **string**<br/>Имя сервиса-источника события.
`event_type` | **string**<br/>Тип события. Определяется сервисом-источником события. Подробнее смотрите в разделе [{#T}](events.md).
`event_time` | **string**<br/>Время, в которое произошло событие.
`authentication` | **object**<br/>Данные аутентификации субъекта события.
`authentication.authenticated` | **boolean**<br/>Результат аутентификации. Возможные значения:<ul><li>`true` — аутентификация успешна;</li><li>`false` — аутентификация неуспешна.</li>
`authentication.subject_type` | **string**<br/>Тип субъекта. Возможные значения:<ul><li>`YANDEX_PASSPORT_USER_ACCOUNT` — аккаунт на Яндексе;</li><li>`SERVICE_ACCOUNT` — сервисный аккаунт;</li><li>`FEDERATED_USER_ACCOUNT` — федеративный аккаунт.</li>
`authentication.subject_id` | **string**<br/>Идентификатор субъекта.
`authentication.subject_name` | **string**<br/>Имя субъекта.
`authorization` | **object**<br/>Данные авторизации субъекта события.
`authorization.authorized` | **boolean**<br/>Результат авторизации. Возможные значения:<ul><li>`true` — авторизация успешна;</li><li>`false` — авторизация неуспешна.</li>
`resource_metadata` | **object**<br/>Метаданные объекта события.
`resource_metadata.cloud_id` | **string**<br/>Идентификатор облака.
`resource_metadata.cloud_name` | **string**<br/>Имя облака.
`resource_metadata.folder_id` | **string**<br/>Идентификатор каталога.
`resource_metadata.folder_name` | **string**<br/>Имя каталога.
`request_metadata` | **object**<br/>Данные о запросе, который инициировал событие.
`request_metadata.remote_address` | **string**<br/>IP-адрес субъекта события.
`request_metadata.user_agent` | **string**<br/>User-Agent субъекта события.
`request_metadata.request_id` | **string**<br/>Идентификатор запроса.
`event_status` | **string**<br/>Статус события. Определяется сервисом-источником и типом события.  Возможные значения:<ul><li>`STARTED` — операция начата;</li><li>`ERROR` — операция завершена с ошибкой;</li><li>`DONE` — операция завершена успешно;</li><li>`CANCELLED` — операция отменена.</li>
`details` | **object**<br/>Детали события. Определяются сервисом-источником и типом события.
