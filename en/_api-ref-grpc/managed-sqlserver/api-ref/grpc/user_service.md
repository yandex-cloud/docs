---
editable: false
---

# UserService

A set of methods for managing SQL Server users.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified SQL Server user. |
| [List](#List) | Retrieves a list of SQL Server users in the specified cluster. |
| [Create](#Create) | Creates an SQL Server user in the specified cluster. |
| [Update](#Update) | Modifies the specified SQL Server user. |
| [Delete](#Delete) | Deletes the specified SQL Server user. |
| [GrantPermission](#GrantPermission) | Grants a permission to the specified SQL Server user. |
| [RevokePermission](#RevokePermission) | Revokes a permission from the specified SQL Server user. |

## Calls UserService {#calls}

## Get {#Get}

Returns the specified SQL Server user. <br>To get the list of available SQL Server users, make a [List](#List) request.

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster the user belongs to. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the SQL Server user to return. <br>To get the name of the user use a [DatabaseService.List](./database_service#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the SQL Server user. 
cluster_id | **string**<br>ID of the SQL Server cluster the user belongs to. 
permissions[] | **[Permission](#Permission)**<br>Set of permissions granted to the user. 
server_roles[] | enum **ServerRole**<br>Set of server roles granted to the login. <ul><li>`MDB_MONITOR`: Effectively grants VIEW SERVER STATE to the login. <br>That gives an ability to use various dynamic management views to monitor server state, including Activity Monitor tool that is built-in into SSMS. <br>No intrusive actions are allowed, so this is pretty safe to grant.</li></ul>


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Members of this fixed database role can perform all configuration and maintenance activities on a database and can also drop a database in SQL Server.</li><li>`DB_SECURITYADMIN`: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li><li>`DB_ACCESSADMIN`: Members of this fixed database role can add or remove access to a database for Windows logins, Windows groups, and SQL Server logins.</li><li>`DB_BACKUPOPERATOR`: Members of this fixed database role can back up the database.</li><li>`DB_DDLADMIN`: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li><li>`DB_DATAWRITER`: Members of this fixed database role can add, delete, or change data in all user tables.</li><li>`DB_DATAREADER`: Members of this fixed database role can read all data from all user tables.</li><li>`DB_DENYDATAWRITER`: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li><li>`DB_DENYDATAREADER`: Members of this fixed database role cannot read any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li></ul>


## List {#List}

Retrieves a list of SQL Server users in the specified cluster.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the cluster to list SQL Server users in. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.next_page_token](#ListUsersResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListUsersResponse.next_page_token](#ListUsersResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListUsersResponse {#ListUsersResponse}

Field | Description
--- | ---
users[] | **[User](#User1)**<br>Requested list of SQL Server users. 
next_page_token | **string**<br>Token that allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListUsersRequest.page_size](#ListUsersRequest), use the `next_page_token` as the value for the [ListUsersRequest.page_token](#ListUsersRequest) parameter in the next list request. <br>Each subsequent list request has its own `next_page_token` to continue paging through the results. 


### User {#User1}

Field | Description
--- | ---
name | **string**<br>Name of the SQL Server user. 
cluster_id | **string**<br>ID of the SQL Server cluster the user belongs to. 
permissions[] | **[Permission](#Permission1)**<br>Set of permissions granted to the user. 
server_roles[] | enum **ServerRole**<br>Set of server roles granted to the login. <ul><li>`MDB_MONITOR`: Effectively grants VIEW SERVER STATE to the login. <br>That gives an ability to use various dynamic management views to monitor server state, including Activity Monitor tool that is built-in into SSMS. <br>No intrusive actions are allowed, so this is pretty safe to grant.</li></ul>


### Permission {#Permission1}

Field | Description
--- | ---
database_name | **string**<br>Name of the database the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Members of this fixed database role can perform all configuration and maintenance activities on a database and can also drop a database in SQL Server.</li><li>`DB_SECURITYADMIN`: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li><li>`DB_ACCESSADMIN`: Members of this fixed database role can add or remove access to a database for Windows logins, Windows groups, and SQL Server logins.</li><li>`DB_BACKUPOPERATOR`: Members of this fixed database role can back up the database.</li><li>`DB_DDLADMIN`: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li><li>`DB_DATAWRITER`: Members of this fixed database role can add, delete, or change data in all user tables.</li><li>`DB_DATAREADER`: Members of this fixed database role can read all data from all user tables.</li><li>`DB_DENYDATAWRITER`: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li><li>`DB_DENYDATAREADER`: Members of this fixed database role cannot read any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li></ul>


## Create {#Create}

Creates an SQL Server user in the specified cluster.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster to create a user for. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_spec | **[UserSpec](#UserSpec)**<br>Required. Properties of the user to be created. 


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the SQL Server user. The maximum string length in characters is 32. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the SQL Server user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission2)**<br>Set of permissions to grant to the user. 
server_roles[] | enum **ServerRole**<br>Set of server roles. <ul><li>`MDB_MONITOR`: Effectively grants VIEW SERVER STATE to the login. <br>That gives an ability to use various dynamic management views to monitor server state, including Activity Monitor tool that is built-in into SSMS. <br>No intrusive actions are allowed, so this is pretty safe to grant.</li></ul>


### Permission {#Permission2}

Field | Description
--- | ---
database_name | **string**<br>Name of the database the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Members of this fixed database role can perform all configuration and maintenance activities on a database and can also drop a database in SQL Server.</li><li>`DB_SECURITYADMIN`: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li><li>`DB_ACCESSADMIN`: Members of this fixed database role can add or remove access to a database for Windows logins, Windows groups, and SQL Server logins.</li><li>`DB_BACKUPOPERATOR`: Members of this fixed database role can back up the database.</li><li>`DB_DDLADMIN`: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li><li>`DB_DATAWRITER`: Members of this fixed database role can add, delete, or change data in all user tables.</li><li>`DB_DATAREADER`: Members of this fixed database role can read all data from all user tables.</li><li>`DB_DENYDATAWRITER`: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li><li>`DB_DENYDATAREADER`: Members of this fixed database role cannot read any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li></ul>


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
cluster_id | **string**<br>ID of the SQL Server cluster the user is being created for. 
user_name | **string**<br>Name of the user being created. 


### User {#User2}

Field | Description
--- | ---
name | **string**<br>Name of the SQL Server user. 
cluster_id | **string**<br>ID of the SQL Server cluster the user belongs to. 
permissions[] | **[Permission](#Permission3)**<br>Set of permissions granted to the user. 
server_roles[] | enum **ServerRole**<br>Set of server roles granted to the login. <ul><li>`MDB_MONITOR`: Effectively grants VIEW SERVER STATE to the login. <br>That gives an ability to use various dynamic management views to monitor server state, including Activity Monitor tool that is built-in into SSMS. <br>No intrusive actions are allowed, so this is pretty safe to grant.</li></ul>


## Update {#Update}

Modifies the specified SQL Server user.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster the user belongs to. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to be updated. <br>To get the name of the user use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the SQL Server user should be updated. 
password | **string**<br>New password for the user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission3)**<br>New set of permissions for the user. 
server_roles[] | enum **ServerRole**<br>New set of server roles granted to the login. <ul><li>`MDB_MONITOR`: Effectively grants VIEW SERVER STATE to the login. <br>That gives an ability to use various dynamic management views to monitor server state, including Activity Monitor tool that is built-in into SSMS. <br>No intrusive actions are allowed, so this is pretty safe to grant.</li></ul>


### Permission {#Permission3}

Field | Description
--- | ---
database_name | **string**<br>Name of the database the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Members of this fixed database role can perform all configuration and maintenance activities on a database and can also drop a database in SQL Server.</li><li>`DB_SECURITYADMIN`: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li><li>`DB_ACCESSADMIN`: Members of this fixed database role can add or remove access to a database for Windows logins, Windows groups, and SQL Server logins.</li><li>`DB_BACKUPOPERATOR`: Members of this fixed database role can back up the database.</li><li>`DB_DDLADMIN`: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li><li>`DB_DATAWRITER`: Members of this fixed database role can add, delete, or change data in all user tables.</li><li>`DB_DATAREADER`: Members of this fixed database role can read all data from all user tables.</li><li>`DB_DENYDATAWRITER`: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li><li>`DB_DENYDATAREADER`: Members of this fixed database role cannot read any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li></ul>


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
cluster_id | **string**<br>ID of the SQL Server cluster the user belongs to. 
user_name | **string**<br>Name of the user being updated. 


### User {#User3}

Field | Description
--- | ---
name | **string**<br>Name of the SQL Server user. 
cluster_id | **string**<br>ID of the SQL Server cluster the user belongs to. 
permissions[] | **[Permission](#Permission4)**<br>Set of permissions granted to the user. 
server_roles[] | enum **ServerRole**<br>Set of server roles granted to the login. <ul><li>`MDB_MONITOR`: Effectively grants VIEW SERVER STATE to the login. <br>That gives an ability to use various dynamic management views to monitor server state, including Activity Monitor tool that is built-in into SSMS. <br>No intrusive actions are allowed, so this is pretty safe to grant.</li></ul>


## Delete {#Delete}

Deletes the specified SQL Server user.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster the user belongs to. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to delete. <br>To get the name of the user, use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


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
cluster_id | **string**<br>ID of the SQL Server cluster the user belongs to. 
user_name | **string**<br>Name of the user being deleted. 


## GrantPermission {#GrantPermission}

Grants a permission to the specified SQL Server user.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster the user belongs to. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to grant the permission to. <br>To get the name of the user, use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission4)**<br>Required. Permission that should be granted to the specified user. 


### Permission {#Permission4}

Field | Description
--- | ---
database_name | **string**<br>Name of the database the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Members of this fixed database role can perform all configuration and maintenance activities on a database and can also drop a database in SQL Server.</li><li>`DB_SECURITYADMIN`: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li><li>`DB_ACCESSADMIN`: Members of this fixed database role can add or remove access to a database for Windows logins, Windows groups, and SQL Server logins.</li><li>`DB_BACKUPOPERATOR`: Members of this fixed database role can back up the database.</li><li>`DB_DDLADMIN`: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li><li>`DB_DATAWRITER`: Members of this fixed database role can add, delete, or change data in all user tables.</li><li>`DB_DATAREADER`: Members of this fixed database role can read all data from all user tables.</li><li>`DB_DENYDATAWRITER`: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li><li>`DB_DENYDATAREADER`: Members of this fixed database role cannot read any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li></ul>


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
cluster_id | **string**<br>ID of the SQL Server cluster the user belongs to. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. 
user_name | **string**<br>Name of the user being granted a permission. 


### User {#User4}

Field | Description
--- | ---
name | **string**<br>Name of the SQL Server user. 
cluster_id | **string**<br>ID of the SQL Server cluster the user belongs to. 
permissions[] | **[Permission](#Permission5)**<br>Set of permissions granted to the user. 
server_roles[] | enum **ServerRole**<br>Set of server roles granted to the login. <ul><li>`MDB_MONITOR`: Effectively grants VIEW SERVER STATE to the login. <br>That gives an ability to use various dynamic management views to monitor server state, including Activity Monitor tool that is built-in into SSMS. <br>No intrusive actions are allowed, so this is pretty safe to grant.</li></ul>


## RevokePermission {#RevokePermission}

Revokes a permission from the specified SQL Server user.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the SQL Server cluster the user belongs to. <br>To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to revoke a permission from. <br>To get the name of the user, use a [UserService.List](#List) request. The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission5)**<br>Required. Permission that should be revoked from the specified user. 


### Permission {#Permission5}

Field | Description
--- | ---
database_name | **string**<br>Name of the database the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Members of this fixed database role can perform all configuration and maintenance activities on a database and can also drop a database in SQL Server.</li><li>`DB_SECURITYADMIN`: Members of this fixed database role can modify role membership for custom roles only and manage permissions. They can potentially elevate their privileges and their actions should be monitored.</li><li>`DB_ACCESSADMIN`: Members of this fixed database role can add or remove access to a database for Windows logins, Windows groups, and SQL Server logins.</li><li>`DB_BACKUPOPERATOR`: Members of this fixed database role can back up the database.</li><li>`DB_DDLADMIN`: Members of this fixed database role can run any Data Definition Language (DDL) command in a database.</li><li>`DB_DATAWRITER`: Members of this fixed database role can add, delete, or change data in all user tables.</li><li>`DB_DATAREADER`: Members of this fixed database role can read all data from all user tables.</li><li>`DB_DENYDATAWRITER`: Members of this fixed database role cannot add, modify, or delete any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li><li>`DB_DENYDATAREADER`: Members of this fixed database role cannot read any data in the user tables within a database. A denial has a higher priority than a grant, so you can use this role to quickly restrict one's privileges without explicitly revoking permissions or roles.</li></ul>


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
cluster_id | **string**<br>ID of the SQL Server cluster the user belongs to. 
user_name | **string**<br>Name of the user whose permission is being revoked. 


### User {#User5}

Field | Description
--- | ---
name | **string**<br>Name of the SQL Server user. 
cluster_id | **string**<br>ID of the SQL Server cluster the user belongs to. 
permissions[] | **[Permission](#Permission6)**<br>Set of permissions granted to the user. 
server_roles[] | enum **ServerRole**<br>Set of server roles granted to the login. <ul><li>`MDB_MONITOR`: Effectively grants VIEW SERVER STATE to the login. <br>That gives an ability to use various dynamic management views to monitor server state, including Activity Monitor tool that is built-in into SSMS. <br>No intrusive actions are allowed, so this is pretty safe to grant.</li></ul>


