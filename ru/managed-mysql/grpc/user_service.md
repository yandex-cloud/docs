---
editable: false
---

# UserService

Набор методов для управления пользователями MySQL.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанного пользователя MySQL. |
| [List](#List) | Получает список пользователей MySQL в указанном кластере. |
| [Create](#Create) | Создает пользователя MySQL в указанном кластере. |
| [Update](#Update) | Изменяет указанного пользователя MySQL. |
| [Delete](#Delete) | Удаляет указанного пользователя MySQL. |
| [GrantPermission](#GrantPermission) | Предоставляет разрешение указанному пользователю MySQL. |
| [RevokePermission](#RevokePermission) | Отзывает разрешение у указанного пользователя MySQL. |

## Вызовы UserService {#calls}

## Get {#Get}

Возвращает указанного пользователя MySQL. <br>Чтобы получить список доступных пользователей MySQL, выполните запрос [List](#List).

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MySQL. Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Обязательное поле. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя MySQL. 
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission)**<br>Набор разрешений, предоставленных пользователю. 
global_permissions[] | enum **GlobalPermission**<br>Набор глобальных разрешений, которые следует предоставить пользователю. <ul><li>`REPLICATION_CLIENT`: Разрешает использование SHOW MASTER STATUS, SHOW SLAVE STATUS, и SHOW BINARY LOGS.</li><li>`REPLICATION_SLAVE`: Разрешает использование SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS и SHOW BINLOG EVENTS.</li><li>`PROCESS`: Разрешает использование SHOW ENGINE INNODB STATUS.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits)**<br>Набор ограничений на коннекты пользователя. 
authentication_plugin | enum **AuthPlugin**<br>Аутентификационный плагин пользователя. <ul><li>`MYSQL_NATIVE_PASSWORD`: Использует [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Использует [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Использует [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 
roles[] | enum **Privilege**<br>Роли, предоставленные пользователю в базе данных. Минимальное количество элементов — 1.<ul><li>`ALL_PRIVILEGES`: Все привилегии, которые могут быть предоставлены пользователю.</li><li>`ALTER`: Изменение таблиц.</li><li>`ALTER_ROUTINE`: Изменение хранимых процедур и функций.</li><li>`CREATE`: Создание таблиц или индексов.</li><li>`CREATE_ROUTINE`: Создание хранимых процедур.</li><li>`CREATE_TEMPORARY_TABLES`: Создание временных таблиц.</li><li>`CREATE_VIEW`: Создание представлений.</li><li>`DELETE`: Удаление таблиц.</li><li>`DROP`: Удаление таблиц или представлений.</li><li>`EVENT`: Создание, изменение, удаление или отображение событий для планировщика событий.</li><li>`EXECUTE`: Выполнение хранимых процедур.</li><li>`INDEX`: Создание и удаление индексов.</li><li>`INSERT`: Вставка строк в базу данных.</li><li>`LOCK_TABLES`: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li><li>`SELECT`: Получение строк из таблиц. <br>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в [документации MySQL](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li><li>`TRIGGER`: Создание, удаление, выполнение или отображение триггеров для таблицы.</li><li>`UPDATE`: Обновление строк в базе данных.</li><li>`REFERENCES`: Создание внешних ключей для таблиц.</li><ul/>


### ConnectionLimits {#ConnectionLimits}

Поле | Описание
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число вопросов в час. Минимальная значение — 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число апдейтов в час. Минимальная значение — 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов в час. Минимальная значение — 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов. Минимальная значение — 0.


## List {#List}

Получает список пользователей MySQL в указанном кластере.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера для вывода списка пользователей MySQL. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListUsersResponse.next_page_token](#ListUsersResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListUsersResponse.next_page_token](#ListUsersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListUsersResponse {#ListUsersResponse}

Поле | Описание
--- | ---
users[] | **[User](#User1)**<br>Запрошенный список пользователей MySQL. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListUsersRequest.page_size](#ListUsersRequest), используйте `next_page_token` в качестве значения параметра [ListUsersRequest.page_token](#ListUsersRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### User {#User1}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя MySQL. 
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission1)**<br>Набор разрешений, предоставленных пользователю. 
global_permissions[] | enum **GlobalPermission**<br>Набор глобальных разрешений, которые следует предоставить пользователю. <ul><li>`REPLICATION_CLIENT`: Разрешает использование SHOW MASTER STATUS, SHOW SLAVE STATUS, и SHOW BINARY LOGS.</li><li>`REPLICATION_SLAVE`: Разрешает использование SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS и SHOW BINLOG EVENTS.</li><li>`PROCESS`: Разрешает использование SHOW ENGINE INNODB STATUS.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits1)**<br>Набор ограничений на коннекты пользователя. 
authentication_plugin | enum **AuthPlugin**<br>Аутентификационный плагин пользователя. <ul><li>`MYSQL_NATIVE_PASSWORD`: Использует [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Использует [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Использует [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission1}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 
roles[] | enum **Privilege**<br>Роли, предоставленные пользователю в базе данных. Минимальное количество элементов — 1.<ul><li>`ALL_PRIVILEGES`: Все привилегии, которые могут быть предоставлены пользователю.</li><li>`ALTER`: Изменение таблиц.</li><li>`ALTER_ROUTINE`: Изменение хранимых процедур и функций.</li><li>`CREATE`: Создание таблиц или индексов.</li><li>`CREATE_ROUTINE`: Создание хранимых процедур.</li><li>`CREATE_TEMPORARY_TABLES`: Создание временных таблиц.</li><li>`CREATE_VIEW`: Создание представлений.</li><li>`DELETE`: Удаление таблиц.</li><li>`DROP`: Удаление таблиц или представлений.</li><li>`EVENT`: Создание, изменение, удаление или отображение событий для планировщика событий.</li><li>`EXECUTE`: Выполнение хранимых процедур.</li><li>`INDEX`: Создание и удаление индексов.</li><li>`INSERT`: Вставка строк в базу данных.</li><li>`LOCK_TABLES`: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li><li>`SELECT`: Получение строк из таблиц. <br>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в [документации MySQL](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li><li>`TRIGGER`: Создание, удаление, выполнение или отображение триггеров для таблицы.</li><li>`UPDATE`: Обновление строк в базе данных.</li><li>`REFERENCES`: Создание внешних ключей для таблиц.</li><ul/>


### ConnectionLimits {#ConnectionLimits1}

Поле | Описание
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число вопросов в час. Минимальная значение — 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число апдейтов в час. Минимальная значение — 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов в час. Минимальная значение — 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов. Минимальная значение — 0.


## Create {#Create}

Создает пользователя MySQL в указанном кластере.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MySQL, для которого следует создать пользователя. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_spec | **[UserSpec](#UserSpec)**<br>Обязательное поле. Свойства создаваемого пользователя. 


### UserSpec {#UserSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя пользователя MySQL. Максимальная длина строки в символах — 32. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
password | **string**<br>Обязательное поле. Пароль пользователя MySQL. Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission2)**<br>Набор разрешений, которые следует предоставить пользователю. 
global_permissions[] | enum **GlobalPermission**<br>Набор глобальных разрешений, которые следует предоставить пользователю. <ul><li>`REPLICATION_CLIENT`: Разрешает использование SHOW MASTER STATUS, SHOW SLAVE STATUS, и SHOW BINARY LOGS.</li><li>`REPLICATION_SLAVE`: Разрешает использование SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS и SHOW BINLOG EVENTS.</li><li>`PROCESS`: Разрешает использование SHOW ENGINE INNODB STATUS.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits2)**<br>Набор ограничений на коннекты пользователя. 
authentication_plugin | enum **AuthPlugin**<br>Аутентификационный плагин пользователя. <ul><li>`MYSQL_NATIVE_PASSWORD`: Использует [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Использует [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Использует [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission2}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 
roles[] | enum **Privilege**<br>Роли, предоставленные пользователю в базе данных. Минимальное количество элементов — 1.<ul><li>`ALL_PRIVILEGES`: Все привилегии, которые могут быть предоставлены пользователю.</li><li>`ALTER`: Изменение таблиц.</li><li>`ALTER_ROUTINE`: Изменение хранимых процедур и функций.</li><li>`CREATE`: Создание таблиц или индексов.</li><li>`CREATE_ROUTINE`: Создание хранимых процедур.</li><li>`CREATE_TEMPORARY_TABLES`: Создание временных таблиц.</li><li>`CREATE_VIEW`: Создание представлений.</li><li>`DELETE`: Удаление таблиц.</li><li>`DROP`: Удаление таблиц или представлений.</li><li>`EVENT`: Создание, изменение, удаление или отображение событий для планировщика событий.</li><li>`EXECUTE`: Выполнение хранимых процедур.</li><li>`INDEX`: Создание и удаление индексов.</li><li>`INSERT`: Вставка строк в базу данных.</li><li>`LOCK_TABLES`: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li><li>`SELECT`: Получение строк из таблиц. <br>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в [документации MySQL](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li><li>`TRIGGER`: Создание, удаление, выполнение или отображение триггеров для таблицы.</li><li>`UPDATE`: Обновление строк в базе данных.</li><li>`REFERENCES`: Создание внешних ключей для таблиц.</li><ul/>


### ConnectionLimits {#ConnectionLimits2}

Поле | Описание
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число вопросов в час. Минимальная значение — 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число апдейтов в час. Минимальная значение — 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов в час. Минимальная значение — 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов. Минимальная значение — 0.


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
cluster_id | **string**<br>Идентификатор кластера MySQL, в котором создается пользователь. 
user_name | **string**<br>Имя создаваемого пользователя. 


### User {#User2}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя MySQL. 
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission3)**<br>Набор разрешений, предоставленных пользователю. 
global_permissions[] | enum **GlobalPermission**<br>Набор глобальных разрешений, которые следует предоставить пользователю. <ul><li>`REPLICATION_CLIENT`: Разрешает использование SHOW MASTER STATUS, SHOW SLAVE STATUS, и SHOW BINARY LOGS.</li><li>`REPLICATION_SLAVE`: Разрешает использование SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS и SHOW BINLOG EVENTS.</li><li>`PROCESS`: Разрешает использование SHOW ENGINE INNODB STATUS.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits3)**<br>Набор ограничений на коннекты пользователя. 
authentication_plugin | enum **AuthPlugin**<br>Аутентификационный плагин пользователя. <ul><li>`MYSQL_NATIVE_PASSWORD`: Использует [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Использует [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Использует [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission3}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 
roles[] | enum **Privilege**<br>Роли, предоставленные пользователю в базе данных. Минимальное количество элементов — 1.<ul><li>`ALL_PRIVILEGES`: Все привилегии, которые могут быть предоставлены пользователю.</li><li>`ALTER`: Изменение таблиц.</li><li>`ALTER_ROUTINE`: Изменение хранимых процедур и функций.</li><li>`CREATE`: Создание таблиц или индексов.</li><li>`CREATE_ROUTINE`: Создание хранимых процедур.</li><li>`CREATE_TEMPORARY_TABLES`: Создание временных таблиц.</li><li>`CREATE_VIEW`: Создание представлений.</li><li>`DELETE`: Удаление таблиц.</li><li>`DROP`: Удаление таблиц или представлений.</li><li>`EVENT`: Создание, изменение, удаление или отображение событий для планировщика событий.</li><li>`EXECUTE`: Выполнение хранимых процедур.</li><li>`INDEX`: Создание и удаление индексов.</li><li>`INSERT`: Вставка строк в базу данных.</li><li>`LOCK_TABLES`: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li><li>`SELECT`: Получение строк из таблиц. <br>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в [документации MySQL](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li><li>`TRIGGER`: Создание, удаление, выполнение или отображение триггеров для таблицы.</li><li>`UPDATE`: Обновление строк в базе данных.</li><li>`REFERENCES`: Создание внешних ключей для таблиц.</li><ul/>


### ConnectionLimits {#ConnectionLimits3}

Поле | Описание
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число вопросов в час. Минимальная значение — 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число апдейтов в час. Минимальная значение — 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов в час. Минимальная значение — 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов. Минимальная значение — 0.


## Update {#Update}

Изменяет указанного пользователя MySQL.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MySQL, которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, которого следует изменить. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, которая указывает, какие атрибуты пользователя MySQL должны быть обновлены. 
password | **string**<br>Новый пароль для пользователя. Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission4)**<br>Новый набор разрешений для пользователя. 
global_permissions[] | enum **GlobalPermission**<br>Новый набор глобальных разрешений, которые следует предоставить пользователю. <ul><li>`REPLICATION_CLIENT`: Разрешает использование SHOW MASTER STATUS, SHOW SLAVE STATUS, и SHOW BINARY LOGS.</li><li>`REPLICATION_SLAVE`: Разрешает использование SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS и SHOW BINLOG EVENTS.</li><li>`PROCESS`: Разрешает использование SHOW ENGINE INNODB STATUS.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits4)**<br>Набор изменившихся ограничений на коннекты пользователя. 
authentication_plugin | enum **AuthPlugin**<br>Новый аутентификационный плагин пользователя. <ul><li>`MYSQL_NATIVE_PASSWORD`: Использует [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Использует [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Использует [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission4}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 
roles[] | enum **Privilege**<br>Роли, предоставленные пользователю в базе данных. Минимальное количество элементов — 1.<ul><li>`ALL_PRIVILEGES`: Все привилегии, которые могут быть предоставлены пользователю.</li><li>`ALTER`: Изменение таблиц.</li><li>`ALTER_ROUTINE`: Изменение хранимых процедур и функций.</li><li>`CREATE`: Создание таблиц или индексов.</li><li>`CREATE_ROUTINE`: Создание хранимых процедур.</li><li>`CREATE_TEMPORARY_TABLES`: Создание временных таблиц.</li><li>`CREATE_VIEW`: Создание представлений.</li><li>`DELETE`: Удаление таблиц.</li><li>`DROP`: Удаление таблиц или представлений.</li><li>`EVENT`: Создание, изменение, удаление или отображение событий для планировщика событий.</li><li>`EXECUTE`: Выполнение хранимых процедур.</li><li>`INDEX`: Создание и удаление индексов.</li><li>`INSERT`: Вставка строк в базу данных.</li><li>`LOCK_TABLES`: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li><li>`SELECT`: Получение строк из таблиц. <br>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в [документации MySQL](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li><li>`TRIGGER`: Создание, удаление, выполнение или отображение триггеров для таблицы.</li><li>`UPDATE`: Обновление строк в базе данных.</li><li>`REFERENCES`: Создание внешних ключей для таблиц.</li><ul/>


### ConnectionLimits {#ConnectionLimits4}

Поле | Описание
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число вопросов в час. Минимальная значение — 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число апдейтов в час. Минимальная значение — 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов в час. Минимальная значение — 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов. Минимальная значение — 0.


### Operation {#Operation1}

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
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит пользователь. 
user_name | **string**<br>Имя изменяемого пользователя. 


### User {#User3}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя MySQL. 
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission5)**<br>Набор разрешений, предоставленных пользователю. 
global_permissions[] | enum **GlobalPermission**<br>Набор глобальных разрешений, которые следует предоставить пользователю. <ul><li>`REPLICATION_CLIENT`: Разрешает использование SHOW MASTER STATUS, SHOW SLAVE STATUS, и SHOW BINARY LOGS.</li><li>`REPLICATION_SLAVE`: Разрешает использование SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS и SHOW BINLOG EVENTS.</li><li>`PROCESS`: Разрешает использование SHOW ENGINE INNODB STATUS.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits5)**<br>Набор ограничений на коннекты пользователя. 
authentication_plugin | enum **AuthPlugin**<br>Аутентификационный плагин пользователя. <ul><li>`MYSQL_NATIVE_PASSWORD`: Использует [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Использует [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Использует [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission5}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 
roles[] | enum **Privilege**<br>Роли, предоставленные пользователю в базе данных. Минимальное количество элементов — 1.<ul><li>`ALL_PRIVILEGES`: Все привилегии, которые могут быть предоставлены пользователю.</li><li>`ALTER`: Изменение таблиц.</li><li>`ALTER_ROUTINE`: Изменение хранимых процедур и функций.</li><li>`CREATE`: Создание таблиц или индексов.</li><li>`CREATE_ROUTINE`: Создание хранимых процедур.</li><li>`CREATE_TEMPORARY_TABLES`: Создание временных таблиц.</li><li>`CREATE_VIEW`: Создание представлений.</li><li>`DELETE`: Удаление таблиц.</li><li>`DROP`: Удаление таблиц или представлений.</li><li>`EVENT`: Создание, изменение, удаление или отображение событий для планировщика событий.</li><li>`EXECUTE`: Выполнение хранимых процедур.</li><li>`INDEX`: Создание и удаление индексов.</li><li>`INSERT`: Вставка строк в базу данных.</li><li>`LOCK_TABLES`: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li><li>`SELECT`: Получение строк из таблиц. <br>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в [документации MySQL](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li><li>`TRIGGER`: Создание, удаление, выполнение или отображение триггеров для таблицы.</li><li>`UPDATE`: Обновление строк в базе данных.</li><li>`REFERENCES`: Создание внешних ключей для таблиц.</li><ul/>


### ConnectionLimits {#ConnectionLimits5}

Поле | Описание
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число вопросов в час. Минимальная значение — 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число апдейтов в час. Минимальная значение — 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов в час. Минимальная значение — 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов. Минимальная значение — 0.


## Delete {#Delete}

Удаляет указанного пользователя MySQL.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MySQL, которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя удаляемого пользователя. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### Operation {#Operation2}

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
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит пользователь. 
user_name | **string**<br>Имя удаляемого пользователя. 


## GrantPermission {#GrantPermission}

Предоставляет разрешение указанному пользователю MySQL.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MySQL, которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, которому следует предоставить разрешение. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission6)**<br>Обязательное поле. Разрешение, которое должно быть предоставлено указанному пользователю. 


### Permission {#Permission6}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 
roles[] | enum **Privilege**<br>Роли, предоставленные пользователю в базе данных. Минимальное количество элементов — 1.<ul><li>`ALL_PRIVILEGES`: Все привилегии, которые могут быть предоставлены пользователю.</li><li>`ALTER`: Изменение таблиц.</li><li>`ALTER_ROUTINE`: Изменение хранимых процедур и функций.</li><li>`CREATE`: Создание таблиц или индексов.</li><li>`CREATE_ROUTINE`: Создание хранимых процедур.</li><li>`CREATE_TEMPORARY_TABLES`: Создание временных таблиц.</li><li>`CREATE_VIEW`: Создание представлений.</li><li>`DELETE`: Удаление таблиц.</li><li>`DROP`: Удаление таблиц или представлений.</li><li>`EVENT`: Создание, изменение, удаление или отображение событий для планировщика событий.</li><li>`EXECUTE`: Выполнение хранимых процедур.</li><li>`INDEX`: Создание и удаление индексов.</li><li>`INSERT`: Вставка строк в базу данных.</li><li>`LOCK_TABLES`: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li><li>`SELECT`: Получение строк из таблиц. <br>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в [документации MySQL](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li><li>`TRIGGER`: Создание, удаление, выполнение или отображение триггеров для таблицы.</li><li>`UPDATE`: Обновление строк в базе данных.</li><li>`REFERENCES`: Создание внешних ключей для таблиц.</li><ul/>


### Operation {#Operation3}

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
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). 
user_name | **string**<br>Имя пользователя, которому предоставляется разрешение. 


### User {#User4}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя MySQL. 
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission7)**<br>Набор разрешений, предоставленных пользователю. 
global_permissions[] | enum **GlobalPermission**<br>Набор глобальных разрешений, которые следует предоставить пользователю. <ul><li>`REPLICATION_CLIENT`: Разрешает использование SHOW MASTER STATUS, SHOW SLAVE STATUS, и SHOW BINARY LOGS.</li><li>`REPLICATION_SLAVE`: Разрешает использование SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS и SHOW BINLOG EVENTS.</li><li>`PROCESS`: Разрешает использование SHOW ENGINE INNODB STATUS.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits6)**<br>Набор ограничений на коннекты пользователя. 
authentication_plugin | enum **AuthPlugin**<br>Аутентификационный плагин пользователя. <ul><li>`MYSQL_NATIVE_PASSWORD`: Использует [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Использует [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Использует [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission7}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 
roles[] | enum **Privilege**<br>Роли, предоставленные пользователю в базе данных. Минимальное количество элементов — 1.<ul><li>`ALL_PRIVILEGES`: Все привилегии, которые могут быть предоставлены пользователю.</li><li>`ALTER`: Изменение таблиц.</li><li>`ALTER_ROUTINE`: Изменение хранимых процедур и функций.</li><li>`CREATE`: Создание таблиц или индексов.</li><li>`CREATE_ROUTINE`: Создание хранимых процедур.</li><li>`CREATE_TEMPORARY_TABLES`: Создание временных таблиц.</li><li>`CREATE_VIEW`: Создание представлений.</li><li>`DELETE`: Удаление таблиц.</li><li>`DROP`: Удаление таблиц или представлений.</li><li>`EVENT`: Создание, изменение, удаление или отображение событий для планировщика событий.</li><li>`EXECUTE`: Выполнение хранимых процедур.</li><li>`INDEX`: Создание и удаление индексов.</li><li>`INSERT`: Вставка строк в базу данных.</li><li>`LOCK_TABLES`: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li><li>`SELECT`: Получение строк из таблиц. <br>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в [документации MySQL](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li><li>`TRIGGER`: Создание, удаление, выполнение или отображение триггеров для таблицы.</li><li>`UPDATE`: Обновление строк в базе данных.</li><li>`REFERENCES`: Создание внешних ключей для таблиц.</li><ul/>


### ConnectionLimits {#ConnectionLimits6}

Поле | Описание
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число вопросов в час. Минимальная значение — 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число апдейтов в час. Минимальная значение — 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов в час. Минимальная значение — 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов. Минимальная значение — 0.


## RevokePermission {#RevokePermission}

Отзывает разрешение у указанного пользователя MySQL.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера MySQL, которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, у которого следует отозвать разрешение. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission8)**<br>Обязательное поле. Разрешение, которое должно быть отозвано у указанного пользователя. 


### Permission {#Permission8}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 
roles[] | enum **Privilege**<br>Роли, предоставленные пользователю в базе данных. Минимальное количество элементов — 1.<ul><li>`ALL_PRIVILEGES`: Все привилегии, которые могут быть предоставлены пользователю.</li><li>`ALTER`: Изменение таблиц.</li><li>`ALTER_ROUTINE`: Изменение хранимых процедур и функций.</li><li>`CREATE`: Создание таблиц или индексов.</li><li>`CREATE_ROUTINE`: Создание хранимых процедур.</li><li>`CREATE_TEMPORARY_TABLES`: Создание временных таблиц.</li><li>`CREATE_VIEW`: Создание представлений.</li><li>`DELETE`: Удаление таблиц.</li><li>`DROP`: Удаление таблиц или представлений.</li><li>`EVENT`: Создание, изменение, удаление или отображение событий для планировщика событий.</li><li>`EXECUTE`: Выполнение хранимых процедур.</li><li>`INDEX`: Создание и удаление индексов.</li><li>`INSERT`: Вставка строк в базу данных.</li><li>`LOCK_TABLES`: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li><li>`SELECT`: Получение строк из таблиц. <br>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в [документации MySQL](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li><li>`TRIGGER`: Создание, удаление, выполнение или отображение триггеров для таблицы.</li><li>`UPDATE`: Обновление строк в базе данных.</li><li>`REFERENCES`: Создание внешних ключей для таблиц.</li><ul/>


### Operation {#Operation4}

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
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит пользователь. 
user_name | **string**<br>Имя пользователя, чье разрешение отзывается. 


### User {#User5}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя MySQL. 
cluster_id | **string**<br>Идентификатор кластера MySQL, которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission9)**<br>Набор разрешений, предоставленных пользователю. 
global_permissions[] | enum **GlobalPermission**<br>Набор глобальных разрешений, которые следует предоставить пользователю. <ul><li>`REPLICATION_CLIENT`: Разрешает использование SHOW MASTER STATUS, SHOW SLAVE STATUS, и SHOW BINARY LOGS.</li><li>`REPLICATION_SLAVE`: Разрешает использование SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS и SHOW BINLOG EVENTS.</li><li>`PROCESS`: Разрешает использование SHOW ENGINE INNODB STATUS.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits7)**<br>Набор ограничений на коннекты пользователя. 
authentication_plugin | enum **AuthPlugin**<br>Аутентификационный плагин пользователя. <ul><li>`MYSQL_NATIVE_PASSWORD`: Использует [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Использует [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Использует [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission9}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 
roles[] | enum **Privilege**<br>Роли, предоставленные пользователю в базе данных. Минимальное количество элементов — 1.<ul><li>`ALL_PRIVILEGES`: Все привилегии, которые могут быть предоставлены пользователю.</li><li>`ALTER`: Изменение таблиц.</li><li>`ALTER_ROUTINE`: Изменение хранимых процедур и функций.</li><li>`CREATE`: Создание таблиц или индексов.</li><li>`CREATE_ROUTINE`: Создание хранимых процедур.</li><li>`CREATE_TEMPORARY_TABLES`: Создание временных таблиц.</li><li>`CREATE_VIEW`: Создание представлений.</li><li>`DELETE`: Удаление таблиц.</li><li>`DROP`: Удаление таблиц или представлений.</li><li>`EVENT`: Создание, изменение, удаление или отображение событий для планировщика событий.</li><li>`EXECUTE`: Выполнение хранимых процедур.</li><li>`INDEX`: Создание и удаление индексов.</li><li>`INSERT`: Вставка строк в базу данных.</li><li>`LOCK_TABLES`: Использование инструкции LOCK TABLES для таблиц, доступных с привилегией SELECT.</li><li>`SELECT`: Получение строк из таблиц. <br>Некоторые операторы SELECT могут быть разрешены без привилегии SELECT. Привилегия SELECT необходима для всех операторов, считывающих значения столбцов. Подробнее в [документации MySQL](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Использование инструкции SHOW CREATE VIEW. Также необходимо для представлений, используемых с EXPLAIN.</li><li>`TRIGGER`: Создание, удаление, выполнение или отображение триггеров для таблицы.</li><li>`UPDATE`: Обновление строк в базе данных.</li><li>`REFERENCES`: Создание внешних ключей для таблиц.</li><ul/>


### ConnectionLimits {#ConnectionLimits7}

Поле | Описание
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число вопросов в час. Минимальная значение — 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число апдейтов в час. Минимальная значение — 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов в час. Минимальная значение — 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимально допустимое число коннектов. Минимальная значение — 0.


