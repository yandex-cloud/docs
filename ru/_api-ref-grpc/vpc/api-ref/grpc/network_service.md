---
editable: false
---

# NetworkService

Набор методов для управления облачными сетями.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Network. |
| [List](#List) | Возвращает список доступных ресурсов Network в указанном каталоге. |
| [Create](#Create) | Создает облачную сеть в указанном каталоге. |
| [Update](#Update) | Обновляет параметры указанной облачной сети. |
| [Delete](#Delete) | Удаляет указанную облачную сеть. |
| [ListSubnets](#ListSubnets) | Возвращает список доступных подсетей в указанной облачной сети. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанной облачной сети. |

## Вызовы NetworkService {#calls}

## Get {#Get}

Возвращает указанный ресурс Network. <br>Чтобы получить список доступных ресурсов Network, используйте запрос [List](#List).

**rpc Get ([GetNetworkRequest](#GetNetworkRequest)) returns ([Network](#Network))**

### GetNetworkRequest {#GetNetworkRequest}

Поле | Описание
--- | ---
network_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Network. Чтобы получить идентификатор облачной сети, используйте запрос [NetworkService.List](#List). Максимальная длина строки в символах — 50.


### Network {#Network}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор облачной сети. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит сеть. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя облачной сети. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание облачной сети. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Максимум 64 метки на ресурс. 
default_security_group_id | **string**<br>Идентификатор группы безопасности по умолчанию. 


## List {#List}

Возвращает список доступных ресурсов Network в указанном каталоге.

**rpc List ([ListNetworksRequest](#ListNetworksRequest)) returns ([ListNetworksResponse](#ListNetworksResponse))**

### ListNetworksRequest {#ListNetworksRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка облачных сетей. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListNetworksResponse.next_page_token](#ListNetworksResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListNetworksResponse.next_page_token](#ListNetworksResponse) прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Network.name](#Network1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListNetworksResponse {#ListNetworksResponse}

Поле | Описание
--- | ---
networks[] | **[Network](#Network1)**<br>Список ресурсов Network. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListNetworkSubnetsRequest.page_size](#ListNetworkSubnetsRequest), используйте `next_page_token` в качестве значения параметра [ListNetworkSubnetsRequest.page_token](#ListNetworkSubnetsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


### Network {#Network1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор облачной сети. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит сеть. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя облачной сети. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание облачной сети. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Максимум 64 метки на ресурс. 
default_security_group_id | **string**<br>Идентификатор группы безопасности по умолчанию. 


## Create {#Create}

Создает облачную сеть в указанном каталоге. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.

**rpc Create ([CreateNetworkRequest](#CreateNetworkRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateNetworkMetadata](#CreateNetworkMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Network](#Network2)<br>

### CreateNetworkRequest {#CreateNetworkRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается облачная сеть. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Имя облачной сети. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание облачной сети. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateNetworkMetadata](#CreateNetworkMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Network](#Network2)>**<br>в случае успешного выполнения операции. 


### CreateNetworkMetadata {#CreateNetworkMetadata}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор создаваемой облачной сети. 


### Network {#Network2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор облачной сети. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит сеть. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя облачной сети. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание облачной сети. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Максимум 64 метки на ресурс. 
default_security_group_id | **string**<br>Идентификатор группы безопасности по умолчанию. 


## Update {#Update}

Обновляет параметры указанной облачной сети. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.

**rpc Update ([UpdateNetworkRequest](#UpdateNetworkRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateNetworkMetadata](#UpdateNetworkMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Network](#Network3)<br>

### UpdateNetworkRequest {#UpdateNetworkRequest}

Поле | Описание
--- | ---
network_id | **string**<br>Обязательное поле. Идентификатор обновляемого ресурса Network. Для получения идентификатора облачной сети используйте запрос [NetworkService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля облачной сети будут обновлены. 
name | **string**<br>Имя облачной сети. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание облачной сети. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateNetworkMetadata](#UpdateNetworkMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Network](#Network3)>**<br>в случае успешного выполнения операции. 


### UpdateNetworkMetadata {#UpdateNetworkMetadata}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор обновляемого ресурса Network. 


### Network {#Network3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор облачной сети. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит сеть. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя облачной сети. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание облачной сети. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Максимум 64 метки на ресурс. 
default_security_group_id | **string**<br>Идентификатор группы безопасности по умолчанию. 


## Delete {#Delete}

Удаляет указанную облачную сеть.

**rpc Delete ([DeleteNetworkRequest](#DeleteNetworkRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteNetworkMetadata](#DeleteNetworkMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteNetworkRequest {#DeleteNetworkRequest}

Поле | Описание
--- | ---
network_id | **string**<br>Обязательное поле. Идентификатор обновляемого ресурса Network. Чтобы получить идентификатор облачной сети, используйте запрос [NetworkService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteNetworkMetadata](#DeleteNetworkMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteNetworkMetadata {#DeleteNetworkMetadata}

Поле | Описание
--- | ---
network_id | **string**<br>Идентификатор удаляемой облачной сети. 


## ListSubnets {#ListSubnets}

Возвращает список доступных подсетей в указанной облачной сети.

**rpc ListSubnets ([ListNetworkSubnetsRequest](#ListNetworkSubnetsRequest)) returns ([ListNetworkSubnetsResponse](#ListNetworkSubnetsResponse))**

### ListNetworkSubnetsRequest {#ListNetworkSubnetsRequest}

Поле | Описание
--- | ---
network_id | **string**<br>Обязательное поле. Идентификатор ресурса Network для получения списка подсетей. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListNetworkSubnetsResponse.next_page_token](#ListNetworkSubnetsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListNetworkSubnetsResponse.next_page_token](#ListNetworkSubnetsResponse) прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListNetworkSubnetsResponse {#ListNetworkSubnetsResponse}

Поле | Описание
--- | ---
subnets[] | **[Subnet](#Subnet)**<br>Список подсетей, принадлежащих облачной сети, указанной в запросе. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListNetworkSubnetsRequest.page_size](#ListNetworkSubnetsRequest), используйте `next_page_token` в качестве значения параметра [ListNetworkSubnetsRequest.page_token](#ListNetworkSubnetsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


### Subnet {#Subnet}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор подсети. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит подсеть. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
name | **string**<br>Имя подсети. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание подсети. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Максимум 64 метки на ресурс. 
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит подсеть. 
zone_id | **string**<br>Идентификатор зоны доступности, где находится подсеть. 
v4_cidr_blocks[] | **string**<br><ol><li></li></ol> 
v6_cidr_blocks[] | **string**<br>IPv6 еще не доступен. 


## ListOperations {#ListOperations}

Возвращает список операций для указанной облачной сети.

**rpc ListOperations ([ListNetworkOperationsRequest](#ListNetworkOperationsRequest)) returns ([ListNetworkOperationsResponse](#ListNetworkOperationsResponse))**

### ListNetworkOperationsRequest {#ListNetworkOperationsRequest}

Поле | Описание
--- | ---
network_id | **string**<br>Обязательное поле. Идентификатор ресурса Network, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListNetworkOperationsResponse.next_page_token](#ListNetworkOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListNetworkOperationsResponse.next_page_token](#ListNetworkOperationsResponse) прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListNetworkOperationsResponse {#ListNetworkOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанной облачной сети. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListNetworkOperationsRequest.page_size](#ListNetworkOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListNetworkOperationsRequest.page_token](#ListNetworkOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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


