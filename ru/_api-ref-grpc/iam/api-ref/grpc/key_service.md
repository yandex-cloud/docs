---
editable: false
---

# KeyService

Набор методов для управления ресурсами Key.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Key. |
| [List](#List) | Возвращает список доступных ресурсов Key для указанного сервисного аккаунта. |
| [Create](#Create) | Создает пару ключей для указанного сервисного аккаунта. |
| [Update](#Update) | Обновляет указанный ключ. |
| [Delete](#Delete) | Удаляет указанный ресурс Key. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанного ресурса Key. |

## Вызовы KeyService {#calls}

## Get {#Get}

Возвращает указанный ресурс Key. <br>Чтобы получить список доступных ресурсов Key, используйте запрос [List](#List).

**rpc Get ([GetKeyRequest](#GetKeyRequest)) returns ([Key](#Key))**

### GetKeyRequest {#GetKeyRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Key. Чтобы получить идентификатор, используйте запрос [KeyService.List](#List). Максимальная длина строки в символах — 50.
format | enum **KeyFormat**<br>Формат ключа. <ul><li>`PEM_FILE`: Формат Privacy-Enhanced Mail (PEM). Значение по умолчанию.</li><ul/>


### Key {#Key}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ресурса Key 
subject | **oneof:** `user_account_id` или `service_account_id`<br>
&nbsp;&nbsp;user_account_id | **string**<br>Идентификатор аккаунта пользователя, которому принадлежит ресурс Key. 
&nbsp;&nbsp;service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит ресурс Key. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание ресурса Key. Длина 0-256 символов. 
key_algorithm | enum **Algorithm**<br>Алгоритм, используемый для создания пары ключей ресурса Key. <ul><li>`RSA_2048`: RSA с длиной ключа 2048 бит. Значение по умолчанию.</li><li>`RSA_4096`: RSA с длиной ключа 4096 бит.</li><ul/>
public_key | **string**<br>Закрытый ключ из ресурса Key. 


## List {#List}

Возвращает список доступных ресурсов Key для указанного сервисного аккаунта.

**rpc List ([ListKeysRequest](#ListKeysRequest)) returns ([ListKeysResponse](#ListKeysResponse))**

### ListKeysRequest {#ListKeysRequest}

Поле | Описание
--- | ---
format | enum **KeyFormat**<br>Формат ключа. <ul><li>`PEM_FILE`: Формат Privacy-Enhanced Mail (PEM). Значение по умолчанию.</li><ul/>
service_account_id | **string**<br>Идентификатор сервисного аккаунта для вывода списка пар ключей. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). Если параметр не указан, то используется идентификатор субъекта, который сделал запрос. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListKeysResponse.next_page_token](#ListKeysResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListKeysResponse.next_page_token](#ListKeysResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListKeysResponse {#ListKeysResponse}

Поле | Описание
--- | ---
keys[] | **[Key](#Key1)**<br>Список ресурсов Key. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListKeysRequest.page_size](#ListKeysRequest), используйте `next_page_token` в качестве значения параметра [ListKeysRequest.page_token](#ListKeysRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Key {#Key1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ресурса Key 
subject | **oneof:** `user_account_id` или `service_account_id`<br>
&nbsp;&nbsp;user_account_id | **string**<br>Идентификатор аккаунта пользователя, которому принадлежит ресурс Key. 
&nbsp;&nbsp;service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит ресурс Key. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание ресурса Key. Длина 0-256 символов. 
key_algorithm | enum **Algorithm**<br>Алгоритм, используемый для создания пары ключей ресурса Key. <ul><li>`RSA_2048`: RSA с длиной ключа 2048 бит. Значение по умолчанию.</li><li>`RSA_4096`: RSA с длиной ключа 4096 бит.</li><ul/>
public_key | **string**<br>Закрытый ключ из ресурса Key. 


## Create {#Create}

Создает пару ключей для указанного сервисного аккаунта.

**rpc Create ([CreateKeyRequest](#CreateKeyRequest)) returns ([CreateKeyResponse](#CreateKeyResponse))**

### CreateKeyRequest {#CreateKeyRequest}

Поле | Описание
--- | ---
service_account_id | **string**<br>Идентификатор сервисного аккаунта для создания пары ключей. Чтобы получить идентификатор сервисного аккаунта, используйте запрос [yandex.cloud.iam.v1.ServiceAccountService.List](/docs/iam/api-ref/grpc/service_account_service#List). Если параметр не указан, то используется идентификатор субъекта, который сделал запрос. Максимальная длина строки в символах — 50.
description | **string**<br>Описание пары ключей. Максимальная длина строки в символах — 256.
format | enum **KeyFormat**<br>Формат ключа. <ul><li>`PEM_FILE`: Формат Privacy-Enhanced Mail (PEM). Значение по умолчанию.</li><ul/>
key_algorithm | **[Key.Algorithm](#Key2)**<br>Алгоритм, используемый для создания пары ключей ресурса Key. 


### CreateKeyResponse {#CreateKeyResponse}

Поле | Описание
--- | ---
key | **[Key](#Key2)**<br>Ресурс Key. 
private_key | **string**<br>Закрытый ключ из ресурса Key. Этот ключ должен храниться в надежном месте. 


### Key {#Key2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ресурса Key 
subject | **oneof:** `user_account_id` или `service_account_id`<br>
&nbsp;&nbsp;user_account_id | **string**<br>Идентификатор аккаунта пользователя, которому принадлежит ресурс Key. 
&nbsp;&nbsp;service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит ресурс Key. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание ресурса Key. Длина 0-256 символов. 
key_algorithm | enum **Algorithm**<br>Алгоритм, используемый для создания пары ключей ресурса Key. <ul><li>`RSA_2048`: RSA с длиной ключа 2048 бит. Значение по умолчанию.</li><li>`RSA_4096`: RSA с длиной ключа 4096 бит.</li><ul/>
public_key | **string**<br>Закрытый ключ из ресурса Key. 


## Update {#Update}

Обновляет указанный ключ.

**rpc Update ([UpdateKeyRequest](#UpdateKeyRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateKeyMetadata](#UpdateKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Key](#Key3)<br>

### UpdateKeyRequest {#UpdateKeyRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор обновляемого ресурса Key. Чтобы получить идентификатор ключа, используйте запрос [KeyService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса Key будут обновлены. 
description | **string**<br>Описание ключа. Максимальная длина строки в символах — 256.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateKeyMetadata](#UpdateKeyMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Key](#Key3)>**<br>в случае успешного выполнения операции. 


### UpdateKeyMetadata {#UpdateKeyMetadata}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор изменяемого ресурса Key. 


### Key {#Key3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор ресурса Key 
subject | **oneof:** `user_account_id` или `service_account_id`<br>
&nbsp;&nbsp;user_account_id | **string**<br>Идентификатор аккаунта пользователя, которому принадлежит ресурс Key. 
&nbsp;&nbsp;service_account_id | **string**<br>Идентификатор сервисного аккаунта, которому принадлежит ресурс Key. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
description | **string**<br>Описание ресурса Key. Длина 0-256 символов. 
key_algorithm | enum **Algorithm**<br>Алгоритм, используемый для создания пары ключей ресурса Key. <ul><li>`RSA_2048`: RSA с длиной ключа 2048 бит. Значение по умолчанию.</li><li>`RSA_4096`: RSA с длиной ключа 4096 бит.</li><ul/>
public_key | **string**<br>Закрытый ключ из ресурса Key. 


## Delete {#Delete}

Удаляет указанный ресурс Key.

**rpc Delete ([DeleteKeyRequest](#DeleteKeyRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteKeyMetadata](#DeleteKeyMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteKeyRequest {#DeleteKeyRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор ключа, который следует удалить. Чтобы получить идентификатор ключа, используйте запрос [KeyService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteKeyMetadata](#DeleteKeyMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteKeyMetadata {#DeleteKeyMetadata}

Поле | Описание
--- | ---
key_id | **string**<br>Идентификатор удаляемого ключа. 


## ListOperations {#ListOperations}

Возвращает список операций для указанного ресурса Key.

**rpc ListOperations ([ListKeyOperationsRequest](#ListKeyOperationsRequest)) returns ([ListKeyOperationsResponse](#ListKeyOperationsResponse))**

### ListKeyOperationsRequest {#ListKeyOperationsRequest}

Поле | Описание
--- | ---
key_id | **string**<br>Обязательное поле. Идентификатор ресурса Key, для которого требуется получть список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListKeyOperationsResponse.next_page_token](#ListKeyOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListKeyOperationsResponse.next_page_token](#ListKeyOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListKeyOperationsResponse {#ListKeyOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation2)**<br>Список операций для указанного ресурса Key. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListKeyOperationsRequest.page_size](#ListKeyOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListKeyOperationsRequest.page_token](#ListKeyOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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


