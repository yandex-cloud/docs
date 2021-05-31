---
editable: false
---

# SnapshotService

Набор методов для управления ресурсами Snapshot.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Snapshot. |
| [List](#List) | Возвращает список доступных ресурсов Snapshot в указанном каталоге. |
| [Create](#Create) | Создает снимок указанного диска. |
| [Update](#Update) | Изменяет указанный снимок. |
| [Delete](#Delete) | Удаляет указанный снимок. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанного снимка. |

## Вызовы SnapshotService {#calls}

## Get {#Get}

Возвращает указанный ресурс Snapshot. <br>Чтобы получить список доступных ресурсов Snapshot, используйте запрос [List](#List).

**rpc Get ([GetSnapshotRequest](#GetSnapshotRequest)) returns ([Snapshot](#Snapshot))**

### GetSnapshotRequest {#GetSnapshotRequest}

Поле | Описание
--- | ---
snapshot_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Snapshot. Чтобы получить идентификатор снимка, используйте запрос [SnapshotService.List](#List). Максимальная длина строки в символах — 50.


### Snapshot {#Snapshot}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор снимка. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит снимок. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя снимка. Длина 1-63 символов. 
description | **string**<br>Описание снимка. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
storage_size | **int64**<br>Размер снимка, указанный в байтах. 
disk_size | **int64**<br>Размер диска при создании снимка указывается в байтах. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус снимка. <ul><li>`CREATING`: Снимок создается.</li><li>`READY`: Снимок готов к использованию.</li><li>`ERROR`: Со снимком произошла ошибка, блокирующая работу.</li><li>`DELETING`: Снимок удаляется.</li><ul/>
source_disk_id | **string**<br>Идентификатор диска, используемого для создания снимка. 


## List {#List}

Возвращает список доступных ресурсов Snapshot в указанном каталоге.

**rpc List ([ListSnapshotsRequest](#ListSnapshotsRequest)) returns ([ListSnapshotsResponse](#ListSnapshotsResponse))**

### ListSnapshotsRequest {#ListSnapshotsRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка снимков. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListSnapshotsResponse.next_page_token](#ListSnapshotsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListSnapshotsResponse.next_page_token](#ListSnapshotsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Snapshot.name](#Snapshot1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Должен содержать от 3 до 63 символов и соответствовать регулярному выражению `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListSnapshotsResponse {#ListSnapshotsResponse}

Поле | Описание
--- | ---
snapshots[] | **[Snapshot](#Snapshot1)**<br>Список снимков. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListSnapshotsRequest.page_size](#ListSnapshotsRequest), используйте `next_page_token` в качестве значения параметра [ListSnapshotsRequest.page_token](#ListSnapshotsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Snapshot {#Snapshot1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор снимка. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит снимок. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя снимка. Длина 1-63 символов. 
description | **string**<br>Описание снимка. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
storage_size | **int64**<br>Размер снимка, указанный в байтах. 
disk_size | **int64**<br>Размер диска при создании снимка указывается в байтах. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус снимка. <ul><li>`CREATING`: Снимок создается.</li><li>`READY`: Снимок готов к использованию.</li><li>`ERROR`: Со снимком произошла ошибка, блокирующая работу.</li><li>`DELETING`: Снимок удаляется.</li><ul/>
source_disk_id | **string**<br>Идентификатор диска, используемого для создания снимка. 


## Create {#Create}

Создает снимок указанного диска.

**rpc Create ([CreateSnapshotRequest](#CreateSnapshotRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateSnapshotMetadata](#CreateSnapshotMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Snapshot](#Snapshot2)<br>

### CreateSnapshotRequest {#CreateSnapshotRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается снимок. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
disk_id | **string**<br>Обязательное поле. Идентификатор диска для создания снимка. Чтобы получить идентификатор диска, используйте запрос [yandex.cloud.compute.v1.DiskService.List](/docs/compute/api-ref/grpc/disk_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Имя снимка. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание снимка. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateSnapshotMetadata](#CreateSnapshotMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Snapshot](#Snapshot2)>**<br>в случае успешного выполнения операции. 


### CreateSnapshotMetadata {#CreateSnapshotMetadata}

Поле | Описание
--- | ---
snapshot_id | **string**<br>Идентификатор создаваемого снимка. 
disk_id | **string**<br>Идентификатор диска, используемого для создания снимка. 


### Snapshot {#Snapshot2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор снимка. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит снимок. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя снимка. Длина 1-63 символов. 
description | **string**<br>Описание снимка. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
storage_size | **int64**<br>Размер снимка, указанный в байтах. 
disk_size | **int64**<br>Размер диска при создании снимка указывается в байтах. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус снимка. <ul><li>`CREATING`: Снимок создается.</li><li>`READY`: Снимок готов к использованию.</li><li>`ERROR`: Со снимком произошла ошибка, блокирующая работу.</li><li>`DELETING`: Снимок удаляется.</li><ul/>
source_disk_id | **string**<br>Идентификатор диска, используемого для создания снимка. 


## Update {#Update}

Изменяет указанный снимок. <br>Значения опущенных параметров не изменяются.

**rpc Update ([UpdateSnapshotRequest](#UpdateSnapshotRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateSnapshotMetadata](#UpdateSnapshotMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Snapshot](#Snapshot3)<br>

### UpdateSnapshotRequest {#UpdateSnapshotRequest}

Поле | Описание
--- | ---
snapshot_id | **string**<br>Обязательное поле. Идентификатор снимка для обновления. Чтобы получить идентификатор снимка, используйте запрос [SnapshotService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса Snapshot будут обновлены. 
name | **string**<br>Имя снимка. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание снимка. Максимальная длина строки в символах — 256.
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
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateSnapshotMetadata](#UpdateSnapshotMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Snapshot](#Snapshot3)>**<br>в случае успешного выполнения операции. 


### UpdateSnapshotMetadata {#UpdateSnapshotMetadata}

Поле | Описание
--- | ---
snapshot_id | **string**<br>Идентификатор изменяемого ресурса Snapshot. 


### Snapshot {#Snapshot3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор снимка. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит снимок. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя снимка. Длина 1-63 символов. 
description | **string**<br>Описание снимка. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
storage_size | **int64**<br>Размер снимка, указанный в байтах. 
disk_size | **int64**<br>Размер диска при создании снимка указывается в байтах. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус снимка. <ul><li>`CREATING`: Снимок создается.</li><li>`READY`: Снимок готов к использованию.</li><li>`ERROR`: Со снимком произошла ошибка, блокирующая работу.</li><li>`DELETING`: Снимок удаляется.</li><ul/>
source_disk_id | **string**<br>Идентификатор диска, используемого для создания снимка. 


## Delete {#Delete}

Удаляет указанный снимок. <br>Удаление снимка — необратимая операция, восстановить удаленный снимок невозможно.

**rpc Delete ([DeleteSnapshotRequest](#DeleteSnapshotRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteSnapshotMetadata](#DeleteSnapshotMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteSnapshotRequest {#DeleteSnapshotRequest}

Поле | Описание
--- | ---
snapshot_id | **string**<br>Обязательное поле. Идентификатор удаляемого снимка. Чтобы получить идентификатор снимка, используйте запрос [SnapshotService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteSnapshotMetadata](#DeleteSnapshotMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteSnapshotMetadata {#DeleteSnapshotMetadata}

Поле | Описание
--- | ---
snapshot_id | **string**<br>Идентификатор снимка, который удаляется. 


## ListOperations {#ListOperations}

Возвращает список операций для указанного снимка.

**rpc ListOperations ([ListSnapshotOperationsRequest](#ListSnapshotOperationsRequest)) returns ([ListSnapshotOperationsResponse](#ListSnapshotOperationsResponse))**

### ListSnapshotOperationsRequest {#ListSnapshotOperationsRequest}

Поле | Описание
--- | ---
snapshot_id | **string**<br>Обязательное поле. Идентификатор ресурса Snapshot, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListSnapshotOperationsResponse.next_page_token](#ListSnapshotOperationsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListSnapshotOperationsResponse.next_page_token](#ListSnapshotOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListSnapshotOperationsResponse {#ListSnapshotOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанного снимка. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListSnapshotOperationsRequest.page_size](#ListSnapshotOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListSnapshotOperationsRequest.page_token](#ListSnapshotOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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


