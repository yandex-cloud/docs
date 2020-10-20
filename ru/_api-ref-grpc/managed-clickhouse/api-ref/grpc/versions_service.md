---
editable: false
---

# VersionsService

Набор методов для управления версиями ClickHouse.

| Вызов | Описание |
| --- | --- |
| [List](#List) | Возвращает список доступных версий ClickHouse. |

## Вызовы VersionsService {#calls}

## List {#List}

Возвращает список доступных версий ClickHouse.

**rpc List ([ListVersionsRequest](#ListVersionsRequest)) returns ([ListVersionsResponse](#ListVersionsResponse))**

### ListVersionsRequest {#ListVersionsRequest}

Поле | Описание
--- | ---
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListVersionsResponse.next_page_token](#ListVersionsResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Допустимые значения — от 0 до 1000 включительно.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListVersionsResponse.next_page_token](#ListVersionsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListVersionsResponse {#ListVersionsResponse}

Поле | Описание
--- | ---
version[] | **[Version](#Version)**<br>Список доступных версий. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе, если количество результатов больше, чем [ListVersionsRequest.page_size](#ListVersionsRequest). Чтобы получить следующую страницу, укажите `next_page_token` в качестве значения для [ListVersionsRequest.page_token](#ListVersionsRequest) в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Version {#Version}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор версии. 
name | **string**<br>Название версии. 
deprecated | **bool**<br>Является ли версия устаревшей. 
updatable_to[] | **string**<br>Список версий, до которых можно обновить текущую. 


