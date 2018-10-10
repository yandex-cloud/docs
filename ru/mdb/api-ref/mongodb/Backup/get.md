# Метод get
Возвращает указанный ресурс Backup для MongoDB.
 
Чтобы получить список доступных ресурсов Backup для MongoDB,
отправьте запрос [list](/docs/mdb/api-ref/mongodb/Backup/list).
 
## HTTP-запрос
`GET /managed-mongodb/v1/backups/{backupId}`
 
## Path-параметры {#path_params}
 
Name | Description
--- | ---
backupId | Обязательное поле. Идентификатор резервной копии, сведения о котором запрашиваются. Чтобы получить идентификатор резервной копии, используйте запрос [listBackups](/docs/mdb/api-ref/mongodb/Cluster/listBackups).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

Ресурс Backup для MongoDB. Подробнее см. в разделе [Взаимосвязь ресурсов сервиса](/docs/mdb/concepts).
 
Поле | Описание
--- | ---
id | **string**<br>Идентификатор резервной копии.
folderId | **string**<br>Идентификатор каталога, которому принадлежит резервная копия.
createdAt | **string** (date-time)<br>Время создания в формате [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) (т. е. когда операция резервного копирования была завершена).
sourceClusterId | **string**<br>Идентификатор кластера MongoDB, для которого была создана резервная копия.
startedAt | **string** (date-time)<br>Время запуска операции резервного копирования.