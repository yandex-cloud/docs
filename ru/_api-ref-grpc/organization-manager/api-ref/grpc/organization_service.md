---
editable: false
---

# OrganizationService

Набор методов для управления организациями.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанную организацию. |
| [List](#List) | Возвращает список доступных организаций. |
| [Update](#Update) | Обновляет указанную органищацию. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанной организации. |
| [ListAccessBindings](#ListAccessBindings) | access Возвращает список привязок прав доступа для указанной организации. |
| [SetAccessBindings](#SetAccessBindings) | Задает список привязок прав доступа для указанной организации. |
| [UpdateAccessBindings](#UpdateAccessBindings) | Обновляет список привязок прав доступа для указанной организации. |

## Вызовы OrganizationService {#calls}

## Get {#Get}

Возвращает указанную организацию. <br>Чтобы получить список доступных организацией, используйте запрос [List](#List).

**rpc Get ([GetOrganizationRequest](#GetOrganizationRequest)) returns ([Organization](#Organization))**

### GetOrganizationRequest {#GetOrganizationRequest}

Поле | Описание
--- | ---
organization_id | **string**<br>Обязательное поле. Идентификатор организации. Чтобы получить идентификатор организации, используйте запрос [OrganizationService.List](#List). Максимальная длина строки в символах — 50.


### Organization {#Organization}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор организации. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя организации. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание организации. Длина описания должна быть от 0 до 256 символов. 
title | **string**<br>Название организации. Длина описания должна быть от 0 до 256 символов. 


## List {#List}

Возвращает список доступных организаций.

**rpc List ([ListOrganizationsRequest](#ListOrganizationsRequest)) returns ([ListOrganizationsResponse](#ListOrganizationsResponse))**

### ListOrganizationsRequest {#ListOrganizationsRequest}

Поле | Описание
--- | ---
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListOrganizationsResponse.next_page_token](#ListOrganizationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListOrganizationsResponse.next_page_token](#ListOrganizationsResponse) прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Organization.name](#Organization1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListOrganizationsResponse {#ListOrganizationsResponse}

Поле | Описание
--- | ---
organizations[] | **[Organization](#Organization1)**<br>Список организаций. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListOrganizationsResponse.page_size](#ListOrganizationsResponse), используйте `next_page_token` в качестве значения параметра [ListOrganizationsRequest.page_token](#ListOrganizationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Organization {#Organization1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор организации. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя организации. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание организации. Длина описания должна быть от 0 до 256 символов. 
title | **string**<br>Название организации. Длина описания должна быть от 0 до 256 символов. 


## Update {#Update}

Обновляет указанную органищацию.

**rpc Update ([UpdateOrganizationRequest](#UpdateOrganizationRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateOrganizationMetadata](#UpdateOrganizationMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Organization](#Organization2)<br>

### UpdateOrganizationRequest {#UpdateOrganizationRequest}

Поле | Описание
--- | ---
organization_id | **string**<br>Обязательное поле. Идентификатор организации для обновления. Чтобы получить идентификатор организации, используйте запрос [OrganizationService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля указанной федерации будут обновлены. 
name | **string**<br>Имя организации. Длина имени должна быть от 3 до 63 символов. Значение должно соответствовать регулярному выражению ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Описание организации. Длина описания должна быть от 0 до 256 символов. Максимальная длина строки в символах — 256.
title | **string**<br>Название организации. Длина описания должна быть от 0 до 256 символов. Максимальная длина строки в символах — 256.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateOrganizationMetadata](#UpdateOrganizationMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Organization](#Organization2)>**<br>в случае успешного выполнения операции. 


### UpdateOrganizationMetadata {#UpdateOrganizationMetadata}

Поле | Описание
--- | ---
organization_id | **string**<br>Идентификатор организации, которая обновляется. 


### Organization {#Organization2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор организации. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Имя организации. Длина имени должна быть от 3 до 63 символов. 
description | **string**<br>Описание организации. Длина описания должна быть от 0 до 256 символов. 
title | **string**<br>Название организации. Длина описания должна быть от 0 до 256 символов. 


## ListOperations {#ListOperations}

Возвращает список операций для указанной организации.

**rpc ListOperations ([ListOrganizationOperationsRequest](#ListOrganizationOperationsRequest)) returns ([ListOrganizationOperationsResponse](#ListOrganizationOperationsResponse))**

### ListOrganizationOperationsRequest {#ListOrganizationOperationsRequest}

Поле | Описание
--- | ---
organization_id | **string**<br>Обязательное поле. Идентификатор организации для перечисления операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListOrganizationOperationsResponse.next_page_token](#ListOrganizationOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListOrganizationOperationsResponse.next_page_token](#ListOrganizationOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListOrganizationOperationsResponse {#ListOrganizationOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation1)**<br>Список операций для указанной федерации. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListOrganizationOperationsResponse.page_size](#ListOrganizationOperationsResponse), используйте `next_page_token` в качестве значения параметра [ListOrganizationOperationsRequest.page_token](#ListOrganizationOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)**<br>Результат операции в случае успешного завершения. Если исходный метод не возвращает никаких данных при успешном завершении, например метод Delete, поле содержит объект [google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty). Если исходный метод — это стандартный метод Create / Update, поле содержит целевой ресурс операции. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `response`. 


## ListAccessBindings {#ListAccessBindings}

access Возвращает список привязок прав доступа для указанной организации.

**rpc ListAccessBindings ([ListAccessBindingsRequest](#ListAccessBindingsRequest)) returns ([ListAccessBindingsResponse](#ListAccessBindingsResponse))**

### ListAccessBindingsRequest {#ListAccessBindingsRequest}

Поле | Описание
--- | ---
resource_id | **string**<br>Обязательное поле. Идентификатор ресурса, для которого запрашивается список привязок прав доступа. <br>Чтобы получить идентификатор ресурса, используйте соответствующий запрос List. Например, используйте запрос [yandex.cloud.resourcemanager.v1.CloudService.List](/docs/resource-manager/api-ref/grpc/cloud_service#List) для получения идентификатора ресурса Cloud. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListAccessBindingsResponse.next_page_token](#ListAccessBindingsResponse) прошлого запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListAccessBindingsResponse {#ListAccessBindingsResponse}

Поле | Описание
--- | ---
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Список привязок прав доступа для указанного ресурса. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListAccessBindingsRequest.page_size](#ListAccessBindingsRequest), используйте `next_page_token` в качестве значения параметра [ListAccessBindingsRequest.page_token](#ListAccessBindingsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### AccessBinding {#AccessBinding}

Поле | Описание
--- | ---
role_id | **string**<br>Обязательное поле. Идентификатор ресурса `yandex.cloud.iam.v1.Role` который назначен для субъекта, указанного в параметре `subject`. Максимальная длина строки в символах — 50.
subject | **[Subject](#Subject)**<br>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой аккаунт с уникальным идентификатором в облаке или системную группу с общим системным идентификатором. 


### Subject {#Subject}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. <ul><li>`allAuthenticatedUsers`: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре `type` указано `system`. </li><li>`allUsers`: Специальный системный идентификатор, представляющий любого пользователя. Аутентификация не требуется. Например, при запросе через API не надо будет указывать IAM-токен. </li><li>`<идентификатор пользователя в облаке>`: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре `type` передано одно из следующих значений: `userAccount`, `federatedUser` или `serviceAccount`.</li></ul> Максимальная длина строки в символах — 50.
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в {{ yandex-cloud }}. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


## SetAccessBindings {#SetAccessBindings}

Задает список привязок прав доступа для указанной организации.

**rpc SetAccessBindings ([SetAccessBindingsRequest](#SetAccessBindingsRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### SetAccessBindingsRequest {#SetAccessBindingsRequest}

Поле | Описание
--- | ---
resource_id | **string**<br>Обязательное поле. Идентификатор ресурса, для которого задается список привязок прав доступа. <br>Чтобы получить идентификатор ресурса, используйте соответствующий запрос List. Максимальная длина строки в символах — 50.
access_bindings[] | **[AccessBinding](#AccessBinding)**<br>Обязательное поле. Привязки прав доступа, которые будут установлены. Дополнительные сведения см. в разделе [Привязка прав доступа](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding1}

Поле | Описание
--- | ---
role_id | **string**<br>Обязательное поле. Идентификатор ресурса `yandex.cloud.iam.v1.Role` который назначен для субъекта, указанного в параметре `subject`. Максимальная длина строки в символах — 50.
subject | **[Subject](#Subject)**<br>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой аккаунт с уникальным идентификатором в облаке или системную группу с общим системным идентификатором. 


### Subject {#Subject1}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. <ul><li>`allAuthenticatedUsers`: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре `type` указано `system`. </li><li>`allUsers`: Специальный системный идентификатор, представляющий любого пользователя. Аутентификация не требуется. Например, при запросе через API не надо будет указывать IAM-токен. </li><li>`<идентификатор пользователя в облаке>`: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре `type` передано одно из следующих значений: `userAccount`, `federatedUser` или `serviceAccount`.</li></ul> Максимальная длина строки в символах — 50.
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в {{ yandex-cloud }}. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[SetAccessBindingsMetadata](#SetAccessBindingsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### SetAccessBindingsMetadata {#SetAccessBindingsMetadata}

Поле | Описание
--- | ---
resource_id | **string**<br>Идентификатор ресурса, для которого задается список привязок прав доступа. 


## UpdateAccessBindings {#UpdateAccessBindings}

Обновляет список привязок прав доступа для указанной организации.

**rpc UpdateAccessBindings ([UpdateAccessBindingsRequest](#UpdateAccessBindingsRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### UpdateAccessBindingsRequest {#UpdateAccessBindingsRequest}

Поле | Описание
--- | ---
resource_id | **string**<br>Обязательное поле. Идентификатор ресурса, для которого обновляется список привязок прав доступа. Максимальная длина строки в символах — 50.
access_binding_deltas[] | **[AccessBindingDelta](#AccessBindingDelta)**<br>Обязательное поле. Изменения в список привязок прав доступа. Количество элементов должно быть больше 0.


### AccessBindingDelta {#AccessBindingDelta}

Поле | Описание
--- | ---
action | enum **AccessBindingAction**<br>Обязательное поле. Действие, которое надо выполнить с привязкой прав доступа. <ul><li>`ADD`: Добавление новой привязки прав доступа.</li><li>`REMOVE`: Удаление привязки прав доступа.</li><ul/>
access_binding | **[AccessBinding](#AccessBinding)**<br>Обязательное поле. Привязка прав доступа. Дополнительные сведения см. в разделе [Привязка прав доступа](/docs/iam/concepts/access-control/#access-bindings). 


### AccessBinding {#AccessBinding2}

Поле | Описание
--- | ---
role_id | **string**<br>Обязательное поле. Идентификатор ресурса `yandex.cloud.iam.v1.Role` который назначен для субъекта, указанного в параметре `subject`. Максимальная длина строки в символах — 50.
subject | **[Subject](#Subject)**<br>Обязательное поле. Субъект, для которого создается привязка прав доступа. Может представлять собой аккаунт с уникальным идентификатором в облаке или системную группу с общим системным идентификатором. 


### Subject {#Subject2}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. <ul><li>`allAuthenticatedUsers`: Специальный системный идентификатор, представляющий любого пользователя, прошедшего аутентификацию. Его можно использовать только если в параметре `type` указано `system`. </li><li>`allUsers`: Специальный системный идентификатор, представляющий любого пользователя. Аутентификация не требуется. Например, при запросе через API не надо будет указывать IAM-токен. </li><li>`<идентификатор пользователя в облаке>`: Идентификатор, представляющий учетную запись пользователя. Его можно использовать только если в параметре `type` передано одно из следующих значений: `userAccount`, `federatedUser` или `serviceAccount`.</li></ul> Максимальная длина строки в символах — 50.
type | **string**<br>Обязательное поле. <ul><li>`userAccount` — аккаунт на Яндексе или Яндекс.Коннекте, добавленный в {{ yandex-cloud }}. </li><li>`serviceAccount` — сервисный аккаунт. Этот тип представляет ресурс `yandex.cloud.iam.v1.ServiceAccount`. </li><li>`federatedUser` — федеративный аккаунт. Этот тип представляет пользователя из федерации удостоверений, например Active Directory. </li><li>`system` — системная группа. Представляет набор аккаунтов, который описывается общим системным идентификатором. </li></ul> Максимальная длина строки в символах — 100.


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateAccessBindingsMetadata](#UpdateAccessBindingsMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### UpdateAccessBindingsMetadata {#UpdateAccessBindingsMetadata}

Поле | Описание
--- | ---
resource_id | **string**<br>Идентификатор ресурса, для которого обновляется список привязок прав доступа. 


