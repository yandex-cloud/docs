# Аудитный лог событий уровня сервисов

Отслеживайте [события уровня сервисов](events-data-plane.md), чтобы убедиться, что только авторизованные пользователи получают доступ к вашим данным и изменяют их. Это поможет обеспечить соответствие вашей облачной инфраструктуры нормативным правовым актам и отраслевым стандартам. Например, вы можете отслеживать получение сотрудниками доступа к конфиденциальным данным, хранящимся в бакетах.

Анализируйте логи событий уровня сервисов, чтобы оптимизировать использование ресурсов в вашей инфраструктуре. Так вы сможете определить наиболее часто используемые ресурсы и повысить их производительность. Или, наоборот, выявить редко используемые ресурсы, которые можно объединить или удалить для сокращения затрат.

{% note warning %}

При настройке сбора событий уровня сервисов для бакета {{ objstorage-name }} не рекомендуем выбирать этот же бакет в качестве [объекта назначения](./trail.md#target) загрузки логов. В этом случае может возникнуть автоматическая рекурсивная генерация логов аудита, что приведет к увеличению объема генерируемых логов (приблизительно на 16 МБ в месяц для всех событий одного трейла, сохраняемых в бакете).

{% endnote %}

Аудитный лог событий уровня сервисов — это запись о событиях, которые произошли с ресурсами {{ yandex-cloud }}, в форме JSON-объекта.

[Формат](#scheme) записей универсален для всех событий. Значения некоторых полей определяются ресурсом-источником и типом события.

Объект события — ресурс сервиса, над которым производится операция. Субъект события — аккаунт, от имени которого производится операция.

{% cut "Пример аудитного лога уровня сервисов при запросе содержимого секрета" %}

Если федеративный пользователь запросит содержимое секрета в сервисе {{ lockbox-full-name }}, в аудитный лог попадет такая запись:

```json
{
    "event_id": "<идентификатор_события>",
    "event_source": "lockbox",
    "event_type": "yandex.cloud.audit.lockbox.GetPayload",
    "event_time": "<дата_события>",
    "authentication": {
        "authenticated": true,
        "subject_type": "FEDERATED_USER_ACCOUNT",
        "subject_id": "<идентификатор_пользователя>",
        "subject_name": "<логин_пользователя>",
        "federation_id": "<идентификатор_федерации>",
        "federation_name": "<имя_федерации>",
        "federation_type": "<тип_федерации>"
    },
    "authorization": {
        "authorized": true
    },
    "resource_metadata": {
        "path": [
            {
                "resource_type": "organization-manager.organization",
                "resource_id": "<идентификатор_организации>",
                "resource_name": "<имя_организации>"
            },
            {
                "resource_type": "resource-manager.cloud",
                "resource_id": "<идентификатор_облака>",
                "resource_name": "<имя_облака>"
            },
            {
                "resource_type": "resource-manager.folder",
                "resource_id": "<идентификатор_каталога>",
                "resource_name": "<имя_каталога>"
            }
        ]
    },
    "request_metadata": {
        "remote_address": "cloud.yandex",
        "user_agent": "Yandex Cloud",
        "request_id": "<идентификатор_запроса>"
    },
    "event_status": "DONE",
    "details": {
        "secret_id": "<идентификатор_секрета>",
        "secret_name": "<имя_секрета>",
        "secret_version_id": "<идентификатор_версии_секрета>",
        "secret_kms_key_id": "<идентификатор_ключа_шифрования_секрета_в_KMS>",
        "secret_status": "<статус_секрета>",
        "secret_version_status": "<статус_версии_секрета>",
        "secret_version_payload_entry_keys": [
            "<ключи_записей_в_версии_секрета>"
        ]
    },
    "request_parameters": {
        "secret_id": "<идентификатор_секрета>",
        "version_id": "<идентификатор_версии_секрета>"
    },
    "response": {
        "version_id": "<идентификатор_версии>",
        "entry_keys": [
            "<ключи_записей>"
        ]
    }
}
```
{% endcut %}

## Схема данных {#scheme}

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
    "subject_name": string,
    "federation_id": string,
    "federation_name": string,
    "federation_type": string,
    "impersonator_info": {
      "impersonator_id": string,
      "type": string,
      "name": string,
      "federation_id": string,
      "federation_name": string,
      "federation_type": string
    }
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
  "error": {
    "code": number,
    "message": string,
    "details": {
      object
    }
  },
  "details": {
    object
  }
  "request_parameters": {
    object
  }
  "response": {
    object
  }
}
```

Поле | Описание
--- | ---
`event_id` | **string**<br>Идентификатор события.
`event_source` | **string**<br>Имя сервиса-источника события.
`event_type` | **string**<br>Тип события. Определяется сервисом-источником события. Подробнее смотрите в разделе [{#T}](events-data-plane.md).
`event_time` | **string**<br>Время, в которое произошло событие.
`authentication` | **object**<br>Данные аутентификации субъекта события.
`authentication.authenticated` | **boolean**<br>Результат аутентификации. Возможные значения:<ul><li>`true` — аутентификация успешна;</li><li>`false` — аутентификация неуспешна.</li>
`authentication.subject_type` | **string**<br>Тип субъекта. Возможные значения:<ul><li>`YANDEX_PASSPORT_USER_ACCOUNT`— аккаунт на Яндексе;</li><li>`SERVICE_ACCOUNT` — сервисный аккаунт;</li><li>`FEDERATED_USER_ACCOUNT` — федеративный аккаунт.</li>
`authentication.subject_id` | **string**<br>Идентификатор субъекта.
`authentication.subject_name` | **string**<br>Имя субъекта.
`authentication.federation_id`* | **string**<br>Идентификатор федерации, в которой состоит федеративный пользователь.
`authentication.federation_name`* | **string**<br>Имя федерации, в которой состоит федеративный пользователь.
`authentication.federation_type`* | **string**<br>Тип федерации. Возможное значение:<ul><li>`PRIVATE_FEDERATION` — федерация, управляемая клиентами {{ yandex-cloud }}.</li></ul>
`authentication.impersonator_info` | **object**<br>Данные аутентификации субъекта события при использовании [имперсонации](../../iam/concepts/access-control/index.md#impersonation).
`authentication.impersonator_info.impersonator_id` | **string**<br>Идентификатор субъекта-имперсонатора.
`authentication.impersonator_info.type` | **string**<br>Тип субъекта-имперсонатора. Возможные значения:<ul><li>`YANDEX_PASSPORT_USER_ACCOUNT`— аккаунт на Яндексе;</li><li>`SERVICE_ACCOUNT` — сервисный аккаунт;</li><li>`FEDERATED_USER_ACCOUNT` — федеративный аккаунт.</li>
`authentication.impersonator_info.name` | **string**<br>Имя субъекта-имперсонатора.
`authentication.impersonator_info.federation_id`* | **string**<br>Идентификатор федерации, в которой состоит федеративный пользователь-имперсонатор.
`authentication.impersonator_info.federation_name`* | **string**<br>Имя федерации, в которой состоит федеративный пользователь-имперсонатор.
`authentication.impersonator_info.federation_type`* | **string**<br>Тип федерации. Возможное значение:<ul><li>`PRIVATE_FEDERATION` — федерация, управляемая клиентами {{ yandex-cloud }}.</li></ul>
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
`event_status` | **string**<br>Статус события. Определяется сервисом-источником и типом события. Возможные значения:<ul><li>`STARTED` — операция начата;</li><li>`ERROR` — операция завершена с ошибкой;</li><li>`DONE` — операция завершена успешно;</li><li>`CANCELLED` — операция отменена.</li></ul>
`error` | **object**<br>Статус ошибки. Объект типа [google.rpc.Status](https://github.com/googleapis/googleapis/blob/master/google/rpc/status.proto):<ul><li>`code` — [код ошибки](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto);</li><li>`message` — описание ошибки;</li><li>`details` — [детали ошибки](https://github.com/googleapis/googleapis/blob/master/google/rpc/error_details.proto).</li></ul>
`details` | **object**<br>Детали события. Определяются сервисом-источником и типом события.
`request_parameters` | **object**<br>Параметры запроса.
`response` | **object**<br>Полученные данные.

<small>* Поле доступно, когда `subject_type` = `FEDERATED_USER_ACCOUNT`</small>

{% note info %}

Если действие выполнил один из инфраструктурных сервисов {{ yandex-cloud }} или сотрудник поддержки, то в поле `remote address` будет значение `cloud.yandex`, а в поле `user agent` — `Yandex Cloud`.

{% endnote %}

## Представление аудитного лога {#log-name}

В зависимости от [объекта назначения](./trail.md#target) — бакет или лог-группа — изменяется структура и содержимое сообщения, в составе которого {{ at-name }} передает объекту назначения аудитные логи:
* для бакета — файл, в котором находится массив [JSON-объектов](./format.md#scheme) аудитного лога;
* для лог-группы — сообщение, в котором находится только один JSON-объект аудитного лога.
### Файл аудитного лога в бакете {#log-file-name}

Шаблон полного имени файла аудитного лога в бакете:

`<префикс_объекта>/<идентификатор_трейла>/<год>/<месяц>/<имя_файла.json>`


### Запись в лог-группе {#logging-group-name}

Значения записей в лог-группе:
* **{{ ui-key.yacloud.logging.column_header-time }}** — значение поля `event_time` события.
* **JSON** — JSON-объект события.
* **{{ ui-key.yacloud.logging.column_header-level }}** — вычисляется в зависимости от значения `event_status` события:
  * `ERROR` — для значения `ERROR`;
  * `WARN` — для значения `CANCELLED`;
  * `INFO` — в остальных случаях.
* **{{ ui-key.yacloud.logging.column_header-message }}** — содержит значения полей `event_status`, `event_type`, `subject_name`, `cloud_name`, `resource_name`.
