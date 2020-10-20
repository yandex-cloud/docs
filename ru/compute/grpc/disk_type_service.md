---
editable: false
---

# DiskTypeService

Набор методов для получения информации о типах дисков.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает сведения об указанном типе диска. |
| [List](#List) | Получает список типов дисков для указанного каталога. |

## Вызовы DiskTypeService {#calls}

## Get {#Get}

Возвращает сведения об указанном типе диска. <br>Чтобы получить список доступных типов дисков, выполните запрос [List](#List).

**rpc Get ([GetDiskTypeRequest](#GetDiskTypeRequest)) returns ([DiskType](#DiskType))**

### GetDiskTypeRequest {#GetDiskTypeRequest}

Поле | Описание
--- | ---
disk_type_id | **string**<br>Обязательное поле. Идентификатор типа диска для возврата сведений о диске. Чтобы получить идентификатор типа диска, используйте запрос [DiskTypeService.List](#List). 


### DiskType {#DiskType}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор типа диска. 
description | **string**<br>Описание диска. Длина описания должна быть от 0 до 256 символов. 
zone_ids[] | **string**<br>Массив зон доступности, в которых доступен тип диска. 


## List {#List}

Получает список типов дисков для указанного каталога.

**rpc List ([ListDiskTypesRequest](#ListDiskTypesRequest)) returns ([ListDiskTypesResponse](#ListDiskTypesResponse))**

### ListDiskTypesRequest {#ListDiskTypesRequest}

Поле | Описание
--- | ---
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListDiskTypesResponse.next_page_token](#ListDiskTypesResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListDiskTypesResponse.next_page_token](#ListDiskTypesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListDiskTypesResponse {#ListDiskTypesResponse}

Поле | Описание
--- | ---
disk_types[] | **[DiskType](#DiskType1)**<br>Список типов дисков. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListDiskTypesRequest.page_size](#ListDiskTypesRequest), используйте `next_page_token` в качестве значения параметра [ListDiskTypesRequest.page_token](#ListDiskTypesRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### DiskType {#DiskType1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор типа диска. 
description | **string**<br>Описание диска. Длина описания должна быть от 0 до 256 символов. 
zone_ids[] | **string**<br>Массив зон доступности, в которых доступен тип диска. 


