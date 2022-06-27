---
editable: false
---

# ApiGatewayService

Набор методов управления API-шлюзами.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный API-шлюз. |
| [List](#List) | Возвращает список API-шлюзов в указанном каталоге. |
| [Create](#Create) | Создает API-шлюз в указанном каталоге. |
| [Update](#Update) | Изменяет указанный API-шлюз. |
| [Delete](#Delete) | Удаляет указанный API-шлюз. |
| [GetOpenapiSpec](#GetOpenapiSpec) | Возвращает спецификацию OpenAPI указанного API-шлюза. |
| [ListOperations](#ListOperations) | Возвращает список операции для указанного API-шлюза. |
| [ListAccessBindings](#ListAccessBindings) | Возвращает список привязок прав доступа для указанного API-шлюза. |
| [SetAccessBindings](#SetAccessBindings) | Задает список привязок прав доступа для указанного API-шлюза. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Обновляет привязки прав доступа для указанного API-шлюза. |

## Вызовы ApiGatewayService {#calls}

## Get {#Get}

Возвращает указанный API-шлюз. Обратите внимание, что возвращаются только базовые параметры API-шлюза. Чтобы получить соответствующую спецификацию OpenAPI, сделайте [GetOpenapiSpec](#GetOpenapiSpec) запрос. <br>Чтобы получить список всех доступных API-шлюзов, сделайте [List](#List) запрос.

**rpc Get ([GetApiGatewayRequest](#GetApiGatewayRequest)) returns ([ApiGateway](#ApiGateway))**

### GetApiGatewayRequest {#GetApiGatewayRequest}

Поле | Описание
--- | ---
api_gateway_id | **string**<br>Обязательное поле. Идентификатор возвращаемого API-шлюза. <br>Чтобы получить идентификатор API-шлюза, сделайте [ApiGatewayService.List](#List) запрос. 


### ApiGateway {#ApiGateway}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор API-шлюза. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит API-шлюз. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания API-шлюза. 
name | **string**<br>Имя API-шлюза. Имя уникально в рамках каталога. 
description | **string**<br>Описание API-шлюза. 
labels | **map<string,string>**<br>Метки API-шлюза в формате `key:value` . 
status | enum **Status**<br>Состояние API-шлюза. <ul><li>`CREATING`: API-шлюз создается.</li><li>`ACTIVE`: API-шлюз готов к использованию.</li><li>`DELETING`: API-шлюз удаляется.</li><li>`ERROR`: Сбой API-шлюза. Единственное разрешенное действие c API-шлюзом — удаление.</li><ul/>
domain | **string**<br>Домен по умолчанию для API-шлюза. Генерируется при создании. 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для API-шлюза. 


## List {#List}

Возвращает список API-шлюзов в указанном каталоге.

**rpc List ([ListApiGatewayRequest](#ListApiGatewayRequest)) returns ([ListApiGatewayResponse](#ListApiGatewayResponse))**

### ListApiGatewayRequest {#ListApiGatewayRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка API-шлюзов. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `pageSize`, сервис вернет значение [ListApiGatewayResponse.next_page_token](#ListApiGatewayResponse), которое можно использовать для получения следующей страницы. <br>Значение по умолчанию: 100. 
page_token | **string**<br>Токен страницы. Установите значение `pageToken` равным значению поля [ListApiGatewayResponse.next_page_token](#ListApiGatewayResponse) предыдущего запроса, чтобы получить следующую страницу результатов. 
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [ApiGateway.name](#ApiGateway1). </li><li>Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Пример фильтра: `name=my-apigw`.</li></ol> 


### ListApiGatewayResponse {#ListApiGatewayResponse}

Поле | Описание
--- | ---
api_gateways[] | **[ApiGateway](#ApiGateway1)**<br>Возвращает список API-шлюзов в указанном каталоге. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListApiGatewayRequest.page_size](#ListApiGatewayRequest), используйте `nextPageToken` в качестве значения параметра [ListApiGatewayRequest.page_token](#ListApiGatewayRequest) в следующем запросе списка ресурсов. <br>Каждая следующая страница будет иметь свой `nextPageToken` для продолжения перебора страниц результатов. 


### ApiGateway {#ApiGateway1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор API-шлюза. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит API-шлюз. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания API-шлюза. 
name | **string**<br>Имя API-шлюза. Имя уникально в рамках каталога. 
description | **string**<br>Описание API-шлюза. 
labels | **map<string,string>**<br>Метки API-шлюза в формате `key:value` . 
status | enum **Status**<br>Состояние API-шлюза. <ul><li>`CREATING`: API-шлюз создается.</li><li>`ACTIVE`: API-шлюз готов к использованию.</li><li>`DELETING`: API-шлюз удаляется.</li><li>`ERROR`: Сбой API-шлюза. Единственное разрешенное действие c API-шлюзом — удаление.</li><ul/>
domain | **string**<br>Домен по умолчанию для API-шлюза. Генерируется при создании. 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для API-шлюза. 


## Create {#Create}

Создает API-шлюз в указанном каталоге.

**rpc Create ([CreateApiGatewayRequest](#CreateApiGatewayRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateApiGatewayMetadata](#CreateApiGatewayMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ApiGateway](#ApiGateway2)<br>

### CreateApiGatewayRequest {#CreateApiGatewayRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для создания API-шлюза. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). 
name | **string**<br>Имя API-шлюза. Имя должно быть уникальным в рамках каталога. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание API-шлюза. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
spec | **oneof:** `openapi_spec`<br>OpenAPI спецификация API-шлюза.
&nbsp;&nbsp;openapi_spec | **string**<br>Текст спецификации, JSON или YAML. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateApiGatewayMetadata](#CreateApiGatewayMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ApiGateway](#ApiGateway2)>**<br>в случае успешного выполнения операции. 


### CreateApiGatewayMetadata {#CreateApiGatewayMetadata}

Поле | Описание
--- | ---
api_gateway_id | **string**<br>Идентификатор создаваемого API-шлюза. 


### ApiGateway {#ApiGateway2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор API-шлюза. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит API-шлюз. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания API-шлюза. 
name | **string**<br>Имя API-шлюза. Имя уникально в рамках каталога. 
description | **string**<br>Описание API-шлюза. 
labels | **map<string,string>**<br>Метки API-шлюза в формате `key:value` . 
status | enum **Status**<br>Состояние API-шлюза. <ul><li>`CREATING`: API-шлюз создается.</li><li>`ACTIVE`: API-шлюз готов к использованию.</li><li>`DELETING`: API-шлюз удаляется.</li><li>`ERROR`: Сбой API-шлюза. Единственное разрешенное действие c API-шлюзом — удаление.</li><ul/>
domain | **string**<br>Домен по умолчанию для API-шлюза. Генерируется при создании. 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для API-шлюза. 


## Update {#Update}

Изменяет указанный API-шлюз.

**rpc Update ([UpdateApiGatewayRequest](#UpdateApiGatewayRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateApiGatewayMetadata](#UpdateApiGatewayMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[ApiGateway](#ApiGateway3)<br>

### UpdateApiGatewayRequest {#UpdateApiGatewayRequest}

Поле | Описание
--- | ---
api_gateway_id | **string**<br>Обязательное поле. Идентификатор API-шлюза для обновления. <br>Чтобы получить идентификатор API-шлюза, сделайте [ApiGatewayService.List](#List) запрос. 
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска поля, указывающая, какие атрибуты API-шлюза должны быть обновлены. 
name | **string**<br>Новое имя для API-шлюза. Имя должно быть уникальным в рамках каталога. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Новое описание для API-шлюза. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки API-шлюза в формате `key:value` . <br>Существующий набор меток полностью заменяется предоставленным набором, поэтому, если вы просто хотите добавить или удалить метку, запросите текущий набор меток, используя запрос [ApiGatewayService.Get](#Get) . Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
spec | **oneof:** `openapi_spec`<br>OpenAPI спецификация API-шлюза.
&nbsp;&nbsp;openapi_spec | **string**<br>Текст спецификации, JSON или YAML. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateApiGatewayMetadata](#UpdateApiGatewayMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[ApiGateway](#ApiGateway3)>**<br>в случае успешного выполнения операции. 


### UpdateApiGatewayMetadata {#UpdateApiGatewayMetadata}

Поле | Описание
--- | ---
api_gateway_id | **string**<br>Идентификатор обновляемого API-шлюза. 


### ApiGateway {#ApiGateway3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор API-шлюза. Генерируется при создании. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит API-шлюз. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания API-шлюза. 
name | **string**<br>Имя API-шлюза. Имя уникально в рамках каталога. 
description | **string**<br>Описание API-шлюза. 
labels | **map<string,string>**<br>Метки API-шлюза в формате `key:value` . 
status | enum **Status**<br>Состояние API-шлюза. <ul><li>`CREATING`: API-шлюз создается.</li><li>`ACTIVE`: API-шлюз готов к использованию.</li><li>`DELETING`: API-шлюз удаляется.</li><li>`ERROR`: Сбой API-шлюза. Единственное разрешенное действие c API-шлюзом — удаление.</li><ul/>
domain | **string**<br>Домен по умолчанию для API-шлюза. Генерируется при создании. 
log_group_id | **string**<br>Идентификатор группы журналов выполнения для API-шлюза. 


## Delete {#Delete}

Удаляет указанный API-шлюз.

**rpc Delete ([DeleteApiGatewayRequest](#DeleteApiGatewayRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteApiGatewayMetadata](#DeleteApiGatewayMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteApiGatewayRequest {#DeleteApiGatewayRequest}

Поле | Описание
--- | ---
api_gateway_id | **string**<br>Обязательное поле. Идентификатор API-шлюза для обновления. <br>Чтобы получить идентификатор API-шлюза, сделайте [ApiGatewayService.List](#List) запрос. 


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteApiGatewayMetadata](#DeleteApiGatewayMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteApiGatewayMetadata {#DeleteApiGatewayMetadata}

Поле | Описание
--- | ---
api_gateway_id | **string**<br>Идентификатор удаляемого API-шлюза. 


## GetOpenapiSpec {#GetOpenapiSpec}

Возвращает спецификацию OpenAPI указанного API-шлюза.

**rpc GetOpenapiSpec ([GetOpenapiSpecRequest](#GetOpenapiSpecRequest)) returns ([GetOpenapiSpecResponse](#GetOpenapiSpecResponse))**

### GetOpenapiSpecRequest {#GetOpenapiSpecRequest}

Поле | Описание
--- | ---
api_gateway_id | **string**<br>Обязательное поле. Идентификатор API-шлюза для получения спецификации. 
format | enum **Format**<br>Формат возвращаемой спецификации. По умолчанию используется исходный формат, используемый в [CreateApiGatewayRequest](#CreateApiGatewayRequest). <ul><ul/>


### GetOpenapiSpecResponse {#GetOpenapiSpecResponse}

Поле | Описание
--- | ---
api_gateway_id | **string**<br>Идентификатор API-шлюза. 
openapi_spec | **string**<br>Текст спецификации, JSON или YAML. 


## ListOperations {#ListOperations}

Возвращает список операции для указанного API-шлюза.

**rpc ListOperations ([ListOperationsRequest](#ListOperationsRequest)) returns ([ListOperationsResponse](#ListOperationsResponse))**

### ListOperationsRequest {#ListOperationsRequest}

Поле | Описание
--- | ---
api_gateway_id | **string**<br>Обязательное поле. Идентификатор API-шлюза для получения списка операций. 
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `pageSize`, сервис вернет значение [ListOperationsResponse.next_page_token](#ListOperationsResponse), которое можно использовать для получения следующей страницы. <br>Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `pageToken` равным значению поля [ListOperationsResponse.next_page_token](#ListOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация может быть применена к полям [operation.Operation.done](#Operation3), [operation.Operation.created_by](#Operation3) . </li><li>Условный оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`. Примеры фильтра: `done=false`, `created_by='John.Doe'`.</li></ol> Максимальная длина строки в символах — 1000.


### ListOperationsResponse {#ListOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Возвращает список операции для указанного API-шлюза. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListOperationsRequest.page_size](#ListOperationsRequest), используйте `nextPageToken` в качестве значения параметра [ListOperationsRequest.page_token](#ListOperationsRequest) в следующем запросе списка ресурсов. <br>Каждая следующая страница будет иметь свой `nextPageToken` для продолжения перебора страниц результатов. 


### Operation {#Operation3}

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


## ListAccessBindings {#ListAccessBindings}

Возвращает список привязок прав доступа для указанного API-шлюза.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Поле | Описание
--- | ---
resource_id | **string**<br>Обязательное поле. Идентификатор ресурса, для которого запрашивается список привязок прав доступа. <br>Чтобы получить идентификатор ресурса, используйте соответствующий запрос List. Например, используйте запрос [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/cloud_service#List) для получения идентификатора ресурса Cloud. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListAccessBindingsResponse {#ListAccessBindingsResponse}

Поле | Описание
--- | ---
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Список привязок прав доступа для указанного ресурса. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListAccessBindingsRequest.page_size](#ListAccessBindingsRequest), используйте `next_page_token` в качестве значения параметра [ListAccessBindingsRequest.page_token](#ListAccessBindingsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### AccessBinding {#AccessBinding}

Поле | Описание
--- | ---
role_id | **string**<br>Обязательное поле. Идентификатор ресурса `yandex.cloud.iam.v1.Role` который назначен для субъекта, указанного в параметре `subject`. Максимальная длина строки в символах — 50.
subject | **[Subject](#Subject)**<br>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой аккаунт с уникальным идентификатором в облаке или системную группу с общим системным идентификатором. 


### Subject {#Subject}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. <ul><li>`allAuthenticatedUsers`: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре `type` указано `system`. </li><li>`allUsers`: Специальный системный идентификатор, представляющий любого пользователя. Аутентификация не требуется. Например, при запросе через API не надо будет указывать IAM-токен. </li><li>`<идентификатор пользователя в облаке>`: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре `type` передано одно из следующих значений: `userAccount`, `federatedUser` или `serviceAccount`.</li></ul> Максимальная длина строки в символах — 50.
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в {{ yandex-cloud }}. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


## SetAccessBindings {#SetAccessBindings}

Задает список привязок прав доступа для указанного API-шлюза.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Поле | Описание
--- | ---
resource_id | **string**<br>Обязательное поле. Идентификатор ресурса, для которого задается список привязок прав доступа. <br>Чтобы получить идентификатор ресурса, используйте соответствующий запрос List. Максимальная длина строки в символах — 50.
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Обязательное поле. Привязки прав доступа, которые будут установлены. Дополнительные сведения см. в разделе [Привязка прав доступа](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding1}

Поле | Описание
--- | ---
role_id | **string**<br>Обязательное поле. Идентификатор ресурса `yandex.cloud.iam.v1.Role` который назначен для субъекта, указанного в параметре `subject`. Максимальная длина строки в символах — 50.
subject | **[Subject](#Subject)**<br>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой аккаунт с уникальным идентификатором в облаке или системную группу с общим системным идентификатором. 


### Subject {#Subject1}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. <ul><li>`allAuthenticatedUsers`: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре `type` указано `system`. </li><li>`allUsers`: Специальный системный идентификатор, представляющий любого пользователя. Аутентификация не требуется. Например, при запросе через API не надо будет указывать IAM-токен. </li><li>`<идентификатор пользователя в облаке>`: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре `type` передано одно из следующих значений: `userAccount`, `federatedUser` или `serviceAccount`.</li></ul> Максимальная длина строки в символах — 50.
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в {{ yandex-cloud }}. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### SetAccessBindingsMetadata {#SetAccessBindingsMetadata}

Поле | Описание
--- | ---
resource_id | **string**<br>Идентификатор ресурса, для которого задается список привязок прав доступа. 


## UpdateAccessBindings {#UpdateAccessBindings}

Обновляет привязки прав доступа для указанного API-шлюза.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Поле | Описание
--- | ---
resource_id | **string**<br>Обязательное поле. Идентификатор ресурса, для которого обновляется список привязок прав доступа. Максимальная длина строки в символах — 50.
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Обязательное поле. Изменения в список привязок прав доступа. Количество элементов должно быть больше 0.


### AccessBindingDelta {#AccessBindingDelta}

Поле | Описание
--- | ---
action | enum **AccessBindingAction**<br>Обязательное поле. Действие, которое надо выполнить с привязкой прав доступа. <ul><li>`ADD`: Добавление новой привязки прав доступа.</li><li>`REMOVE`: Удаление привязки прав доступа.</li><ul/>
access_binding | **[AccessBinding](#AccessBinding)**<br>Обязательное поле. Привязка прав доступа. Дополнительные сведения см. в разделе [Привязка прав доступа](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Поле | Описание
--- | ---
role_id | **string**<br>Обязательное поле. Идентификатор ресурса `yandex.cloud.iam.v1.Role` который назначен для субъекта, указанного в параметре `subject`. Максимальная длина строки в символах — 50.
subject | **[Subject](#Subject)**<br>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой аккаунт с уникальным идентификатором в облаке или системную группу с общим системным идентификатором. 


### Subject {#Subject2}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. <ul><li>`allAuthenticatedUsers`: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре `type` указано `system`. </li><li>`allUsers`: Специальный системный идентификатор, представляющий любого пользователя. Аутентификация не требуется. Например, при запросе через API не надо будет указывать IAM-токен. </li><li>`<идентификатор пользователя в облаке>`: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре `type` передано одно из следующих значений: `userAccount`, `federatedUser` или `serviceAccount`.</li></ul> Максимальная длина строки в символах — 50.
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в {{ yandex-cloud }}. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


### Operation {#Operation5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Поле | Описание
--- | ---
resource_id | **string**<br>Идентификатор ресурса, для которого обновляется список привязок прав доступа. 


