---
editable: false
---

# SubnetService

Набор методов для управления подсетями.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Subnet. |
| [List](#List) | Возвращает список доступных подсетей в указанном каталоге. |
| [Create](#Create) | Создает подсеть в указанных каталоге и сети. |
| [Update](#Update) | Обновляет параметры указанной подсети. |
| [Delete](#Delete) | Удаляет указанную подсеть. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанной подсети. |

## Вызовы SubnetService {#calls}

## Get {#Get}

Возвращает указанный ресурс Subnet. <br>Чтобы получить список доступных подсетей, используйте запрос [List](#List).

**rpc Get ([GetSubnetRequest](#GetSubnetRequest)) returns ([Subnet](#Subnet))**

### GetSubnetRequest {#GetSubnetRequest}

Поле | Описание
--- | ---
subnet_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Subnet. <br>Чтобы получить идентификатор подсети, используйте запрос [SubnetService.List](#List). Максимальная длина строки в символах — 50.


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


## List {#List}

Возвращает список доступных подсетей в указанном каталоге.

**rpc List ([ListSubnetsRequest](#ListSubnetsRequest)) returns ([ListSubnetsResponse](#ListSubnetsResponse))**

### ListSubnetsRequest {#ListSubnetsRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка подсетей. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListSubnetsResponse.next_page_token](#ListSubnetsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListSubnetsResponse.next_page_token](#ListSubnetsResponse) прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Subnet.name](#Subnet1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListSubnetsResponse {#ListSubnetsResponse}

Поле | Описание
--- | ---
subnets[] | **[Subnet](#Subnet1)**<br>Список подсетей. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListSubnetsRequest.page_size](#ListSubnetsRequest), используйте `next_page_token` в качестве значения параметра [ListSubnetsRequest.page_token](#ListSubnetsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


### Subnet {#Subnet1}

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


## Create {#Create}

Создает подсеть в указанных каталоге и сети. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.

**rpc Create ([CreateSubnetRequest](#CreateSubnetRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSubnetMetadata](#CreateSubnetMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subnet](#Subnet2)<br>

### CreateSubnetRequest {#CreateSubnetRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается подсеть. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Имя подсети. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание подсети. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
network_id | **string**<br>Обязательное поле. Идентификатор облачной сети, в которой создается подсеть. Максимальная длина строки в символах — 50.
zone_id | **string**<br>Идентификатор зоны доступности, где находится подсеть. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
v4_cidr_blocks[] | **string**<br><ol><li></li></ol> 
v6_cidr_blocks[] | **string**<br>Диапазоны IPv6 еще не доступны. 
route_table_id | **string**<br>ID of route table the subnet is linked to. Максимальная длина строки в символах — 50.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSubnetMetadata](#CreateSubnetMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subnet](#Subnet2)>**<br>в случае успешного выполнения операции. 


### CreateSubnetMetadata {#CreateSubnetMetadata}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор создаваемой подсети. 


### Subnet {#Subnet2}

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


## Update {#Update}

Обновляет параметры указанной подсети. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.

**rpc Update ([UpdateSubnetRequest](#UpdateSubnetRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSubnetMetadata](#UpdateSubnetMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Subnet](#Subnet3)<br>

### UpdateSubnetRequest {#UpdateSubnetRequest}

Поле | Описание
--- | ---
subnet_id | **string**<br>Обязательное поле. Идентификатор обновляемого ресурса Subnet. Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса Subnet будут обновлены. 
name | **string**<br>Имя подсети. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание подсети. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
route_table_id | **string**<br>ID of route table the subnet is linked to. Максимальная длина строки в символах — 50.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSubnetMetadata](#UpdateSubnetMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Subnet](#Subnet3)>**<br>в случае успешного выполнения операции. 


### UpdateSubnetMetadata {#UpdateSubnetMetadata}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор обновляемого ресурса Subnet. 


### Subnet {#Subnet3}

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


## Delete {#Delete}

Удаляет указанную подсеть.

**rpc Delete ([DeleteSubnetRequest](#DeleteSubnetRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSubnetMetadata](#DeleteSubnetMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteSubnetRequest {#DeleteSubnetRequest}

Поле | Описание
--- | ---
subnet_id | **string**<br>Обязательное поле. Идентификатор удаляемой подсети. Чтобы получить идентификатор подсети, используйте запрос [SubnetService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSubnetMetadata](#DeleteSubnetMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteSubnetMetadata {#DeleteSubnetMetadata}

Поле | Описание
--- | ---
subnet_id | **string**<br>Идентификатор удаляемого ресурса Subnet. 


## ListOperations {#ListOperations}

Возвращает список операций для указанной подсети.

**rpc ListOperations ([ListSubnetOperationsRequest](#ListSubnetOperationsRequest)) returns ([ListSubnetOperationsResponse](#ListSubnetOperationsResponse))**

### ListSubnetOperationsRequest {#ListSubnetOperationsRequest}

Поле | Описание
--- | ---
subnet_id | **string**<br>Обязательное поле. Идентификатор ресурса Subnet, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListNetworkOperationsResponse.next_page_token](#ListNetworkOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListNetworkSubnetsResponse.next_page_token](#ListNetworkSubnetsResponse) прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListSubnetOperationsResponse {#ListSubnetOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанного ресурса Subnet. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListNetworkSubnetsRequest.page_size](#ListNetworkSubnetsRequest), используйте `next_page_token` в качестве значения параметра [ListNetworkSubnetsRequest.page_token](#ListNetworkSubnetsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


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


