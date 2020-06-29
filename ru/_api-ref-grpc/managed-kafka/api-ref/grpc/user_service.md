---
editable: false
---

# UserService

A set of methods for managing Apache Kafka users.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Returns the specified Apache Kafka user. |
| [List](#List) | Retrieves the list of Apache Kafka users in the specified cluster. |
| [Create](#Create) | Creates a Apache Kafka user in the specified cluster. |
| [Update](#Update) | Updates the specified Apache Kafka user. |
| [Delete](#Delete) | Deletes the specified Apache Kafka user. |
| [GrantPermission](#GrantPermission) | Grants permission to the specified Apache Kafka user. |
| [RevokePermission](#RevokePermission) | Revokes permission from the specified Apache Kafka user. |

## Вызовы UserService {#calls}

## Get {#Get}

Returns the specified Apache Kafka user. <br>To get the list of available Apache Kafka users, make a [List](#List) request.

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster the user belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Name of the Apache Kafka User resource to return. <br>To get the name of the user, make a [UserService.List](#List) request. false Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Name of the Apache Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka cluster the user belongs to. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission)**<br>Set of permissions granted to this user. 


### Permission {#Permission}

Поле | Описание
--- | ---
topic_name | **string**<br>Name of the topic that the permission grants access to. <br>To get the topic name, make a [Topic.List](#Topic) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: Producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: Consumer role for the user.</li><ul/>


## List {#List}

Retrieves the list of Apache Kafka users in the specified cluster.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the cluster to list Apache Kafka users in. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
page_size | **int64**<br>The maximum number of results per page to return. <br>If the number of available results is larger than `page_size`, the service returns a [ListUsersResponse.next_page_token](#ListUsersResponse) that can be used to get the next page of results in subsequent list requests. Максимальное значение — 1000.
page_token | **string**<br>Page token. <br>To get the next page of results, set `page_token` to the [ListUsersResponse.next_page_token](#ListUsersResponse) returned by a previous list request. Максимальная длина строки в символах — 100.


### ListUsersResponse {#ListUsersResponse}

Поле | Описание
--- | ---
users[] | **[User](#User1)**<br>List of Apache Kafka User resources. 
next_page_token | **string**<br>This token allows you to get the next page of results for list requests. <br>If the number of results is larger than [ListUsersRequest.page_size](#ListUsersRequest1), use the `next_page_token` as the value for the [ListUsersRequest.page_token](#ListUsersRequest1) parameter in the next list request. Each subsequent list request will have its own `next_page_token` to continue paging through the results. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Name of the Apache Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka cluster the user belongs to. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission1)**<br>Set of permissions granted to this user. 


### Permission {#Permission}

Поле | Описание
--- | ---
topic_name | **string**<br>Name of the topic that the permission grants access to. <br>To get the topic name, make a [Topic.List](#Topic) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: Producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: Consumer role for the user.</li><ul/>


## Create {#Create}

Creates a Apache Kafka user in the specified cluster.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster to create a user in. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
user_spec | **[UserSpec](#UserSpec)**<br>Обязательное поле. Configuration of the user to create. false


### UserSpec {#UserSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Name of the Apache Kafka user. false Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
password | **string**<br>Обязательное поле. Password of the Apache Kafka user. false Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission2)**<br>Set of permissions granted to the user. 


### Permission {#Permission}

Поле | Описание
--- | ---
topic_name | **string**<br>Name of the topic that the permission grants access to. <br>To get the topic name, make a [Topic.List](#Topic) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: Producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: Consumer role for the user.</li><ul/>


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
cluster_id | **string**<br>ID of the Apache Kafka cluster the user is being created in. 
user_name | **string**<br>Name of the user that is being created. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Name of the Apache Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka cluster the user belongs to. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission3)**<br>Set of permissions granted to this user. 


## Update {#Update}

Updates the specified Apache Kafka user.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster the user belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Required. Name of the user to be updated. <br>To get the name of the user, make a [UserService.List](#List) request. false Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Field mask that specifies which fields of the Apache Kafka user should be updated. <br>By default, this API method will replace all the values for the settings that are not present in `update_mask` list with the default ones. Pass the list of the settings to change in this parameter to prevent the method from doing so (use comma as a delimiter if you want to modify a few settings at once). 
password | **string**<br>New password for the user. Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission3)**<br>New set of permissions for the user. 


### Permission {#Permission}

Поле | Описание
--- | ---
topic_name | **string**<br>Name of the topic that the permission grants access to. <br>To get the topic name, make a [Topic.List](#Topic) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: Producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: Consumer role for the user.</li><ul/>


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
cluster_id | **string**<br>ID of the Apache Kafka cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being updated. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Name of the Apache Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka cluster the user belongs to. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission4)**<br>Set of permissions granted to this user. 


## Delete {#Delete}

Deletes the specified Apache Kafka user.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster the user belongs to. To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Required. Name of the user to delete. To get the name of the user, make a [UserService.List](#List) request. false Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


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
cluster_id | **string**<br>ID of the Apache Kafka cluster the user belongs to. 
user_name | **string**<br>Name of the user that is being deleted. 


## GrantPermission {#GrantPermission}

Grants permission to the specified Apache Kafka user.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster the user belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Name of the user to grant the permission to. <br>To get the name of the user, make a [UserService.List](#List) request. false Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission4)**<br>Обязательное поле. Permission that should be granted to the specified user. false


### Permission {#Permission}

Поле | Описание
--- | ---
topic_name | **string**<br>Name of the topic that the permission grants access to. <br>To get the topic name, make a [Topic.List](#Topic) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: Producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: Consumer role for the user.</li><ul/>


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
cluster_id | **string**<br>ID of the Apache Kafka cluster the user belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
user_name | **string**<br>Name of the user that is being granted a permission. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Name of the Apache Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka cluster the user belongs to. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission5)**<br>Set of permissions granted to this user. 


## RevokePermission {#RevokePermission}

Revokes permission from the specified Apache Kafka user.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. ID of the Apache Kafka cluster the user belongs to. <br>To get the cluster ID, make a [ClusterService.List](./cluster_service#List) request. false Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Name of the user to revoke a permission from. <br>To get the name of the user, make a [UserService.List](#List) request. false Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission5)**<br>Обязательное поле. Permission that should be revoked from the specified user. false


### Permission {#Permission}

Поле | Описание
--- | ---
topic_name | **string**<br>Name of the topic that the permission grants access to. <br>To get the topic name, make a [Topic.List](#Topic) request. 
role | enum **AccessRole**<br>Access role type to grant to the user. <ul><li>`ACCESS_ROLE_PRODUCER`: Producer role for the user.</li><li>`ACCESS_ROLE_CONSUMER`: Consumer role for the user.</li><ul/>


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
cluster_id | **string**<br>ID of the Apache Kafka cluster the user belongs to. 
user_name | **string**<br>Name of the user whose permission is being revoked. 


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Name of the Apache Kafka user. 
cluster_id | **string**<br>ID of the Apache Kafka cluster the user belongs to. <br>To get the Apache Kafka cluster ID, make a [ClusterService.List](./cluster_service#List) request. 
permissions[] | **[Permission](#Permission6)**<br>Set of permissions granted to this user. 


