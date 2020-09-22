---
editable: false
---

# Метод get
Возвращает указанный шаблон ресурса.
 
Чтобы получить список доступных шаблонов ресурсов, выполните запрос [list](/docs/managed-elasticsearch/api-ref/ResourcePreset/list).
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-elasticsearch/v1/resourcePresets/{resourcePresetId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
resourcePresetId | Обязательное поле. Идентификатор шаблона ресурса, данные о котором запрашиваются.  Чтобы получить идентификатор шаблона ресурса, выполните запрос [list](/docs/managed-elasticsearch/api-ref/ResourcePreset/list).
 
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
Описание набора вычислительных ресурсов.
 
Поле | Описание
--- | ---
id | **string**<br><p>Идентификатор набора ресурсов.</p> 
zoneIds[] | **string**<br><p>Идентификаторы зон доступности, в которых доступен этот набор вычислительных ресурсов.</p> 
cores | **string** (int64)<br><p>Количество процессорных ядер для узла Elasticsearch, созданного с помощью набора вычислительных ресурсов.</p> 
memory | **string** (int64)<br><p>Объем оперативной памяти для узла Elasticsearch, созданного с помощью набора вычислительных ресурсов, в байтах.</p> 