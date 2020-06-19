---
editable: false
---

# Метод get
Возвращает указанный ресурс Backup для PostgreSQL.
 
Чтобы получить список доступных ресурсов Backup для PostgreSQL, отправьте запрос [list](/docs/managed-postgresql/api-ref/Backup/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-postgresql/v1/backups/{backupId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
backupId | Обязательное поле. Идентификатор резервной копии, сведения о которой запрашиваются. Чтобы получить идентификатор резервной копии, используйте запрос [listBackups](/docs/managed-postgresql/api-ref/Cluster/listBackups).
 
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
Ресурс Backup для PostgreSQL. Подробнее см. в разделе [Developer's Guide](/docs/managed-postgresql/concepts/backup).
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор резервной копии.</p> 
folderId | **string**<br><p>Идентификатор каталога, которому принадлежит резервная копия.</p> 
createdAt | **string** (date-time)<br><p>Время создания в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a> (т. е. когда операция резервного копирования была завершена).</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 
sourceClusterId | **string**<br><p>Идентификатор кластера PostgreSQL, для которого была создана резервная копия.</p> 
startedAt | **string** (date-time)<br><p>Время запуска операции резервного копирования.</p> <p>Строка в формате <a href="https://www.ietf.org/rfc/rfc3339.txt">RFC3339</a>.</p> 