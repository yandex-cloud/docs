---
editable: false
---

# DiskService

Набор методов для управления ресурсами Disk.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Disk. |
| [List](#List) | Возвращает список доступных ресурсов Disk в указанном каталоге. |
| [Create](#Create) | Создает диск в указанном каталоге. |
| [Update](#Update) | Изменяет указанный диск. |
| [Delete](#Delete) | Удаляет указанный диск. |
| [ListOperations](#ListOperations) | Возвращает список операций для указанного диска. |

## Вызовы DiskService {#calls}

## Get {#Get}

Возвращает указанный ресурс Disk. <br>Чтобы получить список доступных ресурсов Disk, используйте запрос [List](#List).

**rpc Get ([GetDiskRequest](#GetDiskRequest)) returns ([Disk](#Disk))**

### GetDiskRequest {#GetDiskRequest}

Поле | Описание
--- | ---
disk_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Disk. Чтобы получить идентификатор диска, используйте запрос [DiskService.List](#List). Максимальная длина строки в символах — 50.


### Disk {#Disk}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор типа диска. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит диск. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя диска. Длина 1-63 символов. 
description | **string**<br>Описание диска. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
type_id | **string**<br>Идентификатор типа диска. 
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. 
size | **int64**<br>Размер диска в байтах. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус диска. <ul><li>`CREATING`: Диск создается.</li><li>`READY`: Диск готов к использованию.</li><li>`ERROR`: С диском произошла ошибка, блокирующая работу.</li><li>`DELETING`: Диск удаляется.</li><ul/>
source | **oneof:** `source_image_id` или `source_snapshot_id`<br>
&nbsp;&nbsp;source_image_id | **string**<br>Идентификатор образа, из которого был создан диск. 
&nbsp;&nbsp;source_snapshot_id | **string**<br>Идентификатор снимка, из которого был создан диск. 
instance_ids[] | **string**<br>Массив виртуальных машин, к которым подключен диск. 


## List {#List}

Возвращает список доступных ресурсов Disk в указанном каталоге.

**rpc List ([ListDisksRequest](#ListDisksRequest)) returns ([ListDisksResponse](#ListDisksResponse))**

### ListDisksRequest {#ListDisksRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка дисков. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListDisksResponse.next_page_token](#ListDisksResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListDisksResponse.next_page_token](#ListDisksResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Disk.name](#Disk1). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Должен содержать от 3 до 63 символов и соответствовать регулярному выражению `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListDisksResponse {#ListDisksResponse}

Поле | Описание
--- | ---
disks[] | **[Disk](#Disk1)**<br>Список ресурсов Disk. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListDisksRequest.page_size](#ListDisksRequest), используйте `next_page_token` в качестве значения параметра [ListDisksRequest.page_token](#ListDisksRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Disk {#Disk1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор типа диска. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит диск. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя диска. Длина 1-63 символов. 
description | **string**<br>Описание диска. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
type_id | **string**<br>Идентификатор типа диска. 
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. 
size | **int64**<br>Размер диска в байтах. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус диска. <ul><li>`CREATING`: Диск создается.</li><li>`READY`: Диск готов к использованию.</li><li>`ERROR`: С диском произошла ошибка, блокирующая работу.</li><li>`DELETING`: Диск удаляется.</li><ul/>
source | **oneof:** `source_image_id` или `source_snapshot_id`<br>
&nbsp;&nbsp;source_image_id | **string**<br>Идентификатор образа, из которого был создан диск. 
&nbsp;&nbsp;source_snapshot_id | **string**<br>Идентификатор снимка, из которого был создан диск. 
instance_ids[] | **string**<br>Массив виртуальных машин, к которым подключен диск. 


## Create {#Create}

Создает диск в указанном каталоге. <br>Вы можете создать пустой диск или восстановить его из снимка или образа. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.

**rpc Create ([CreateDiskRequest](#CreateDiskRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateDiskMetadata](#CreateDiskMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Disk](#Disk2)<br>

### CreateDiskRequest {#CreateDiskRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога, в котором создается диск. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Имя диска. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
type_id | **string**<br>Идентификатор типа диска. Чтобы получить список доступных типов дисков, используйте запрос [yandex.cloud.compute.v1.DiskTypeService.List](/docs/compute/api-ref/grpc/disk_type_service#List). Максимальная длина строки в символах — 50.
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности, в которой находится хост. Чтобы получить список доступных зон, используйте запрос [yandex.cloud.compute.v1.ZoneService.List](/docs/compute/api-ref/grpc/zone_service#List). Максимальная длина строки в символах — 50.
size | **int64**<br>Обязательное поле. Размер диска в байтах. Если диск был создан из образа, это значение должно быть больше, чем значение `yandex.cloud.compute.v1.Image.min_disk_size`. Допустимые значения — от 4194304 до 4398046511104 включительно.
source | **oneof:** `image_id` или `snapshot_id`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа для создания диска. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка для восстановления диска. Максимальная длина строки в символах — 50.


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateDiskMetadata](#CreateDiskMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Disk](#Disk2)>**<br>в случае успешного выполнения операции. 


### CreateDiskMetadata {#CreateDiskMetadata}

Поле | Описание
--- | ---
disk_id | **string**<br>Идентификатор создаваемого диска. 


### Disk {#Disk2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор типа диска. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит диск. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя диска. Длина 1-63 символов. 
description | **string**<br>Описание диска. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
type_id | **string**<br>Идентификатор типа диска. 
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. 
size | **int64**<br>Размер диска в байтах. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус диска. <ul><li>`CREATING`: Диск создается.</li><li>`READY`: Диск готов к использованию.</li><li>`ERROR`: С диском произошла ошибка, блокирующая работу.</li><li>`DELETING`: Диск удаляется.</li><ul/>
source | **oneof:** `source_image_id` или `source_snapshot_id`<br>
&nbsp;&nbsp;source_image_id | **string**<br>Идентификатор образа, из которого был создан диск. 
&nbsp;&nbsp;source_snapshot_id | **string**<br>Идентификатор снимка, из которого был создан диск. 
instance_ids[] | **string**<br>Массив виртуальных машин, к которым подключен диск. 


## Update {#Update}

Изменяет указанный диск.

**rpc Update ([UpdateDiskRequest](#UpdateDiskRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateDiskMetadata](#UpdateDiskMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Disk](#Disk3)<br>

### UpdateDiskRequest {#UpdateDiskRequest}

Поле | Описание
--- | ---
disk_id | **string**<br>Обязательное поле. Идентификатор изменяемого ресурса Disk. Чтобы получить идентификатор диска, используйте запрос [DiskService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса Disk будут обновлены. 
name | **string**<br>Имя диска. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание диска. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. <br>Существующий набор `labels` полностью перезаписывается набором, переданным в запросе. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
size | **int64**<br>Размер диска в байтах. Допустимые значения — от 4194304 до 4398046511104 включительно.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateDiskMetadata](#UpdateDiskMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Disk](#Disk3)>**<br>в случае успешного выполнения операции. 


### UpdateDiskMetadata {#UpdateDiskMetadata}

Поле | Описание
--- | ---
disk_id | **string**<br>Идентификатор изменяемого ресурса Disk. 


### Disk {#Disk3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор типа диска. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит диск. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя диска. Длина 1-63 символов. 
description | **string**<br>Описание диска. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `key:value`. Максимум 64 на ресурс. 
type_id | **string**<br>Идентификатор типа диска. 
zone_id | **string**<br>Идентификатор зоны доступности, в которой находится хост. 
size | **int64**<br>Размер диска в байтах. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус диска. <ul><li>`CREATING`: Диск создается.</li><li>`READY`: Диск готов к использованию.</li><li>`ERROR`: С диском произошла ошибка, блокирующая работу.</li><li>`DELETING`: Диск удаляется.</li><ul/>
source | **oneof:** `source_image_id` или `source_snapshot_id`<br>
&nbsp;&nbsp;source_image_id | **string**<br>Идентификатор образа, из которого был создан диск. 
&nbsp;&nbsp;source_snapshot_id | **string**<br>Идентификатор снимка, из которого был создан диск. 
instance_ids[] | **string**<br>Массив виртуальных машин, к которым подключен диск. 


## Delete {#Delete}

Удаляет указанный диск. <br>Удаление снимка — необратимая операция, восстановить удаленный снимок невозможно. Однако при удалении диска не удаляются снимки или образы, ранее созданные из этого диска. Снимки и образы необходимо удалять отдельно. <br>Невозможно удалить диск, подключенный к виртуальной машине.

**rpc Delete ([DeleteDiskRequest](#DeleteDiskRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteDiskMetadata](#DeleteDiskMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteDiskRequest {#DeleteDiskRequest}

Поле | Описание
--- | ---
disk_id | **string**<br>Обязательное поле. Идентификатор удаляемого диска. Чтобы получить идентификатор диска, используйте запрос [DiskService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteDiskMetadata](#DeleteDiskMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteDiskMetadata {#DeleteDiskMetadata}

Поле | Описание
--- | ---
disk_id | **string**<br>Идентификатор удаляемого диска. 


## ListOperations {#ListOperations}

Возвращает список операций для указанного диска.

**rpc ListOperations ([ListDiskOperationsRequest](#ListDiskOperationsRequest)) returns ([ListDiskOperationsResponse](#ListDiskOperationsResponse))**

### ListDiskOperationsRequest {#ListDiskOperationsRequest}

Поле | Описание
--- | ---
disk_id | **string**<br>Обязательное поле. Идентификатор ресурса Disk, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListDiskOperationsResponse.next_page_token](#ListDiskOperationsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListDiskOperationsResponse.next_page_token](#ListDiskOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListDiskOperationsResponse {#ListDiskOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанного диска. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListDiskOperationsRequest.page_size](#ListDiskOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListDiskOperationsRequest.page_token](#ListDiskOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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


