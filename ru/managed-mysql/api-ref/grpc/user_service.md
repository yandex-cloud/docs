---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответсвует заголовку","Другое"]}
---


# UserService

A set of methods for managing MySQL users.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified MySQL user. |
| [List](#List) | Retrieves a list of MySQL users in the specified cluster. |
| [Create](#Create) | Creates a MySQL user in the specified cluster. |
| [Update](#Update) | Modifies the specified MySQL user. |
| [Delete](#Delete) | Deletes the specified MySQL user. |
| [GrantPermission](#GrantPermission) | Grants a permission to the specified MySQL user. |
| [RevokePermission](#RevokePermission) | Revokes a permission from the specified MySQL user. |

## Calls UserService {#calls}

## Get {#Get}

Returns the specified MySQL user. <br>To get the list of available MySQL users, make a [List](#List) request.

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MySQL cluster. The maximum string length in characters is 50.
user_name | **string**<br>Required. Required. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the MySQL user. 
cluster_id | **string**<br>ID of the MySQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the SHOW MASTER STATUS, SHOW SLAVE STATUS, and SHOW BINARY LOGS statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS, and SHOW BINLOG EVENTS statements.</li><li>`PROCESS`: Enables display of information about the threads executing within the server (that is, information about the statements being executed by sessions). The privilege enables use of SHOW PROCESSLIST or mysqladmin processlist to see threads belonging to other accounts; you can always see your own threads. The PROCESS privilege also enables use of SHOW ENGINE.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines (stored procedures and functions).</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using LOCK TABLES statement for tables available with SELECT privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li><ul/>


### ConnectionLimits {#ConnectionLimits}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


## List {#List}

Retrieves a list of MySQL users in the specified cluster.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list MySQL users in. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.next_page_token](#ListUsersResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListUsersResponse.next_page_token](#ListUsersResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListUsersResponse {#ListUsersResponse}

Field | Description
--- | ---
users[] | **[User](#User1)**<br>Requested list of MySQL users. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListUsersRequest.page_size](#ListUsersRequest), use the `next_page_token` as the value for the [ListUsersRequest.page_token](#ListUsersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### User {#User1}

Field | Description
--- | ---
name | **string**<br>Name of the MySQL user. 
cluster_id | **string**<br>ID of the MySQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission1)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the SHOW MASTER STATUS, SHOW SLAVE STATUS, and SHOW BINARY LOGS statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS, and SHOW BINLOG EVENTS statements.</li><li>`PROCESS`: Enables display of information about the threads executing within the server (that is, information about the statements being executed by sessions). The privilege enables use of SHOW PROCESSLIST or mysqladmin processlist to see threads belonging to other accounts; you can always see your own threads. The PROCESS privilege also enables use of SHOW ENGINE.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits1)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission1}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines (stored procedures and functions).</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using LOCK TABLES statement for tables available with SELECT privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li><ul/>


### ConnectionLimits {#ConnectionLimits1}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


## Create {#Create}

Creates a MySQL user in the specified cluster.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MySQL cluster to create a user for. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_spec | **[UserSpec](#UserSpec)**<br>Required. Properties of the user to be created. 


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the MySQL user. The maximum string length in characters is 32. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the MySQL user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission2)**<br>Set of permissions to grant to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the SHOW MASTER STATUS, SHOW SLAVE STATUS, and SHOW BINARY LOGS statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS, and SHOW BINLOG EVENTS statements.</li><li>`PROCESS`: Enables display of information about the threads executing within the server (that is, information about the statements being executed by sessions). The privilege enables use of SHOW PROCESSLIST or mysqladmin processlist to see threads belonging to other accounts; you can always see your own threads. The PROCESS privilege also enables use of SHOW ENGINE.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits2)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission2}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines (stored procedures and functions).</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using LOCK TABLES statement for tables available with SELECT privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li><ul/>


### ConnectionLimits {#ConnectionLimits2}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


### Operation {#Operation}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateUserMetadata](#CreateUserMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User2)>**<br>if operation finished successfully. 


### CreateUserMetadata {#CreateUserMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MySQL cluster the user is being created for. 
user_name | **string**<br>Name of the user that is being created. 


### User {#User2}

Field | Description
--- | ---
name | **string**<br>Name of the MySQL user. 
cluster_id | **string**<br>ID of the MySQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission3)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the SHOW MASTER STATUS, SHOW SLAVE STATUS, and SHOW BINARY LOGS statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS, and SHOW BINLOG EVENTS statements.</li><li>`PROCESS`: Enables display of information about the threads executing within the server (that is, information about the statements being executed by sessions). The privilege enables use of SHOW PROCESSLIST or mysqladmin processlist to see threads belonging to other accounts; you can always see your own threads. The PROCESS privilege also enables use of SHOW ENGINE.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits3)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission3}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines (stored procedures and functions).</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using LOCK TABLES statement for tables available with SELECT privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li><ul/>


### ConnectionLimits {#ConnectionLimits3}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


## Update {#Update}

Modifies the specified MySQL user.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MySQL cluster the user belongs to. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to be updated. To get the name of the user use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the MySQL user should be updated. 
password | **string**<br>New password for the user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission4)**<br>New set of permissions for the user. 
global_permissions[] | enum **GlobalPermission**<br>New set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the SHOW MASTER STATUS, SHOW SLAVE STATUS, and SHOW BINARY LOGS statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS, and SHOW BINLOG EVENTS statements.</li><li>`PROCESS`: Enables display of information about the threads executing within the server (that is, information about the statements being executed by sessions). The privilege enables use of SHOW PROCESSLIST or mysqladmin processlist to see threads belonging to other accounts; you can always see your own threads. The PROCESS privilege also enables use of SHOW ENGINE.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits4)**<br>Set of changed user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>New user authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission4}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines (stored procedures and functions).</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using LOCK TABLES statement for tables available with SELECT privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li><ul/>


### ConnectionLimits {#ConnectionLimits4}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


### Operation {#Operation1}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateUserMetadata](#UpdateUserMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User3)>**<br>if operation finished successfully. 


### UpdateUserMetadata {#UpdateUserMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MySQL cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being updated. 


### User {#User3}

Field | Description
--- | ---
name | **string**<br>Name of the MySQL user. 
cluster_id | **string**<br>ID of the MySQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission5)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the SHOW MASTER STATUS, SHOW SLAVE STATUS, and SHOW BINARY LOGS statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS, and SHOW BINLOG EVENTS statements.</li><li>`PROCESS`: Enables display of information about the threads executing within the server (that is, information about the statements being executed by sessions). The privilege enables use of SHOW PROCESSLIST or mysqladmin processlist to see threads belonging to other accounts; you can always see your own threads. The PROCESS privilege also enables use of SHOW ENGINE.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits5)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission5}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines (stored procedures and functions).</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using LOCK TABLES statement for tables available with SELECT privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li><ul/>


### ConnectionLimits {#ConnectionLimits5}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


## Delete {#Delete}

Deletes the specified MySQL user.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MySQL cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to delete. To get the name of the user, use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


### Operation {#Operation2}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteUserMetadata](#DeleteUserMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>if operation finished successfully. 


### DeleteUserMetadata {#DeleteUserMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MySQL cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being deleted. 


## GrantPermission {#GrantPermission}

Grants a permission to the specified MySQL user.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MySQL cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to grant the permission to. To get the name of the user, use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission6)**<br>Required. Permission that should be granted to the specified user. 


### Permission {#Permission6}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines (stored procedures and functions).</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using LOCK TABLES statement for tables available with SELECT privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li><ul/>


### Operation {#Operation3}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User4)>**<br>if operation finished successfully. 


### GrantUserPermissionMetadata {#GrantUserPermissionMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MySQL cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. 
user_name | **string**<br>Name of the user that is being granted a permission. 


### User {#User4}

Field | Description
--- | ---
name | **string**<br>Name of the MySQL user. 
cluster_id | **string**<br>ID of the MySQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission7)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the SHOW MASTER STATUS, SHOW SLAVE STATUS, and SHOW BINARY LOGS statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS, and SHOW BINLOG EVENTS statements.</li><li>`PROCESS`: Enables display of information about the threads executing within the server (that is, information about the statements being executed by sessions). The privilege enables use of SHOW PROCESSLIST or mysqladmin processlist to see threads belonging to other accounts; you can always see your own threads. The PROCESS privilege also enables use of SHOW ENGINE.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits6)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission7}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines (stored procedures and functions).</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using LOCK TABLES statement for tables available with SELECT privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li><ul/>


### ConnectionLimits {#ConnectionLimits6}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


## RevokePermission {#RevokePermission}

Revokes a permission from the specified MySQL user.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the MySQL cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to revoke a permission from. To get the name of the user, use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission8)**<br>Required. Permission that should be revoked from the specified user. 


### Permission {#Permission8}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines (stored procedures and functions).</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using LOCK TABLES statement for tables available with SELECT privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li><ul/>


### Operation {#Operation4}

Field | Description
--- | ---
id | **string**<br>ID of the operation. 
description | **string**<br>Description of the operation. 0-256 characters long. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Creation timestamp. 
created_by | **string**<br>ID of the user or service account who initiated the operation. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>The time when the Operation resource was last modified. 
done | **bool**<br>If the value is `false`, it means the operation is still in progress. If `true`, the operation is completed, and either `error` or `response` is available. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)>**<br>Service-specific metadata associated with the operation. It typically contains the ID of the target resource that the operation is performed on. Any method that returns a long-running operation should document the metadata type, if any. 
result | **oneof:** `error` or `response`<br>The operation result. If `done == false` and there was no failure detected, neither `error` nor `response` is set. If `done == false` and there was a failure detected, `error` is set. If `done == true`, exactly one of `error` or `response` is set.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>The error result of the operation in case of failure or cancellation. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](#User5)>**<br>if operation finished successfully. 


### RevokeUserPermissionMetadata {#RevokeUserPermissionMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the MySQL cluster the user belongs to. 
user_name | **string**<br>Name of the user whose permission is being revoked. 


### User {#User5}

Field | Description
--- | ---
name | **string**<br>Name of the MySQL user. 
cluster_id | **string**<br>ID of the MySQL cluster the user belongs to. 
permissions[] | **[Permission](#Permission9)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the SHOW MASTER STATUS, SHOW SLAVE STATUS, and SHOW BINARY LOGS statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the SHOW SLAVE HOSTS, SHOW RELAYLOG EVENTS, and SHOW BINLOG EVENTS statements.</li><li>`PROCESS`: Enables display of information about the threads executing within the server (that is, information about the statements being executed by sessions). The privilege enables use of SHOW PROCESSLIST or mysqladmin processlist to see threads belonging to other accounts; you can always see your own threads. The PROCESS privilege also enables use of SHOW ENGINE.</li><ul/>
connection_limits | **[ConnectionLimits](#ConnectionLimits7)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li><ul/>


### Permission {#Permission9}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines (stored procedures and functions).</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using LOCK TABLES statement for tables available with SELECT privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some SELECT statements can be allowed without the SELECT privilege. All statements that read column values require the SELECT privilege. See details in [MySQL documentation](https://dev.mysql.com/doc/refman/5.7/en/privileges-provided.html#priv_select).</li><li>`SHOW_VIEW`: Using the SHOW CREATE VIEW statement. Also needed for views used with EXPLAIN.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li><ul/>


### ConnectionLimits {#ConnectionLimits7}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


