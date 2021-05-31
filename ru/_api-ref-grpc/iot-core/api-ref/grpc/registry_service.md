---
editable: false
---

# RegistryService

Набор методов для управления реестрами.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный реестр. |
| [List](#List) | Возвращает список реестров в указанном каталоге. |
| [Create](#Create) | Создает реестр в указанном каталоге. |
| [Update](#Update) | Обновляет указанный реестр. |
| [Delete](#Delete) | Удаляет указанный реестр. |
| [ListCertificates](#ListCertificates) | Возвращает список сертификатов реестра для указанного реестра. |
| [AddCertificate](#AddCertificate) | Добавляет сертификат. |
| [DeleteCertificate](#DeleteCertificate) | Удаляет указанный сертификат реестра. |
| [ListPasswords](#ListPasswords) | Возращает список паролей для указанного реестра. |
| [AddPassword](#AddPassword) | Добавляет пароль для указанного реестра. |
| [DeletePassword](#DeletePassword) | Удаляет указанный пароль. |
| [ListDeviceTopicAliases](#ListDeviceTopicAliases) | Возвращает список алиасов устройств для указанного реестра. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанного реестра. |

## Вызовы RegistryService {#calls}

## Get {#Get}

Возвращает указанный реестр. <br>Чтобы получить список доступных реестров, используйте запрос [List](#List).

**rpc Get ([GetRegistryRequest](#GetRegistryRequest)) returns ([Registry](#Registry))**

### GetRegistryRequest {#GetRegistryRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор возвращаемого реестра. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](#List). Максимальная длина строки в символах — 50.


### Registry {#Registry}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор реестра. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит реестр. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Название реестра. Имя уникально в рамках каталога. 
description | **string**<br>Описание реестра. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки группы размещения в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус реестра. <ul><li>`CREATING`: Реестр создается.</li><li>`ACTIVE`: Реестр готов к использованию.</li><li>`DELETING`: Реестр удаляется.</li><ul/>
log_group_id | **string**<br>Идентификатор группы журналов для указанного реестра. 


## List {#List}

Возвращает список реестров в указанном каталоге.

**rpc List ([ListRegistriesRequest](#ListRegistriesRequest)) returns ([ListRegistriesResponse](#ListRegistriesResponse))**

### ListRegistriesRequest {#ListRegistriesRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка реестров. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListRegistriesResponse.next_page_token](#ListRegistriesResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListRegistriesResponse.next_page_token](#ListRegistriesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListRegistriesResponse {#ListRegistriesResponse}

Поле | Описание
--- | ---
registries[] | **[Registry](#Registry1)**<br>Список реестров. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListRegistriesRequest.page_size](#ListRegistriesRequest), используйте `next_page_token` в качестве значения параметра [ListRegistriesRequest.page_token](#ListRegistriesRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Registry {#Registry1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор реестра. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит реестр. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Название реестра. Имя уникально в рамках каталога. 
description | **string**<br>Описание реестра. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки группы размещения в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус реестра. <ul><li>`CREATING`: Реестр создается.</li><li>`ACTIVE`: Реестр готов к использованию.</li><li>`DELETING`: Реестр удаляется.</li><ul/>
log_group_id | **string**<br>Идентификатор группы журналов для указанного реестра. 


## Create {#Create}

Создает реестр в указанном каталоге.

**rpc Create ([CreateRegistryRequest](#CreateRegistryRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateRegistryMetadata](#CreateRegistryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Registry](#Registry2)<br>

### CreateRegistryRequest {#CreateRegistryRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается реестр. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Обязательное поле. Название реестра. Имя должно быть уникальным в рамках каталога. Максимальная длина строки в символах — 50. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание реестра. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки группы размещения в формате `key:value`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
certificates[] | **[Certificate](#Certificate)**<br>Сертификат реестра. 
password | **string**<br>Пароль реестра. <br>Пароль должен содержать не менее трех категорий символов: строчные латинские буквы, прописные латинские буквы, цифры, специальные символы. 


### Certificate {#Certificate}

Поле | Описание
--- | ---
certificate_data | **string**<br>Публичная часть сертификата реестра. 


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateRegistryMetadata](#CreateRegistryMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Registry](#Registry2)>**<br>в случае успешного выполнения операции. 


### CreateRegistryMetadata {#CreateRegistryMetadata}

Поле | Описание
--- | ---
registry_id | **string**<br>Идентификатор создаваемого реестра. 


### Registry {#Registry2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор реестра. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит реестр. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Название реестра. Имя уникально в рамках каталога. 
description | **string**<br>Описание реестра. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки группы размещения в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус реестра. <ul><li>`CREATING`: Реестр создается.</li><li>`ACTIVE`: Реестр готов к использованию.</li><li>`DELETING`: Реестр удаляется.</li><ul/>
log_group_id | **string**<br>Идентификатор группы журналов для указанного реестра. 


## Update {#Update}

Обновляет указанный реестр.

**rpc Update ([UpdateRegistryRequest](#UpdateRegistryRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRegistryMetadata](#UpdateRegistryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Registry](#Registry3)<br>

### UpdateRegistryRequest {#UpdateRegistryRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра для обновления. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля реестра будут обновлены. 
name | **string**<br>Название реестра. Имя должно быть уникальным в рамках каталога. Максимальная длина строки в символах — 50. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_-]* `.
description | **string**<br>Описание реестра. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки группы размещения в формате `key:value`. <br>Существующий набор `labels` полностью перезаписывается набором, переданным в запросе. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateRegistryMetadata](#UpdateRegistryMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Registry](#Registry3)>**<br>в случае успешного выполнения операции. 


### UpdateRegistryMetadata {#UpdateRegistryMetadata}

Поле | Описание
--- | ---
registry_id | **string**<br>Идентификатор обновляемого реестра. 


### Registry {#Registry3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор реестра. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит реестр. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 
name | **string**<br>Название реестра. Имя уникально в рамках каталога. 
description | **string**<br>Описание реестра. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки группы размещения в формате `key:value`. Максимум 64 метки на ресурс. 
status | enum **Status**<br>Статус реестра. <ul><li>`CREATING`: Реестр создается.</li><li>`ACTIVE`: Реестр готов к использованию.</li><li>`DELETING`: Реестр удаляется.</li><ul/>
log_group_id | **string**<br>Идентификатор группы журналов для указанного реестра. 


## Delete {#Delete}

Удаляет указанный реестр.

**rpc Delete ([DeleteRegistryRequest](#DeleteRegistryRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteRegistryMetadata](#DeleteRegistryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteRegistryRequest {#DeleteRegistryRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор удаляемого реестра. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteRegistryMetadata](#DeleteRegistryMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteRegistryMetadata {#DeleteRegistryMetadata}

Поле | Описание
--- | ---
registry_id | **string**<br>Идентификатор удаляемого реестра. 


## ListCertificates {#ListCertificates}

Возвращает список сертификатов реестра для указанного реестра.

**rpc ListCertificates ([ListRegistryCertificatesRequest](#ListRegistryCertificatesRequest)) returns ([ListRegistryCertificatesResponse](#ListRegistryCertificatesResponse))**

### ListRegistryCertificatesRequest {#ListRegistryCertificatesRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра для получения списка сертификатов. Максимальная длина строки в символах — 50.


### ListRegistryCertificatesResponse {#ListRegistryCertificatesResponse}

Поле | Описание
--- | ---
certificates[] | **[RegistryCertificate](#RegistryCertificate)**<br>Список сертификатов для указанного реестра. 


### RegistryCertificate {#RegistryCertificate}

Поле | Описание
--- | ---
registry_id | **string**<br>Идентификатор реестра, к которому принадлежит сертификат. 
fingerprint | **string**<br>SHA256-хэш сертификата. 
certificate_data | **string**<br>Публичная часть сертификата устройства. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 


## AddCertificate {#AddCertificate}

Добавляет сертификат.

**rpc AddCertificate ([AddRegistryCertificateRequest](#AddRegistryCertificateRequest)) returns ([operation.Operation](#Operation3))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddRegistryCertificateMetadata](#AddRegistryCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RegistryCertificate](#RegistryCertificate1)<br>

### AddRegistryCertificateRequest {#AddRegistryCertificateRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра, для которого добавляется сертификат. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](#List). Максимальная длина строки в символах — 50.
certificate_data | **string**<br>Публичная часть добавляемого сертификата. 


### Operation {#Operation3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddRegistryCertificateMetadata](#AddRegistryCertificateMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RegistryCertificate](#RegistryCertificate1)>**<br>в случае успешного выполнения операции. 


### AddRegistryCertificateMetadata {#AddRegistryCertificateMetadata}

Поле | Описание
--- | ---
registry_id | **string**<br>Идентификатор добавляемого сертификата реестра. 
fingerprint | **string**<br>Цифровой отпечаток добавляемого сертификата. 


### RegistryCertificate {#RegistryCertificate1}

Поле | Описание
--- | ---
registry_id | **string**<br>Идентификатор реестра, к которому принадлежит сертификат. 
fingerprint | **string**<br>SHA256-хэш сертификата. 
certificate_data | **string**<br>Публичная часть сертификата устройства. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 


## DeleteCertificate {#DeleteCertificate}

Удаляет указанный сертификат реестра.

**rpc DeleteCertificate ([DeleteRegistryCertificateRequest](#DeleteRegistryCertificateRequest)) returns ([operation.Operation](#Operation4))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteRegistryCertificateMetadata](#DeleteRegistryCertificateMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteRegistryCertificateRequest {#DeleteRegistryCertificateRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра для удаления сертификата. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](#List). Максимальная длина строки в символах — 50.
fingerprint | **string**<br>Обязательное поле. Цифровой отпечаток удаляемого сертификата. Максимальная длина строки в символах — 50.


### Operation {#Operation4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteRegistryCertificateMetadata](#DeleteRegistryCertificateMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteRegistryCertificateMetadata {#DeleteRegistryCertificateMetadata}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра, для которого удаляется сертификат. Максимальная длина строки в символах — 50.
fingerprint | **string**<br>Обязательное поле. Цифровой отпечаток сертификата для удаления. Максимальная длина строки в символах — 50.


## ListPasswords {#ListPasswords}

Возращает список паролей для указанного реестра.

**rpc ListPasswords ([ListRegistryPasswordsRequest](#ListRegistryPasswordsRequest)) returns ([ListRegistryPasswordsResponse](#ListRegistryPasswordsResponse))**

### ListRegistryPasswordsRequest {#ListRegistryPasswordsRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра для получения списка паролей. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](#List). Максимальная длина строки в символах — 50.


### ListRegistryPasswordsResponse {#ListRegistryPasswordsResponse}

Поле | Описание
--- | ---
passwords[] | **[RegistryPassword](#RegistryPassword)**<br>Возращает список паролей для указанного реестра. 


### RegistryPassword {#RegistryPassword}

Поле | Описание
--- | ---
registry_id | **string**<br>Идентификатор реестра, к которому принадлежит пароль. 
id | **string**<br>Идентификатор пароля. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 


## AddPassword {#AddPassword}

Добавляет пароль для указанного реестра.

**rpc AddPassword ([AddRegistryPasswordRequest](#AddRegistryPasswordRequest)) returns ([operation.Operation](#Operation5))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[AddRegistryPasswordMetadata](#AddRegistryPasswordMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[RegistryPassword](#RegistryPassword1)<br>

### AddRegistryPasswordRequest {#AddRegistryPasswordRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра для добавления пароля. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](#List). Максимальная длина строки в символах — 50.
password | **string**<br>Пароли для реестра. <br>Пароль должен содержать не менее трех категорий символов: строчные латинские буквы, прописные латинские буквы, цифры, специальные символы. Минимальная длина строки в символах — 14.


### Operation {#Operation5}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[AddRegistryPasswordMetadata](#AddRegistryPasswordMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[RegistryPassword](#RegistryPassword1)>**<br>в случае успешного выполнения операции. 


### AddRegistryPasswordMetadata {#AddRegistryPasswordMetadata}

Поле | Описание
--- | ---
registry_id | **string**<br>Идентификатор реестра, для которого добавляется пароль. 
password_id | **string**<br>Идентификатор добавляемого пароля. 


### RegistryPassword {#RegistryPassword1}

Поле | Описание
--- | ---
registry_id | **string**<br>Идентификатор реестра, к которому принадлежит пароль. 
id | **string**<br>Идентификатор пароля. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания. 


## DeletePassword {#DeletePassword}

Удаляет указанный пароль.

**rpc DeletePassword ([DeleteRegistryPasswordRequest](#DeleteRegistryPasswordRequest)) returns ([operation.Operation](#Operation6))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteRegistryPasswordMetadata](#DeleteRegistryPasswordMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteRegistryPasswordRequest {#DeleteRegistryPasswordRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра для удаления пароля. <br>Чтобы получить идентификатор реестра, используйте запрос [DeviceService.List](./device_service#List). Максимальная длина строки в символах — 50.
password_id | **string**<br>Обязательное поле. Идентификатор пароля для удаления. <br>Для получения идентификатора пароля используйте запрос [RegistryService.ListPasswords](#ListPasswords). Максимальная длина строки в символах — 50.


### Operation {#Operation6}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteRegistryPasswordMetadata](#DeleteRegistryPasswordMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteRegistryPasswordMetadata {#DeleteRegistryPasswordMetadata}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра, для которого удаляется пароль. Максимальная длина строки в символах — 50.
password_id | **string**<br>Обязательное поле. Идентификатор пароля для удаления. <br>Для получения идентификатора пароля используйте запрос [RegistryService.ListPasswords](#ListPasswords). Максимальная длина строки в символах — 50.


## ListDeviceTopicAliases {#ListDeviceTopicAliases}

Возвращает список алиасов устройств для указанного реестра.

**rpc ListDeviceTopicAliases ([ListDeviceTopicAliasesRequest](#ListDeviceTopicAliasesRequest)) returns ([ListDeviceTopicAliasesResponse](#ListDeviceTopicAliasesResponse))**

### ListDeviceTopicAliasesRequest {#ListDeviceTopicAliasesRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра для получения списка алиасов для топика устройства. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListDeviceTopicAliasesResponse.next_page_token](#ListDeviceTopicAliasesResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListDeviceTopicAliasesResponse.next_page_token](#ListDeviceTopicAliasesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListDeviceTopicAliasesResponse {#ListDeviceTopicAliasesResponse}

Поле | Описание
--- | ---
aliases[] | **[DeviceAlias](#DeviceAlias)**<br>Список алиасов устройств для указанного реестра. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListDeviceTopicAliasesRequest.page_size](#ListDeviceTopicAliasesRequest), используйте `next_page_token` в качестве значения параметра [ListDeviceTopicAliasesRequest.page_token](#ListDeviceTopicAliasesRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### DeviceAlias {#DeviceAlias}

Поле | Описание
--- | ---
device_id | **string**<br>Идентификатор устройства, которому принадлежит алиас. 
topic_prefix | **string**<br>Префикс алиаса стандартного топика устройства, например `$devices/abcdef`. 
alias | **string**<br>Алиас топика устройства. 


## ListOperations {#ListOperations}

Возвращает список операций для указанного реестра.

**rpc ListOperations ([ListRegistryOperationsRequest](#ListRegistryOperationsRequest)) returns ([ListRegistryOperationsResponse](#ListRegistryOperationsResponse))**

### ListRegistryOperationsRequest {#ListRegistryOperationsRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор реестра для получения списка операций. 
page_size | **int64**<br>Максимальное число возвращаемых результатов на странице. Если количество результатов больше чем `page_size`, сервис вернет значение [ListRegistryOperationsResponse.next_page_token](#ListRegistryOperationsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListRegistryOperationsResponse.next_page_token](#ListRegistryOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. В настоящее время фильтрация осуществляется только по полю [Registry.name](#Registry4). Максимальная длина строки в символах — 1000.


### ListRegistryOperationsResponse {#ListRegistryOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation7)**<br>Список операций для указанного реестра. 
next_page_token | **string**<br>Токен для получения следующей страницы списка. Если количество результатов больше чем [ListRegistryOperationsRequest.page_size](#ListRegistryOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListRegistryOperationsRequest.page_token](#ListRegistryOperationsRequest) в следующем запросе списка ресурсов. <br>Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Operation {#Operation7}

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


