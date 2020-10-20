---
editable: false
---

# BackupService

Набор методов для управления резервными копиями MySQL.

| Вызов | Описание |
| --- | --- |
| [Get](#Get) | Возвращает указанную резервную копию MySQL. |
| [List](#List) | Возвращает список резервных копий MySQL, доступных для указанного каталога. |

## Вызовы BackupService {#calls}

## Get {#Get}

Возвращает указанную резервную копию MySQL. <br>Чтобы получить список доступных резервных копий MySQL, выполните запрос [List](#List).

**rpc Get ([GetBackupRequest](#GetBackupRequest)) returns ([Backup](#Backup))**

### GetBackupRequest {#GetBackupRequest}

Поле | Описание
--- | ---
backup_id | **string**<br>Обязательное поле. Идентификатор резервной копии, сведения о которой запрашиваются. Чтобы получить идентификатор резервной копии, используйте запрос [ClusterService.ListBackups](./cluster_service#ListBackups). 


### Backup {#Backup}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. Идентификатор резервной копии. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит резервная копия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
source_cluster_id | **string**<br>Идентификатор кластера MySQL, для которого была создана резервная копия. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время запуска операции резервного копирования. 


## List {#List}

Возвращает список резервных копий MySQL, доступных для указанного каталога.

**rpc List ([ListBackupsRequest](#ListBackupsRequest)) returns ([ListBackupsResponse](#ListBackupsResponse))**

### ListBackupsRequest {#ListBackupsRequest}

Поле | Описание
--- | ---
folder_id | **string**<br>Обязательное поле. Идентификатор каталога для вывода списка резервных копий. Чтобы получить идентификатор каталога, используйте запрос [yandex.cloud.resourcemanager.v1.FolderService.List](/docs/resource-manager/grpc/folder_service#List). Максимальная длина строки в символах — 50.
page_size | **int64**<br>Максимальное количество результатов на странице ответа на запрос. Если количество результатов больше чем `page_size`, сервис вернет значение [ListBackupsResponse.next_page_token](#ListBackupsResponse), которое можно использовать для получения следующей страницы. Максимальное значение — 1000.
page_token | **string**<br>Токен страницы. Установите значение `page_token` равным значению поля [ListBackupsResponse.next_page_token](#ListBackupsResponse) предыдущего запроса, чтобы получить следующую страницу результатов. Максимальная длина строки в символах — 100.


### ListBackupsResponse {#ListBackupsResponse}

Поле | Описание
--- | ---
backups[] | **[Backup](#Backup1)**<br>Список резервных копий MySQL. 
next_page_token | **string**<br>Токен для получения следующей страницы результатов в ответе. Если количество результатов больше чем [ListBackupsRequest.page_size](#ListBackupsRequest), используйте `next_page_token` в качестве значения параметра [ListBackupsRequest.page_token](#ListBackupsRequest) в следующем запросе списка ресурсов. Все последующие запросы будут получать свои значения `next_page_token` для перебора страниц результатов. Максимальная длина строки в символах — 100.


### Backup {#Backup1}

Поле | Описание
--- | ---
id | **string**<br>Обязательное поле. Идентификатор резервной копии. 
folder_id | **string**<br>Идентификатор каталога, которому принадлежит резервная копия. 
created_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br> 
source_cluster_id | **string**<br>Идентификатор кластера MySQL, для которого была создана резервная копия. 
started_at | **[google.protobuf.Timestamp](https://developers.google.com/protocol-buffers/docs/reference/google.protobuf#timestamp)**<br>Время запуска операции резервного копирования. 


