---
editable: false
---

# ResourcePresetService

Методы для работы с наборами вычислительных ресурсов.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный набор вычислительных ресурсов. |
| [List](#List) | Возвращает список доступных наборов вычислительных ресурсов. |

## Вызовы ResourcePresetService {#calls}

## Get {#Get}

Возвращает указанный набор вычислительных ресурсов. <br>Чтобы получить список доступных наборов вычислительных ресурсов, выполните запрос [List](#List).

**rpc Get ([GetResourcePresetRequest](#GetResourcePresetRequest)) returns ([ResourcePreset](#ResourcePreset))**

### GetResourcePresetRequest {#GetResourcePresetRequest}

Поле | Описание
--- | ---
resource_preset_id | **string**<br>Обязательное поле. Идентификатор наборов вычислительных ресурсов, данные о котором запрашиваются. <br>Чтобы получить идентификатор наборов вычислительных ресурсов, выполните запрос [ResourcePresetService.List](#List). 


### ResourcePreset {#ResourcePreset}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор набора вычислительных ресурсов. 
zone_ids[] | **string**<br>Идентификаторы зон доступности, в которых доступен этот набор вычислительных ресурсов. 
cores | **int64**<br>Количество процессорных ядер для хоста SQL, созданного с данным набором вычислительных ресурсов. 
memory | **int64**<br>Объем оперативной памяти для хоста SQL Server, созданного с данным набором вычислительных ресурсов, в байтах. 


## List {#List}

Возвращает список доступных наборов вычислительных ресурсов.

**rpc List ([ListResourcePresetsRequest](#ListResourcePresetsRequest)) returns ([ListResourcePresetsResponse](#ListResourcePresetsResponse))**

### ListResourcePresetsRequest {#ListResourcePresetsRequest}

Поле | Описание
--- | ---
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. Если количество результатов больше чем `page_size`, сервис вернет значение [ListResourcePresetsResponse.next_page_token](#ListResourcePresetsResponse), которое можно использовать для получения следующей страницы. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListResourcePresetsResponse.next_page_token](#ListResourcePresetsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListResourcePresetsResponse {#ListResourcePresetsResponse}

Поле | Описание
--- | ---
resource_presets[] | **[ResourcePreset](#ResourcePreset1)**<br>Список наборов вычислительных ресурсов. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListResourcePresetsRequest.page_size](#ListResourcePresetsRequest), используйте `next_page_token` в качестве значения параметра [ListResourcePresetsRequest.page_token](#ListResourcePresetsRequest) в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. Максимальная длина строки в символах — 100.


### ResourcePreset {#ResourcePreset1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор набора вычислительных ресурсов. 
zone_ids[] | **string**<br>Идентификаторы зон доступности, в которых доступен этот набор вычислительных ресурсов. 
cores | **int64**<br>Количество процессорных ядер для хоста SQL, созданного с данным набором вычислительных ресурсов. 
memory | **int64**<br>Объем оперативной памяти для хоста SQL Server, созданного с данным набором вычислительных ресурсов, в байтах. 


