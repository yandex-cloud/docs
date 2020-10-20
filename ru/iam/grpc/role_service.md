---
editable: false
---

# RoleService

Набор методов для управления ресурсами Role.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанный ресурс Role. |
| [List](#List) | Возвращает список доступных ресурсов Role. |

## Вызовы RoleService {#calls}

## Get {#Get}

Возвращает указанный ресурс Role. <br>Чтобы получить список доступных ресурсов Role, используйте запрос [List](#List).

**rpc Get ([GetRoleRequest](#GetRoleRequest)) returns ([Role](#Role))**

### GetRoleRequest {#GetRoleRequest}

Поле | Описание
--- | ---
role_id | **string**<br>Обязательное поле. Идентификатор возвращаемого ресурса Role. Чтобы получить идентификатор роли, используйте запрос [RoleService.List](#List). Максимальная длина строки в символах — 50.


### Role {#Role}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор роли. 
description | **string**<br>Описание роли. Длина описания должна быть от 0 до 256 символов. 


## List {#List}

Возвращает список доступных ресурсов Role.

**rpc List ([ListRolesRequest](#ListRolesRequest)) returns ([ListRolesResponse](#ListRolesResponse))**

### ListRolesRequest {#ListRolesRequest}

Поле | Описание
--- | ---
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListRolesResponse.next_page_token](#ListRolesResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListRolesResponse.next_page_token](#ListRolesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br>Параметры фильтрации ресурсов в ответе. Максимальная длина строки в символах — 1000.


### ListRolesResponse {#ListRolesResponse}

Поле | Описание
--- | ---
roles[] | **[Role](#Role1)**<br>Список ресурсов Role. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListRolesRequest.page_size](#ListRolesRequest), используйте `next_page_token` в качестве значения параметра [ListRolesRequest.page_token](#ListRolesRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Role {#Role1}

Поле | Описание
--- | ---
id | **string**<br>Идентификатор роли. 
description | **string**<br>Описание роли. Длина описания должна быть от 0 до 256 символов. 


