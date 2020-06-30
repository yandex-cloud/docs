---
editable: false
---

# Метод get
Returns the specified resource preset.
 
To get the list of available resource presets, make a [list](/docs/managed-kafka/api-ref/ResourcePreset/list) request.
 
## HTTP-запрос {#https-request}
```
GET https://mdb.api.cloud.yandex.net/managed-kafka/v1/resourcePresets/{resourcePresetId}
```
 
## Path-параметры {#path_params}
 
Параметр | Описание
--- | ---
resourcePresetId | Обязательное поле. ID of the resource preset to return.  To get the resource preset ID, use a [list](/docs/managed-kafka/api-ref/ResourcePreset/list) request.
 
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
A ResourcePreset resource for describing hardware configuration presets.
 
Поле | Описание
--- | ---
id | **string**<br><p>ID of the ResourcePreset resource.</p> 
zoneIds[] | **string**<br><p>IDs of availability zones where the resource preset is available.</p> 
cores | **string** (int64)<br><p>Number of CPU cores for a Kafka broker created with the preset.</p> 
memory | **string** (int64)<br><p>RAM volume for a Kafka broker created with the preset, in bytes.</p> 