---
editable: false
---

# UserService

Набор методов для управления пользователями Elasticsearch.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает информацию об указанном пользователе Elasticsearch. |
| [List](#List) | Получает список пользователей Elasticsearch в указанном кластере. |

## Вызовы UserService {#calls}

## Get {#Get}

Возвращает информацию об указанном пользователе Elasticsearch. <br>Чтобы получить список доступных пользователей Elasticsearch, выполните запрос [List](#List).

**rpc Get ([GetUserRequest](#GetUserRequest)) returns ([User](#User))**

### GetUserRequest {#GetUserRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch, к которому принадлежит пользователь. <br>Чтобы получить идентификатор кластера, выполните запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
user_name | **string**<br>Обязательное поле. Имя запрашиваемого пользователя Elasticsearch. <br>Чтобы получить имя пользователя, выполните запрос [UserService.List](#List). Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению ` [a-zA-Z0-9_]* `.


### User {#User}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя Elasticsearch. 
cluster_id | **string**<br>Идентификатор кластера Elasticsearch, к которому принадлежит пользователь. 


## List {#List}

Получает список пользователей Elasticsearch в указанном кластере.

**rpc List ([ListUsersRequest](#ListUsersRequest)) returns ([ListUsersResponse](#ListUsersResponse))**

### ListUsersRequest {#ListUsersRequest}

Поле | Описание
--- | ---
cluster_id | **string**<br>Обязательное поле. Идентификатор кластера Elasticsearch, для которого нужно получить список пользователей. <br>Чтобы получить идентификатор кластера, используйте запрос [ClusterService.List](./cluster_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на одной странице в ответе. <br>Если количество результатов больше чем `page_size`, сервис вернет значение [ListUsersResponse.next_page_token](#ListUsersResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. <br>Установите значение `page_token` равным значению поля [ListUsersResponse.next_page_token](#ListUsersResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListUsersResponse {#ListUsersResponse}

Поле | Описание
--- | ---
users[] | **[User](#User1)**<br>Список пользователей Elasticsearch. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. <br>Если количество результатов больше чем [ListUsersRequest.page_size](#ListUsersRequest), используйте `next_page_token` в качестве значения параметра [ListUsersRequest.page_token](#ListUsersRequest) в следующем запросе. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### User {#User1}

Поле | Описание
--- | ---
name | **string**<br>Имя пользователя Elasticsearch. 
cluster_id | **string**<br>Идентификатор кластера Elasticsearch, к которому принадлежит пользователь. 


