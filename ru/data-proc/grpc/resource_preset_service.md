---
editable: false
---

# ResourcePresetService

Набор методов для управления ресурсами ResourcePreset.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс ResourcePreset. |
| [List](#List) | Получает список доступных ресурсов ResourcePreset. |

## Вызовы ResourcePresetService {#calls}

## Get {#Get}

Возвращает указанный ресурс ResourcePreset. <br>Чтобы получить список доступных ресурсов ResourcePreset, используйте запрос [List](#List).

**rpc Get ([GetResourcePresetRequest](#GetResourcePresetRequest)) returns ([ResourcePreset](#ResourcePreset))**

### GetResourcePresetRequest {#GetResourcePresetRequest}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Обязательное поле. Идентификатор набора ресурсов, данные о котором запрашиваются. Чтобы получить идентификатор набора ресурсов, используйте запрос [ResourcePresetService.List](#List). 


### ResourcePreset {#ResourcePreset}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор конфигурации ресурсов. 
zone_ids[] | **string**<br>Идентификаторы зон доступности, в которых доступен данный набор ресурсов. 
cores | **int64**<br>Количество ядер CPU для хоста Data Proc, созданного с данным набором ресурсов. 
memory | **int64**<br>Объем оперативной памяти для хоста Data Proc, созданного с данным набором ресурсов, в байтах. 


## List {#List}

Получает список доступных ресурсов ResourcePreset.

**rpc List ([ListResourcePresetsRequest](#ListResourcePresetsRequest)) returns ([ListResourcePresetsResponse](#ListResourcePresetsResponse))**

### ListResourcePresetsRequest {#ListResourcePresetsRequest}

Поле | Описание
--- | ---
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListResourcePresetsResponse.next_page_token](#ListResourcePresetsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListResourcePresetsResponse.next_page_token](#ListResourcePresetsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListResourcePresetsResponse {#ListResourcePresetsResponse}

Поле | Описание
--- | ---
resource_presets[] | **[ResourcePreset](#ResourcePreset1)**<br>Список ресурсов ResourcePreset. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListResourcePresetsRequest.page_size](#ListResourcePresetsRequest), используйте `next_page_token` в качестве значения параметра [ListResourcePresetsRequest.page_token](#ListResourcePresetsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. Максимальная длина строки в символах — 100.


### ResourcePreset {#ResourcePreset1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор конфигурации ресурсов. 
zone_ids[] | **string**<br>Идентификаторы зон доступности, в которых доступен данный набор ресурсов. 
cores | **int64**<br>Количество ядер CPU для хоста Data Proc, созданного с данным набором ресурсов. 
memory | **int64**<br>Объем оперативной памяти для хоста Data Proc, созданного с данным набором ресурсов, в байтах. 


