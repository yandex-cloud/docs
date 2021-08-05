---
editable: false

__system: {"dislikeVariants":["Нет ответа на мой вопрос","Рекомендации не помогли","Содержание не соответствует заголовку","Другое"]}
---


# RepositoryService

Набор методов для управления ресурсами Repository.

| Вызов | Описание |
| --- | --- |
| [List](#List) | Получает список ресурсов Repository в указанном реестре. |

## Вызовы RepositoryService {#calls}

## List {#List}

Получает список ресурсов Repository в указанном реестре.

**rpc List ([ListRepositoriesRequest](#ListRepositoriesRequest)) returns ([ListRepositoriesResponse](#ListRepositoriesResponse))**

### ListRepositoriesRequest {#ListRepositoriesRequest}

Поле | Описание
--- | ---
registry_id | **string**<br>Идентификатор реестра для получения списка репозиториев. <br>Чтобы получить идентификатор реестра, используйте запрос [RegistryService.List](./registry_service#List). Максимальная длина строки в символах — 50.
folder_id | **string**<br>Идентификатор каталога, для которого запрашивается список реестров. `folder_id` игнорируется, если в запросе указан [ListImagesRequest.registry_id](#ListImagesRequest). <br>Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/api-ref/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListRepositoriesResponse.next_page_token](#ListRepositoriesResponse), которое можно использовать для получения следующей страницы. Значение по умолчанию: 100. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListRepositoriesResponse.next_page_token](#ListRepositoriesResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.
filter | **string**<br><ol><li>Имя поля. В настоящее время фильтрация осуществляется только по полю [Repository.name](./#Repository). </li><li>Оператор. Может быть `=` или `!=` для одиночных значений, `IN` или `NOT IN` для списков значений. </li><li>Значение или список значений для сравнения со значениями фильтра.</li></ol> Максимальная длина строки в символах — 1000.
order_by | **string**<br> Максимальная длина строки в символах — 100.


### ListRepositoriesResponse {#ListRepositoriesResponse}

Поле | Описание
--- | ---
repositories[] | **[Repository](./#Repository)**<br>Список ресурсов Repository. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListRepositoriesRequest.page_size](#ListRepositoriesRequest), используйте `next_page_token` в качестве значения параметра [ListRepositoriesRequest.page_token](#ListRepositoriesRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. 


### Repository {#Repository}

Поле | Описание
--- | ---
name | **string**<br>Имя репозитория. Уникально в рамках реестра. 


