---
editable: false
---

# Метод get
Возвращает указанную базу данных MySQL.
 
Чтобы получить список доступных баз данных MySQL, выполните запрос [list](/docs/managed-mysql/api-ref/Database/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-mysql/v1/clusters/{clusterId}/databases/{databaseName}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
clusterId | Обязательное поле. Идентификатор кластера MySQL, которому принадлежит база данных. Чтобы получить идентификатор кластера, используйте запрос [list](/docs/managed-mysql/api-ref/Cluster/list).  Максимальная длина строки в символах — 50.
databaseName | Обязательное поле. Имя базы данных MySQL, данные о которой нужно запросить. Чтобы получить имя базы данных, используйте запрос [list](/docs/managed-mysql/api-ref/Database/list).  Максимальная длина строки в символах — 63. Значение должно соответствовать регулярному выражению `` [a-zA-Z0-9_-]* ``.
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "name": "string",
  "clusterId": "string"
}
```
База данных MySQL. Подробнее см. в [документации](/docs/managed-mysql/concepts).
 
Поле | Описание
--- | ---
name | **string**<br><p>Имя базы данных.</p> 
clusterId | **string**<br><p>Идентификатор кластера MySQL, которому принадлежит база данных.</p> 