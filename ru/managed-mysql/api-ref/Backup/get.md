---
editable: false
---

# Метод get
Возвращает указанную резервную копию MySQL.
 
Чтобы получить список доступных резервных копий MySQL, выполните запрос [list](/docs/managed-mysql/api-ref/Backup/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/backups/{backupId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
backupId | Обязательное поле. Идентификатор резервной копии, сведения о которой запрашиваются. Чтобы получить идентификатор резервной копии, используйте запрос [listBackups](/docs/managed-mysql/api-ref/Cluster/listBackups).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "startedAt": "string"
}
```
Резервная копия MySQL. Подробнее см. в разделе [Резервные копии](/docs/managed-mysql/concepts/backup).
 
Поле | Описание
--- | ---
id | **string**<br><p>Обязательное поле. Идентификатор резервной копии.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит резервная копия.</p> 
createdAt | **string** (date-time)<br><p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
sourceClusterId | **string**<br><p>Идентификатор кластера MySQL, для которого была создана резервная копия.</p> 
startedAt | **string** (date-time)<br><p>Время запуска операции резервного копирования.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 