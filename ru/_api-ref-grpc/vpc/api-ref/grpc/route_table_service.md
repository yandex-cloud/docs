---
editable: false
---

# RouteTableService

Набор методов для управления таблицами маршрутизации.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанную таблицу маршрутизации. |
| [List](#List) | Возвращает список доступных таблиц маршрутизации в указанном каталоге. |
| [Create](#Create) | Создает таблицу маршрутизации в указанных каталоге и сети. |
| [Update](#Update) | Обновляет указанную таблицу маршрутизации. |
| [Delete](#Delete) | Удаляет указанную таблицу маршрутизации. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанной таблицы маршрутизации. |

## Вызовы RouteTableService {#calls}

## Get {#Get}

Возвращает указанную таблицу маршрутизации. <br>Чтобы получить список доступных таблиц маршрутизации, используйте запрос [List](#List).

**rpc Get ([GetRouteTableRequest](#GetRouteTableRequest)) returns ([RouteTable](#RouteTable))**

### GetRouteTableRequest {#GetRouteTableRequest}

Поле | Описание
--- | ---
route_table_id | **string**<br>Обязательное поле. Идентификатор возвращаемой таблицы маршрутизации. Для получения идентификатора таблицы маршрутизации используйте запрос [RouteTableService.List](#List) . Максимальная длина строки в символах — 50.


### RouteTable {#RouteTable}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор таблицы маршрутизации. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит таблица маршрутизации. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя таблицы маршрутизации. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание таблицы маршрутизации. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Максимум 64 метки на ресурс. 
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит таблица маршрутизации. 
static_routes[] | **[StaticRoute](#StaticRoute)**<br>Список статических маршрутов в таблице маршрутизации. 


### StaticRoute {#StaticRoute}

Поле | Описание
--- | ---
destination | **oneof:** `destination_prefix`<br>
&nbsp;&nbsp;destination_prefix | **string**<br>Подсеть назначения в нотации CIDR. 
next_hop | **oneof:** `next_hop_address`<br>
&nbsp;&nbsp;next_hop_address | **string**<br>IP-адрес next hop. 


## List {#List}

Возвращает список доступных таблиц маршрутизации в указанном каталоге.

**rpc List ([ListRouteTablesRequest](#ListRouteTablesRequest)) returns ([ListRouteTablesResponse](#ListRouteTablesResponse))**

### ListRouteTablesRequest {#ListRouteTablesRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, к которому принадлежит таблица маршрутизации. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListRouteTablesResponse.next_page_token](#ListRouteTablesResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListRouteTablesResponse.next_page_token](#ListRouteTablesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [RouteTable.name](#RouteTable1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListRouteTablesResponse {#ListRouteTablesResponse}

Поле | Описание
--- | ---
route_tables[] | **[RouteTable](#RouteTable1)**<br>Список таблиц маршрутизации. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListRouteTablesRequest.page_size](#ListRouteTablesRequest), используйте `next_page_token` в качестве значения параметра [ListRouteTablesRequest.page_token](#ListRouteTablesRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token`, для перебора страниц результатов. 


### RouteTable {#RouteTable1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор таблицы маршрутизации. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит таблица маршрутизации. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя таблицы маршрутизации. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание таблицы маршрутизации. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Максимум 64 метки на ресурс. 
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит таблица маршрутизации. 
static_routes[] | **[StaticRoute](#StaticRoute1)**<br>Список статических маршрутов в таблице маршрутизации. 


### StaticRoute {#StaticRoute1}

Поле | Описание
--- | ---
destination | **oneof:** `destination_prefix`<br>
&nbsp;&nbsp;destination_prefix | **string**<br>Подсеть назначения в нотации CIDR. 
next_hop | **oneof:** `next_hop_address`<br>
&nbsp;&nbsp;next_hop_address | **string**<br>IP-адрес next hop. 


## Create {#Create}

Создает таблицу маршрутизации в указанных каталоге и сети. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.

**rpc Create ([CreateRouteTableRequest](#CreateRouteTableRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateRouteTableMetadata](#CreateRouteTableMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RouteTable](#RouteTable2)<br>

### CreateRouteTableRequest {#CreateRouteTableRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, к которому принадлежит таблица маршрутизации. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List) . Максимальная длина строки в символах — 50.
name | **string**<br>Имя таблицы маршрутизации. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание таблицы маршрутизации. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
network_id | **string**<br>Обязательное поле. Идентификатор облачной сети, к которой принадлежит таблица маршрутизации. Максимальная длина строки в символах — 50.
static_routes[] | **[StaticRoute](#StaticRoute2)**<br>Список статических маршрутов в таблице маршрутизации. 


### StaticRoute {#StaticRoute2}

Поле | Описание
--- | ---
destination | **oneof:** `destination_prefix`<br>
&nbsp;&nbsp;destination_prefix | **string**<br>Подсеть назначения в нотации CIDR. 
next_hop | **oneof:** `next_hop_address`<br>
&nbsp;&nbsp;next_hop_address | **string**<br>IP-адрес next hop. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateRouteTableMetadata](#CreateRouteTableMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RouteTable](#RouteTable2)>**<br>в случае успешного выполнения операции. 


### CreateRouteTableMetadata {#CreateRouteTableMetadata}

Поле | Описание
--- | ---
route_table_id | **string**<br>Идентификатор создаваемой таблицы маршрутизации. 


### RouteTable {#RouteTable2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор таблицы маршрутизации. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит таблица маршрутизации. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя таблицы маршрутизации. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание таблицы маршрутизации. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Максимум 64 метки на ресурс. 
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит таблица маршрутизации. 
static_routes[] | **[StaticRoute](#StaticRoute3)**<br>Список статических маршрутов в таблице маршрутизации. 


### StaticRoute {#StaticRoute3}

Поле | Описание
--- | ---
destination | **oneof:** `destination_prefix`<br>
&nbsp;&nbsp;destination_prefix | **string**<br>Подсеть назначения в нотации CIDR. 
next_hop | **oneof:** `next_hop_address`<br>
&nbsp;&nbsp;next_hop_address | **string**<br>IP-адрес next hop. 


## Update {#Update}

Обновляет указанную таблицу маршрутизации. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.

**rpc Update ([UpdateRouteTableRequest](#UpdateRouteTableRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRouteTableMetadata](#UpdateRouteTableMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RouteTable](#RouteTable3)<br>

### UpdateRouteTableRequest {#UpdateRouteTableRequest}

Поле | Описание
--- | ---
route_table_id | **string**<br>Обязательное поле. Идентификатор обновляемой таблицы маршрутизации. Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса RouteTable будут обновлены. 
name | **string**<br>Имя таблицы маршрутизации. Имя должно быть уникальным в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание таблицы маршрутизации. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
static_routes[] | **[StaticRoute](#StaticRoute4)**<br>Список статических маршрутов. 


### StaticRoute {#StaticRoute4}

Поле | Описание
--- | ---
destination | **oneof:** `destination_prefix`<br>
&nbsp;&nbsp;destination_prefix | **string**<br>Подсеть назначения в нотации CIDR. 
next_hop | **oneof:** `next_hop_address`<br>
&nbsp;&nbsp;next_hop_address | **string**<br>IP-адрес next hop. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateRouteTableMetadata](#UpdateRouteTableMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RouteTable](#RouteTable3)>**<br>в случае успешного выполнения операции. 


### UpdateRouteTableMetadata {#UpdateRouteTableMetadata}

Поле | Описание
--- | ---
route_table_id | **string**<br>Идентификатор обновляемой таблицы маршрутизации. 


### RouteTable {#RouteTable3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор таблицы маршрутизации. 
folder_id | **string**<br>Идентификатор каталога, к которому принадлежит таблица маршрутизации. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) . 
name | **string**<br>Имя таблицы маршрутизации. Имя должно быть уникальным в каталоге. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание таблицы маршрутизации. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `` ключ:значение ``. Максимум 64 метки на ресурс. 
network_id | **string**<br>Идентификатор облачной сети, к которой принадлежит таблица маршрутизации. 
static_routes[] | **[StaticRoute](#StaticRoute5)**<br>Список статических маршрутов в таблице маршрутизации. 


### StaticRoute {#StaticRoute5}

Поле | Описание
--- | ---
destination | **oneof:** `destination_prefix`<br>
&nbsp;&nbsp;destination_prefix | **string**<br>Подсеть назначения в нотации CIDR. 
next_hop | **oneof:** `next_hop_address`<br>
&nbsp;&nbsp;next_hop_address | **string**<br>IP-адрес next hop. 


## Delete {#Delete}

Удаляет указанную таблицу маршрутизации.

**rpc Delete ([DeleteRouteTableRequest](#DeleteRouteTableRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteRouteTableMetadata](#DeleteRouteTableMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteRouteTableRequest {#DeleteRouteTableRequest}

Поле | Описание
--- | ---
route_table_id | **string**<br>Обязательное поле. Идентификатор удаляемой таблицы маршрутизации. Для получения идентификатора таблицы маршрутизации используйте запрос [RouteTableService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteRouteTableMetadata](#DeleteRouteTableMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteRouteTableMetadata {#DeleteRouteTableMetadata}

Поле | Описание
--- | ---
route_table_id | **string**<br>Идентификатор удаляемой таблицы маршрутизации. 


## ListOperations {#ListOperations}

Возвращает список операций для указанной таблицы маршрутизации.

**rpc ListOperations ([ListRouteTableOperationsRequest](#ListRouteTableOperationsRequest)) returns ([ListRouteTableOperationsResponse](#ListRouteTableOperationsResponse))**

### ListRouteTableOperationsRequest {#ListRouteTableOperationsRequest}

Поле | Описание
--- | ---
route_table_id | **string**<br>Обязательное поле. Идентификатор таблицы маршрутизации, для которой запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListRouteTableOperationsResponse.next_page_token](#ListRouteTableOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListRouteTableOperationsResponse.next_page_token](#ListRouteTableOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListRouteTableOperationsResponse {#ListRouteTableOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанной таблицы маршрутизации. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListRouteTableOperationsRequest.page_size](#ListRouteTableOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListRouteTableOperationsRequest.page_token](#ListRouteTableOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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


