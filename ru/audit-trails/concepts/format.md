# Аудитный лог

Аудитный лог — это запись о событиях, которые произошли с ресурсами {{ yandex-cloud }}, в форме JSON-объекта.

[Формат](#scheme) записей универсален для всех событий. Значения некоторых полей определяются ресурсом-источником и типом события.

Объект события — ресурс сервиса, над которым производится операция. Субъект события — аккаунт, от имени которого производится операция.

## Схема данных  {#scheme}

```json
{
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
    "path": [{
      "resource_type": string,
      "resource_id": string,
      "resource_name": string
    }]
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
}
```

Поле | Описание
--- | ---
`event_id` | **string**<br>Идентификатор события.
`event_source` | **string**<br>Имя сервиса-источника события.
`event_type` | **string**<br>Тип события. Определяется сервисом-источником события. Подробнее смотрите в разделе [{#T}](events.md).
`event_time` | **string**<br>Время, в которое произошло событие.
`authentication` | **object**<br>Данные аутентификации субъекта события.
`authentication.authenticated` | **boolean**<br>Результат аутентификации. Возможные значения:<ul><li>`true` — аутентификация успешна;</li><li>`false` — аутентификация неуспешна.</li>
`authentication.subject_type` | **string**<br>Тип субъекта. Возможные значения:<ul>{% if product == "yandex-cloud" %}<li>`YANDEX_PASSPORT_USER_ACCOUNT`— аккаунт на Яндексе;</li>{% endif %}<li>`SERVICE_ACCOUNT` — сервисный аккаунт;</li><li>`FEDERATED_USER_ACCOUNT` — федеративный аккаунт.</li>
`authentication.subject_id` | **string**<br>Идентификатор субъекта.
`authentication.subject_name` | **string**<br>Имя субъекта.
`authorization` | **object**<br>Данные авторизации субъекта события.
`authorization.authorized` | **boolean**<br>Результат авторизации. Возможные значения:<ul><li>`true` — авторизация успешна;</li><li>`false` — авторизация неуспешна.</li>
`resource_metadata` | **object**<br>Метаданные объекта события.
`resource_metadata.path[]` | **array**<br>Путь к ресурсу в котором произошло событие.
`resource_metadata.path[].resource_type` | **string**<br>Тип ресурса.
`resource_metadata.path[].resource_id` | **string**<br>Идентификатор ресурса.
`resource_metadata.path[].resource_name` | **string**<br>Имя ресурса.
`request_metadata` | **object**<br>Данные о запросе, который инициировал событие.
`request_metadata.remote_address` | **string**<br>IP-адрес субъекта события.
`request_metadata.user_agent` | **string**<br>User-Agent субъекта события.
`request_metadata.request_id` | **string**<br>Идентификатор запроса.
`event_status` | **string**<br>Статус события. Определяется сервисом-источником и типом события. Возможные значения:<ul><li>`STARTED` — операция начата;</li><li>`ERROR` — операция завершена с ошибкой;</li><li>`DONE` — операция завершена успешно;</li><li>`CANCELLED` — операция отменена.</li>
`details` | **object**<br>Детали события. Определяются сервисом-источником и типом события.

{% if product == "yandex-cloud" %}
## Представление аудитного лога {#log-name}

В зависимости от [объекта назначения](./trail.md#target) — бакет или лог-группа — изменяется структура и содержимое сообщения, в составе которого {{ at-name }} передает объекту назначения аудитные логи:
* для бакета — файл, в котором находится массив [JSON-объектов](./format.md#scheme) аудитного лога;
* для лог-группы — сообщение, в котором находится только один JSON-объект аудитного лога.
{% endif %}
### Файл аудитного лога в бакете {#log-file-name}

Шаблон полного имени файла аудитного лога в бакете:

`<префикс объекта>/<идентификатор трейла>/<год>/<месяц>/<имя_файла.json>`

{% if product == "yandex-cloud" %}
### Запись в лог-группе {#logging-group-name}

Значения записей в лог-группе:
* **Время** — значение поля `event_time` события.
* **JSON** — JSON-объект события.
* **Уровень** — вычисляется в зависимости от значения `event_status` события:
  * `ERROR`  —  для значения `ERROR`;
  * `WARN` — для значения `CANCELLED`;
  * `INFO` — в остальных случаях.
* **Сообщение** — содержит значения полей `event_status`, `event_type`, `subject_name`, `cloud_name`, `resource_name`.
{% endif %}