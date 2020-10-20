---
editable: false
---

# ResourcePresetService

Методы для работы с наборами ресурсов.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный набор ресурсов. |
| [List](#List) | Возвращает список доступных наборов ресурсов. |

## Вызовы ResourcePresetService {#calls}

## Get {#Get}

Возвращает указанный набор ресурсов. <br>Чтобы получить список доступных наборов ресурсов, используйте запрос [List](#List).

**rpc Get ([GetResourcePresetRequest](#GetResourcePresetRequest)) returns ([ResourcePreset](#ResourcePreset))**

### GetResourcePresetRequest {#GetResourcePresetRequest}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Обязательное поле. Идентификатор набора ресурсов, данные о котором запрашиваются. Чтобы получить идентификатор набора ресурсов, используйте запрос [ResourcePresetService.List](#List). 


### ResourcePreset {#ResourcePreset}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор набора ресурсов. 
zone_ids[] | **string**<br>Идентификаторы зон доступности, в которых доступен данный набор ресурсов. 
memory | **int64**<br>Объем оперативной памяти для хоста Redis, созданного с данным набором ресурсов, в байтах. 


## List {#List}

Возвращает список доступных наборов ресурсов.

**rpc List ([ListResourcePresetsRequest](#ListResourcePresetsRequest)) returns ([ListResourcePresetsResponse](#ListResourcePresetsResponse))**

### ListResourcePresetsRequest {#ListResourcePresetsRequest}

Поле | Описание
--- | ---
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListResourcePresetsResponse.next_page_token](#ListResourcePresetsResponse), которое можно использовать для получения следующей страницы. 
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListResourcePresetsResponse.next_page_token](#ListResourcePresetsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. 


### ListResourcePresetsResponse {#ListResourcePresetsResponse}

Поле | Описание
--- | ---
resource_presets[] | **[ResourcePreset](#ResourcePreset1)**<br>Список наборов ресурсов. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListResourcePresetsRequest.page_size](#ListResourcePresetsRequest), используйте `next_page_token` в качестве значения параметра [ListResourcePresetsRequest.page_token](#ListResourcePresetsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### ResourcePreset {#ResourcePreset1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор набора ресурсов. 
zone_ids[] | **string**<br>Идентификаторы зон доступности, в которых доступен данный набор ресурсов. 
memory | **int64**<br>Объем оперативной памяти для хоста Redis, созданного с данным набором ресурсов, в байтах. 


