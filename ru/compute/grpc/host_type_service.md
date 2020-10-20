---
editable: false
---

# HostTypeService

Набор методов для просмотра возможных конфигураций выделенного хоста.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает информацию об указанном типе выделенного хоста. |
| [List](#List) | Список доступных типов выделенных хостов. |

## Вызовы HostTypeService {#calls}

## Get {#Get}

Возвращает информацию об указанном типе выделенного хоста.

**rpc Get ([GetHostTypeRequest](#GetHostTypeRequest)) returns ([HostType](#HostType))**

### GetHostTypeRequest {#GetHostTypeRequest}

Поле | Описание
--- | ---
host_type_id | **string**<br>Обязательное поле. Идентификатор возвращаемого типа выделенного хоста. <br>Чтобы получить идентификатор типа выделенного хоста, используйте запрос [HostTypeService.List](#List). Максимальная длина строки в символах — 50.


### HostType {#HostType}

Поле | Описание
--- | ---
id | **string**<br>Уникальный идентификатор типа выделенного хоста. 
cores | **int64**<br>Общее количество ядер, доступных для ВМ выделенного хоста. 
memory | **int64**<br>Объем памяти, доступный для ВМ выделенного хоста. 


## List {#List}

Список доступных типов выделенных хостов.

**rpc List ([ListHostTypesRequest](#ListHostTypesRequest)) returns ([ListHostTypesResponse](#ListHostTypesResponse))**

### ListHostTypesRequest {#ListHostTypesRequest}

Поле | Описание
--- | ---
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListHostTypesResponse.next_page_token](#ListHostTypesResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListHostTypesResponse.next_page_token](#ListHostTypesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListHostTypesResponse {#ListHostTypesResponse}

Поле | Описание
--- | ---
host_types[] | **[HostType](#HostType1)**<br>Список типов выделенных хостов. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListHostTypesRequest.page_size](#ListHostTypesRequest), используйте `next_page_token` в качестве значения параметра [ListHostTypesRequest.page_token](#ListHostTypesRequest) в следующем запросе списка ресурсов. <br>Каждая следующая страница будет иметь свой `next_page_token` для продолжения перебора страниц результатов. 


### HostType {#HostType1}

Поле | Описание
--- | ---
id | **string**<br>Уникальный идентификатор типа выделенного хоста. 
cores | **int64**<br>Общее количество ядер, доступных для ВМ выделенного хоста. 
memory | **int64**<br>Объем памяти, доступный для ВМ выделенного хоста. 


