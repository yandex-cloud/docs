---
editable: false
---

# Метод get
Возвращает указанный набор ресурсов.
 
Чтобы получить список доступных наборов ресурсов, используйте запрос [list](/docs/managed-redis/api-ref/ResourcePreset/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-redis/v1/resourcePresets/{resourcePresetId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
resourcePresetId | Обязательное поле. Идентификатор набора ресурсов, данные о котором запрашиваются. Чтобы получить идентификатор набора ресурсов, используйте запрос [list](/docs/managed-redis/api-ref/ResourcePreset/list).
 
## Ответ {#responses}
**HTTP Code: 200 - OK**

```json 
{
  "id": "string",
  "zoneIds": [
    "string"
  ],
  "memory": "string"
}
```
Набор ресурсов, который описывает конфигурацию хоста.
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор набора ресурсов.</p> 
zoneIds[] | **string**<br><p>Идентификаторы зон доступности, в которых доступен данный набор ресурсов.</p> 
memory | **string** (int64)<br><p>Объем оперативной памяти для хоста Redis, созданного с данным набором ресурсов, в байтах.</p> 