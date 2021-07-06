---
title: "Метод ImageService. Справочник API в Yandex Container Registry"
description: "Набор методов для управления ресурсами Image через API в Yandex Container Registry – Get, List, Delete."

editable: false
---

# ImageService

Набор методов для управления ресурсами Image.

| Вызов | Описание |
| --- | --- |
| [List](#List) | Получает список ресурсов Image в указанном реестре или репозитории. |
| [Get](#Get) | Возвращает указанный ресурс Image. |
| [Delete](#Delete) | Удаляет указанный Docker-образ. |

## Вызовы ImageService {#calls}

## List {#List}

Получает список ресурсов Image в указанном реестре или репозитории.

**rpc List ([ListImagesRequest](#ListImagesRequest)) returns ([ListImagesResponse](#ListImagesResponse))**

### ListImagesRequest {#ListImagesRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Идентификатор реестра для получения списка Docker-образов. `registry_id` игнорируется, если в запросе указан [ListImagesRequest.repository_name](#ListImagesRequest). <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](./registry_service#List). Максимальная длина строки в символах — 50.
repository_name | **string**<br>Имя репозитория для получения списка Docker-образов. <br>Чтобы получить имя репозитория, используйте [RepositoryService.List](./repository_service#List) запрос. Значение должно соответствовать регулярному выражению ` |[a-z0-9]+(?:[._-][a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))* `.
folder_id | **string**<br>Идентификатор каталога, для которого запрашивается список Docker-образов. `folder_id` игнорируется, если в запросе есть [ListImagesRequest.repository_name](#ListImagesRequest) или [ListImagesRequest.registry_id](#ListImagesRequest). <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListImagesResponse.next_page_token](#ListImagesResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListImagesResponse.next_page_token](#ListImagesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Image.name](#Image). </li><li>Оператор. Может быть `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение. Должно быть не более 256 символов и соответствовать регулярному выражению `[a-z0-9]+(?:[._-](./#)(./#)[a-z0-9]+)*(/([a-z0-9]+(?:[._-][a-z0-9]+)*))`.</li></ol> Максимальная длина строки в символах — 1000.
order_by | **string**<br> Максимальная длина строки в символах — 100.


### ListImagesResponse {#ListImagesResponse}

Поле | Описание
--- | ---
images[] | **[Image](#Image)**<br>Список ресурсов Image. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListImagesRequest.page_size](#ListImagesRequest), используйте `next_page_token` в качестве значения параметра [ListImagesRequest.page_token](#ListImagesRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Image {#Image}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор Docker-образа. 
name | **string**<br>Имя Docker-образа. Уникально в рамках реестра. 
digest | **string**<br>Контентный адрес Docker-образа. 
compressed_size | **int64**<br>Размер сжатого Docker-образа, в байтах. 
config | **[Blob](#Blob)**<br>Конфигурация Docker-образа. 
layers[] | **[Blob](#Blob)**<br>Слои Docker-образа. 
tags[] | **string**<br>Теги Docker-образа. <br>Каждый тег уникален в пределах репозитория. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 


### Blob {#Blob}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор блоба. 
digest | **string**<br>Контентный адрес блоба. 
size | **int64**<br>Размер блоба, указанный в байтах. 


## Get {#Get}

Возвращает указанный ресурс Image. <br>Чтобы получить список доступных ресурсов Image, используйте запрос [List](#List).

**rpc Get ([GetImageRequest](#GetImageRequest)) returns ([Image](#Image1))**

### GetImageRequest {#GetImageRequest}

Поле | Описание
--- | ---
image_id | **string**<br>Обязательное поле. Идентификатор возвращаемого Docker-образа. <br>Чтобы получить идентификатор Docker-образа, используйте запрос [ImageService.List](#List). Максимальная длина строки в символах — 50.


### Image {#Image1}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор Docker-образа. 
name | **string**<br>Имя Docker-образа. Уникально в рамках реестра. 
digest | **string**<br>Контентный адрес Docker-образа. 
compressed_size | **int64**<br>Размер сжатого Docker-образа, в байтах. 
config | **[Blob](#Blob1)**<br>Конфигурация Docker-образа. 
layers[] | **[Blob](#Blob1)**<br>Слои Docker-образа. 
tags[] | **string**<br>Теги Docker-образа. <br>Каждый тег уникален в пределах репозитория. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Только для вывода. Время создания ресурса в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt). 


### Blob {#Blob1}

Поле | Описание
--- | ---
id | **string**<br>Только для вывода. Идентификатор блоба. 
digest | **string**<br>Контентный адрес блоба. 
size | **int64**<br>Размер блоба, указанный в байтах. 


## Delete {#Delete}

Удаляет указанный Docker-образ.

**rpc Delete ([DeleteImageRequest](#DeleteImageRequest)) returns ([operation.Operation](#Operation))**

Метаданные и результат операции:<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.metadata:[DeleteImageMetadata](#DeleteImageMetadata)<br>
	&nbsp;&nbsp;&nbsp;&nbsp;Operation.response:[google.protobuf.Empty](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#google.protobuf.Empty)<br>

### DeleteImageRequest {#DeleteImageRequest}

Поле | Описание
--- | ---
image_id | **string**<br>Обязательное поле. Идентификатор удаляемого Docker-образа. <br>Чтобы получить идентификатор Docker-образа, используйте запрос [ImageService.List](#List). Максимальная длина строки в символах — 50.


### Operation {#Operation}

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
image_id | **string**<br>Идентификатор удаляемого Docker-образа. 


