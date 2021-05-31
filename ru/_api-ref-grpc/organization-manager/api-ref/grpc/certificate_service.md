---
editable: false
---

# CertificateService

Набор методов для управления сертификатами.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный сертификат. |
| [List](#List) | Возвращает список сертификатов для указанной федерации. |
| [Create](#Create) | Добавляет сертификат для указанной федерации. |
| [Update](#Update) | Обновляет указанный сертификат. |
| [Delete](#Delete) | Удаляет указанный сертификат. |
| [ListOperations](#ListOperations) | Перечисляет операции для указанного сертификата. |

## Вызовы CertificateService {#calls}

## Get {#Get}

Возвращает указанный сертификат. <br>Чтобы получить список доступных сертификатов, используйте запрос [List](#List).

**rpc Get ([GetCertificateRequest](#GetCertificateRequest)) returns ([Certificate](#Certificate))**

### GetCertificateRequest {#GetCertificateRequest}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор возвращаемого сертификата. Чтобы получить идентификатор сертификата, используйте запрос [CertificateService.List](#List). Максимальная длина строки в символах — 50.


### Certificate {#Certificate}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. Идентификатор сертификата. Максимальная длина строки в символах — 50.
federation_id | **string**<br>Обязательное поле. Идентификатор федерации, которой принадлежит сертификат. Максимальная длина строки в символах — 50.
name | **string**<br>Имя сертификата. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание сертификата. Длина описания должна быть от 0 до 256 символов. Максимальная длина строки в символах — 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
data | **string**<br>Обязательное поле. Данные сертификата в формате PEM. Максимальная длина строки в символах — 32000.


## List {#List}

Возвращает список сертификатов для указанной федерации.

**rpc List ([ListCertificatesRequest](#ListCertificatesRequest)) returns ([ListCertificatesResponse](#ListCertificatesResponse))**

### ListCertificatesRequest {#ListCertificatesRequest}

Поле | Описание
--- | ---
federation_id | **string**<br>Обязательное поле. Идентификатор федерации для получения списка сертификатов. Чтобы получить идентификатор федерации, используйте запрос [yandex.cloud.organizationmanager.v1.saml.FederationService.List](/docs/organization-manager/api-ref/grpc/federation_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListCertificatesResponse.next_page_token](#ListCertificatesResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListCertificatesResponse.next_page_token](#ListCertificatesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Certificate.name](#Certificate1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Значение длиной от 3 до 63 символов, совпадающее с регулярным выражением `^[a-z][-a-z0-9]{1,61}[a-z0-9]$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListCertificatesResponse {#ListCertificatesResponse}

Поле | Описание
--- | ---
certificates[] | **[Certificate](#Certificate1)**<br>Список сертификатов. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListCertificatesRequest.page_size](#ListCertificatesRequest), используйте `next_page_token` в качестве значения параметра [ListCertificatesRequest.page_token](#ListCertificatesRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Certificate {#Certificate1}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. Идентификатор сертификата. Максимальная длина строки в символах — 50.
federation_id | **string**<br>Обязательное поле. Идентификатор федерации, которой принадлежит сертификат. Максимальная длина строки в символах — 50.
name | **string**<br>Имя сертификата. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание сертификата. Длина описания должна быть от 0 до 256 символов. Максимальная длина строки в символах — 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
data | **string**<br>Обязательное поле. Данные сертификата в формате PEM. Максимальная длина строки в символах — 32000.


## Create {#Create}

Добавляет сертификат для указанной федерации.

**rpc Create ([CreateCertificateRequest](#CreateCertificateRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateCertificateMetadata](#CreateCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](#Certificate2)<br>

### CreateCertificateRequest {#CreateCertificateRequest}

Поле | Описание
--- | ---
federation_id | **string**<br>Идентификатор федерации для добавления нового сертификата. Чтобы получить идентификатор федерации, используйте запрос [yandex.cloud.iam.v1.FederationService.List]. Максимальная длина строки в символах — 50.
name | **string**<br>Имя сертификата. Имя должно быть уникальным в пределах федерации. Значение должно соответствовать регулярному выражению ` [a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Описание сертификата. Максимальная длина строки в символах — 256.
data | **string**<br>Данные сертификата в формате PEM. Максимальная длина строки в символах — 32000.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateCertificateMetadata](#CreateCertificateMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](#Certificate2)>**<br>в случае успешного выполнения операции. 


### CreateCertificateMetadata {#CreateCertificateMetadata}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор добавляемого сертификата. 


### Certificate {#Certificate2}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. Идентификатор сертификата. Максимальная длина строки в символах — 50.
federation_id | **string**<br>Обязательное поле. Идентификатор федерации, которой принадлежит сертификат. Максимальная длина строки в символах — 50.
name | **string**<br>Имя сертификата. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание сертификата. Длина описания должна быть от 0 до 256 символов. Максимальная длина строки в символах — 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
data | **string**<br>Обязательное поле. Данные сертификата в формате PEM. Максимальная длина строки в символах — 32000.


## Update {#Update}

Обновляет указанный сертификат.

**rpc Update ([UpdateCertificateRequest](#UpdateCertificateRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateCertificateMetadata](#UpdateCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Certificate](#Certificate3)<br>

### UpdateCertificateRequest {#UpdateCertificateRequest}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор сертификата для обновления. Чтобы получить идентификатор сертификата, используйте запрос [CertificateService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля указанного сертификата будут обновлены. 
name | **string**<br>Имя сертификата. Имя должно быть уникальным в пределах федерации. Значение должно соответствовать регулярному выражению ` |[a-z]([-a-z0-9]{0,61}[a-z0-9])? `.
description | **string**<br>Описание сертификата. Максимальная длина строки в символах — 256.
data | **string**<br>Данные сертификата в формате PEM. Максимальная длина строки в символах — 32000.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateCertificateMetadata](#UpdateCertificateMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Certificate](#Certificate3)>**<br>в случае успешного выполнения операции. 


### UpdateCertificateMetadata {#UpdateCertificateMetadata}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор обновляемого сертификата. 


### Certificate {#Certificate3}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. Идентификатор сертификата. Максимальная длина строки в символах — 50.
federation_id | **string**<br>Обязательное поле. Идентификатор федерации, которой принадлежит сертификат. Максимальная длина строки в символах — 50.
name | **string**<br>Имя сертификата. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание сертификата. Длина описания должна быть от 0 до 256 символов. Максимальная длина строки в символах — 256.
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
data | **string**<br>Обязательное поле. Данные сертификата в формате PEM. Максимальная длина строки в символах — 32000.


## Delete {#Delete}

Удаляет указанный сертификат.

**rpc Delete ([DeleteCertificateRequest](#DeleteCertificateRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteCertificateMetadata](#DeleteCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteCertificateRequest {#DeleteCertificateRequest}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор сертификата, который следует удалить. Чтобы получить идентификатор сертификата, используйте запрос [CertificateService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteCertificateMetadata](#DeleteCertificateMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteCertificateMetadata {#DeleteCertificateMetadata}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор удаляемого сертификата. 


## ListOperations {#ListOperations}

Перечисляет операции для указанного сертификата.

**rpc ListOperations ([ListCertificateOperationsRequest](#ListCertificateOperationsRequest)) returns ([ListCertificateOperationsResponse](#ListCertificateOperationsResponse))**

### ListCertificateOperationsRequest {#ListCertificateOperationsRequest}

Поле | Описание
--- | ---
certificate_id | **string**<br>Идентификатор сертификата, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListCertificateOperationsResponse.next_page_token](#ListCertificateOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListCertificateOperationsResponse.next_page_token](#ListCertificateOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListCertificateOperationsResponse {#ListCertificateOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанного сертификата. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListCertificateOperationsRequest.page_size](#ListCertificateOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListCertificateOperationsRequest.page_token](#ListCertificateOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation3}

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


