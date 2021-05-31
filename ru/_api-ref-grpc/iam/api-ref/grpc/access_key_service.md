---
editable: false
---

# AccessKeyService

Набор методов управления ключами доступа.

| Вызов | Описание |
| --- | --- |
| [List](#List) | Возвращает список ключей доступа для указанного сервисного аккаунта. |
| [Get](#Get) | Возвращает указанный ключ доступа. |
| [Create](#Create) | Создает ключ доступа для указанного сервисного аккаунта. |
| [Update](#Update) | Обновляет указанный ключ доступа. |
| [Delete](#Delete) | Удаляет указанный ключ доступа. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанного ключа доступа. |

## Вызовы AccessKeyService {#calls}

## List {#List}

Возвращает список ключей доступа для указанного сервисного аккаунта.

**rpc List ([ListAccessKeysRequest](#ListAccessKeysRequest)) returns ([ListAccessKeysResponse](#ListAccessKeysResponse))**

### ListAccessKeysRequest {#ListAccessKeysRequest}

Поле | Описание
--- | ---
service_account_id | **string**<br>Идентификатор сервисного аккаунта, для которого запрашивается список ключей доступа. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). Если параметр не указан, то используется идентификатор субъекта, который сделал запрос. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListAccessKeysResponse.next_page_token](#ListAccessKeysResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListAccessKeysResponse.next_page_token](#ListAccessKeysResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListAccessKeysResponse {#ListAccessKeysResponse}

Поле | Описание
--- | ---
access_keys[] | **[AccessKey](#AccessKey)**<br>Список ключей доступа. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListAccessKeysRequest.page_size](#ListAccessKeysRequest), используйте `next_page_token` в качестве значения параметра [ListAccessKeysRequest.page_token](#ListAccessKeysRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### AccessKey {#AccessKey}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ресурса AccessKey. Он используется для управления идентификатором ключа доступа и секретным ключом доступа. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит ключ доступа. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов. 
key_id | **string**<br>Идентификатор ключа доступа. Ключ совместим с сервисами AWS. 


## Get {#Get}

Возвращает указанный ключ доступа. <br>Чтобы получить список доступных ключей доступа, используйте запрос [List](#List).

**rpc Get ([GetAccessKeyRequest](#GetAccessKeyRequest)) returns ([AccessKey](#AccessKey1))**

### GetAccessKeyRequest {#GetAccessKeyRequest}

Поле | Описание
--- | ---
access_key_id | **string**<br>Обязательное поле. Идентификатор запрашиваемого ресурса AccessKey. Чтобы получить идентификатор ключа доступа, используйте запрос [AccessKeyService.List](#List). Максимальная длина строки в символах — 50.


### AccessKey {#AccessKey1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ресурса AccessKey. Он используется для управления идентификатором ключа доступа и секретным ключом доступа. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит ключ доступа. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов. 
key_id | **string**<br>Идентификатор ключа доступа. Ключ совместим с сервисами AWS. 


## Create {#Create}

Создает ключ доступа для указанного сервисного аккаунта.

**rpc Create ([CreateAccessKeyRequest](#CreateAccessKeyRequest)) returns ([CreateAccessKeyResponse](#CreateAccessKeyResponse))**

### CreateAccessKeyRequest {#CreateAccessKeyRequest}

Поле | Описание
--- | ---
service_account_id | **string**<br>Идентификатор сервисного аккаунта для создания ключа доступа. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). Если параметр не указан, то используется идентификатор субъекта, который сделал запрос. Максимальная длина строки в символах — 50.
description | **string**<br>Описание ключа доступа. Максимальная длина строки в символах — 256.


### CreateAccessKeyResponse {#CreateAccessKeyResponse}

Поле | Описание
--- | ---
access_key | **[AccessKey](#AccessKey2)**<br>Ресурс AccessKey. 
secret | **string**<br>Секретный ключ доступа. Ключ совместим с сервисами AWS. 


### AccessKey {#AccessKey2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ресурса AccessKey. Он используется для управления идентификатором ключа доступа и секретным ключом доступа. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит ключ доступа. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов. 
key_id | **string**<br>Идентификатор ключа доступа. Ключ совместим с сервисами AWS. 


## Update {#Update}

Обновляет указанный ключ доступа.

**rpc Update ([UpdateAccessKeyRequest](#UpdateAccessKeyRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessKeyMetadata](#UpdateAccessKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[AccessKey](#AccessKey3)<br>

### UpdateAccessKeyRequest {#UpdateAccessKeyRequest}

Поле | Описание
--- | ---
access_key_id | **string**<br>Обязательное поле. Идентификатор обновляемого ресурса AccessKey. Чтобы получить идентификатор ключа доступа, используйте запрос [AccessKeyService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса AccessKey будут обновлены. 
description | **string**<br>Описание ключа доступа. Максимальная длина строки в символах — 256.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessKeyMetadata](#UpdateAccessKeyMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AccessKey](#AccessKey3)>**<br>в случае успешного выполнения операции. 


### UpdateAccessKeyMetadata {#UpdateAccessKeyMetadata}

Поле | Описание
--- | ---
access_key_id | **string**<br>Идентификатор изменяемого ресурса AccessKey. 


### AccessKey {#AccessKey3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ресурса AccessKey. Он используется для управления идентификатором ключа доступа и секретным ключом доступа. 
service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит ключ доступа. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание ключа доступа. Длина описания должна быть от 0 до 256 символов. 
key_id | **string**<br>Идентификатор ключа доступа. Ключ совместим с сервисами AWS. 


## Delete {#Delete}

Удаляет указанный ключ доступа.

**rpc Delete ([DeleteAccessKeyRequest](#DeleteAccessKeyRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteAccessKeyMetadata](#DeleteAccessKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteAccessKeyRequest {#DeleteAccessKeyRequest}

Поле | Описание
--- | ---
access_key_id | **string**<br>Обязательное поле. Идентификатор ключа доступа, который следует удалить. Чтобы получить идентификатор ключа доступа, используйте запрос [AccessKeyService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteAccessKeyMetadata](#DeleteAccessKeyMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteAccessKeyMetadata {#DeleteAccessKeyMetadata}

Поле | Описание
--- | ---
access_key_id | **string**<br>Идентификатор удаляемого ключа доступа. 


## ListOperations {#ListOperations}

Возвращает список операций для указанного ключа доступа.

**rpc ListOperations ([ListAccessKeyOperationsRequest](#ListAccessKeyOperationsRequest)) returns ([ListAccessKeyOperationsResponse](#ListAccessKeyOperationsResponse))**

### ListAccessKeyOperationsRequest {#ListAccessKeyOperationsRequest}

Поле | Описание
--- | ---
access_key_id | **string**<br>Обязательное поле. Идентификатор ключа доступа, для которого требуется получть список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListAccessKeyOperationsResponse.next_page_token](#ListAccessKeyOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListAccessKeyOperationsResponse.next_page_token](#ListAccessKeyOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListAccessKeyOperationsResponse {#ListAccessKeyOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation2)**<br>Список операций для указанного ключа доступа. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListAccessKeyOperationsRequest.page_size](#ListAccessKeyOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListAccessKeyOperationsRequest.page_token](#ListAccessKeyOperationsRequest) в следующем запросе списка ключей доступа. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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


