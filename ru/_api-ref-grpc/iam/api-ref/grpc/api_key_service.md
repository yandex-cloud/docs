---
editable: false
---

# ApiKeyService

Набор методов управления API-ключами.

| Вызов | Описание |
| --- | --- |
| [List](#List) | Возвращает список API-ключей для указанного сервисного аккаунта. |
| [Get](#Get) | Возвращает указанный API-ключ. |
| [Create](#Create) | Создает API-ключ для указанного сервисного аккаунта. |
| [Update](#Update) | Обновляет указанный API-ключ. |
| [Delete](#Delete) | Удаляет указанный API-ключ. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанного API ключа. |

## Вызовы ApiKeyService {#calls}

## List {#List}

Возвращает список API-ключей для указанного сервисного аккаунта.

**rpc List ([ListApiKeysRequest](#ListApiKeysRequest)) returns ([ListApiKeysResponse](#ListApiKeysResponse))**

### ListApiKeysRequest {#ListApiKeysRequest}

Поле | Описание
--- | ---
service_account_id | **string**<br>Идентификатор сервисного аккаунта, для которого запрашивается список API-ключей. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). Если параметр не указан, то используется идентификатор субъекта, который сделал запрос. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListApiKeysResponse.next_page_token](#ListApiKeysResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListApiKeysResponse.next_page_token](#ListApiKeysResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListApiKeysResponse {#ListApiKeysResponse}

Поле | Описание
--- | ---
api_keys[] | **[ApiKey](#ApiKey)**<br>Список API-ключей. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListApiKeysRequest.page_size](#ListApiKeysRequest), используйте `next_page_token` в качестве значения параметра [ListApiKeysRequest.page_token](#ListApiKeysRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### ApiKey {#ApiKey}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор API-ключа. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит API-ключ. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание API-ключа. Длина описания должна быть от 0 до 256 символов. 


## Get {#Get}

Возвращает указанный API-ключ. <br>Чтобы получить список доступных API-ключ, используйте запрос [List](#List).

**rpc Get ([GetApiKeyRequest](#GetApiKeyRequest)) returns ([ApiKey](#ApiKey1))**

### GetApiKeyRequest {#GetApiKeyRequest}

Поле | Описание
--- | ---
api_key_id | **string**<br>Обязательное поле. Идентификатор возвращаемого API-ключа. Чтобы получить идентификатор ключа, используйте запрос [ApiKeyService.List](#List). Максимальная длина строки в символах — 50.


### ApiKey {#ApiKey1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор API-ключа. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит API-ключ. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание API-ключа. Длина описания должна быть от 0 до 256 символов. 


## Create {#Create}

Создает API-ключ для указанного сервисного аккаунта.

**rpc Create ([CreateApiKeyRequest](#CreateApiKeyRequest)) returns ([CreateApiKeyResponse](#CreateApiKeyResponse))**

### CreateApiKeyRequest {#CreateApiKeyRequest}

Поле | Описание
--- | ---
service_account_id | **string**<br>Идентификатор сервисного аккаунта для создания API-ключа. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). Если параметр не указан, то используется идентификатор субъекта, который сделал запрос. Максимальная длина строки в символах — 50.
description | **string**<br>Описание API-ключа. Максимальная длина строки в символах — 256.


### CreateApiKeyResponse {#CreateApiKeyResponse}

Поле | Описание
--- | ---
api_key | **[ApiKey](#ApiKey2)**<br>Ресурс ApiKey. 
secret | **string**<br>Секретная часть API-ключа. Этот секретный ключ можно использовать для аутентификации при запросах. 


### ApiKey {#ApiKey2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор API-ключа. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит API-ключ. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание API-ключа. Длина описания должна быть от 0 до 256 символов. 


## Update {#Update}

Обновляет указанный API-ключ.

**rpc Update ([UpdateApiKeyRequest](#UpdateApiKeyRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateApiKeyMetadata](#UpdateApiKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ApiKey](#ApiKey3)<br>

### UpdateApiKeyRequest {#UpdateApiKeyRequest}

Поле | Описание
--- | ---
api_key_id | **string**<br>Обязательное поле. Идентификатор обновляемого ресурса ApiKey. Чтобы получить идентификатор API-ключа, используйте запрос [ApiKeyService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса ApiKey будут обновлены. 
description | **string**<br>Описание API-ключа. Максимальная длина строки в символах — 256.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateApiKeyMetadata](#UpdateApiKeyMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ApiKey](#ApiKey3)>**<br>в случае успешного выполнения операции. 


### UpdateApiKeyMetadata {#UpdateApiKeyMetadata}

Поле | Описание
--- | ---
api_key_id | **string**<br>Идентификатор изменяемого ресурса ApiKey. 


### ApiKey {#ApiKey3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор API-ключа. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит API-ключ. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание API-ключа. Длина описания должна быть от 0 до 256 символов. 


## Delete {#Delete}

Удаляет указанный API-ключ.

**rpc Delete ([DeleteApiKeyRequest](#DeleteApiKeyRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteApiKeyMetadata](#DeleteApiKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteApiKeyRequest {#DeleteApiKeyRequest}

Поле | Описание
--- | ---
api_key_id | **string**<br>Обязательное поле. Идентификатор ключа, который следует удалить. Чтобы получить идентификатор ключа, используйте запрос [ApiKeyService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteApiKeyMetadata](#DeleteApiKeyMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteApiKeyMetadata {#DeleteApiKeyMetadata}

Поле | Описание
--- | ---
api_key_id | **string**<br>Идентификатор удаляемого API-ключа. 


## ListOperations {#ListOperations}

Возвращает список операций для указанного API ключа.

**rpc ListOperations ([ListApiKeyOperationsRequest](#ListApiKeyOperationsRequest)) returns ([ListApiKeyOperationsResponse](#ListApiKeyOperationsResponse))**

### ListApiKeyOperationsRequest {#ListApiKeyOperationsRequest}

Поле | Описание
--- | ---
api_key_id | **string**<br>Обязательное поле. Идентификатор API-ключа, для которого требуется получть список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListApiKeyOperationsResponse.next_page_token](#ListApiKeyOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListApiKeyOperationsResponse.next_page_token](#ListApiKeyOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListApiKeyOperationsResponse {#ListApiKeyOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation2)**<br>Список операций для указанного API-ключа. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListApiKeyOperationsRequest.page_size](#ListApiKeyOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListApiKeyOperationsRequest.page_token](#ListApiKeyOperationsRequest) в следующем запросе списка API-ключей. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`. 


