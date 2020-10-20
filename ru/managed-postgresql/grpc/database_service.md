---
editable: false
---

# DatabaseService

Набор методов для управления ресурсами Database для PostgreSQL.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Database для PostgreSQL. |
| [List](#List) | Получает список ресурсов Database для указанного кластера PostgreSQL. |
| [Create](#Create) | Создает новую базу данных PostgreSQL в указанном кластере. |
| [Update](#Update) | Изменяет указанную базу данных PostgreSQL. |
| [Delete](#Delete) | Удаляет указанную базу данных PostgreSQL. |

## Вызовы DatabaseService {#calls}

## Get {#Get}

Возвращает указанный ресурс Database для PostgreSQL. <br>Чтобы получить список доступных ресурсов Database для PostgreSQL, отправьте запрос [List](#List).

**rpc Get ([GetDatabaseRequest](#GetDatabaseRequest)) returns ([Database](#Database))**

### GetDatabaseRequest {#GetDatabaseRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, к которому принадлежит база данных. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
database_name | **string**<br>Обязательное поле. Имя запрашиваемого ресурса Database для PostgreSQL. Чтобы получить имя базы данных, используйте запрос [DatabaseService.List](#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Database {#Database}

Поле | Описание
--- | ---
name | **string**<br>Имя базы данных. 
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит база данных. 
owner | **string**<br>Имя пользователя, назначенного владельцем базы данных. 
lc_collate | **string**<br>POSIX-локаль для порядка сортировки строк. Может быть установлен только во время создания. 
lc_ctype | **string**<br>POSIX-локаль для классификации символов. Может быть установлена только во время создания. 
extensions[] | **[Extension](#Extension)**<br>Расширения PostgreSQL, включенные для базы данных. 


### Extension {#Extension}

Поле | Описание
--- | ---
name | **string**<br>Имя расширения, например `pg_trgm` или `pg_btree`. Расширения, которые поддерживает Managed Service for PostgreSQL, [перечислены в документации](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Версия расширения. 


## List {#List}

Получает список ресурсов Database для указанного кластера PostgreSQL.

**rpc List ([ListDatabasesRequest](#ListDatabasesRequest)) returns ([ListDatabasesResponse](#ListDatabasesResponse))**

### ListDatabasesRequest {#ListDatabasesRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, для которого нужно вывести список баз данных. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListDatabasesResponse.next_page_token](#ListDatabasesResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListDatabasesResponse.next_page_token](#ListDatabasesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListDatabasesResponse {#ListDatabasesResponse}

Поле | Описание
--- | ---
databases[] | **[Database](#Database1)**<br>Список ресурсов Database для баз данных PostgreSQL. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListDatabasesRequest.page_size](#ListDatabasesRequest), используйте `next_page_token` в качестве значения параметра [ListDatabasesRequest.page_token](#ListDatabasesRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Database {#Database1}

Поле | Описание
--- | ---
name | **string**<br>Имя базы данных. 
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит база данных. 
owner | **string**<br>Имя пользователя, назначенного владельцем базы данных. 
lc_collate | **string**<br>POSIX-локаль для порядка сортировки строк. Может быть установлен только во время создания. 
lc_ctype | **string**<br>POSIX-локаль для классификации символов. Может быть установлена только во время создания. 
extensions[] | **[Extension](#Extension1)**<br>Расширения PostgreSQL, включенные для базы данных. 


### Extension {#Extension1}

Поле | Описание
--- | ---
name | **string**<br>Имя расширения, например `pg_trgm` или `pg_btree`. Расширения, которые поддерживает Managed Service for PostgreSQL, [перечислены в документации](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Версия расширения. 


## Create {#Create}

Создает новую базу данных PostgreSQL в указанном кластере.

**rpc Create ([CreateDatabaseRequest](#CreateDatabaseRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDatabaseMetadata](#CreateDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database2)<br>

### CreateDatabaseRequest {#CreateDatabaseRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, в котором следует создать базу данных. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
database_spec | **[DatabaseSpec](#DatabaseSpec)**<br>Обязательное поле. Конфигурация создаваемой базы данных. 


### DatabaseSpec {#DatabaseSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя базы данных PostgreSQL. Длина 1-63 символов. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
owner | **string**<br>Обязательное поле. Имя пользователя, которого нужно назначить владельцем базы данных. Чтобы получить список доступных пользователей PostgreSQL, сделайте запрос [UserService.List](./user_service#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
lc_collate | **string**<br>POSIX-локаль для порядка сортировки строк. Может быть установлен только во время создания. Значение должно соответствовать регулярному выражению ` |[a-zA-Z_]+.UTF-8|C `.
lc_ctype | **string**<br>POSIX-локаль для классификации символов. Может быть установлена только во время создания. Значение должно соответствовать регулярному выражению ` |[a-zA-Z_]+.UTF-8|C `.
extensions[] | **[Extension](#Extension2)**<br>Расширения PostgreSQL, которые следует подключить для базы данных. 


### Extension {#Extension2}

Поле | Описание
--- | ---
name | **string**<br>Имя расширения, например `pg_trgm` или `pg_btree`. Расширения, которые поддерживает Managed Service for PostgreSQL, [перечислены в документации](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Версия расширения. 


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
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, в котором создается база данных. 
database_name | **string**<br>Имя создаваемой базы данных PostgreSQL. 


### Database {#Database2}

Поле | Описание
--- | ---
name | **string**<br>Имя базы данных. 
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит база данных. 
owner | **string**<br>Имя пользователя, назначенного владельцем базы данных. 
lc_collate | **string**<br>POSIX-локаль для порядка сортировки строк. Может быть установлен только во время создания. 
lc_ctype | **string**<br>POSIX-локаль для классификации символов. Может быть установлена только во время создания. 
extensions[] | **[Extension](#Extension3)**<br>Расширения PostgreSQL, включенные для базы данных. 


### Extension {#Extension3}

Поле | Описание
--- | ---
name | **string**<br>Имя расширения, например `pg_trgm` или `pg_btree`. Расширения, которые поддерживает Managed Service for PostgreSQL, [перечислены в документации](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Версия расширения. 


## Update {#Update}

Изменяет указанную базу данных PostgreSQL.

**rpc Update ([UpdateDatabaseRequest](#UpdateDatabaseRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateDatabaseMetadata](#UpdateDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Database](#Database3)<br>

### UpdateDatabaseRequest {#UpdateDatabaseRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, в котором следует изменить базу данных. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
database_name | **string**<br>Обязательное поле. Имя изменяемой базы данных. Чтобы получить имя базы данных, используйте запрос [DatabaseService.List](#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, которая указывает, какие поля ресурса Database должны быть обновлены. 
extensions[] | **[Extension](#Extension4)**<br>Расширения PostgreSQL, которые должны быть подключены для базы данных. <br>Если поле указано, список включенных расширений полностью переписывается. Поэтому, чтобы отключить активное расширение, вам нужно отправить новый список без этого расширения. 


### Extension {#Extension4}

Поле | Описание
--- | ---
name | **string**<br>Имя расширения, например `pg_trgm` или `pg_btree`. Расширения, которые поддерживает Managed Service for PostgreSQL, [перечислены в документации](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Версия расширения. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateDatabaseMetadata](#UpdateDatabaseMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Database](#Database3)>**<br>в случае успешного выполнения операции. 


### UpdateDatabaseMetadata {#UpdateDatabaseMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, в котором изменяется база данных. 
database_name | **string**<br>Имя изменяемой базы данных PostgreSQL. 


### Database {#Database3}

Поле | Описание
--- | ---
name | **string**<br>Имя базы данных. 
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит база данных. 
owner | **string**<br>Имя пользователя, назначенного владельцем базы данных. 
lc_collate | **string**<br>POSIX-локаль для порядка сортировки строк. Может быть установлен только во время создания. 
lc_ctype | **string**<br>POSIX-локаль для классификации символов. Может быть установлена только во время создания. 
extensions[] | **[Extension](#Extension5)**<br>Расширения PostgreSQL, включенные для базы данных. 


### Extension {#Extension5}

Поле | Описание
--- | ---
name | **string**<br>Имя расширения, например `pg_trgm` или `pg_btree`. Расширения, которые поддерживает Managed Service for PostgreSQL, [перечислены в документации](/docs/managed-postgresql/operations/cluster-extensions). 
version | **string**<br>Версия расширения. 


## Delete {#Delete}

Удаляет указанную базу данных PostgreSQL.

**rpc Delete ([DeleteDatabaseRequest](#DeleteDatabaseRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDatabaseMetadata](#DeleteDatabaseMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDatabaseRequest {#DeleteDatabaseRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, в котором следует удалить базу данных. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
database_name | **string**<br>Обязательное поле. Имя удаляемой базы данных. Чтобы получить имя базы данных, используйте запрос [DatabaseService.List](#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation2}

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
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, в котором удаляется база данных. 
database_name | **string**<br>Имя удаляемой базы данных PostgreSQL. 


