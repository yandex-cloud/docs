---
editable: false
---

# Метод get
Возвращает указанную резервную копию для ClickHouse.
 
Чтобы получить список доступных ресурсов Backup для ClickHouse, отправьте запрос [list](/docs/managed-clickhouse/api-ref/Backup/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-clickhouse/v1/backups/{backupId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
backupId | Обязательное поле. Идентификатор резервной копии, сведения о которой запрашиваются. Чтобы получить идентификатор резервной копии, используйте запрос [listBackups](/docs/managed-clickhouse/api-ref/Cluster/listBackups).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "folderId": "string",
  "createdAt": "string",
  "sourceClusterId": "string",
  "sourceShardNames": [
    "string"
  ],
  "startedAt": "string"
}
```
Ресурс Backup для ClickHouse. Подробное описание см. в [документации](/docs/managed-clickhouse/concepts/backup).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор резервной копии.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит резервная копия.</p> 
createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> (т. е. когда операция резервного копирования была завершена).</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
sourceClusterId | **string**<br><p>Идентификатор кластера ClickHouse, для которого была создана резервная копия.</p> 
sourceShardNames[] | **string**<br><p>Имена шардов, включенных в резервную копию.</p> 
startedAt | **string** (date-time)<br><p>Время запуска операции резервного копирования.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 