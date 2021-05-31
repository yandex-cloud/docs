---
editable: false
---

# Метод get
Возвращает указанный набор вычислительных ресурсов.
 
Чтобы получить список доступных наборов вычислительных ресурсов, выполните запрос [list](/docs/managed-sqlserver/api-ref/ResourcePreset/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/mdb/sqlserver/v1/resourcePresets/{resourcePresetId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
resourcePresetId | Обязательное поле. Идентификатор наборов вычислительных ресурсов, данные о котором запрашиваются.  Чтобы получить идентификатор наборов вычислительных ресурсов, выполните запрос [list](/docs/managed-sqlserver/api-ref/ResourcePreset/list).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "zoneIds": [
    "string"
  ],
  "cores": "string",
  "memory": "string"
}
```
Набор вычислительных ресурсов для хостов SQL Server.
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор набора вычислительных ресурсов.</p> 
zoneIds[] | **string**<br><p>Идентификаторы зон доступности, в которых доступен этот набор вычислительных ресурсов.</p> 
cores | **string** (int64)<br><p>Количество процессорных ядер для хоста SQL, созданного с данным набором вычислительных ресурсов.</p> 
memory | **string** (int64)<br><p>Объем оперативной памяти для хоста SQL Server, созданного с данным набором вычислительных ресурсов, в байтах.</p> 