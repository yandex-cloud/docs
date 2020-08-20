---
editable: false
---

# UserService

A set of methods for managing SQLServer users.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified SQLServer user. |
| [List](#List) | Retrieves a list of SQLServer users in the specified cluster. |
| [Create](#Create) | Creates a SQLServer user in the specified cluster. |
| [Update](#Update) | Modifies the specified SQLServer user. |
| [Delete](#Delete) | Deletes the specified SQLServer user. |
| [GrantPermission](#GrantPermission) | Grants a permission to the specified SQLServer user. |
| [RevokePermission](#RevokePermission) | Revokes a permission from the specified SQLServer user. |

## Calls UserService {#calls}

## Get {#Get}

Returns the specified SQLServer user. <br>To get the list of available SQLServer users, make a [List](#List) request.

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](../user.proto#User))**

### GetUserRequest {#GetUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the SQLServer cluster. false The maximum string length in characters is 50.
user_name | **string**<br>Required. Required. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the sqlserver user. 
cluster_id | **string**<br>ID of the sqlserver cluster the user belongs to. 
permissions[] | **[Permission](../user.proto#Permission)**<br>Set of permissions granted to the user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Члены предопределенной роли базы данных db_owner могут выполнять все действия по настройке и обслуживанию базы данных, а также удалять базу данных в SQL Server. (В База данных SQL и Хранилище данных SQLнекоторые операции по обслуживанию требуют наличие разрешений на уровне сервера и не может быть выполнены членами db_owner.)</li><li>`DB_SECURITYADMIN`: Элементы предопределенной роли базы данных db_securityadmin могут изменять членство в роли (только для настраиваемых ролей) и управлять разрешениями. Элементы этой роли потенциально могут повышать свои права доступа, поэтому необходимо отслеживать их действия.</li><li>`DB_ACCESSADMIN`: Члены предопределенной роли базы данных db_accessadmin могут добавлять или удалять права удаленного доступа к базе данных для имен входа и групп Windows, а также имен входа SQL Server .</li><li>`DB_BACKUPOPERATOR`: Члены предопределенной роли базы данных db_backupoperator могут создавать резервные копии базы данных.</li><li>`DB_DDLADMIN`: Члены предопределенной роли базы данных db_ddladmin могут выполнять любые команды языка определения данных (DDL) в базе данных.</li><li>`DB_DATAWRITER`: Члены предопределенной роли базы данных db_datawriter могут добавлять, удалять или изменять данные во всех пользовательских таблицах.</li><li>`DB_DATAREADER`: Элементы предопределенной роли базы данных db_datareader могут считывать все данные из всех пользовательских таблиц.</li><li>`DB_DENYDATAWRITER`: Члены предопределенной роли базы данных db_denydatawriter не могут добавлять, изменять или удалять данные в пользовательских таблицах базы данных.</li><li>`DB_DENYDATAREADER`: Члены предопределенной роли базы данных db_denydatareader не могут считывать данные из пользовательских таблиц базы данных.</li><ul/>


## List {#List}

Retrieves a list of SQLServer users in the specified cluster.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the cluster to list SQLServer users in. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. false The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.next_page_token](#ListUsersResponse) that can be used to get the next page of results in subsequent list requests. Acceptable values are 0 to 1000, inclusive.
page_token | **string**<br>Page token. To get the next page of results, set `page_token` to the [ListUsersResponse.next_page_token](#ListUsersResponse) returned by a previous list request. The maximum string length in characters is 100.


### ListUsersResponse {#ListUsersResponse}

Field | Description
--- | ---
users[] | **[User](../user.proto#User1)**<br>Requested list of SQLServer users. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. If the number of results is larger than [ListUsersRequest.page_size](#ListUsersRequest1), use the `next_page_token` as the value for the [ListUsersRequest.page_token](#ListUsersRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the sqlserver user. 
cluster_id | **string**<br>ID of the sqlserver cluster the user belongs to. 
permissions[] | **[Permission](../user.proto#Permission1)**<br>Set of permissions granted to the user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Члены предопределенной роли базы данных db_owner могут выполнять все действия по настройке и обслуживанию базы данных, а также удалять базу данных в SQL Server. (В База данных SQL и Хранилище данных SQLнекоторые операции по обслуживанию требуют наличие разрешений на уровне сервера и не может быть выполнены членами db_owner.)</li><li>`DB_SECURITYADMIN`: Элементы предопределенной роли базы данных db_securityadmin могут изменять членство в роли (только для настраиваемых ролей) и управлять разрешениями. Элементы этой роли потенциально могут повышать свои права доступа, поэтому необходимо отслеживать их действия.</li><li>`DB_ACCESSADMIN`: Члены предопределенной роли базы данных db_accessadmin могут добавлять или удалять права удаленного доступа к базе данных для имен входа и групп Windows, а также имен входа SQL Server .</li><li>`DB_BACKUPOPERATOR`: Члены предопределенной роли базы данных db_backupoperator могут создавать резервные копии базы данных.</li><li>`DB_DDLADMIN`: Члены предопределенной роли базы данных db_ddladmin могут выполнять любые команды языка определения данных (DDL) в базе данных.</li><li>`DB_DATAWRITER`: Члены предопределенной роли базы данных db_datawriter могут добавлять, удалять или изменять данные во всех пользовательских таблицах.</li><li>`DB_DATAREADER`: Элементы предопределенной роли базы данных db_datareader могут считывать все данные из всех пользовательских таблиц.</li><li>`DB_DENYDATAWRITER`: Члены предопределенной роли базы данных db_denydatawriter не могут добавлять, изменять или удалять данные в пользовательских таблицах базы данных.</li><li>`DB_DENYDATAREADER`: Члены предопределенной роли базы данных db_denydatareader не могут считывать данные из пользовательских таблиц базы данных.</li><ul/>


## Create {#Create}

Creates a SQLServer user in the specified cluster.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](../user.proto#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the SQLServer cluster to create a user for. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. false The maximum string length in characters is 50.
user_spec | **[UserSpec](../user.proto#UserSpec)**<br>Required. Properties of the user to be created. false


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the sqlserver user. false The maximum string length in characters is 32. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the sqlserver user. false The string length in characters must be 8-128.
permissions[] | **[Permission](../user.proto#Permission2)**<br>Set of permissions to grant to the user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Члены предопределенной роли базы данных db_owner могут выполнять все действия по настройке и обслуживанию базы данных, а также удалять базу данных в SQL Server. (В База данных SQL и Хранилище данных SQLнекоторые операции по обслуживанию требуют наличие разрешений на уровне сервера и не может быть выполнены членами db_owner.)</li><li>`DB_SECURITYADMIN`: Элементы предопределенной роли базы данных db_securityadmin могут изменять членство в роли (только для настраиваемых ролей) и управлять разрешениями. Элементы этой роли потенциально могут повышать свои права доступа, поэтому необходимо отслеживать их действия.</li><li>`DB_ACCESSADMIN`: Члены предопределенной роли базы данных db_accessadmin могут добавлять или удалять права удаленного доступа к базе данных для имен входа и групп Windows, а также имен входа SQL Server .</li><li>`DB_BACKUPOPERATOR`: Члены предопределенной роли базы данных db_backupoperator могут создавать резервные копии базы данных.</li><li>`DB_DDLADMIN`: Члены предопределенной роли базы данных db_ddladmin могут выполнять любые команды языка определения данных (DDL) в базе данных.</li><li>`DB_DATAWRITER`: Члены предопределенной роли базы данных db_datawriter могут добавлять, удалять или изменять данные во всех пользовательских таблицах.</li><li>`DB_DATAREADER`: Элементы предопределенной роли базы данных db_datareader могут считывать все данные из всех пользовательских таблиц.</li><li>`DB_DENYDATAWRITER`: Члены предопределенной роли базы данных db_denydatawriter не могут добавлять, изменять или удалять данные в пользовательских таблицах базы данных.</li><li>`DB_DENYDATAREADER`: Члены предопределенной роли базы данных db_denydatareader не могут считывать данные из пользовательских таблиц базы данных.</li><ul/>


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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](../user.proto#User2)>**<br>if operation finished successfully. 


### CreateUserMetadata {#CreateUserMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the SQLServer cluster the user is being created for. 
user_name | **string**<br>Name of the user that is being created. 


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the sqlserver user. 
cluster_id | **string**<br>ID of the sqlserver cluster the user belongs to. 
permissions[] | **[Permission](../user.proto#Permission3)**<br>Set of permissions granted to the user. 


## Update {#Update}

Modifies the specified SQLServer user.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](../user.proto#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the SQLServer cluster the user belongs to. To get the cluster ID use a [ClusterService.List](./cluster_service#List) request. false The maximum string length in characters is 50.
user_name | **string**<br>Required. Required. Name of the user to be updated. To get the name of the user use a [UserService.List](#List) request. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the SQLServer user should be updated. 
password | **string**<br>New password for the user. The string length in characters must be 8-128.
permissions[] | **[Permission](../user.proto#Permission3)**<br>New set of permissions for the user. 


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Члены предопределенной роли базы данных db_owner могут выполнять все действия по настройке и обслуживанию базы данных, а также удалять базу данных в SQL Server. (В База данных SQL и Хранилище данных SQLнекоторые операции по обслуживанию требуют наличие разрешений на уровне сервера и не может быть выполнены членами db_owner.)</li><li>`DB_SECURITYADMIN`: Элементы предопределенной роли базы данных db_securityadmin могут изменять членство в роли (только для настраиваемых ролей) и управлять разрешениями. Элементы этой роли потенциально могут повышать свои права доступа, поэтому необходимо отслеживать их действия.</li><li>`DB_ACCESSADMIN`: Члены предопределенной роли базы данных db_accessadmin могут добавлять или удалять права удаленного доступа к базе данных для имен входа и групп Windows, а также имен входа SQL Server .</li><li>`DB_BACKUPOPERATOR`: Члены предопределенной роли базы данных db_backupoperator могут создавать резервные копии базы данных.</li><li>`DB_DDLADMIN`: Члены предопределенной роли базы данных db_ddladmin могут выполнять любые команды языка определения данных (DDL) в базе данных.</li><li>`DB_DATAWRITER`: Члены предопределенной роли базы данных db_datawriter могут добавлять, удалять или изменять данные во всех пользовательских таблицах.</li><li>`DB_DATAREADER`: Элементы предопределенной роли базы данных db_datareader могут считывать все данные из всех пользовательских таблиц.</li><li>`DB_DENYDATAWRITER`: Члены предопределенной роли базы данных db_denydatawriter не могут добавлять, изменять или удалять данные в пользовательских таблицах базы данных.</li><li>`DB_DENYDATAREADER`: Члены предопределенной роли базы данных db_denydatareader не могут считывать данные из пользовательских таблиц базы данных.</li><ul/>


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](../user.proto#User3)>**<br>if operation finished successfully. 


### UpdateUserMetadata {#UpdateUserMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the SQLServer cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being updated. 


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the sqlserver user. 
cluster_id | **string**<br>ID of the sqlserver cluster the user belongs to. 
permissions[] | **[Permission](../user.proto#Permission4)**<br>Set of permissions granted to the user. 


## Delete {#Delete}

Deletes the specified SQLServer user.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the SQLServer cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. false The maximum string length in characters is 50.
user_name | **string**<br>Required. Required. Name of the user to delete. To get the name of the user, use a [UserService.List](#List) request. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


### Operation {#Operation}

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
cluster_id | **string**<br>ID of the SQLServer cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being deleted. 


## GrantPermission {#GrantPermission}

Grants a permission to the specified SQLServer user.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](../user.proto#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the SQLServer cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. false The maximum string length in characters is 50.
user_name | **string**<br>Required. Required. Name of the user to grant the permission to. To get the name of the user, use a [UserService.List](#List) request. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
permission | **[Permission](../user.proto#Permission4)**<br>Required. Permission that should be granted to the specified user. false


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Члены предопределенной роли базы данных db_owner могут выполнять все действия по настройке и обслуживанию базы данных, а также удалять базу данных в SQL Server. (В База данных SQL и Хранилище данных SQLнекоторые операции по обслуживанию требуют наличие разрешений на уровне сервера и не может быть выполнены членами db_owner.)</li><li>`DB_SECURITYADMIN`: Элементы предопределенной роли базы данных db_securityadmin могут изменять членство в роли (только для настраиваемых ролей) и управлять разрешениями. Элементы этой роли потенциально могут повышать свои права доступа, поэтому необходимо отслеживать их действия.</li><li>`DB_ACCESSADMIN`: Члены предопределенной роли базы данных db_accessadmin могут добавлять или удалять права удаленного доступа к базе данных для имен входа и групп Windows, а также имен входа SQL Server .</li><li>`DB_BACKUPOPERATOR`: Члены предопределенной роли базы данных db_backupoperator могут создавать резервные копии базы данных.</li><li>`DB_DDLADMIN`: Члены предопределенной роли базы данных db_ddladmin могут выполнять любые команды языка определения данных (DDL) в базе данных.</li><li>`DB_DATAWRITER`: Члены предопределенной роли базы данных db_datawriter могут добавлять, удалять или изменять данные во всех пользовательских таблицах.</li><li>`DB_DATAREADER`: Элементы предопределенной роли базы данных db_datareader могут считывать все данные из всех пользовательских таблиц.</li><li>`DB_DENYDATAWRITER`: Члены предопределенной роли базы данных db_denydatawriter не могут добавлять, изменять или удалять данные в пользовательских таблицах базы данных.</li><li>`DB_DENYDATAREADER`: Члены предопределенной роли базы данных db_denydatareader не могут считывать данные из пользовательских таблиц базы данных.</li><ul/>


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](../user.proto#User4)>**<br>if operation finished successfully. 


### GrantUserPermissionMetadata {#GrantUserPermissionMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the SQLServer cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. 
user_name | **string**<br>Name of the user that is being granted a permission. 


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the sqlserver user. 
cluster_id | **string**<br>ID of the sqlserver cluster the user belongs to. 
permissions[] | **[Permission](../user.proto#Permission5)**<br>Set of permissions granted to the user. 


## RevokePermission {#RevokePermission}

Revokes a permission from the specified SQLServer user.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](../user.proto#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. Required. ID of the SQLServer cluster the user belongs to. To get the cluster ID, use a [ClusterService.List](./cluster_service#List) request. false The maximum string length in characters is 50.
user_name | **string**<br>Required. Required. Name of the user to revoke a permission from. To get the name of the user, use a [UserService.List](#List) request. false The maximum string length in characters is 63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
permission | **[Permission](../user.proto#Permission5)**<br>Required. Permission that should be revoked from the specified user. false


### Permission {#Permission}

Field | Description
--- | ---
database_name | **string**<br>Name of the database that the permission grants access to. 
roles[] | enum **Role**<br>Roles granted to the user within the database. The minimum number of elements is 1.<ul><li>`DB_OWNER`: Члены предопределенной роли базы данных db_owner могут выполнять все действия по настройке и обслуживанию базы данных, а также удалять базу данных в SQL Server. (В База данных SQL и Хранилище данных SQLнекоторые операции по обслуживанию требуют наличие разрешений на уровне сервера и не может быть выполнены членами db_owner.)</li><li>`DB_SECURITYADMIN`: Элементы предопределенной роли базы данных db_securityadmin могут изменять членство в роли (только для настраиваемых ролей) и управлять разрешениями. Элементы этой роли потенциально могут повышать свои права доступа, поэтому необходимо отслеживать их действия.</li><li>`DB_ACCESSADMIN`: Члены предопределенной роли базы данных db_accessadmin могут добавлять или удалять права удаленного доступа к базе данных для имен входа и групп Windows, а также имен входа SQL Server .</li><li>`DB_BACKUPOPERATOR`: Члены предопределенной роли базы данных db_backupoperator могут создавать резервные копии базы данных.</li><li>`DB_DDLADMIN`: Члены предопределенной роли базы данных db_ddladmin могут выполнять любые команды языка определения данных (DDL) в базе данных.</li><li>`DB_DATAWRITER`: Члены предопределенной роли базы данных db_datawriter могут добавлять, удалять или изменять данные во всех пользовательских таблицах.</li><li>`DB_DATAREADER`: Элементы предопределенной роли базы данных db_datareader могут считывать все данные из всех пользовательских таблиц.</li><li>`DB_DENYDATAWRITER`: Члены предопределенной роли базы данных db_denydatawriter не могут добавлять, изменять или удалять данные в пользовательских таблицах базы данных.</li><li>`DB_DENYDATAREADER`: Члены предопределенной роли базы данных db_denydatareader не могут считывать данные из пользовательских таблиц базы данных.</li><ul/>


### Operation {#Operation}

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
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[User](../user.proto#User5)>**<br>if operation finished successfully. 


### RevokeUserPermissionMetadata {#RevokeUserPermissionMetadata}

Field | Description
--- | ---
cluster_id | **string**<br>ID of the SQLServer cluster the user belongs to. 
user_name | **string**<br>Name of the user whose permission is being revoked. 


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the sqlserver user. 
cluster_id | **string**<br>ID of the sqlserver cluster the user belongs to. 
permissions[] | **[Permission](../user.proto#Permission6)**<br>Set of permissions granted to the user. 


