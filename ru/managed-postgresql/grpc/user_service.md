---
editable: false
---

# UserService

Набор методов для управления ресурсами User для PostgreSQL.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс User для PostgreSQL. |
| [List](#List) | Получает список ресурсов User для указанного кластера PostgreSQL. |
| [Create](#Create) | Создает пользователя PostgreSQL в указанном кластере. |
| [Update](#Update) | Изменяет указанного пользователя PostgreSQL. |
| [Delete](#Delete) | Удаляет указанного пользователя PostgreSQL. |
| [GrantPermission](#GrantPermission) | Выдает разрешение указанному пользователю PostgreSQL. |
| [RevokePermission](#RevokePermission) | Отзывает разрешение у указанного пользователя PostgreSQL. |

## Вызовы UserService {#calls}

## Get {#Get}

Возвращает указанный ресурс User для PostgreSQL. <br>Чтобы получить список доступных ресурсов User для PostgreSQL, отправьте запрос [List](#List).

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). false Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя запрашиваемого ресурса User для PostgreSQL. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List). false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя PostgreSQL. 
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission)**<br>Набор разрешений, предоставленных пользователю. 
conn_limit | **int64**<br>Количество доступных пользователю подключений к базе данных. 
settings | **[UserSettings](#UserSettings)**<br>Настройки PostgreSQL для этого пользователя 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Пользователь может войти (по умолчанию True). 
grants[] | **string**<br>Пользовательские гранты (GRANT <роль> TO <пользователь>), роль должна быть другим пользователем. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 


### UserSettings {#UserSettings}

Поле | Описание
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br> <ul><ul/>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в миллисекундах. 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в миллисекундах. 
synchronous_commit | enum **SynchronousCommit**<br> <ul><ul/>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в байтах. 


## List {#List}

Получает список ресурсов User для указанного кластера PostgreSQL.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера для вывода списка пользователей PostgreSQL. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). false Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListUsersResponse.next_page_token](#ListUsersResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListUsersResponse.next_page_token](#ListUsersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListUsersResponse {#ListUsersResponse}

Поле | Описание
--- | ---
users[] | **[User](#User1)**<br>Список ресурсов User для PostgreSQL. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListUsersRequest.page_size](#ListUsersRequest1), используйте `next_page_token` в качестве значения параметра [ListUsersRequest.page_token](#ListUsersRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя PostgreSQL. 
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission1)**<br>Набор разрешений, предоставленных пользователю. 
conn_limit | **int64**<br>Количество доступных пользователю подключений к базе данных. 
settings | **[UserSettings](#UserSettings1)**<br>Настройки PostgreSQL для этого пользователя 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Пользователь может войти (по умолчанию True). 
grants[] | **string**<br>Пользовательские гранты (GRANT <роль> TO <пользователь>), роль должна быть другим пользователем. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 


### UserSettings {#UserSettings}

Поле | Описание
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br> <ul><ul/>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в миллисекундах. 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в миллисекундах. 
synchronous_commit | enum **SynchronousCommit**<br> <ul><ul/>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в байтах. 


## Create {#Create}

Создает пользователя PostgreSQL в указанном кластере.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, в котором следует создать пользователя. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). false Максимальная длина строки в символах — 50.
user_spec | **[UserSpec](#UserSpec)**<br>Обязательное поле. Свойства создаваемого пользователя. false


### UserSpec {#UserSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя пользователя PostgreSQL. false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
password | **string**<br>Обязательное поле. Пароль пользователя PostgreSQL. false Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission2)**<br>Набор разрешений, которые следует предоставить пользователю. 
conn_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Количество подключений к базе данных, которые должны быть доступны пользователю. Минимальная значение — 10.
settings | **[UserSettings](#UserSettings2)**<br>Настройки PostgreSQL для этого пользователя 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Пользователь может войти (по умолчанию True). 
grants[] | **string**<br>Пользовательские гранты (GRANT <роль> TO <пользователь>), роль должна быть другим пользователем. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 


### UserSettings {#UserSettings}

Поле | Описание
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br> <ul><ul/>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в миллисекундах. 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в миллисекундах. 
synchronous_commit | enum **SynchronousCommit**<br> <ul><ul/>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в байтах. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateUserMetadata](#CreateUserMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User2)>**<br>в случае успешного выполнения операции. 


### CreateUserMetadata {#CreateUserMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, в котором создается пользователь. 
user_name | **string**<br>Имя создаваемого пользователя. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя PostgreSQL. 
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission3)**<br>Набор разрешений, предоставленных пользователю. 
conn_limit | **int64**<br>Количество доступных пользователю подключений к базе данных. 
settings | **[UserSettings](#UserSettings3)**<br>Настройки PostgreSQL для этого пользователя 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Пользователь может войти (по умолчанию True). 
grants[] | **string**<br>Пользовательские гранты (GRANT <роль> TO <пользователь>), роль должна быть другим пользователем. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


## Update {#Update}

Изменяет указанного пользователя PostgreSQL.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). false Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, которого следует изменить. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List). false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, которая указывает, какие поля ресурса User для PostgreSQL должны быть обновлены. 
password | **string**<br>Новый пароль для пользователя. Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission3)**<br>Новый набор разрешений для пользователя. 
conn_limit | **int64**<br>Количество одновременных подключений к базе данных, которые должны быть доступны пользователю. Минимальная значение — 10.
settings | **[UserSettings](#UserSettings3)**<br>Настройки PostgreSQL для этого пользователя 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Пользователь может войти (по умолчанию True). 
grants[] | **string**<br>Пользовательские гранты (GRANT <роль> TO <пользователь>), роль должна быть другим пользователем. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 


### UserSettings {#UserSettings}

Поле | Описание
--- | ---
default_transaction_isolation | enum **TransactionIsolation**<br> <ul><ul/>
lock_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в миллисекундах. 
log_min_duration_statement | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в миллисекундах. 
synchronous_commit | enum **SynchronousCommit**<br> <ul><ul/>
temp_file_limit | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>в байтах. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateUserMetadata](#UpdateUserMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User3)>**<br>в случае успешного выполнения операции. 


### UpdateUserMetadata {#UpdateUserMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. 
user_name | **string**<br>Имя изменяемого пользователя. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя PostgreSQL. 
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission4)**<br>Набор разрешений, предоставленных пользователю. 
conn_limit | **int64**<br>Количество доступных пользователю подключений к базе данных. 
settings | **[UserSettings](#UserSettings4)**<br>Настройки PostgreSQL для этого пользователя 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Пользователь может войти (по умолчанию True). 
grants[] | **string**<br>Пользовательские гранты (GRANT <роль> TO <пользователь>), роль должна быть другим пользователем. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


## Delete {#Delete}

Удаляет указанного пользователя PostgreSQL.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). false Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя удаляемого пользователя. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List). false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteUserMetadata](#DeleteUserMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteUserMetadata {#DeleteUserMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. 
user_name | **string**<br>Имя удаляемого пользователя. 


## GrantPermission {#GrantPermission}

Выдает разрешение указанному пользователю PostgreSQL.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). false Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, которому следует предоставить разрешение. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List). false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission4)**<br>Обязательное поле. Разрешение, которое должно быть предоставлено указанному пользователю. false


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User4)>**<br>в случае успешного выполнения операции. 


### GrantUserPermissionMetadata {#GrantUserPermissionMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). 
user_name | **string**<br>Имя пользователя, которому предоставляется разрешение. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя PostgreSQL. 
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission5)**<br>Набор разрешений, предоставленных пользователю. 
conn_limit | **int64**<br>Количество доступных пользователю подключений к базе данных. 
settings | **[UserSettings](#UserSettings4)**<br>Настройки PostgreSQL для этого пользователя 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Пользователь может войти (по умолчанию True). 
grants[] | **string**<br>Пользовательские гранты (GRANT <роль> TO <пользователь>), роль должна быть другим пользователем. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


## RevokePermission {#RevokePermission}

Отзывает разрешение у указанного пользователя PostgreSQL.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). false Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, у которого следует отозвать разрешение. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List). false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
database_name | **string**<br>Обязательное поле. Имя базы данных, к которой пользователь должен потерять доступ. false Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User5)>**<br>в случае успешного выполнения операции. 


### RevokeUserPermissionMetadata {#RevokeUserPermissionMetadata}

Поле | Описание
--- | ---
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. 
user_name | **string**<br>Имя пользователя, чье разрешение отзывается. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя PostgreSQL. 
cluster_id | **string**<br>Идентификатор кластера PostgreSQL, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission5)**<br>Набор разрешений, предоставленных пользователю. 
conn_limit | **int64**<br>Количество доступных пользователю подключений к базе данных. 
settings | **[UserSettings](#UserSettings4)**<br>Настройки PostgreSQL для этого пользователя 
login | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>Пользователь может войти (по умолчанию True). 
grants[] | **string**<br>Пользовательские гранты (GRANT <роль> TO <пользователь>), роль должна быть другим пользователем. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


