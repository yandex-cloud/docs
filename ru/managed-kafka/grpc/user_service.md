---
editable: false
---

# UserService

Набор методов для управления пользователями Kafka.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает информацию об указанном пользователе Kafka. |
| [List](#List) | Получает список пользователей Kafka в указанном кластере. |
| [Create](#Create) | Создает пользователя Kafka в указанном кластере. |
| [Update](#Update) | Изменяет указанного пользователя Kafka. |
| [Delete](#Delete) | Удаляет указанного пользователя Kafka. |
| [GrantPermission](#GrantPermission) | Предоставляет разрешение указанному пользователю Kafka. |
| [RevokePermission](#RevokePermission) | Отзывает разрешение у указанного пользователя Kafka. |

## Вызовы UserService {#calls}

## Get {#Get}

Возвращает информацию об указанном пользователе Kafka. <br>Чтобы получить список доступных пользователей Kafka, выполните запрос [List](#List).

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя запрашиваемого пользователя Kafka. <br>Чтобы получить имя пользователя, выполните запрос [UserService.List](#List). Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя Kafka. 
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](./cluster_service#List). 
permissions[] | **[Permission](#Permission)**<br>Набор разрешений, предоставленных пользователю. 


### Permission {#Permission}

Поле | Описание
--- | ---
topic_name | **string**<br>Имя топика, к которому предоставляется доступ. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](./topic_service#List). 
role | enum **AccessRole**<br>Роль доступа, которую нужно предоставить пользователю. <ul><li>`ACCESS_ROLE_PRODUCER`: роль пользователя — производитель.</li><li>`ACCESS_ROLE_CONSUMER`: роль пользователя — потребитель.</li><ul/>


## List {#List}

Получает список пользователей Kafka в указанном кластере.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, для которого нужно получить список пользователей. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. <br>Если количество результатов больше чем `page_size`, сервис вернет значение [ListUsersResponse.next_page_token](#ListUsersResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. <br>Установите значение `page_token` равным значению поля [ListUsersResponse.next_page_token](#ListUsersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListUsersResponse {#ListUsersResponse}

Поле | Описание
--- | ---
users[] | **[User](#User1)**<br>Список пользователей Kafka. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. <br>Если количество результатов больше чем [ListUsersRequest.page_size](#ListUsersRequest), используйте `next_page_token` в качестве значения параметра [ListUsersRequest.page_token](#ListUsersRequest) в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### User {#User1}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя Kafka. 
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](./cluster_service#List). 
permissions[] | **[Permission](#Permission1)**<br>Набор разрешений, предоставленных пользователю. 


### Permission {#Permission1}

Поле | Описание
--- | ---
topic_name | **string**<br>Имя топика, к которому предоставляется доступ. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](./topic_service#List). 
role | enum **AccessRole**<br>Роль доступа, которую нужно предоставить пользователю. <ul><li>`ACCESS_ROLE_PRODUCER`: роль пользователя — производитель.</li><li>`ACCESS_ROLE_CONSUMER`: роль пользователя — потребитель.</li><ul/>


## Create {#Create}

Создает пользователя Kafka в указанном кластере.

**rpc Create ([CreateUserRequest](#CreateUserRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateUserMetadata](#CreateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User2)<br>

### CreateUserRequest {#CreateUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, в котором следует создать пользователя. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_spec | **[UserSpec](#UserSpec)**<br>Обязательное поле. Свойства создаваемого пользователя. 


### UserSpec {#UserSpec}

Поле | Описание
--- | ---
name | **string**<br>Обязательное поле. Имя пользователя Kafka. Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
password | **string**<br>Обязательное поле. Пароль пользователя Kafka. Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission2)**<br>Набор разрешений, предоставленных пользователю. 


### Permission {#Permission2}

Поле | Описание
--- | ---
topic_name | **string**<br>Имя топика, к которому предоставляется доступ. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](./topic_service#List). 
role | enum **AccessRole**<br>Роль доступа, которую нужно предоставить пользователю. <ul><li>`ACCESS_ROLE_PRODUCER`: роль пользователя — производитель.</li><li>`ACCESS_ROLE_CONSUMER`: роль пользователя — потребитель.</li><ul/>


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
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, в котором создается пользователь. 
user_name | **string**<br>Имя создаваемого пользователя. 


### User {#User2}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя Kafka. 
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](./cluster_service#List). 
permissions[] | **[Permission](#Permission3)**<br>Набор разрешений, предоставленных пользователю. 


### Permission {#Permission3}

Поле | Описание
--- | ---
topic_name | **string**<br>Имя топика, к которому предоставляется доступ. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](./topic_service#List). 
role | enum **AccessRole**<br>Роль доступа, которую нужно предоставить пользователю. <ul><li>`ACCESS_ROLE_PRODUCER`: роль пользователя — производитель.</li><li>`ACCESS_ROLE_CONSUMER`: роль пользователя — потребитель.</li><ul/>


## Update {#Update}

Изменяет указанного пользователя Kafka.

**rpc Update ([UpdateUserRequest](#UpdateUserRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateUserMetadata](#UpdateUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User3)<br>

### UpdateUserRequest {#UpdateUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, которого следует изменить. <br>Чтобы получить имя пользователя, выполните запрос [UserService.List](#List). Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br> 
password | **string**<br>Новый пароль для пользователя. Длина строки в символах должна быть от 8 до 128.
permissions[] | **[Permission](#Permission4)**<br>Новый набор разрешений для пользователя. 


### Permission {#Permission4}

Поле | Описание
--- | ---
topic_name | **string**<br>Имя топика, к которому предоставляется доступ. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](./topic_service#List). 
role | enum **AccessRole**<br>Роль доступа, которую нужно предоставить пользователю. <ul><li>`ACCESS_ROLE_PRODUCER`: роль пользователя — производитель.</li><li>`ACCESS_ROLE_CONSUMER`: роль пользователя — потребитель.</li><ul/>


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
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. 
user_name | **string**<br>Имя изменяемого пользователя. 


### User {#User3}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя Kafka. 
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](./cluster_service#List). 
permissions[] | **[Permission](#Permission5)**<br>Набор разрешений, предоставленных пользователю. 


### Permission {#Permission5}

Поле | Описание
--- | ---
topic_name | **string**<br>Имя топика, к которому предоставляется доступ. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](./topic_service#List). 
role | enum **AccessRole**<br>Роль доступа, которую нужно предоставить пользователю. <ul><li>`ACCESS_ROLE_PRODUCER`: роль пользователя — производитель.</li><li>`ACCESS_ROLE_CONSUMER`: роль пользователя — потребитель.</li><ul/>


## Delete {#Delete}

Удаляет указанного пользователя Kafka.

**rpc Delete ([DeleteUserRequest](#DeleteUserRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteUserMetadata](#DeleteUserMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteUserRequest {#DeleteUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, которого нужно удалить. Чтобы получить имя пользователя, выполните запрос [UserService.List](#List). Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


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
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. 
user_name | **string**<br>Имя удаляемого пользователя. 


## GrantPermission {#GrantPermission}

Предоставляет разрешение указанному пользователю Kafka.

**rpc GrantPermission ([GrantUserPermissionRequest](#GrantUserPermissionRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[GrantUserPermissionMetadata](#GrantUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User4)<br>

### GrantUserPermissionRequest {#GrantUserPermissionRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, которому следует предоставить разрешение. <br>Чтобы получить имя пользователя, выполните запрос [UserService.List](#List). Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission6)**<br>Обязательное поле. Разрешение, которое должно быть предоставлено указанному пользователю. 


### Permission {#Permission6}

Поле | Описание
--- | ---
topic_name | **string**<br>Имя топика, к которому предоставляется доступ. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](./topic_service#List). 
role | enum **AccessRole**<br>Роль доступа, которую нужно предоставить пользователю. <ul><li>`ACCESS_ROLE_PRODUCER`: роль пользователя — производитель.</li><li>`ACCESS_ROLE_CONSUMER`: роль пользователя — потребитель.</li><ul/>


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
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). 
user_name | **string**<br>Имя пользователя, которому предоставляется разрешение. 


### User {#User4}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя Kafka. 
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](./cluster_service#List). 
permissions[] | **[Permission](#Permission7)**<br>Набор разрешений, предоставленных пользователю. 


### Permission {#Permission7}

Поле | Описание
--- | ---
topic_name | **string**<br>Имя топика, к которому предоставляется доступ. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](./topic_service#List). 
role | enum **AccessRole**<br>Роль доступа, которую нужно предоставить пользователю. <ul><li>`ACCESS_ROLE_PRODUCER`: роль пользователя — производитель.</li><li>`ACCESS_ROLE_CONSUMER`: роль пользователя — потребитель.</li><ul/>


## RevokePermission {#RevokePermission}

Отзывает разрешение у указанного пользователя Kafka.

**rpc RevokePermission ([RevokeUserPermissionRequest](#RevokeUserPermissionRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[RevokeUserPermissionMetadata](#RevokeUserPermissionMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[User](#User5)<br>

### RevokeUserPermissionRequest {#RevokeUserPermissionRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя пользователя, у которого следует отозвать разрешение. <br>Чтобы получить имя пользователя, выполните запрос [UserService.List](#List). Длина строки в символах должна быть от 1 до 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.
permission | **[Permission](#Permission8)**<br>Обязательное поле. Разрешение, которое должно быть отозвано у указанного пользователя. 


### Permission {#Permission8}

Поле | Описание
--- | ---
topic_name | **string**<br>Имя топика, к которому предоставляется доступ. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](./topic_service#List). 
role | enum **AccessRole**<br>Роль доступа, которую нужно предоставить пользователю. <ul><li>`ACCESS_ROLE_PRODUCER`: роль пользователя — производитель.</li><li>`ACCESS_ROLE_CONSUMER`: роль пользователя — потребитель.</li><ul/>


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
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. 
user_name | **string**<br>Имя пользователя, для которого отзывается разрешение. 


### User {#User5}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя Kafka. 
cluster_id | **string**<br>Идентификатор кластера Apache Kafka®, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера Apache Kafka®, выполните запрос [ClusterService.List](./cluster_service#List). 
permissions[] | **[Permission](#Permission9)**<br>Набор разрешений, предоставленных пользователю. 


### Permission {#Permission9}

Поле | Описание
--- | ---
topic_name | **string**<br>Имя топика, к которому предоставляется доступ. <br>Чтобы получить имя топика, выполните запрос [TopicService.List](./topic_service#List). 
role | enum **AccessRole**<br>Роль доступа, которую нужно предоставить пользователю. <ul><li>`ACCESS_ROLE_PRODUCER`: роль пользователя — производитель.</li><li>`ACCESS_ROLE_CONSUMER`: роль пользователя — потребитель.</li><ul/>


