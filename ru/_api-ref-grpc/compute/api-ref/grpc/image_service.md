---
title: "Метод ImageService. Справочник API в Yandex Compute Cloud"
description: "Набор методов для управления ресурсами Image через API в Yandex Compute Cloud – Get, GetLatestByFamily, List, Create, Update, Delete, ListOperations."

editable: false
---

# ImageService

Набор методов для управления ресурсами Image.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Image. |
| [GetLatestByFamily](#GetLatestByFamily) | Возвращает последний образ из указанного семейства образов. |
| [List](#List) | Возвращает список доступных ресурсов Image в указанном каталоге. |
| [Create](#Create) | Создает образ в указанном каталоге. |
| [Update](#Update) | Изменяет указанный образ. |
| [Delete](#Delete) | Удаляет указанный образ. |
| [ListOperations](#ListOperations) | Список операций для указанного образа. |

## Вызовы ImageService {#calls}

## Get {#Get}

Возвращает указанный ресурс Image. <br>Чтобы получить список доступных ресурсов Image, используйте запрос [List](#List).

**rpc Get ([GetImageRequest](#GetImageRequest)) returns ([Image](#Image))**

### GetImageRequest {#GetImageRequest}

Поле | Описание
--- | ---
image_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Image. Чтобы получить идентификатор образа, используйте запрос [ImageService.List](#List). Максимальная длина строки в символах — 50.


### Image {#Image}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор образа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит образ диска. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя образа. Длина 1-63 символов. 
description | **string**<br>Описание образа. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Максимум 64 на ресурс. 
family | **string**<br>Имя семейства образов, к которому принадлежит этот образ. <br>Вы можете получить самый последний образ из семейства образов, используя запрос [yandex.cloud.compute.v1.ImageService.GetLatestByFamily](/docs/compute/api-ref/grpc/image_service#GetLatestByFamily), чтобы создать диск из этого образа. 
storage_size | **int64**<br>Размер образа в байтах. 
min_disk_size | **int64**<br>Минимальный размер диска, который будет создан из этого образа. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус образа диска. <ul><li>`CREATING`: Образ диска создается.</li><li>`READY`: Образ диска готов к использованию.</li><li>`ERROR`: С образом произошла ошибка, блокирующая работу.</li><li>`DELETING`: Образ диска удаляется.</li><ul/>
os | **[Os](#Os)**<br>Операционная система, содержащаяся в образе. 


### Os {#Os}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Тип операционной системы. Значение по умолчанию — `LINUX`. <br>Это поле используется для правильной эмуляции vCPU и расчета стоимости использования виртуальной машины. <ul><li>`LINUX`: Операционная система Linux.</li><li>`WINDOWS`: Операционная система Windows.</li><ul/>


## GetLatestByFamily {#GetLatestByFamily}

Возвращает последний образ из указанного семейства образов.

**rpc GetLatestByFamily ([GetImageLatestByFamilyRequest](#GetImageLatestByFamilyRequest)) returns ([Image](#Image1))**

### GetImageLatestByFamilyRequest {#GetImageLatestByFamilyRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения образа. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
family | **string**<br>Имя семейства образов для поиска. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.


### Image {#Image1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор образа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит образ диска. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя образа. Длина 1-63 символов. 
description | **string**<br>Описание образа. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Максимум 64 на ресурс. 
family | **string**<br>Имя семейства образов, к которому принадлежит этот образ. <br>Вы можете получить самый последний образ из семейства образов, используя запрос [yandex.cloud.compute.v1.ImageService.GetLatestByFamily](/docs/compute/api-ref/grpc/image_service#GetLatestByFamily), чтобы создать диск из этого образа. 
storage_size | **int64**<br>Размер образа в байтах. 
min_disk_size | **int64**<br>Минимальный размер диска, который будет создан из этого образа. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус образа диска. <ul><li>`CREATING`: Образ диска создается.</li><li>`READY`: Образ диска готов к использованию.</li><li>`ERROR`: С образом произошла ошибка, блокирующая работу.</li><li>`DELETING`: Образ диска удаляется.</li><ul/>
os | **[Os](#Os1)**<br>Операционная система, содержащаяся в образе. 


### Os {#Os1}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Тип операционной системы. Значение по умолчанию — `LINUX`. <br>Это поле используется для правильной эмуляции vCPU и расчета стоимости использования виртуальной машины. <ul><li>`LINUX`: Операционная система Linux.</li><li>`WINDOWS`: Операционная система Windows.</li><ul/>


## List {#List}

Возвращает список доступных ресурсов Image в указанном каталоге.

**rpc List ([ListImagesRequest](#ListImagesRequest)) returns ([ListImagesResponse](#ListImagesResponse))**

### ListImagesRequest {#ListImagesRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для получения списка образов. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListImagesResponse.next_page_token](#ListImagesResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListImagesResponse.next_page_token](#ListImagesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Image.name](#Image2). </li><li>Оператор. Операторы `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Должен содержать от 3 до 63 символов и соответствовать регулярному выражению `^[a-z]([-a-z0-9]{,61}[a-z0-9])?$`.</li></ol> Максимальная длина строки в символах — 1000.


### ListImagesResponse {#ListImagesResponse}

Поле | Описание
--- | ---
images[] | **[Image](#Image2)**<br>Список образов. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListSnapshotsRequest.page_size](#ListSnapshotsRequest), используйте `next_page_token` в качестве значения параметра [ListSnapshotsRequest.page_token](#ListSnapshotsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Image {#Image2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор образа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит образ диска. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя образа. Длина 1-63 символов. 
description | **string**<br>Описание образа. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Максимум 64 на ресурс. 
family | **string**<br>Имя семейства образов, к которому принадлежит этот образ. <br>Вы можете получить самый последний образ из семейства образов, используя запрос [yandex.cloud.compute.v1.ImageService.GetLatestByFamily](/docs/compute/api-ref/grpc/image_service#GetLatestByFamily), чтобы создать диск из этого образа. 
storage_size | **int64**<br>Размер образа в байтах. 
min_disk_size | **int64**<br>Минимальный размер диска, который будет создан из этого образа. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус образа диска. <ul><li>`CREATING`: Образ диска создается.</li><li>`READY`: Образ диска готов к использованию.</li><li>`ERROR`: С образом произошла ошибка, блокирующая работу.</li><li>`DELETING`: Образ диска удаляется.</li><ul/>
os | **[Os](#Os2)**<br>Операционная система, содержащаяся в образе. 


### Os {#Os2}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Тип операционной системы. Значение по умолчанию — `LINUX`. <br>Это поле используется для правильной эмуляции vCPU и расчета стоимости использования виртуальной машины. <ul><li>`LINUX`: Операционная система Linux.</li><li>`WINDOWS`: Операционная система Windows.</li><ul/>


## Create {#Create}

Создает образ в указанном каталоге. <br>Вы можете создать образ из диска, снимка, другого образа или URI. Метод запускает асинхронную операцию, которую можно отменить перед тем, как она завершится.

**rpc Create ([CreateImageRequest](#CreateImageRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[CreateImageMetadata](#CreateImageMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Image](#Image3)<br>

### CreateImageRequest {#CreateImageRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для создания образа. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
name | **string**<br>Имя образа. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание образа. Максимальная длина строки в символах — 256.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.
family | **string**<br>Имя семейства образов, к которому принадлежит этот образ. Дополнительные сведения см. в разделе [Семейство образов](/docs/compute/concepts/image#family). <br>Чтобы получить информацию о последнем образе в семействе, используйте запрос [ImageService.GetLatestByFamily](#GetLatestByFamily). Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
min_disk_size | **int64**<br>Минимальный размер диска, который будет создан из этого образа. Указывается в байтах. Значение должно быть больше размера исходных данных. Допустимые значения — от 4194304 до 4398046511104 включительно.
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в этом запросе. Максимальная длина строки в символах для каждого значения — 50.
source | **oneof:** `image_id`, `disk_id`, `snapshot_id` или `uri`<br>
&nbsp;&nbsp;image_id | **string**<br>Идентификатор образа, из которого будет создан новый образ. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;disk_id | **string**<br>Идентификатор диска, из которого будет создан образ. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;snapshot_id | **string**<br>Идентификатор снимка, из которого будет создан образ. Максимальная длина строки в символах — 50.
&nbsp;&nbsp;uri | **string**<br>URI образа, из которого будет создан новый образ. В настоящее время поддерживаются только ссылки на образы, которые хранятся в Yandex Object Storage. В настоящее время поддерживаются только форматы Qcow2, VMDK и VHD. 
os | **[Os](#Os3)**<br>Операционная система, содержащаяся в образе. <br>По умолчанию наследуется от исходного ресурса, если в качестве источника вы использовали `image_id` или `disk_id`. 


### Os {#Os3}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Тип операционной системы. Значение по умолчанию — `LINUX`. <br>Это поле используется для правильной эмуляции vCPU и расчета стоимости использования виртуальной машины. <ul><li>`LINUX`: Операционная система Linux.</li><li>`WINDOWS`: Операционная система Windows.</li><ul/>


### Operation {#Operation}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[CreateImageMetadata](#CreateImageMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Image](#Image3)>**<br>в случае успешного выполнения операции. 


### CreateImageMetadata {#CreateImageMetadata}

Поле | Описание
--- | ---
image_id | **string**<br>Идентификатор создаваемого образа. 


### Image {#Image3}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор образа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит образ диска. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя образа. Длина 1-63 символов. 
description | **string**<br>Описание образа. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Максимум 64 на ресурс. 
family | **string**<br>Имя семейства образов, к которому принадлежит этот образ. <br>Вы можете получить самый последний образ из семейства образов, используя запрос [yandex.cloud.compute.v1.ImageService.GetLatestByFamily](/docs/compute/api-ref/grpc/image_service#GetLatestByFamily), чтобы создать диск из этого образа. 
storage_size | **int64**<br>Размер образа в байтах. 
min_disk_size | **int64**<br>Минимальный размер диска, который будет создан из этого образа. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус образа диска. <ul><li>`CREATING`: Образ диска создается.</li><li>`READY`: Образ диска готов к использованию.</li><li>`ERROR`: С образом произошла ошибка, блокирующая работу.</li><li>`DELETING`: Образ диска удаляется.</li><ul/>
os | **[Os](#Os4)**<br>Операционная система, содержащаяся в образе. 


### Os {#Os4}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Тип операционной системы. Значение по умолчанию — `LINUX`. <br>Это поле используется для правильной эмуляции vCPU и расчета стоимости использования виртуальной машины. <ul><li>`LINUX`: Операционная система Linux.</li><li>`WINDOWS`: Операционная система Windows.</li><ul/>


## Update {#Update}

Изменяет указанный образ.

**rpc Update ([UpdateImageRequest](#UpdateImageRequest)) returns ([operation.Operation](#Operation1))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[UpdateImageMetadata](#UpdateImageMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[Image](#Image4)<br>

### UpdateImageRequest {#UpdateImageRequest}

Поле | Описание
--- | ---
image_id | **string**<br>Обязательное поле. Идентификатор изменяемого ресурса Image. Чтобы получить идентификатор образа, используйте запрос [ImageService.List](#List). Максимальная длина строки в символах — 50.
update_mask | **[google.protobuf.FieldMask](https://developers.google.com/protocol-buffers/docs/reference/csharp/class/google/protobuf/well-known-types/field-mask)**<br>Маска, определяющая, какие поля ресурса Image будут обновлены. 
name | **string**<br>Имя образа. Значение должно соответствовать регулярному выражению ` |[a-z][-a-z0-9]{1,61}[a-z0-9] `.
description | **string**<br>Описание образа. Максимальная длина строки в символах — 256.
min_disk_size | **int64**<br>Минимальный размер диска, который может быть создан из этого образа. Указывается в байтах. Должен быть больше объема исходных данных и больше размера виртуального диска. Допустимые значения — от 4194304 до 4398046511104 включительно.
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. <br>Существующий набор `labels` полностью перезаписывается набором, переданным в запросе. Не более 64 на ресурс. Максимальная длина строки в символах для каждого значения — 63. Каждое значение должно соответствовать регулярному выражению ` [-_0-9a-z]* `. Длина строки в символах для каждого ключа должна быть от 1 до 63. Каждый ключ должен соответствовать регулярному выражению ` [a-z][-_0-9a-z]* `.


### Operation {#Operation1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[UpdateImageMetadata](#UpdateImageMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[Image](#Image4)>**<br>в случае успешного выполнения операции. 


### UpdateImageMetadata {#UpdateImageMetadata}

Поле | Описание
--- | ---
image_id | **string**<br>Идентификатор изменяемого ресурса Disk. 


### Image {#Image4}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор образа. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит образ диска. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
name | **string**<br>Имя образа. Длина 1-63 символов. 
description | **string**<br>Описание образа. Длина описания должна быть от 0 до 256 символов. 
labels | **map<string,string>**<br>Метки ресурса в формате `ключ:значение`. Максимум 64 на ресурс. 
family | **string**<br>Имя семейства образов, к которому принадлежит этот образ. <br>Вы можете получить самый последний образ из семейства образов, используя запрос [yandex.cloud.compute.v1.ImageService.GetLatestByFamily](/docs/compute/api-ref/grpc/image_service#GetLatestByFamily), чтобы создать диск из этого образа. 
storage_size | **int64**<br>Размер образа в байтах. 
min_disk_size | **int64**<br>Минимальный размер диска, который будет создан из этого образа. 
product_ids[] | **string**<br>Идентификаторы лицензий, указывающие, какие лицензии подключены к этому ресурсу. Идентификаторы лицензий используются для расчета дополнительной платы за использование виртуальной машины. <br>Правильный идентификатор лицензии генерируется Яндекс.Облаком. Идентификаторы наследуются новыми ресурсами, созданными из этого ресурса. <br>Если вам известны идентификаторы лицензий, укажите их при создании образа. Например, если создать образ диска с помощью сторонней утилиты и загрузить его в Yandex Object Storage, то идентификаторы лицензий будут потеряны. Вы можете указать их в запросе [yandex.cloud.compute.v1.ImageService.Create](/docs/compute/api-ref/grpc/image_service#Create). 
status | enum **Status**<br>Текущий статус образа диска. <ul><li>`CREATING`: Образ диска создается.</li><li>`READY`: Образ диска готов к использованию.</li><li>`ERROR`: С образом произошла ошибка, блокирующая работу.</li><li>`DELETING`: Образ диска удаляется.</li><ul/>
os | **[Os](#Os5)**<br>Операционная система, содержащаяся в образе. 


### Os {#Os5}

Поле | Описание
--- | ---
type | enum **[Type](./disk_type#undefined)**<br>Тип операционной системы. Значение по умолчанию — `LINUX`. <br>Это поле используется для правильной эмуляции vCPU и расчета стоимости использования виртуальной машины. <ul><li>`LINUX`: Операционная система Linux.</li><li>`WINDOWS`: Операционная система Windows.</li><ul/>


## Delete {#Delete}

Удаляет указанный образ. <br>Удаление образа — необратимая операция, восстановить удаленный образ невозможно.

**rpc Delete ([DeleteImageRequest](#DeleteImageRequest)) returns ([operation.Operation](#Operation2))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteImageMetadata](#DeleteImageMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteImageRequest {#DeleteImageRequest}

Поле | Описание
--- | ---
image_id | **string**<br>Обязательное поле. Идентификатор удаляемого образа. Чтобы получить идентификатор образа, используйте запрос [ImageService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation2}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор операции. 
description | **string**<br>Описание операции. Длина описания должна быть от 0 до 256 символов. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время создания ресурса в формате в [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
created_by | **string**<br>Идентификатор пользователя или сервисного аккаунта, инициировавшего операцию. 
modified_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время, когда ресурс Operation последний раз обновлялся. Значение в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 
done | **bool**<br>Если значение равно `false` — операция еще выполняется. Если `true` — операция завершена, и задано значение одного из полей `error` или `response`. 
metadata | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[DeleteImageMetadata](#DeleteImageMetadata)>**<br>Метаданные операции. Обычно в поле содержится идентификатор ресурса, над которым выполняется операция. Если метод возвращает ресурс Operation, в описании метода приведена структура соответствующего ему поля `metadata`. 
result | **oneof:** `error` или `response`<br>Результат операции. Если `done == false` и не было выявлено ошибок — значения полей `error` и `response` не заданы. Если `done == false` и была выявлена ошибка — задано значение поля `error`. Если `done == true` — задано значение ровно одного из полей `error` или `response`.
&nbsp;&nbsp;error | **[google.rpc.Status](https://cloud.google.com/tasks/docs/reference/rpc/google.rpc#status)**<br>Описание ошибки в случае сбоя или отмены операции. 
&nbsp;&nbsp;response | **[google.protobuf.Any](https://developers.google.com/protocol-buffers/docs/proto3#any)<[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)>**<br>в случае успешного выполнения операции. 


### DeleteImageMetadata {#DeleteImageMetadata}

Поле | Описание
--- | ---
image_id | **string**<br>Идентификатор удаляемого образа. 


## ListOperations {#ListOperations}

Список операций для указанного образа.

**rpc ListOperations ([ListImageOperationsRequest](#ListImageOperationsRequest)) returns ([ListImageOperationsResponse](#ListImageOperationsResponse))**

### ListImageOperationsRequest {#ListImageOperationsRequest}

Поле | Описание
--- | ---
image_id | **string**<br>Обязательное поле. Идентификатор ресурса Image, для которого запрашивается список операций. Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListImageOperationsResponse.next_page_token](#ListImageOperationsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListImageOperationsResponse.next_page_token](#ListImageOperationsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListImageOperationsResponse {#ListImageOperationsResponse}

Поле | Описание
--- | ---
operations[] | **[operation.Operation](#Operation3)**<br>Список операций для указанного образа. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListImageOperationsRequest.page_size](#ListImageOperationsRequest), используйте `next_page_token` в качестве значения параметра [ListImageOperationsRequest.page_token](#ListImageOperationsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


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


