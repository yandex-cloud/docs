---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# RegistryService

Набор методов для управления ресурсами Registry.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Registry. |
| [List](#List) | Возвращает список доступных ресурсов Registry в указанном каталоге. |
| [Create](#Create) | Создает реестр в указанном каталоге. |
| [Update](#Update) | Обновляет указанный реестр. |
| [Delete](#Delete) | Удаляет указанный реестр. |

## Вызовы RegistryService {#calls}

## Get {#Get}

Возвращает указанный ресурс Registry. <br>Чтобы получить список доступных ресурсов Registry, используйте запрос [List](#List).

**rpc Get ([GetRegistryRequest](#GetRegistryRequest)) returns ([Registry](#Registry))**

### GetRegistryRequest {#GetRegistryRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Registry. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](#List). Максимальная длина строки в символах — 50.


### Registry {#Registry}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор реестра. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит реестр. 
name | **string**<br>Название реестра. 
status | enum **Status**<br>Только для вывода. Статус реестра. <ul><li>`CREATING`: Реестр создается.</li><li>`ACTIVE`: Реестр готов к использованию.</li><li>`DELETING`: Реестр удаляется.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 


## List {#List}

Возвращает список доступных ресурсов Registry в указанном каталоге.

**rpc List ([ListRegistriesRequest](#ListRegistriesRequest)) returns ([ListRegistriesResponse](#ListRegistriesResponse))**

### ListRegistriesRequest {#ListRegistriesRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка реестров. <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListRegistriesResponse.next_page_token](#ListRegistriesResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListRegistriesResponse.next_page_token](#ListRegistriesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Registry.name](#Registry1). </li><li>Оператор. Может быть `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение или список значений для сравнения со значениями фильтра.</li></ol> Максимальная длина строки в символах — 1000.


### ListRegistriesResponse {#ListRegistriesResponse}

Поле | Описание
--- | ---
registries[] | **[Registry](#Registry1)**<br>Список ресурсов Registry. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListRegistriesRequest.page_size](#ListRegistriesRequest), используйте `next_page_token` в качестве значения параметра [ListRegistriesRequest.page_token](#ListRegistriesRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Registry {#Registry1}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор реестра. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит реестр. 
name | **string**<br>Название реестра. 
status | enum **Status**<br>Только для вывода. Статус реестра. <ul><li>`CREATING`: Реестр создается.</li><li>`ACTIVE`: Реестр готов к использованию.</li><li>`DELETING`: Реестр удаляется.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 


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
name | **string**<br>Название реестра. <br>Может быть только один реестр в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


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
id | **string**<br>Только для вывода. Идентификатор реестра. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит реестр. 
name | **string**<br>Название реестра. 
status | enum **Status**<br>Только для вывода. Статус реестра. <ul><li>`CREATING`: Реестр создается.</li><li>`ACTIVE`: Реестр готов к использованию.</li><li>`DELETING`: Реестр удаляется.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 


## Update {#Update}

Обновляет указанный реестр.

**rpc Update ([UpdateRegistryRequest](#UpdateRegistryRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateRegistryMetadata](#UpdateRegistryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Registry](#Registry3)<br>

### UpdateRegistryRequest {#UpdateRegistryRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор изменяемого ресурса Registry. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса Registry будут обновлены. 
name | **string**<br>Название реестра. <br>Может быть только один реестр в каталоге. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. <br>Существующий набор `labels` полностью перезаписывается набором, переданным в запросе. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


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
registry_id | **string**<br>Идентификатор изменяемого ресурса Registry. 


### Registry {#Registry3}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор реестра. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит реестр. 
name | **string**<br>Название реестра. 
status | enum **Status**<br>Только для вывода. Статус реестра. <ul><li>`CREATING`: Реестр создается.</li><li>`ACTIVE`: Реестр готов к использованию.</li><li>`DELETING`: Реестр удаляется.</li><ul/>
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 метки на ресурс. 


## Delete {#Delete}

Удаляет указанный реестр.

**rpc Delete ([DeleteRegistryRequest](#DeleteRegistryRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteRegistryMetadata](#DeleteRegistryMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteRegistryRequest {#DeleteRegistryRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Обязательное поле. Идентификатор удаляемого реестра. Максимальная длина строки в символах — 50.


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


