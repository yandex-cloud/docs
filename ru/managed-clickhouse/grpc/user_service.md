---
editable: false
---

# UserService

Набор методов для управления ресурсами User для ClickHouse.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс User для ClickHouse. |
| [List](#List) | Получает список ресурсов User для указанного кластера ClickHouse. |
| [Create](#Create) | Создает пользователя ClickHouse в указанном кластере. |
| [Update](#Update) | Изменяет указанного пользователя ClickHouse. |
| [Delete](#Delete) | Удаляет указанного пользователя ClickHouse. |
| [GrantPermission](#GrantPermission) | Предоставляет разрешение указанному пользователю ClickHouse. |
| [RevokePermission](#RevokePermission) | Отзывает разрешение у указанного пользователя ClickHouse. |

## Вызовы UserService {#calls}

## Get {#Get}

Возвращает указанный ресурс User для ClickHouse. <br>Чтобы получить список доступных ресурсов User для ClickHouse, отправьте запрос [List](#List).

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List).  Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя запрашиваемого ресурса User для ClickHouse. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя базы данных ClickHouse. 
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission)**<br>Набор разрешений, предоставленных пользователю. 
settings | **[UserSettings](#UserSettings)**<br> 


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 


### UserSettings {#UserSettings}

Поле | Описание
--- | ---
readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_readonly). Допустимые значения — от 0 до 2 включительно.
allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_allow_ddl). 
insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum). Минимальная значение — 0.
insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. </li></ol> Минимальная значение — 1000.
select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-select_sequential_consistency). 
max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries).</li></ol> Минимальная значение — 1000.
fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). 
max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_threads). Значение должно быть больше 0.
max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#max-block-size). Значение должно быть больше 0.
max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_insert_block_size). Значение должно быть больше 0.
max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#settings_max_memory_usage). Минимальная значение — 0.
max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-memory-usage-for-user). Минимальная значение — 0.
max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-read). Минимальная значение — 0.
max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-read). Минимальная значение — 0.
read_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#read-overflow-mode). <ul><ul/>
max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-group-by). Минимальная значение — 0.
group_by_overflow_mode | enum **GroupByOverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#group-by-overflow-mode). <ul><ul/>
max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-sort). Минимальная значение — 0.
max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-sort). Минимальная значение — 0.
sort_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#sort-overflow-mode). <ul><ul/>
max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-rows). Минимальная значение — 0.
max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-bytes). Минимальная значение — 0.
result_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#result-overflow-mode). <ul><ul/>
max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-in-distinct). Минимальная значение — 0.
max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-in-distinct). Минимальная значение — 0.
distinct_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#distinct-overflow-mode). <ul><ul/>
max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-transfer). Минимальная значение — 0.
max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-transfer). Минимальная значение — 0.
transfer_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#transfer-overflow-mode). <ul><ul/>
max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное время выполнения запроса в миллисекундах. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-execution-time). Минимальная значение — 0.
timeout_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#timeout-overflow-mode). <ul><ul/>
max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество столбцов, которые можно прочитать из таблицы в одном запросе. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-columns-to-read). Минимальная значение — 0.
max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, включая постоянные столбцы. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-columns). Минимальная значение — 0.
max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, за исключением постоянных столбцов. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-non-const-columns). Минимальная значение — 0.
max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_query_size).</li></ol> Значение должно быть больше 0.
max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. </li></ol> Значение должно быть больше 0.
max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-ast-elements).</li></ol> Значение должно быть больше 0.
max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер синтаксического дерева запроса в количестве узлов после раскрытия псевдонимов и звездочки. Значение по умолчанию: 500000. Значение должно быть больше 0.


## List {#List}

Получает список ресурсов User для указанного кластера ClickHouse.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера для вывода списка пользователей ClickHouse. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List).  Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListUsersResponse.next_page_token](#ListUsersResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListUsersResponse.next_page_token](#ListUsersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListUsersResponse {#ListUsersResponse}

Поле | Описание
--- | ---
users[] | **[User](#User1)**<br>Список ресурсов User для ClickHouse. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListUsersRequest.page_size](#ListUsersRequest1), используйте `next_page_token` в качестве значения параметра [ListUsersRequest.page_token](#ListUsersRequest1) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя базы данных ClickHouse. 
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission1)**<br>Набор разрешений, предоставленных пользователю. 
settings | **[UserSettings](#UserSettings1)**<br> 


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 


### UserSettings {#UserSettings}

Поле | Описание
--- | ---
readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_readonly). Допустимые значения — от 0 до 2 включительно.
allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_allow_ddl). 
insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum). Минимальная значение — 0.
insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. </li></ol> Минимальная значение — 1000.
select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-select_sequential_consistency). 
max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries).</li></ol> Минимальная значение — 1000.
fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). 
max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_threads). Значение должно быть больше 0.
max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#max-block-size). Значение должно быть больше 0.
max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_insert_block_size). Значение должно быть больше 0.
max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#settings_max_memory_usage). Минимальная значение — 0.
max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-memory-usage-for-user). Минимальная значение — 0.
max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-read). Минимальная значение — 0.
max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-read). Минимальная значение — 0.
read_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#read-overflow-mode). <ul><ul/>
max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-group-by). Минимальная значение — 0.
group_by_overflow_mode | enum **GroupByOverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#group-by-overflow-mode). <ul><ul/>
max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-sort). Минимальная значение — 0.
max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-sort). Минимальная значение — 0.
sort_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#sort-overflow-mode). <ul><ul/>
max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-rows). Минимальная значение — 0.
max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-bytes). Минимальная значение — 0.
result_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#result-overflow-mode). <ul><ul/>
max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-in-distinct). Минимальная значение — 0.
max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-in-distinct). Минимальная значение — 0.
distinct_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#distinct-overflow-mode). <ul><ul/>
max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-transfer). Минимальная значение — 0.
max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-transfer). Минимальная значение — 0.
transfer_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#transfer-overflow-mode). <ul><ul/>
max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное время выполнения запроса в миллисекундах. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-execution-time). Минимальная значение — 0.
timeout_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#timeout-overflow-mode). <ul><ul/>
max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество столбцов, которые можно прочитать из таблицы в одном запросе. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-columns-to-read). Минимальная значение — 0.
max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, включая постоянные столбцы. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-columns). Минимальная значение — 0.
max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, за исключением постоянных столбцов. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-non-const-columns). Минимальная значение — 0.
max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_query_size).</li></ol> Значение должно быть больше 0.
max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. </li></ol> Значение должно быть больше 0.
max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-ast-elements).</li></ol> Значение должно быть больше 0.
max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер синтаксического дерева запроса в количестве узлов после раскрытия псевдонимов и звездочки. Значение по умолчанию: 500000. Значение должно быть больше 0.


## Create {#Create}

Создает пользователя ClickHouse в указанном кластере.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, в котором следует создать пользователя. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List).  Максимальная длина строки в символах — 50.
user_spec | **[UserSpec](#UserSpec)**<br>Обязательное поле. Свойства создаваемого пользователя. 


### UserSpec {#UserSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя пользователя базы данных ClickHouse.  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
password | **string**<br>Обязательное поле. Пароль пользователя ClickHouse.  Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission2)**<br>Набор разрешений, которые следует предоставить пользователю. 
settings | **[UserSettings](#UserSettings2)**<br> 


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 


### UserSettings {#UserSettings}

Поле | Описание
--- | ---
readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_readonly). Допустимые значения — от 0 до 2 включительно.
allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_allow_ddl). 
insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum). Минимальная значение — 0.
insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. </li></ol> Минимальная значение — 1000.
select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-select_sequential_consistency). 
max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries).</li></ol> Минимальная значение — 1000.
fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). 
max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_threads). Значение должно быть больше 0.
max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#max-block-size). Значение должно быть больше 0.
max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_insert_block_size). Значение должно быть больше 0.
max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#settings_max_memory_usage). Минимальная значение — 0.
max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-memory-usage-for-user). Минимальная значение — 0.
max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-read). Минимальная значение — 0.
max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-read). Минимальная значение — 0.
read_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#read-overflow-mode). <ul><ul/>
max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-group-by). Минимальная значение — 0.
group_by_overflow_mode | enum **GroupByOverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#group-by-overflow-mode). <ul><ul/>
max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-sort). Минимальная значение — 0.
max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-sort). Минимальная значение — 0.
sort_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#sort-overflow-mode). <ul><ul/>
max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-rows). Минимальная значение — 0.
max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-bytes). Минимальная значение — 0.
result_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#result-overflow-mode). <ul><ul/>
max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-in-distinct). Минимальная значение — 0.
max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-in-distinct). Минимальная значение — 0.
distinct_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#distinct-overflow-mode). <ul><ul/>
max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-transfer). Минимальная значение — 0.
max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-transfer). Минимальная значение — 0.
transfer_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#transfer-overflow-mode). <ul><ul/>
max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное время выполнения запроса в миллисекундах. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-execution-time). Минимальная значение — 0.
timeout_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#timeout-overflow-mode). <ul><ul/>
max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество столбцов, которые можно прочитать из таблицы в одном запросе. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-columns-to-read). Минимальная значение — 0.
max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, включая постоянные столбцы. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-columns). Минимальная значение — 0.
max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, за исключением постоянных столбцов. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-non-const-columns). Минимальная значение — 0.
max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_query_size).</li></ol> Значение должно быть больше 0.
max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. </li></ol> Значение должно быть больше 0.
max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-ast-elements).</li></ol> Значение должно быть больше 0.
max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер синтаксического дерева запроса в количестве узлов после раскрытия псевдонимов и звездочки. Значение по умолчанию: 500000. Значение должно быть больше 0.


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
cluster_id | **string**<br>Идентификатор кластера ClickHouse, в котором создается пользователь. 
user_name | **string**<br>Имя создаваемого пользователя. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя базы данных ClickHouse. 
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission3)**<br>Набор разрешений, предоставленных пользователю. 
settings | **[UserSettings](#UserSettings3)**<br> 


## Update {#Update}

Изменяет указанного пользователя ClickHouse.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List).  Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, которого следует изменить. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, которая указывает, какие атрибуты пользователя ClickHouse должны быть изменены. 
password | **string**<br>Новый пароль для пользователя. Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission3)**<br>Новый набор разрешений для пользователя. 
settings | **[UserSettings](#UserSettings3)**<br> 


### Permission {#Permission}

Поле | Описание
--- | ---
database_name | **string**<br>Имя базы данных, к которой предоставляет доступ разрешение. 


### UserSettings {#UserSettings}

Поле | Описание
--- | ---
readonly | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_readonly). Допустимые значения — от 0 до 2 включительно.
allow_ddl | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/permissions_for_queries/#settings_allow_ddl). 
insert_quorum | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-insert_quorum). Минимальная значение — 0.
insert_quorum_timeout | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. </li></ol> Минимальная значение — 1000.
select_sequential_consistency | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-select_sequential_consistency). 
max_replica_delay_for_distributed_queries | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_replica_delay_for_distributed_queries).</li></ol> Минимальная значение — 1000.
fallback_to_stale_replicas_for_distributed_queries | **[google.protobuf.BoolValue](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/bool-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-fallback_to_stale_replicas_for_distributed_queries). 
max_threads | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_threads). Значение должно быть больше 0.
max_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#max-block-size). Значение должно быть больше 0.
max_insert_block_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_insert_block_size). Значение должно быть больше 0.
max_memory_usage | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#settings_max_memory_usage). Минимальная значение — 0.
max_memory_usage_for_user | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-memory-usage-for-user). Минимальная значение — 0.
max_rows_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-read). Минимальная значение — 0.
max_bytes_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-read). Минимальная значение — 0.
read_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#read-overflow-mode). <ul><ul/>
max_rows_to_group_by | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-group-by). Минимальная значение — 0.
group_by_overflow_mode | enum **GroupByOverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#group-by-overflow-mode). <ul><ul/>
max_rows_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-sort). Минимальная значение — 0.
max_bytes_to_sort | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-sort). Минимальная значение — 0.
sort_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#sort-overflow-mode). <ul><ul/>
max_result_rows | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-rows). Минимальная значение — 0.
max_result_bytes | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-result-bytes). Минимальная значение — 0.
result_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#result-overflow-mode). <ul><ul/>
max_rows_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-in-distinct). Минимальная значение — 0.
max_bytes_in_distinct | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-in-distinct). Минимальная значение — 0.
distinct_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#distinct-overflow-mode). <ul><ul/>
max_rows_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-rows-to-transfer). Минимальная значение — 0.
max_bytes_to_transfer | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-bytes-to-transfer). Минимальная значение — 0.
transfer_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#transfer-overflow-mode). <ul><ul/>
max_execution_time | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное время выполнения запроса в миллисекундах. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-execution-time). Минимальная значение — 0.
timeout_overflow_mode | enum **OverflowMode**<br>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#timeout-overflow-mode). <ul><ul/>
max_columns_to_read | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество столбцов, которые можно прочитать из таблицы в одном запросе. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-columns-to-read). Минимальная значение — 0.
max_temporary_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, включая постоянные столбцы. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-columns). Минимальная значение — 0.
max_temporary_non_const_columns | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальное количество временных столбцов, которые должны храниться в оперативной памяти одновременно при выполнении запроса, за исключением постоянных столбцов. См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-temporary-non-const-columns). Минимальная значение — 0.
max_query_size | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/settings/#settings-max_query_size).</li></ol> Значение должно быть больше 0.
max_ast_depth | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. </li></ol> Значение должно быть больше 0.
max_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br><ol><li>См. подробное описание в [документации ClickHouse](https://clickhouse.yandex/docs/ru/operations/settings/query_complexity/#max-ast-elements).</li></ol> Значение должно быть больше 0.
max_expanded_ast_elements | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>Максимальный размер синтаксического дерева запроса в количестве узлов после раскрытия псевдонимов и звездочки. Значение по умолчанию: 500000. Значение должно быть больше 0.


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
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит пользователь. 
user_name | **string**<br>Имя изменяемого пользователя. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя базы данных ClickHouse. 
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission4)**<br>Набор разрешений, предоставленных пользователю. 
settings | **[UserSettings](#UserSettings4)**<br> 


## Delete {#Delete}

Удаляет указанного пользователя ClickHouse.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List).  Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя удаляемого пользователя. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


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
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит пользователь. 
user_name | **string**<br>Имя удаляемого пользователя. 


## GrantPermission {#GrantPermission}

Предоставляет разрешение указанному пользователю ClickHouse.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List).  Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, которому следует предоставить разрешение. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission4)**<br>Разрешение, которое должно быть предоставлено указанному пользователю. 


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
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит пользователь. 
user_name | **string**<br>Имя пользователя, которому предоставляется разрешение. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя базы данных ClickHouse. 
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission5)**<br>Набор разрешений, предоставленных пользователю. 
settings | **[UserSettings](#UserSettings4)**<br> 


## RevokePermission {#RevokePermission}

Отзывает разрешение у указанного пользователя ClickHouse.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера ClickHouse, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List).  Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, у которого следует отозвать разрешение. Чтобы получить имя пользователя, используйте запрос [UserService.List](#List).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
database_name | **string**<br>Имя базы данных, к которой пользователь должен потерять доступ. Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.


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
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит пользователь. 
user_name | **string**<br>Имя пользователя, чье разрешение отзывается. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя базы данных ClickHouse. 
cluster_id | **string**<br>Идентификатор кластера ClickHouse, к которому принадлежит пользователь. 
permissions[] | **[Permission](#Permission5)**<br>Набор разрешений, предоставленных пользователю. 
settings | **[UserSettings](#UserSettings4)**<br> 


