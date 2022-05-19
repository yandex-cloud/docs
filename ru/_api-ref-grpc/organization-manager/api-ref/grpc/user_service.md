---
editable: false
---

# UserService

Набор методов для управления пользователями организации.

| Вызов | Описание |
| --- | --- |
| [ListMembers](#ListMembers) | Возвращает список пользователей для указанной организации. |
| [DeleteMembership](#DeleteMembership) | Удаляет пользователя из членов организации. |

## Вызовы UserService {#calls}

## ListMembers {#ListMembers}

Возвращает список пользователей для указанной организации.

**rpc ListMembers ([ListMembersRequest](#ListMembersRequest)) returns ([ListMembersResponse](#ListMembersResponse))**

### ListMembersRequest {#ListMembersRequest}

Поле | Описание
--- | ---
organization_id | **string**<br>Обязательное поле. Идентификатор организации в которой будет удалено членство пользователя. Чтобы получить идентификатор организации, используйте запрос [OrganizationService.List](./organization_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListMembersResponse.next_page_token](#ListMembersResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListMembersResponse.next_page_token](#ListMembersResponse) прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListMembersResponse {#ListMembersResponse}

Поле | Описание
--- | ---
users[] | **OrganizationUser**<br>Список пользователей запрошенной организации. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListMembersRequest.page_size](#ListMembersRequest), используйте `next_page_token` в качестве значения параметра [ListMembersRequest.page_token](#ListMembersRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### OrganizationUser {#OrganizationUser}

Поле | Описание
--- | ---
subject_claims | **yandex.cloud.oauth.SubjectClaims**<br>OpenID standard claims with additional Yandex.Organization claims. 


## DeleteMembership {#DeleteMembership}

Удаляет пользователя из членов организации.

**rpc DeleteMembership ([DeleteMembershipRequest](#DeleteMembershipRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteMembershipMetadata](#DeleteMembershipMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[DeleteMembershipResponse](#DeleteMembershipResponse)<br>

### DeleteMembershipRequest {#DeleteMembershipRequest}

Поле | Описание
--- | ---
organization_id | **string**<br>Обязательное поле. Идентификатор организации в которой будет удалено членство пользователя. Максимальная длина строки в символах — 50.
subject_id | **string**<br>Идентификатор субъекта, который будет удален из организации. По умолчанию совпадает с идентификатором субъекта вызывающиего API. Максимальная длина строки в символах — 50.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteMembershipMetadata](#DeleteMembershipMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteMembershipResponse](#DeleteMembershipResponse)>**<br>в случае успешного выполнения операции. 


### DeleteMembershipMetadata {#DeleteMembershipMetadata}

Поле | Описание
--- | ---
organization_id | **string**<br>Обязательное поле. Идентификатор организации в которой будет удаляется членство пользователя. Максимальная длина строки в символах — 50.
subject_id | **string**<br>Обязательное поле. Идентификатор субъекта удаляемого из организации. Максимальная длина строки в символах — 50.


### DeleteMembershipResponse {#DeleteMembershipResponse}

Поле | Описание
--- | ---
organization_id | **string**<br>Обязательное поле. Идентификатор организации в которой удалено членство пользователя. Максимальная длина строки в символах — 50.
subject_id | **string**<br>Обязательное поле. Идентификатор субъекта удаленного из организации. Максимальная длина строки в символах — 50.


