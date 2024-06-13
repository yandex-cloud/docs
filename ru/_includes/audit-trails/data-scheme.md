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
    "token_info": {
      "masked_iam_token": string,
      "iam_token_id": string,
      "impersonator_id": string,
      "impersonator_type": string,
      "impersonator_name": string,
      "impersonator_federation_id": string,
      "impersonator_federation_name": string,
      "impersonator_federation_type": string
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
  },
  "request_parameters": {
    object
  },
  "response": {
    object
  }
}
```

Поле | Описание
--- | ---
`event_id` | **string**<br>Идентификатор события.
`event_source` | **string**<br>Имя сервиса-источника события.
`event_type` | **string**<br>Тип события. Определяется сервисом-источником события. Подробнее смотрите в разделе [{#T}](../../audit-trails/concepts/events-data-plane.md).
`event_time` | **string**<br>Время, в которое произошло событие.
`authentication` ^1^ | **object**<br>Данные аутентификации субъекта события.
`authentication.authenticated` | **boolean**<br>Результат аутентификации. Возможные значения:<ul><li>`true` — аутентификация успешна;</li><li>`false` — аутентификация неуспешна.</li>
`authentication.subject_type` | **string**<br>Тип субъекта. Возможные значения:<ul><li>`YANDEX_PASSPORT_USER_ACCOUNT`— аккаунт на Яндексе;</li><li>`SERVICE_ACCOUNT` — сервисный аккаунт;</li><li>`FEDERATED_USER_ACCOUNT` — федеративный аккаунт.</li>
`authentication.subject_id` | **string**<br>Идентификатор субъекта.
`authentication.subject_name` | **string**<br>Имя субъекта.
`authentication.federation_id` ^2^ | **string**<br>Идентификатор федерации, в которой состоит федеративный пользователь.
`authentication.federation_name` ^2^ | **string**<br>Имя федерации, в которой состоит федеративный пользователь.
`authentication.federation_type` ^2^ | **string**<br>Тип федерации. Возможное значение:<ul><li>`PRIVATE_FEDERATION` — федерация, управляемая клиентами {{ yandex-cloud }}.</li></ul>
`authentication.token_info` ^1^ | **object**<br>Данные аутентификации субъекта события.
`authentication.token_info.masked_iam_token` | **string**<br>Зашифрованное значение IAM-токена, с которым субъект выполнил запрос.
`authentication.token_info.iam_token_id` | **string**<br>Идентификатор зашифрованного IAM-токена.
`authentication.token_info.impersonator_id` | **string**<br>Идентификатор субъекта при использовании [имперсонации](../../iam/concepts/access-control/index.md#impersonation).
`authentication.token_info.impersonator_type` | **string**<br>Тип субъекта-имперсонатора. Возможные значения:<ul><li>`YANDEX_PASSPORT_USER_ACCOUNT`— аккаунт на Яндексе;</li><li>`SERVICE_ACCOUNT` — сервисный аккаунт;</li><li>`FEDERATED_USER_ACCOUNT` — федеративный аккаунт.</li>
`authentication.token_info.impersonator_name` | **string**<br>Имя субъекта-имперсонатора.
`authentication.token_info.impersonator_federation_id` ^2^ | **string**<br>Идентификатор федерации, в которой состоит федеративный пользователь-имперсонатор.
`authentication.token_info.impersonator_federation_name`&nbsp;^2^ | **string**<br>Имя федерации, в которой состоит федеративный пользователь-имперсонатор.
`authentication.token_info.impersonator_federation_type`&nbsp;^2^ | **string**<br>Тип федерации. Возможное значение:<ul><li>`PRIVATE_FEDERATION` — федерация, управляемая клиентами {{ yandex-cloud }}.</li></ul>
`authorization` ^1^ | **object**<br>Данные авторизации субъекта события.
`authorization.authorized` | **boolean**<br>Результат авторизации. Возможные значения:<ul><li>`true` — авторизация успешна;</li><li>`false` — авторизация неуспешна.</li>
`resource_metadata` ^1^ | **object**<br>Метаданные объекта события.
`resource_metadata.path[]` | **array**<br>Путь к ресурсу в котором произошло событие.
`resource_metadata.path[].resource_type` | **string**<br>Тип ресурса.
`resource_metadata.path[].resource_id` | **string**<br>Идентификатор ресурса.
`resource_metadata.path[].resource_name` | **string**<br>Имя ресурса.
`request_metadata` | **object**<br>Данные о запросе, который инициировал событие.
`request_metadata.remote_address` | **string**<br>IP-адрес субъекта события.
`request_metadata.user_agent` | **string**<br>User-Agent субъекта события.
`request_metadata.request_id` | **string**<br>Идентификатор запроса.
`event_status` | **string**<br>Статус события. Определяется сервисом-источником и типом события. Возможные значения:<ul><li>`STARTED` — операция начата;</li><li>`ERROR` — операция завершена с ошибкой;</li><li>`DONE` — операция завершена успешно;</li><li>`CANCELLED` — операция отменена.</li></ul>
`error` | **object**<br>Статус ошибки. Объект типа [google.rpc.Status](https://github.com/googleapis/googleapis/blob/master/google/rpc/status.proto):<ul><li>`code` — [код ошибки](https://github.com/googleapis/googleapis/blob/master/google/rpc/code.proto);</li><li>`message` — описание ошибки;</li><li>`details` — [детали ошибки](https://github.com/googleapis/googleapis/blob/master/google/rpc/error_details.proto).</li></ul>Заполняется только в случае ошибки.
`details` | **object**<br>Детали события. Определяются сервисом-источником и типом события.
`request_parameters` ^1^ | **object**<br>Параметры запроса.
`response` ^1^ | **object**<br>Полученные данные.

<small>^1^ Блок полей используется не для всех типов событий.</small>
<small>^2^ Поле доступно, когда `subject_type` = `FEDERATED_USER_ACCOUNT`.</small>

{% note info %}

Если действие выполнил один из инфраструктурных сервисов {{ yandex-cloud }} или сотрудник поддержки, то в поле `remote address` будет значение `cloud.yandex`, а в поле `user agent` — `Yandex Cloud`.

{% endnote %}