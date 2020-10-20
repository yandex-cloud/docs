---
editable: false
---

# ZoneService

Набор методов для получения информации о зонах доступности.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает сведения об указанной зоне доступности. |
| [List](#List) | Возвращает список зон доступности. |

## Вызовы ZoneService {#calls}

## Get {#Get}

Возвращает сведения об указанной зоне доступности. <br>Чтобы получить список зон доступности, выполните запрос [List](#List).

**rpc Get ([GetZoneRequest](#GetZoneRequest)) returns ([Zone](#Zone))**

### GetZoneRequest {#GetZoneRequest}

Поле | Описание
--- | ---
zone_id | **string**<br>Обязательное поле. Идентификатор зоны доступности для получения сведений. Максимальная длина строки в символах — 50.


### Zone {#Zone}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор зоны. 
region_id | **string**<br>Идентификатор региона. 
status | enum **Status**<br>Статус зоны доступности. <ul><li>`UP`: Зона доступна. Вы можете обращаться к ресурсам в этой зоне.</li><li>`DOWN`: Зона недоступна.</li><ul/>


## List {#List}

Возвращает список зон доступности.

**rpc List ([ListZonesRequest](#ListZonesRequest)) returns ([ListZonesResponse](#ListZonesResponse))**

### ListZonesRequest {#ListZonesRequest}

Поле | Описание
--- | ---
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListZonesResponse.next_page_token](#ListZonesResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListZonesResponse.next_page_token](#ListZonesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListZonesResponse {#ListZonesResponse}

Поле | Описание
--- | ---
zones[] | **[Zone](#Zone1)**<br>Список зон доступности. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListZonesRequest.page_size](#ListZonesRequest), используйте [ListZonesRequest.page_token](#ListZonesRequest)(#ListZonesRequest)(#ListZonesRequest) в качестве значения параметра [ListZonesRequest.page_token] в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения [ListZonesRequest.page_token] для перебора страниц результатов. 


### Zone {#Zone1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор зоны. 
region_id | **string**<br>Идентификатор региона. 
status | enum **Status**<br>Статус зоны доступности. <ul><li>`UP`: Зона доступна. Вы можете обращаться к ресурсам в этой зоне.</li><li>`DOWN`: Зона недоступна.</li><ul/>


