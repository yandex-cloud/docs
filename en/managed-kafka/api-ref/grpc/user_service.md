---
editable: false
sourcePath: en/_api-ref-grpc/managed-kafka/api-ref/grpc/user_service.md
---

# Managed Service for Apache Kafka® API, gRPC: UserService

A set of methods for managing Kafka users.

| Call | Description |
| --- | --- |
| [Get](#Get) | Returns the specified Kafka user. |
| [List](#List) | Retrieves the list of Kafka users in the specified cluster. |
| [Create](#Create) | Creates a Kafka user in the specified cluster. |
| [Update](#Update) | Updates the specified Kafka user. |
| [Delete](#Delete) | Deletes the specified Kafka user. |
| [GrantPermission](#GrantPermission) | Grants permission to the specified Kafka user. |
| [RevokePermission](#RevokePermission) | Revokes permission from the specified Kafka user. |

## Calls UserService {#calls}

## Get {#Get}

Returns the specified Kafka user. <br>To get the list of available Kafka users, make a [List](#List) request.

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster the user belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the Kafka user to return. <br>To get the name of the user, make a [UserService.List](#List) request. The string length in characters must be 1-63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


### User {#User}

Field | Description
--- | ---
name | **string**<br>Name of the Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka® cluster the user belongs to. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission)**<br>Set of permissions granted to this user. 


### Permission {#Permission}

Field | Description
--- | ---
topic_name | **string**<br>Name or prefix-pattern with wildcard for the topic that the permission grants access to. <br>To get the topic name, make a [TopicService.List](./topic_service#List) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: consumer role for the user.</li><li>`ACCESS_ROLE_ADMIN`: admin role for the user.</li></ul>
allow_hosts[] | **string**<br>Lists hosts allowed for this permission. When not defined, access from any host is allowed. <br>Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the `allow_hosts` of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. 


## List {#List}

Retrieves the list of Kafka users in the specified cluster.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to list Kafka users in. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.next_page_token](#ListUsersResponse) that can be used to get the next page of results in subsequent list requests. The maximum value is 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListUsersResponse.next_page_token](#ListUsersResponse) returned by the previous list request. The maximum string length in characters is 100.


### ListUsersResponse {#ListUsersResponse}

Field | Description
--- | ---
users[] | **[User](#User1)**<br>List of Kafka users. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListUsersRequest.page_size](#ListUsersRequest), use the `next_page_token` as the value for the [ListUsersRequest.page_token](#ListUsersRequest) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### User {#User1}

Field | Description
--- | ---
name | **string**<br>Name of the Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka® cluster the user belongs to. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission1)**<br>Set of permissions granted to this user. 


### Permission {#Permission1}

Field | Description
--- | ---
topic_name | **string**<br>Name or prefix-pattern with wildcard for the topic that the permission grants access to. <br>To get the topic name, make a [TopicService.List](./topic_service#List) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: consumer role for the user.</li><li>`ACCESS_ROLE_ADMIN`: admin role for the user.</li></ul>
allow_hosts[] | **string**<br>Lists hosts allowed for this permission. When not defined, access from any host is allowed. <br>Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the `allow_hosts` of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. 


## Create {#Create}

Creates a Kafka user in the specified cluster.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster to create a user in. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_spec | **[UserSpec](#UserSpec)**<br>Required. Configuration of the user to create. 


### UserSpec {#UserSpec}

Field | Description
--- | ---
name | **string**<br>Required. Name of the Kafka user. The string length in characters must be 1-256. Value must match the regular expression ` [a-zA-Z0-9_]* `.
password | **string**<br>Required. Password of the Kafka user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission2)**<br>Set of permissions granted to the user. 


### Permission {#Permission2}

Field | Description
--- | ---
topic_name | **string**<br>Name or prefix-pattern with wildcard for the topic that the permission grants access to. <br>To get the topic name, make a [TopicService.List](./topic_service#List) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: consumer role for the user.</li><li>`ACCESS_ROLE_ADMIN`: admin role for the user.</li></ul>
allow_hosts[] | **string**<br>Lists hosts allowed for this permission. When not defined, access from any host is allowed. <br>Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the `allow_hosts` of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. 


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
cluster_id | **string**<br>ID of the Apache Kafka® cluster the user is being created in. 
user_name | **string**<br>Name of the user that is being created. 


### User {#User2}

Field | Description
--- | ---
name | **string**<br>Name of the Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka® cluster the user belongs to. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission3)**<br>Set of permissions granted to this user. 


## Update {#Update}

Updates the specified Kafka user.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster the user belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to be updated. <br>To get the name of the user, make a [UserService.List](#List) request. The string length in characters must be 1-63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
password | **string**<br>New password for the user. The string length in characters must be 8-128.
permissions[] | **[Permission](#Permission3)**<br>New set of permissions for the user. 


### Permission {#Permission3}

Field | Description
--- | ---
topic_name | **string**<br>Name or prefix-pattern with wildcard for the topic that the permission grants access to. <br>To get the topic name, make a [TopicService.List](./topic_service#List) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: consumer role for the user.</li><li>`ACCESS_ROLE_ADMIN`: admin role for the user.</li></ul>
allow_hosts[] | **string**<br>Lists hosts allowed for this permission. When not defined, access from any host is allowed. <br>Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the `allow_hosts` of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. 


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
cluster_id | **string**<br>ID of the Apache Kafka® cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being updated. 


### User {#User3}

Field | Description
--- | ---
name | **string**<br>Name of the Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka® cluster the user belongs to. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission4)**<br>Set of permissions granted to this user. 


## Delete {#Delete}

Deletes the specified Kafka user.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster the user belongs to. To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to delete. To get the name of the user, make a [UserService.List](#List) request. The string length in characters must be 1-63. Value must match the regular expression ` [a-zA-Z0-9_]* `.


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
cluster_id | **string**<br>ID of the Apache Kafka® cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being deleted. 


## GrantPermission {#GrantPermission}

Grants permission to the specified Kafka user.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster the user belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to grant the permission to. <br>To get the name of the user, make a [UserService.List](#List) request. The string length in characters must be 1-63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission4)**<br>Required. Permission that should be granted to the specified user. 


### Permission {#Permission4}

Field | Description
--- | ---
topic_name | **string**<br>Name or prefix-pattern with wildcard for the topic that the permission grants access to. <br>To get the topic name, make a [TopicService.List](./topic_service#List) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: consumer role for the user.</li><li>`ACCESS_ROLE_ADMIN`: admin role for the user.</li></ul>
allow_hosts[] | **string**<br>Lists hosts allowed for this permission. When not defined, access from any host is allowed. <br>Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the `allow_hosts` of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. 


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
cluster_id | **string**<br>ID of the Apache Kafka® cluster the user belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
user_name | **string**<br>Name of the user that is being granted a permission. 


### User {#User4}

Field | Description
--- | ---
name | **string**<br>Name of the Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka® cluster the user belongs to. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission5)**<br>Set of permissions granted to this user. 


## RevokePermission {#RevokePermission}

Revokes permission from the specified Kafka user.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Metadata and response of Operation:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Field | Description
--- | ---
cluster_id | **string**<br>Required. ID of the Apache Kafka® cluster the user belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. The maximum string length in characters is 50.
user_name | **string**<br>Required. Name of the user to revoke a permission from. <br>To get the name of the user, make a [UserService.List](#List) request. The string length in characters must be 1-63. Value must match the regular expression ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission5)**<br>Required. Permission that should be revoked from the specified user. 


### Permission {#Permission5}

Field | Description
--- | ---
topic_name | **string**<br>Name or prefix-pattern with wildcard for the topic that the permission grants access to. <br>To get the topic name, make a [TopicService.List](./topic_service#List) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: consumer role for the user.</li><li>`ACCESS_ROLE_ADMIN`: admin role for the user.</li></ul>
allow_hosts[] | **string**<br>Lists hosts allowed for this permission. When not defined, access from any host is allowed. <br>Bare in mind that the same host might appear in multiple permissions at the same time, hence removing individual permission doesn't automatically restricts access from the `allow_hosts` of the permission. If the same host(s) is listed for another permission of the same principal/topic, the host(s) remains allowed. 


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
cluster_id | **string**<br>ID of the Apache Kafka® cluster the user belongs to. 
user_name | **string**<br>Name of the user whose permission is being revoked. 


### User {#User5}

Field | Description
--- | ---
name | **string**<br>Name of the Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka® cluster the user belongs to. <br>To get the Apache Kafka® cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission6)**<br>Set of permissions granted to this user. 


