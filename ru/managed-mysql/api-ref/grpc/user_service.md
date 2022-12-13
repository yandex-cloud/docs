---
editable: false
sourcePath: en/_api-ref-grpc/managed-mysql/api-ref/grpc/user_service.md
---

# Managed Service for MySQL API, gRPC: UserService

A set of methods for managing MySQL users. 

See [the documentation](/docs/managed-mysql/operations/cluster-users) for details.

| Call | Description |
| --- | --- |
| [Get](#Get) | Retrieves information about the specified user. |
| [List](#List) | Retrieves the list of users in a cluster. |
| [Create](#Create) | Creates a user in a cluster. |
| [Update](#Update) | Updates a user in a cluster. |
| [Delete](#Delete) | Deletes a user in a cluster. |
| [GrantPermission](#GrantPermission) | Grants permission to access a database to a user in a cluster. |
| [RevokePermission](#RevokePermission) | Revokes permission to access a database from a user in a cluster. |

## Calls UserService {#calls}

## Get {#Get}

Retrieves information about the specified user.

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster the user belongs to. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to return information about. <br>To get this name, make a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the user. 
cluster_id | **string**<br>ID of the cluster the user belongs to. 
permissions[] | **[Permission](#Permission)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.</li><li>`PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server). <br>The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users. You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.</li></ul>
connection_limits | **[ConnectionLimits](#ConnectionLimits)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li></ul>


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. <br>See [the documentation](/docs/managed-mysql/operations/grant) for details. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines and functions.</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using `LOCK TABLES` statement for tables available with `SELECT` privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some `SELECT` statements can be allowed without the `SELECT` privilege. All statements that read column values require the `SELECT` privilege. <br>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select) for details.</li><li>`SHOW_VIEW`: Using the `SHOW CREATE VIEW` statement. Also needed for views used with `EXPLAIN`.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li></ul>


### ConnectionLimits {#ConnectionLimits}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


## List {#List}

Retrieves the list of users in a cluster.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list the users in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the API returns a [ListUsersResponse.next_page_token](#ListUsersResponse) that can be used to get the next page of results in the subsequent [UserService.List](#List) requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token that can be used to iterate through multiple pages of results. <br>To get the next page of results, set `page_token` to the [ListUsersResponse.next_page_token](#ListUsersResponse) returned by the previous [UserService.List](#List) request. The maximum string length in characters is 100.


### ListUsersResponse {#ListUsersResponse}

Field | Description
--- | ---
users[] | **[User](#User1)**<br>List of users. 
next_page_token | **string**<br>The token that can be used to get the next page of results. <br>If the number of results is larger than [ListUsersRequest.page_size](#ListUsersRequest), use the `next_page_token` as the value for the [ListUsersRequest.page_token](#ListUsersRequest) in the subsequent [UserService.List](#List) request to iterate through multiple pages of results. <br>Each of the subsequent [UserService.List](#List) requests should use the `next_page_token` value returned by the previous request to continue paging through the results. 


### User {#User1}

Field | Description
--- | ---
name | **string**<br>Name of the user. 
cluster_id | **string**<br>ID of the cluster the user belongs to. 
permissions[] | **[Permission](#Permission1)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.</li><li>`PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server). <br>The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users. You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.</li></ul>
connection_limits | **[ConnectionLimits](#ConnectionLimits1)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li></ul>


### Permission {#Permission1}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. <br>See [the documentation](/docs/managed-mysql/operations/grant) for details. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines and functions.</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using `LOCK TABLES` statement for tables available with `SELECT` privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some `SELECT` statements can be allowed without the `SELECT` privilege. All statements that read column values require the `SELECT` privilege. <br>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select) for details.</li><li>`SHOW_VIEW`: Using the `SHOW CREATE VIEW` statement. Also needed for views used with `EXPLAIN`.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li></ul>


### ConnectionLimits {#ConnectionLimits1}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


## Create {#Create}

Creates a user in a cluster.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to create the user in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_spec | **[UserSpec](#UserSpec)**<br>Required. Configuration of the user. 


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the user. The maximum string length in characters is 32. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission2)**<br>Set of permissions granted to the user to access specific databases. One permission per database. <br>When a permission for a database is set, the user will have access to the database. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.</li><li>`PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server). <br>The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users. You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.</li></ul>
connection_limits | **[ConnectionLimits](#ConnectionLimits2)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li></ul>


### Permission {#Permission2}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. <br>See [the documentation](/docs/managed-mysql/operations/grant) for details. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines and functions.</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using `LOCK TABLES` statement for tables available with `SELECT` privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some `SELECT` statements can be allowed without the `SELECT` privilege. All statements that read column values require the `SELECT` privilege. <br>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select) for details.</li><li>`SHOW_VIEW`: Using the `SHOW CREATE VIEW` statement. Also needed for views used with `EXPLAIN`.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li></ul>


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
cluster_id | **string**<br>ID of the cluster the user is being created in. 
user_name | **string**<br>Name of the user that is being created. 


### User {#User2}

Field | Description
--- | ---
name | **string**<br>Name of the user. 
cluster_id | **string**<br>ID of the cluster the user belongs to. 
permissions[] | **[Permission](#Permission3)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.</li><li>`PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server). <br>The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users. You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.</li></ul>
connection_limits | **[ConnectionLimits](#ConnectionLimits3)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li></ul>


## Update {#Update}

Updates a user in a cluster.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to update the user in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to update. <br>To get this name, make a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which settings of the user should be updated. 
password | **string**<br>New password for the user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission3)**<br>A new set of permissions that should be granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>New set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.</li><li>`PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server). <br>The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users. You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.</li></ul>
connection_limits | **[ConnectionLimits](#ConnectionLimits3)**<br>Set of changed user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>New user authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li></ul>


### Permission {#Permission3}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. <br>See [the documentation](/docs/managed-mysql/operations/grant) for details. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines and functions.</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using `LOCK TABLES` statement for tables available with `SELECT` privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some `SELECT` statements can be allowed without the `SELECT` privilege. All statements that read column values require the `SELECT` privilege. <br>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select) for details.</li><li>`SHOW_VIEW`: Using the `SHOW CREATE VIEW` statement. Also needed for views used with `EXPLAIN`.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li></ul>


### ConnectionLimits {#ConnectionLimits3}

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
cluster_id | **string**<br>ID of the cluster the user is being updated in. 
user_name | **string**<br>Name of the user that is being updated. 


### User {#User3}

Field | Description
--- | ---
name | **string**<br>Name of the user. 
cluster_id | **string**<br>ID of the cluster the user belongs to. 
permissions[] | **[Permission](#Permission4)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.</li><li>`PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server). <br>The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users. You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.</li></ul>
connection_limits | **[ConnectionLimits](#ConnectionLimits4)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li></ul>


## Delete {#Delete}

Deletes a user in a cluster.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to delete the user from. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to delete. <br>To get this name, make a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


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
cluster_id | **string**<br>ID of the cluster the user is being deleted from. 
user_name | **string**<br>Name of the user that is being deleted. 


## GrantPermission {#GrantPermission}

Grants permission to access a database to a user in a cluster.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to grant permission to the user in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to grant permission to. <br>To get this name, make a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission4)**<br>Required. Permission that should be granted to the specified user. 


### Permission {#Permission4}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. <br>See [the documentation](/docs/managed-mysql/operations/grant) for details. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines and functions.</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using `LOCK TABLES` statement for tables available with `SELECT` privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some `SELECT` statements can be allowed without the `SELECT` privilege. All statements that read column values require the `SELECT` privilege. <br>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select) for details.</li><li>`SHOW_VIEW`: Using the `SHOW CREATE VIEW` statement. Also needed for views used with `EXPLAIN`.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li></ul>


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
cluster_id | **string**<br>ID of the cluster the user is being granted a permission in. 
user_name | **string**<br>Name of the user that is being granted a permission. 


### User {#User4}

Field | Description
--- | ---
name | **string**<br>Name of the user. 
cluster_id | **string**<br>ID of the cluster the user belongs to. 
permissions[] | **[Permission](#Permission5)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.</li><li>`PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server). <br>The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users. You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.</li></ul>
connection_limits | **[ConnectionLimits](#ConnectionLimits4)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li></ul>


### ConnectionLimits {#ConnectionLimits4}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


## RevokePermission {#RevokePermission}

Revokes permission to access a database from a user in a cluster.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to revoke permission from the user in. <br>To get this ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to revoke permission from. <br>To get this name, make a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission5)**<br>Required. Permission that should be revoked from the user. 


### Permission {#Permission5}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Privilege**<br>Roles granted to the user within the database. <br>See [the documentation](/docs/managed-mysql/operations/grant) for details. The minimum number of elements is 1.<ul><li>`ALL_PRIVILEGES`: All privileges that can be made available to the user.</li><li>`ALTER`: Altering tables.</li><li>`ALTER_ROUTINE`: Altering stored routines and functions.</li><li>`CREATE`: Creating tables or indexes.</li><li>`CREATE_ROUTINE`: Creating stored routines.</li><li>`CREATE_TEMPORARY_TABLES`: Creating temporary tables.</li><li>`CREATE_VIEW`: Creating views.</li><li>`DELETE`: Deleting tables.</li><li>`DROP`: Removing tables or views.</li><li>`EVENT`: Creating, altering, dropping, or displaying events for the Event Scheduler.</li><li>`EXECUTE`: Executing stored routines.</li><li>`INDEX`: Creating and removing indexes.</li><li>`INSERT`: Inserting rows into the database.</li><li>`LOCK_TABLES`: Using `LOCK TABLES` statement for tables available with `SELECT` privilege.</li><li>`SELECT`: Selecting rows from tables. <br>Some `SELECT` statements can be allowed without the `SELECT` privilege. All statements that read column values require the `SELECT` privilege. <br>See [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/privileges-provided.html#priv_select) for details.</li><li>`SHOW_VIEW`: Using the `SHOW CREATE VIEW` statement. Also needed for views used with `EXPLAIN`.</li><li>`TRIGGER`: Creating, removing, executing, or displaying triggers for a table.</li><li>`UPDATE`: Updating rows in the database.</li><li>`REFERENCES`: Creation of a foreign key constraint for the parent table.</li></ul>


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
cluster_id | **string**<br>ID of the cluster the user is being revoked a permission in. 
user_name | **string**<br>Name of the user whose permission is being revoked. 


### User {#User5}

Field | Description
--- | ---
name | **string**<br>Name of the user. 
cluster_id | **string**<br>ID of the cluster the user belongs to. 
permissions[] | **[Permission](#Permission6)**<br>Set of permissions granted to the user. 
global_permissions[] | enum **GlobalPermission**<br>Set of global permissions to grant to the user. <ul><li>`REPLICATION_CLIENT`: Enables use of the `SHOW MASTER STATUS`, `SHOW SLAVE STATUS`, and `SHOW BINARY LOGS` statements.</li><li>`REPLICATION_SLAVE`: Enables the account to request updates that have been made to databases on the master server, using the `SHOW SLAVE HOSTS`, `SHOW RELAYLOG EVENTS` and `SHOW BINLOG EVENTS` statements.</li><li>`PROCESS`: Enables display of information about the the statements currently being performed by sessions (the set of threads executing within the server). <br>The privilege enables use of `SHOW PROCESSLIST` or `mysqladmin` processlist to see threads belonging to other users. You can always see your own threads. The `PROCESS` privilege also enables use of `SHOW ENGINE`.</li></ul>
connection_limits | **[ConnectionLimits](#ConnectionLimits5)**<br>Set of user connection limits. 
authentication_plugin | enum **AuthPlugin**<br>User authentication plugin. <ul><li>`MYSQL_NATIVE_PASSWORD`: Use [Native Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/native-pluggable-authentication.html).</li><li>`CACHING_SHA2_PASSWORD`: Use [Caching SHA-2 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).</li><li>`SHA256_PASSWORD`: Use [SHA-256 Pluggable Authentication](https://dev.mysql.com/doc/refman/8.0/en/sha256-pluggable-authentication.html).</li></ul>


### ConnectionLimits {#ConnectionLimits5}

Field | Description
--- | ---
max_questions_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user questions per hour. The minimum value is 0.
max_updates_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of user updates per hour. The minimum value is 0.
max_connections_per_hour | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum permitted number of simultaneous client connections per hour. The minimum value is 0.
max_user_connections | **[google.protobuf.Int64Value](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/int64-value)**<br>The maximum number of simultaneous connections permitted to any given MySQL user account. The minimum value is 0.


