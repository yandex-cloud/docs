---
editable: false
---

# DatabaseService

Набор методов для управления базами данных MySQL.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанную базу данных MySQL. |
| [List](#List) | Получает список баз данных MySQL в указанном кластере. |
| [Create](#Create) | Создает новую базу данных MySQL в указанном кластере. |
| [Delete](#Delete) | Удаляет указанную базу данных MySQL. |

## Вызовы DatabaseService {#calls}

## Get {#Get}

Возвращает указанную базу данных MySQL. <br>Чтобы получить список доступных баз данных MySQL, выполните запрос [List](#List).

**rpc Get ([GetDatabaseRequest](#GetDatabaseRequest)) returns ([Database](#Database))**

### GetDatabaseRequest {#GetDatabaseRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MySQL, которому принадлежит база данных. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
database_name | **string**<br>Обязательное поле. Имя базы данных MySQL, данные о которой нужно запросить. Чтобы получить имя базы данных, используйте запрос [DatabaseService.List](#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Database {#Database}

Поле | Описание
--- | ---
name | **string**<br>Имя базы данных. 
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит база данных. 


## List {#List}

Получает список баз данных MySQL в указанном кластере.

**rpc List ([ListDatabasesRequest](#ListDatabasesRequest)) returns ([ListDatabasesResponse](#ListDatabasesResponse))**

### ListDatabasesRequest {#ListDatabasesRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MySQL, для которого нужно вывести список баз данных. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListDatabasesResponse.next_page_token](#ListDatabasesResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListDatabasesResponse.next_page_token](#ListDatabasesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListDatabasesResponse {#ListDatabasesResponse}

Поле | Описание
--- | ---
databases[] | **[Database](#Database1)**<br>Список баз данных MySQL. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListDatabasesRequest.page_size](#ListDatabasesRequest), используйте `next_page_token` в качестве значения параметра [ListDatabasesRequest.page_token](#ListDatabasesRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Database {#Database1}

Поле | Описание
--- | ---
name | **string**<br>Имя базы данных. 
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит база данных. 


## Create {#Create}

Создает новую базу данных MySQL в указанном кластере.

**rpc Create ([CreateDatabaseRequest](#CreateDatabaseRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDatabaseMetadata](#CreateDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database2)<br>

### CreateDatabaseRequest {#CreateDatabaseRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MySQL, в котором следует создать базу данных. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
database_spec | **[DatabaseSpec](#DatabaseSpec)**<br>Обязательное поле. Конфигурация создаваемой базы данных. 


### DatabaseSpec {#DatabaseSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя базы данных MySQL. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDatabaseMetadata](#CreateDatabaseMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database2)>**<br>в случае успешного выполнения операции. 


### CreateDatabaseMetadata {#CreateDatabaseMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера MySQL, в котором создается база данных. 
database_name | **string**<br>Имя создаваемой базы данных MySQL. 


### Database {#Database2}

Поле | Описание
--- | ---
name | **string**<br>Имя базы данных. 
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит база данных. 


## Delete {#Delete}

Удаляет указанную базу данных MySQL.

**rpc Delete ([DeleteDatabaseRequest](#DeleteDatabaseRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDatabaseMetadata](#DeleteDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDatabaseRequest {#DeleteDatabaseRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MySQL, в котором следует удалить базу данных. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
database_name | **string**<br>Обязательное поле. Имя удаляемой базы данных. Чтобы получить имя базы данных, используйте запрос [DatabaseService.List](#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDatabaseMetadata](#DeleteDatabaseMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteDatabaseMetadata {#DeleteDatabaseMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера MySQL, в котором удаляется база данных. 
database_name | **string**<br>Имя удаляемой базы данных MySQL. 


